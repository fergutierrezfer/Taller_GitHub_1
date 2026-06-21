-- =====================================================================
-- Nombre de la Tabla: ACMST
-- Descripción: Archivo Maestro de Cuentas de Detalle
-- Objetivo: Gestion de Archivo Maestro de Cuentas de Detalle
-- Tipo de Tabla: Maestro
-- Origen de los Datos: Sistema
-- Permanencia de Datos: Permanente
-- Uso de los datos: Consulta
-- Restricciones: Se requiere validación de integridad referencial
-- =====================================================================
-- Hecho por: Generador de Scripts SQL
-- Fecha: 2026-06-16
-- Proyecto: Taller GitHub - IBM i
-- =====================================================================

CREATE OR REPLACE TABLE FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle FOR SYSTEM NAME ACMST
(
    id_registro                    FOR COLUMN IDREG    BIGINT NOT NULL,
    descripcion                    FOR COLUMN DESC     VARCHAR(120),
    usuario_creacion               FOR COLUMN USCRE    VARCHAR(30),
    usuario_actualizacion          FOR COLUMN USACT    VARCHAR(30),
    version_registro               FOR COLUMN VRSRG    INT,
    observaciones                  FOR COLUMN OBSRV    VARCHAR(120),
    estado_registro                FOR COLUMN ESTDO    CHAR(1),
    created_at                     FOR COLUMN CRTM     TIMESTAMP,
    updated_at                     FOR COLUMN UPDTM    TIMESTAMP,
    
    CONSTRAINT PK_ACMST PRIMARY KEY (id_registro)
)
RCDFMT ACMSTREC;

COMMENT ON TABLE FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle IS 'Archivo Maestro de Cuentas de Detalle';

LABEL ON TABLE FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle IS 'ACMST';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.id_registro IS 'Identificador del registro';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.id_registro IS 'IDREG';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.id_registro TEXT IS 'Identificador del registro';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.descripcion IS 'Descripcion';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.descripcion IS 'DESC';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.descripcion TEXT IS 'Descripcion';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.usuario_creacion IS 'Usuario creacion';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.usuario_creacion IS 'USCRE';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.usuario_creacion TEXT IS 'Usuario creacion';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.usuario_actualizacion IS 'Usuario actualizacion';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.usuario_actualizacion IS 'USACT';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.usuario_actualizacion TEXT IS 'Usuario actualizacion';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.version_registro IS 'Version';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.version_registro IS 'VRSRG';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.version_registro TEXT IS 'Version';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.observaciones IS 'Observaciones';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.observaciones IS 'OBSRV';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.observaciones TEXT IS 'Observaciones';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.estado_registro IS 'Estado';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.estado_registro IS 'ESTDO';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.estado_registro TEXT IS 'Estado';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.created_at IS 'Fecha creacion';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.created_at IS 'CRTM';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.created_at TEXT IS 'Fecha creacion';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.updated_at IS 'Fecha actualizacion';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.updated_at IS 'UPDTM';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Cuentas_de_Detalle.updated_at TEXT IS 'Fecha actualizacion';

