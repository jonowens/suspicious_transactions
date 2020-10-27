-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/T7mAoO
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- drops tables if exist
DROP TABLE IF EXISTS card_holder CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;
DROP TABLE IF EXISTS transaction CASCADE;

CREATE TABLE "card_holder" (
    "card_holder_id" SERIAL   NOT NULL,
    "card_holder_name" VARCHAR(100)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "card_holder_id"
     )
);

CREATE TABLE "credit_card" (
    "credit_card_number" VARCHAR(20)   NOT NULL,
    "card_holder_id" INT   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "credit_card_number"
     )
);

CREATE TABLE "merchant_category" (
    "merchant_category_id" SERIAL   NOT NULL,
    "merchant_category_name" VARCHAR(100)   NOT NULL,
    CONSTRAINT "pk_merchant_category" PRIMARY KEY (
        "merchant_category_id"
     )
);

CREATE TABLE "merchant" (
    "merchant_id" SERIAL   NOT NULL,
    "merchant_name" VARCHAR(100)   NOT NULL,
    "merchant_category_id" INT   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "merchant_id"
     )
);

CREATE TABLE "transaction" (
    "transaction_id" INT   NOT NULL,
    "transaction_date" TIMESTAMP   NOT NULL,
    "transaction_amount" FLOAT   NOT NULL,
    "credit_card_number" VARCHAR(20)   NOT NULL,
    "merchant_id" INT   NOT NULL,

    CONSTRAINT "uc_transaction_transaction_id" UNIQUE (
        "transaction_id"
    )
);

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_card_holder_id" FOREIGN KEY("card_holder_id")
REFERENCES "card_holder" ("card_holder_id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_merchant_category_id" FOREIGN KEY("merchant_category_id")
REFERENCES "merchant_category" ("merchant_category_id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_credit_card_number" FOREIGN KEY("credit_card_number")
REFERENCES "credit_card" ("credit_card_number");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_merchant_id" FOREIGN KEY("merchant_id")
REFERENCES "merchant" ("merchant_id");

