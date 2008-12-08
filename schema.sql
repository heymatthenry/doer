CREATE TABLE "tasks" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" VARCHAR(50),
  "description" TEXT,
  "category" VARCHAR(50),
  "category_id" INTEGER, 
  "completed" BOOLEAN
);