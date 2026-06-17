-- =====================================================================
-- Nombre de la Tabla: MLNOT
-- Descripción: Archivo que contiene los datos a imprimir en la notificación
-- Objetivo: Almacenar datos de notificaciones
-- Tipo de Tabla: Transaccional
-- Origen de los Datos: Sistema
-- Permanencia de Datos: Temporal
-- Uso de los datos: Consulta y actualización
-- Restricciones: Se requiere validación de integridad referencial
-- =====================================================================
-- Hecho por: Generador de Scripts SQL
-- Fecha: 2026-06-16
-- Proyecto: Taller GitHub - IBM i
-- =====================================================================

CREATE OR REPLACE TABLE FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones
FOR SYSTEM NAME MLNOT
(
    codigo_banco                   FOR COLUMN CDBNC    VARCHAR(20) NOT NULL,
    fecha_proceso                  FOR COLUMN FPROC    DATE NOT NULL,
    numero_cuenta                  FOR COLUMN NUMCT    VARCHAR(24) NOT NULL,
    codigo_de_notificacion         FOR COLUMN CDNOT    VARCHAR(20) NOT NULL,
    nivel                          FOR COLUMN NIVL     INT NOT NULL,
    descripcion                    FOR COLUMN DESC     VARCHAR(120),
    valor_texto                    FOR COLUMN VTEXT    VARCHAR(50),
    valor_numerico                 FOR COLUMN VNUM     DECIMAL(18,2),
    usuario_creacion               FOR COLUMN USCRE    VARCHAR(30),
    usuario_actualizacion          FOR COLUMN USACT    VARCHAR(30),
    version_registro               FOR COLUMN VRSRG    INT,
    observaciones                  FOR COLUMN OBSRV    VARCHAR(120),
    estado_registro                FOR COLUMN ESTDO    CHAR(1),
    created_at                     FOR COLUMN CRTM     TIMESTAMP,
    updated_at                     FOR COLUMN UPDTM    TIMESTAMP,
    
CONSTRAINT PK_MLNOT PRIMARY KEY (codigo_banco, fecha_proceso, numero_cuenta,
codigo_de_notificacion, nivel)
)
RCDFMT MLNOTREC;

COMMENT ON TABLE FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones IS
'Archivo que contiene los datos a imprimir en la notificación';

LABEL ON TABLE FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones IS
'MLNOT';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.
codigo_banco IS 'Código banco';
banco';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.codigo_banco IS
'CDBNC';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.codigo_banco TEXT IS
'Código banco';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.fecha_proceso IS 'Fecha
proceso';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.fecha_proceso IS
'FPROC';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.fecha_proceso TEXT IS
'Fecha proceso';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.numero_cuenta IS
'Número cuenta';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.numero_cuenta IS
'NUMCT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.numero_cuenta TEXT IS
'Número cuenta';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.codigo_de_notificacion
IS 'Código notificación';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.codigo_de_notificacion
IS 'CDNOT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.codigo_de_notificacion
TEXT IS 'Código notificación';

COMMENT ON COLUMN FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.nivel
IS 'Nivel';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.nivel
IS 'NIVL';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.nivel
TEXT IS 'Nivel';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.descripcion IS
'Descripción';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.descripcion IS 'DESC';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.descripcion TEXT IS
'Descripción';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.valor_texto IS 'Valor
texto';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.valor_texto IS 'VTEXT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.valor_texto TEXT IS
'Valor texto';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.valor_numerico IS
'Valor numérico';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.valor_numerico IS
'VNUM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.valor_numerico TEXT IS
'Valor numérico';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.usuario_creacion IS
'Usuario creación';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.usuario_creacion IS
'USCRE';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.usuario_creacion TEXT
IS 'Usuario creación';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.usuario_actualizacion
IS 'Usuario actualización';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.usuario_actualizacion
IS 'USACT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.usuario_actualizacion
TEXT IS 'Usuario actualización';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.version_registro IS
'Versión registro';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.version_registro IS
'VRSRG';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.version_registro TEXT
IS 'Versión registro';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.observaciones IS
'Observaciones';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.observaciones IS
'OBSRV';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.observaciones TEXT IS
'Observaciones';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.estado_registro IS
'Estado registro';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.estado_registro IS
'ESTDO';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.estado_registro TEXT IS
'Estado registro';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.created_at IS 'Fecha
creación';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.created_at IS 'CRTM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.created_at TEXT IS
'Fecha creación';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.updated_at IS 'Fecha
actualización';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.updated_at IS 'UPDTM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.updated_at TEXT IS
'Fecha actualización';
