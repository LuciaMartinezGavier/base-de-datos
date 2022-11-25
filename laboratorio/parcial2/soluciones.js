// Nota: 9.1

// EJERCICIO 1

/*
  Buscar los clientes que no tengan el campo active y que o bien posean más de 4
  cuentas o bien nacieron entre Abril de 1995 y Marzo de 1997 inclusives. Listar el
  nombre, email, fecha de nacimiento y cantidad de cuentas. Limitar el resultado a los
  50 primeros clientes de acuerdo al orden alfabético.
*/
db.customers.find(
  {
    $or: [
      {
        active: { $exists: false },
      },
      {
        "accounts.4": { $exists: true },
      },
      {
        birthdate: { $gt: ISODate("1995-04-01"), $lt: ISODate("1997-03-31") },
      },
    ],
  },
  {
    _id: 0,
    name: 1,
    email: 1,
    birthdate: 1,
    n_accounts: { $size: "$accounts" },
  }
).sort(
  { name: -1 }
).limit(50);

// EJERCICIO 2
/*
  Actualizar las cuentas que tengan un límite entre 8000 y 9000 inclusives,
  agregando un nuevo campo "class" con el valor "A" si la cuenta tiene hasta dos
  productos y con el valor "B" si tiene 3 o más productos.
*/

db.accounts.updateMany(
  {
    limit: { $gte: 8000, $lte: 9000 },
  },
  [
    {
      $addFields: {
        class: {
          $switch: {
            branches: [
              {
                case: {
                  $lte: [{ $size: "$products" }, 2],
                },
                then: "A",
              },
            ],
            default: "B",
          },
        },
      },
    },
  ]
);


// EJERCICIO 3
/*
  Buscar las transacciones donde la cantidad de transacciones sea mayor a 94.
  Listar id de transacción, id de la cuenta, y solo aquellas transacciones que tengan el
  código de transacción igual a "buy" y con "total" mayor a 500000. Mostrar el
  resultado ordenados por el id de la cuenta en orden decreciente.
  HINTS: (i) El operador $filter puede ser de utilidad. (ii) Notar que el valor del campo
  total está en string y requiere conversión.
*/

db.transactions.aggregate([
  {
    $match: {
      transaction_count: { $gt: 94 },
    },
  },
  {
    $addFields: {
      transactions: {
        $map: {
          input: "$transactions",
          in: {
            $mergeObjects: ["$$this", { total: { $toDouble: "$$this.total" } }],
          },
        },
      },
    },
  },
  {
    $addFields: {
      buy_transactions: {
        $filter: {
          input: "$transactions",
          cond: {
            $and: [
              { $gt: ["$$this.total", 500000] },
              { $eq: ["$$this.transaction_code", "buy"] },
            ],
          },
        },
      },
    },
  },
  {
    $project: {
      _id: "$_id",
      account_id: "$account_id",
      buy_transactions: "$buy_transactions",
    },
  },
  {
    $sort: { account_id: -1 },
  },
]);

// EJERCICIO 4
/*
  Crear la vista "transactionCountByCode" que lista el id de transacción, id de la
  cuenta, cantidad de transacciones, cantidad de transacciones de compra
  (transacciones con transaction_code igual a buy) y cantidad de transacciones de
  venta (transacciones con transaction_code igual a sell). Listar el resultado
  ordenados por cantidad de transacciones (orden decreciente).
*/
db.createView("transactionCountByCode", "transactions", [
  {
    $addFields: {
      buy_transactions: {
        $filter: {
          input: "$transactions",
          cond: { $eq: ["$$this.transaction_code", "buy"] },
        },
      },
      sell_transactions: {
        $filter: {
          input: "$transactions",
          cond: { $eq: ["$$this.transaction_code", "sell"] },
        },
      },
    },
  },
  {
    $project: {
      _id: 0,
      transaction_id: "$_id",
      account_id: "$account_id",
      transaction_count: "$transaction_count",
      buy_transaction_count: { $size: "$buy_transactions" },
      sell_transaction_count: { $size: "$sell_transactions" },
    },
  },
  {
    $sort: { transaction_count: -1 },
  },
]);


// EJERCICIO 5
/*
  Calcular la suma total, suma total de ventas y suma total de compras de las
  transacciones realizadas por año y mes. Mostrar el resultado en orden cronológico.
  No se debe mostrar resultados anidados en el resultado.
  HINT: El operador $cond o $switch puede ser de utilidad.
*/

