-- =====================================================================
-- Nombre de la Tabla: INPUT
-- Descripción: Archivo de Asientos Contables Aprobados
-- Objetivo: Gestion de Archivo de Asientos Contables Aprobados
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

CREATE OR REPLACE TABLE FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados FOR
SYSTEM NAME INPUT
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
    
    CONSTRAINT PK_INPUT PRIMARY KEY (id_registro)
)
RCDFMT INPUTREC;

COMMENT ON TABLE FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados IS 'Archivo
de Asientos Contables Aprobados';

LABEL ON TABLE FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados IS 'INPUT';

COMMENT ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.id_registro
IS 'Identificador del registro';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.id_registro
IS 'IDREG';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.id_registro
TEXT IS 'Identificador del registro';

COMMENT ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.descripcion
IS 'Descripcion';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.descripcion
IS 'DESC';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.descripcion
TEXT IS 'Descripcion';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.usuario_creacion IS 'Usuario
creacion';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.usuario_creacion IS 'USCRE';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.usuario_creacion TEXT IS
'Usuario creacion';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.usuario_actualizacion IS
'Usuario actualizacion';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.usuario_actualizacion IS
'USACT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.usuario_actualizacion TEXT IS
'Usuario actualizacion';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.version_registro IS
'Version';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.version_registro IS 'VRSRG';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.version_registro TEXT IS
'Version';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.observaciones IS
'Observaciones';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.observaciones
IS 'OBSRV';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.observaciones
TEXT IS 'Observaciones';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.estado_registro IS 'Estado';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.estado_registro IS 'ESTDO';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.estado_registro TEXT IS
'Estado';

COMMENT ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.created_at
IS 'Fecha creacion';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.created_at IS
'CRTM';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.created_at
TEXT IS 'Fecha creacion';

COMMENT ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.updated_at
IS 'Fecha actualizacion';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.updated_at IS
'UPDTM';
LABEL ON COLUMN FGUTIERRM1.Archivo_de_Asientos_Contables_Aprobados.updated_at
TEXT IS 'Fecha actualizacion';
