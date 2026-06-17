-- =====================================================================
-- Nombre de la Tabla: DPDTL
-- Descripción: Detalle Declaracion Patrimonial Personas Naturales
-- Objetivo: Gestion de Detalle Declaracion Patrimonial Personas Naturales
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

CREATE OR REPLACE TABLE
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales FOR SYSTEM NAME
DPDTL
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
    
    CONSTRAINT PK_DPDTL PRIMARY KEY (id_registro)
)
RCDFMT DPDTLREC;

COMMENT ON TABLE FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales
IS 'Detalle Declaracion Patrimonial Personas Naturales';

LABEL ON TABLE FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales IS
'DPDTL';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.id_registro IS
'Identificador del registro';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.id_registro IS
'IDREG';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.id_registro TEXT
IS 'Identificador del registro';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.descripcion IS
'Descripcion';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.descripcion IS
'DESC';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.descripcion TEXT
IS 'Descripcion';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.usuario_creacion
IS 'Usuario creacion';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.usuario_creacion
IS 'USCRE';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.usuario_creacion
TEXT IS 'Usuario creacion';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.usuario_actualizac
ion
IS 'Usuario actualizacion';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.usuario_actualizac
ion
IS 'USACT';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.usuario_actualizac
ion
TEXT IS 'Usuario actualizacion';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.version_registro
IS 'Version';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.version_registro
IS 'VRSRG';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.version_registro
TEXT IS 'Version';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.observaciones IS
'Observaciones';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.observaciones IS
'OBSRV';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.observaciones TEXT
IS 'Observaciones';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.estado_registro IS
'Estado';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.estado_registro IS
'ESTDO';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.estado_registro
TEXT IS 'Estado';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.created_at IS
'Fecha creacion';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.created_at IS
'CRTM';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.created_at TEXT IS
'Fecha creacion';

COMMENT ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.updated_at IS
'Fecha actualizacion';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.updated_at IS
'UPDTM';
LABEL ON COLUMN
FGUTIERRM1.Detalle_Declaracion_Patrimonial_Personas_Naturales.updated_at TEXT IS
'Fecha actualizacion';
