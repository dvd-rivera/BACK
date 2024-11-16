const pool = require("../database/postgres");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");

dotenv.config();
const SECRET_KEY = process.env.SECRET_KEY;

const getOneProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const query = `SELECT 
 p.id AS product_id,
    p.description,
    p.price,
    p.stock,
    p.other_attributes,
    p.img,
    t.name AS type_name,
    th.name AS theme_name
FROM products p 
LEFT JOIN type t ON p.type_id = t.id 
LEFT JOIN theme th ON p.theme_id = th.id 
WHERE p.id = $1`;
    const response = await pool.query(query, [id]);
    if (!response.rows.length) {
      return res.status(404).json({
        message: "Producto no existe",
        code: 404,
      });
    }
    /// response.rows[0] para devolver el unico objeto
    res.status(200).json(response.rows[0]);
  } catch (error) {
    console.log(error);
    res
      .status(500)
      .json({ message: "Ocurrió un error al obtener el producto" });
  }
};

const getAllProducts = async (req, res) => {
  try {
    const { size } = req.query;
    let query = `SELECT 
 p.id AS product_id,
    p.description,
    p.price,
    p.stock,
    p.other_attributes,
    p.img,
    t.name AS type_name,
    th.name AS theme_name
FROM products p 
LEFT JOIN type t ON p.type_id = t.id 
LEFT JOIN theme th ON p.theme_id = th.id`;

    if (size) {
      query += ` LIMIT $1`;
    }
    const response = size
      ? await pool.query(query, [size])
      : await pool.query(query);
    //const response = await pool.query(query);
    if (!response.rows.length) {
      return res.status(404).json({
        message: "Producto no existe",
        code: 404,
      });
    }
    res.status(200).json(response.rows);
  } catch (error) {
    console.log(error);
    res
      .status(500)
      .json({ message: "Ocurrió un error al obtener los productos" });
  }
};

const createNewProduct = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const { role } = jwt.verify(token, SECRET_KEY);
    if (role == "client") {
      return res.status(401).json({
        message: "No autorizado, token no pertenece a un usuario administrador",
        code: 401,
      });
    }
    const {
      description,
      price,
      stock,
      other_attributes,
      img,
      type_id,
      theme_id,
    } = req.body;
    const query =
      "INSERT INTO products (description, price, stock, other_attributes, img, type_id, theme_id) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *;";
    const values = [
      description,
      price,
      stock,
      JSON.stringify(other_attributes),
      img,
      type_id,
      theme_id,
    ];
    const response = await pool.query(query, values);
    res.status(201).json(response.rows[0]);
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Ocurrió un error al registrar producto" });
  }
};

module.exports = {
  getOneProduct,
  getAllProducts,
  createNewProduct,
};