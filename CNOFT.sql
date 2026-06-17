-- =====================================================================
-- Nombre de la Tabla: CNOFT
-- Descripción: Archivo Maestro de Tablas de Datos Comunes para gestión centralizada de datos
-- Objetivo: Centralizar la definición de tablas comunes del sistema
-- Tipo de Tabla: Maestro
-- Origen de los Datos: Sistema
-- Permanencia de Datos: Permanente
-- Uso de los datos: Consulta y actualización
-- Restricciones: Se requiere validación de integridad referencial
-- =====================================================================
-- Hecho por: Generador de Scripts SQL
-- Fecha: 2026-06-16
-- Proyecto: Taller GitHub - IBM i
-- =====================================================================

CREATE OR REPLACE TABLE FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes FOR SYSTEM NAME CNOFT
(
    codigo_tabla                   FOR COLUMN CDTBL    VARCHAR(20) NOT NULL,
    idioma                         FOR COLUMN IDIOM    VARCHAR(20) NOT NULL,
    descripcion                    FOR COLUMN DESC     VARCHAR(120),
    valor_texto                    FOR COLUMN VTEXT    VARCHAR(50),
    valor_numerico                 FOR COLUMN VNUM     DECIMAL(18,2),
    vigencia_desde                 FOR COLUMN VDESD    DATE,
    vigencia_hasta                 FOR COLUMN VHAST    DATE,
    orden_visualizacion            FOR COLUMN ORDEN    INT,
    usuario_creacion               FOR COLUMN USCRE    VARCHAR(30),
    usuario_actualizacion          FOR COLUMN USACT    VARCHAR(30),
    version_registro               FOR COLUMN VRSRG    INT,
    observaciones                  FOR COLUMN OBSRV    VARCHAR(120),
    estado_registro                FOR COLUMN ESTDO    CHAR(1),
    created_at                     FOR COLUMN CRTM     TIMESTAMP,
    updated_at                     FOR COLUMN UPDTM    TIMESTAMP,
    
    CONSTRAINT PK_CNOFT PRIMARY KEY (codigo_tabla, idioma)
)
RCDFMT CNOFTREC;

COMMENT ON TABLE FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes IS 'Archivo Maestro de Tablas de Datos Comunes para gestión centralizada de datos';

LABEL ON TABLE FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes IS 'CNOFT';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.codigo_tabla IS 'Código de la tabla';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.codigo_tabla IS 'CDTBL';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.codigo_tabla TEXT IS 'Código de la tabla';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.idioma IS 'Idioma';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.idioma IS 'IDIOM';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.idioma TEXT IS 'Idioma';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.descripcion IS 'Descripción';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.descripcion IS 'DESC';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.descripcion TEXT IS 'Descripción';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.valor_texto IS 'Valor texto';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.valor_texto IS 'VTEXT';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.valor_texto TEXT IS 'Valor texto';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.valor_numerico IS 'Valor numérico';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.valor_numerico IS 'VNUM';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.valor_numerico TEXT IS 'Valor numérico';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.vigencia_desde IS 'Vigencia desde';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.vigencia_desde IS 'VDESD';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.vigencia_desde TEXT IS 'Vigencia desde';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.vigencia_hasta IS 'Vigencia hasta';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.vigencia_hasta IS 'VHAST';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.vigencia_hasta TEXT IS 'Vigencia hasta';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.orden_visualizacion IS 'Orden visualización';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.orden_visualizacion IS 'ORDEN';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.orden_visualizacion TEXT IS 'Orden visualización';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.usuario_creacion IS 'Usuario creación';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.usuario_creacion IS 'USCRE';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.usuario_creacion TEXT IS 'Usuario creación';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.usuario_actualizacion IS 'Usuario actualización';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.usuario_actualizacion IS 'USACT';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.usuario_actualizacion TEXT IS 'Usuario actualización';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.version_registro IS 'Versión registro';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.version_registro IS 'VRSRG';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.version_registro TEXT IS 'Versión registro';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.observaciones IS 'Observaciones';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.observaciones IS 'OBSRV';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.observaciones TEXT IS 'Observaciones';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.estado_registro IS 'Estado registro';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.estado_registro IS 'ESTDO';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.estado_registro TEXT IS 'Estado registro';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.created_at IS 'Fecha creación';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.created_at IS 'CRTM';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.created_at TEXT IS 'Fecha creación';

COMMENT ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.updated_at IS 'Fecha actualización';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.updated_at IS 'UPDTM';
LABEL ON COLUMN FGUTIERRM1.Archivo_Maestro_de_Tablas_de_Datos_Comunes.updated_at TEXT IS 'Fecha actualización';

