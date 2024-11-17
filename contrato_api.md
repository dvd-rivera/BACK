# Proyecto Happy Art - Tienda Online

## Base URL

```
https://api.happyart.com/v1
```

## Autenticación

- Algunos endpoints requieren autenticación mediante JWT Token
- El token debe ser incluido en el header: `Authorization: Bearer <token>`

## Endpoints

### 1. Autenticación y Usuarios

#### Registro de Usuario

```http
POST /auth/register
Content-Type: application/json

Request:
{
    "firstName": "string",
    "lastName": "string",
    "email": "string",
    "password": "string",
    "phone": "string",
    "address": "string"
}

Response: 201 Created
{
    "email": "string",
    "message": "Usuario registrado exitosamente",
    "token": "string"
}

Response: 400 Bad Request
{
    "message": "Error al registrar el usuario, falta algunos datos"
}
```

#### Inicio de Sesión

```http
POST /auth/login
Content-Type: application/json

Request:
{
    "email": "string",
    "password": "string"
}

Response: 200 OK
{
    "token": "string",
    "email": "string",
    "userType": "string"
}

Response: 400 Bad Request
{
    "message": "Error al iniciar sesión, email o password incorrectos"
}
```

### 2. Perfil de Usuario

#### Obtener Perfil

```http
GET /auth/myprofile
Authorization: Bearer <token>

Response: 200 OK
{
    "usuario": {
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "password": "string",
        "phone": "string",
        "address": "string"
    }
}

Response: 400 Bad Request
{
    "message": "Error obteniendo el perfil"
}
```

### 3. Productos

#### Crear Producto

```http
POST /products
Authorization: Bearer <token>
Content-Type: application/json

Request:
{
    "name": "string",
    "description": "string",
    "category": "string",
    "productType": "string",
    "price": "number",
    "stock": "integer",
    "theme": "string",
    "imagenes": "file[]"
}

Response: 201 Created
{
    "productoId": "integer",
    "message": "Producto creado exitosamente"
}

Response: 400 Bad Request
{
    "message": "Error al crear el producto"
}
```

#### Obtener Productos (Galería)

```http
GET /products

Query Parameters:
- page (integer)
- limit (integer)
- category (string, opcional)
- order (string, opcional: "name", "price", "stock")
- orderBy (string, opcional: "asc", "desc")

Response: 200 OK
{
    "products": [{
        "productoId": "integer",
        "name": "string",
        "price": "number",
        "stock": "integer"
        "category": "string",
        "theme": "string",
        "productType": "string",
        "img": "string"

    }],
    "total": "integer",
    "current_page": "integer",
    "total_pages": "integer"
}

Response: 400 Bad Request
{
    "message": "Error obteniendo los productos"
}

Response: 404 Not Found
{
    "message": "Productos no encontrado"
}
```

#### Obtener Detalle del Producto

```http
GET /products/{productId}

Response: 200 OK
{
   "productoId": "integer",
    "name": "string",
    "price": "number",
    "stock": "integer"
    "category": "string",
    "theme": "string",
    "productType": "string",
    "img": "string"
}

Response: 400 Bad Request
{
    "message": "Error obteniendo el detalle del producto"
}

Response: 404 Not Found
{
    "message": "Producto no encontrado"
}
```
