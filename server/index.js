const productRoutes = require("../routes/products");
const userRoutes = require("../routes/users");
const express = require("express");

function apiRoutes(app) {
  const router = express.Router();
  app.use("/happyart/api/v1", router);
  router.use("/products", productRoutes);
  router.use("/users", userRoutes);
}

module.exports = apiRoutes;
