-- =====================================================================
-- Nombre de la Tabla: HSNOT
-- Descripción: Historico de Datos impresos en Notificaciones
-- Objetivo: Gestion de Historico de Datos impresos en Notificaciones
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

CREATE OR REPLACE TABLE FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones FOR SYSTEM NAME HSNOT
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
    
    CONSTRAINT PK_HSNOT PRIMARY KEY (id_registro)
)
RCDFMT HSNOTREC;

COMMENT ON TABLE FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones IS 'Historico de Datos impresos en Notificaciones';

LABEL ON TABLE FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones IS 'HSNOT';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.id_registro IS 'Identificador del registro';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.id_registro IS 'IDREG';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.id_registro TEXT IS 'Identificador del registro';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.descripcion IS 'Descripcion';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.descripcion IS 'DESC';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.descripcion TEXT IS 'Descripcion';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.usuario_creacion IS 'Usuario creacion';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.usuario_creacion IS 'USCRE';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.usuario_creacion TEXT IS 'Usuario creacion';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.usuario_actualizacion IS 'Usuario actualizacion';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.usuario_actualizacion IS 'USACT';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.usuario_actualizacion TEXT IS 'Usuario actualizacion';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.version_registro IS 'Version';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.version_registro IS 'VRSRG';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.version_registro TEXT IS 'Version';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.observaciones IS 'Observaciones';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.observaciones IS 'OBSRV';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.observaciones TEXT IS 'Observaciones';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.estado_registro IS 'Estado';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.estado_registro IS 'ESTDO';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.estado_registro TEXT IS 'Estado';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.created_at IS 'Fecha creacion';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.created_at IS 'CRTM';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.created_at TEXT IS 'Fecha creacion';

COMMENT ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.updated_at IS 'Fecha actualizacion';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.updated_at IS 'UPDTM';
LABEL ON COLUMN FGUTIERRM1.Historico_de_Datos_impresos_en_Notificaciones.updated_at TEXT IS 'Fecha actualizacion';

