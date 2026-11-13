
-- ==========================================
-- BASE DE DATOS: VESTISTOCK
-- MOTOR: POSTGRESQL
-- ==========================================

-- 1. TABLA USUARIOS
CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(30) NOT NULL,
    estado VARCHAR(20) DEFAULT 'activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. TABLA CLIENTES
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    estado VARCHAR(20) DEFAULT 'activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. TABLA PROVEEDORES
CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(150),
    direccion VARCHAR(200),
    estado VARCHAR(20) DEFAULT 'activo'
);

-- 4. TABLA PRODUCTOS
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    categoria VARCHAR(100),
    precio_base NUMERIC(12,2) NOT NULL CHECK (precio_base > 0),
    estado VARCHAR(20) DEFAULT 'activo',
    imagen TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. TABLA VARIANTE_PRODUCTO
CREATE TABLE variante_producto (
    id_variante SERIAL PRIMARY KEY,
    id_producto INT NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    talla VARCHAR(20),
    color VARCHAR(50),
    precio NUMERIC(12,2) NOT NULL CHECK (precio > 0),
    estado VARCHAR(20) DEFAULT 'activo',

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);

-- 6. TABLA INVENTARIO
CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,
    id_variante INT NOT NULL UNIQUE,
    stock_actual INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INT NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),
    stock_maximo INT NOT NULL DEFAULT 0,
    estado VARCHAR(20) DEFAULT 'activo',

    FOREIGN KEY (id_variante)
        REFERENCES variante_producto(id_variante),

    CHECK (stock_maximo >= stock_minimo)
);

-- 7. TABLA VENTAS
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_cliente INT NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(12,2) NOT NULL DEFAULT 0,
    estado VARCHAR(30) DEFAULT 'registrada',
    metodo_pago VARCHAR(50),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

-- 8. TABLA DETALLE_VENTA
CREATE TABLE detalle_venta (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INT NOT NULL,
    id_variante INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(12,2) NOT NULL,
    subtotal NUMERIC(12,2)
        GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

    FOREIGN KEY (id_venta)
        REFERENCES ventas(id_venta),

    FOREIGN KEY (id_variante)
        REFERENCES variante_producto(id_variante),

    CHECK (precio_unitario > 0)
);

-- 9. TABLA COMPRAS
CREATE TABLE compras (
    id_compra SERIAL PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(12,2) NOT NULL DEFAULT 0,
    estado VARCHAR(30) DEFAULT 'registrada',

    FOREIGN KEY (id_proveedor)
        REFERENCES proveedores(id_proveedor)
);

-- 10. TABLA DETALLE_COMPRA
CREATE TABLE detalle_compra (
    id_detalle_compra SERIAL PRIMARY KEY,
    id_compra INT NOT NULL,
    id_variante INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(12,2) NOT NULL,
    subtotal NUMERIC(12,2)
        GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

    FOREIGN KEY (id_compra)
        REFERENCES compras(id_compra),

    FOREIGN KEY (id_variante)
        REFERENCES variante_producto(id_variante),

    CHECK (precio_unitario > 0)
);

