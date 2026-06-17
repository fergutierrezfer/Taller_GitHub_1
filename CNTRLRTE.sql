-- =====================================================================
-- Nombre de la Tabla: CNTRLRTE
-- Descripción: Tabla de Tasas y Cargos por Servicio Cuentas
-- Objetivo: Gestion de Tabla de Tasas y Cargos por Servicio Cuentas
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

CREATE OR REPLACE TABLE FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas FOR SYSTEM NAME CNTRLRTE
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
    
    CONSTRAINT PK_CNTRLRTE PRIMARY KEY (id_registro)
)
RCDFMT CNTRLRTEREC;

COMMENT ON TABLE FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas IS 'Tabla de Tasas y Cargos por Servicio Cuentas';

LABEL ON TABLE FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas IS 'CNTRLRTE';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.id_registro IS 'Identificador del registro';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.id_registro IS 'IDREG';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.id_registro TEXT IS 'Identificador del registro';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.descripcion IS 'Descripcion';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.descripcion IS 'DESC';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.descripcion TEXT IS 'Descripcion';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.usuario_creacion IS 'Usuario creacion';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.usuario_creacion IS 'USCRE';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.usuario_creacion TEXT IS 'Usuario creacion';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.usuario_actualizacion IS 'Usuario actualizacion';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.usuario_actualizacion IS 'USACT';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.usuario_actualizacion TEXT IS 'Usuario actualizacion';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.version_registro IS 'Version';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.version_registro IS 'VRSRG';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.version_registro TEXT IS 'Version';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.observaciones IS 'Observaciones';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.observaciones IS 'OBSRV';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.observaciones TEXT IS 'Observaciones';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.estado_registro IS 'Estado';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.estado_registro IS 'ESTDO';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.estado_registro TEXT IS 'Estado';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.created_at IS 'Fecha creacion';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.created_at IS 'CRTM';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.created_at TEXT IS 'Fecha creacion';

COMMENT ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.updated_at IS 'Fecha actualizacion';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.updated_at IS 'UPDTM';
LABEL ON COLUMN FGUTIERRM1.Tabla_de_Tasas_y_Cargos_por_Servicio_Cuentas.updated_at TEXT IS 'Fecha actualizacion';

