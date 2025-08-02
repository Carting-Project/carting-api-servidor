-- 001_create_initial_tables.sql
-- Este script crea las tablas iniciales para el MVP de Carting.

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    telefono VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255),
    nombre_completo VARCHAR(255),
    auth_provider VARCHAR(50) NOT NULL DEFAULT 'email',
    fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    fecha_actualizacion TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS negocios (
    id SERIAL PRIMARY KEY,
    usuario_propietario_id INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    nombre_negocio VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    telefono_negocio VARCHAR(50),
    descripcion TEXT,
    logo_url VARCHAR(255),
    fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    fecha_actualizacion TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS vehiculos (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    ano INTEGER NOT NULL,
    kilometraje_actual INTEGER NOT NULL DEFAULT 0,
    foto_url VARCHAR(255),
    fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    fecha_actualizacion TIMESTAMPTZ
);

-- Índices para mejorar la velocidad de las búsquedas
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_vehiculos_usuario_id ON vehiculos(usuario_id);
CREATE INDEX idx_negocios_usuario_propietario_id ON negocios(usuario_propietario_id);
