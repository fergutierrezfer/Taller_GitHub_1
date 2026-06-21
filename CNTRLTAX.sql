-- =====================================================================
-- Nombre de la Tabla: CNTRLTAX
-- Descripción: Definiciones para el manejo de cobro de impuestos
-- Objetivo: Gestion de Definiciones para el manejo de cobro de impuestos
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

CREATE OR REPLACE TABLE FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos FOR SYSTEM NAME CNTRLTAX
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
    
    CONSTRAINT PK_CNTRLTAX PRIMARY KEY (id_registro)
)
RCDFMT CNTRLTAXREC;

COMMENT ON TABLE FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos IS 'Definiciones para el manejo de cobro de impuestos';

LABEL ON TABLE FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos IS 'CNTRLTAX';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.id_registro IS 'Identificador del registro';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.id_registro IS 'IDREG';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.id_registro TEXT IS 'Identificador del registro';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.descripcion IS 'Descripcion';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.descripcion IS 'DESC';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.descripcion TEXT IS 'Descripcion';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.usuario_creacion IS 'Usuario creacion';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.usuario_creacion IS 'USCRE';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.usuario_creacion TEXT IS 'Usuario creacion';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.usuario_actualizacion IS 'Usuario actualizacion';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.usuario_actualizacion IS 'USACT';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.usuario_actualizacion TEXT IS 'Usuario actualizacion';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.version_registro IS 'Version';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.version_registro IS 'VRSRG';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.version_registro TEXT IS 'Version';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.observaciones IS 'Observaciones';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.observaciones IS 'OBSRV';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.observaciones TEXT IS 'Observaciones';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.estado_registro IS 'Estado';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.estado_registro IS 'ESTDO';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.estado_registro TEXT IS 'Estado';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.created_at IS 'Fecha creacion';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.created_at IS 'CRTM';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.created_at TEXT IS 'Fecha creacion';

COMMENT ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.updated_at IS 'Fecha actualizacion';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.updated_at IS 'UPDTM';
LABEL ON COLUMN FGUTIERRM1.Definiciones_para_el_manejo_de_cobro_de_impuestos.updated_at TEXT IS 'Fecha actualizacion';