db.transactions.aggregate([
  {
    $addFields: {
      transactions: {
        $map: {
          input: "$transactions",
          in: {
            $mergeObjects: ["$$this", { total: { $toDouble: "$$this.total" } }],
          },
        },
      },
    },
  },
  {
    $unwind: "$transactions",
  },
  {
    $addFields: {
      "transactions.total_buy": {
        $cond: {
          if: { $eq: ["buy", "$transactions.transaction_code"] },
          then: { $toDouble: "$transactions.total" },
          else: 0,
        },
      },
      "transactions.total_sell": {
        $cond: {
          if: { $eq: ["sell", "$transactions.transaction_code"] },
          then: { $toDouble: "$transactions.total" },
          else: 0,
        },
      },
    },
  },
  {
    $group: {
      _id: {
        year: { $year: "$transactions.date" },
        month: { $month: "$transactions.date" },
      },

      total_sum: { $sum: "$transactions.total" },
      total_sum_buy: { $sum: "$transactions.total_buy" },
      total_sum_sell: { $sum: "$transactions.total_sell" },
    },
  },
  {
    $addFields: {
      year: "$_id.year",
      month: "$_id.month",
    },
  },
  {
    $project: {
      _id: 0,
      year: "$year",
      month: "$month",
      total_sum: "$sum_total",
      total_sum_buy: "$total_sum_buy",
      total_sum_sell: "$total_sum_sell",
    },
  },
  {
    $sort: { total_sell: -1 },
  },
]);

// EJERCICIO 6
/*
  Especificar reglas de validación en la colección transactions 
  (a) usando JSON Schema a los campos: account_id, transaction_count, bucket_start_date,
  bucket_end_date y transactions ( y todos sus campos anidados ). Inferir los tipos y
  otras restricciones que considere adecuados para especificar las reglas a partir de
  los documentos de la colección. 
  (b) Luego añadir una regla de validación tal que
  bucket_start_date debe ser menor o igual a bucket_end_date.
*/

db.runCommand({
  collMod: "transactions",
  validationLevel: "moderate",
  validationAction: "error",
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "account_id",
        "bucket_end_date",
        "bucket_start_date",
        "transactions",
      ],
      properties: {
        account_id: {
          bsonType: "number",
        },
        transaction_count: {
          bsonType: "number",
        },
        bucket_end_date: {
          bsonType: "date",
        },
        bucket_start_date: {
          bsonType: "date",
        },
        transactions: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: [
              "date",
              "amount",
              "transaction_code",
              "symbol",
              "price",
              "total",
            ],
            properties: {
              date: {
                bsonType: "date",
              },
              amount: {
                bsonType: "number",
              },
              transaction_code: {
                bsonType: "string",
              },
              symbol: {
                bsonType: "string",
              },
              price: {
                bsonType: "string",
              },
              total: {
                bsonType: "string",
              },
            },
          },
        },
      },
    },
    // b
    $expr: {
      $lte: ["$bucket_start_date", "$bucket_end_date"],
    },
  },
});

// (c) Testear la regla de validación generando dos casos de falla en la
// regla de validación y dos casos donde
// cumple la regla de validación. Aclarar en la entrega cuales son los casos que fallan y
// cuales cumplen la regla de validación. Los casos no deben ser triviales.

// Casos validos
db.transactions.insertOne({
  account_id: 85,
  transaction_count: 2,
  bucket_start_date: ISODate("1986-06-06T00:00:00Z"),
  bucket_end_date: ISODate("2011-03-11T00:00:00Z"),
  transactions: [
    {
      date: ISODate("2010-02-24T00:00:00Z"),
      amount: 1000,
      transaction_code: "sell",
      symbol: "nvda",
      price: "15.41568788589975014247102080844342708587646484375",
      total: "13349.98570918918362337990402",
    },
    {
      date: ISODate("1990-06-18T00:00:00Z"),
      amount: 2918,
      transaction_code: "buy",
      symbol: "adbe",
      price: "2.20295603461750477691794003476388752460479736328125",
      total: "6428.225709013878939046549021",
    },
  ],
});

db.transactions.insertOne({
  account_id: 123456,
  bucket_start_date: ISODate("1986-06-06T00:00:00Z"),
  bucket_end_date: ISODate("2011-03-11T00:00:00Z"),
  transactions: [],
});

// Casos inválidos
db.transactions.insertOne({
  account_id: -123456,
  bucket_start_date: ISODate("1986-06-06T00:00:00Z"),
  bucket_end_date: ISODate("2011-03-11T00:00:00Z"),
  transactions: [
    {
      date: ISODate("2010-02-24T00:00:00Z"),
      amount: 1000,
      transaction_code: "sell",
      symbol: "nvda",
    },
    {
      date: ISODate("1990-06-18T00:00:00Z"),
      amount: 2918,
    },
  ],
});

db.transactions.insertOne({
  account_id: 123456,
  bucket_end_date: ISODate("1986-06-06T00:00:00Z"),
  bucket_start_date: ISODate("2011-03-11T00:00:00Z"),
});
