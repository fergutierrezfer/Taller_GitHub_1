-- =====================================================================
-- Nombre de la Tabla: MLNCT
-- Descripción: Archivo de patrones y formatos de Notificaciones a Clientes
-- Objetivo: Gestionar patrones de notificaciones
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

CREATE OR REPLACE TABLE
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes FOR SYSTEM NAME
MLNCT
(
    codigo_banco                   FOR COLUMN CDBNC    VARCHAR(20) NOT NULL,
    codigo_de_notificacion         FOR COLUMN CDNOT    VARCHAR(20) NOT NULL,
    nivel                          FOR COLUMN NIVL     INT NOT NULL,
    idioma                         FOR COLUMN IDIOM    VARCHAR(20) NOT NULL,
    secuencia                      FOR COLUMN SECU     INT NOT NULL,
    descripcion                    FOR COLUMN DESC     VARCHAR(120),
    valor_texto                    FOR COLUMN VTEXT    VARCHAR(50),
    valor_numerico                 FOR COLUMN VNUM     DECIMAL(18,2),
    vigencia_desde                 FOR COLUMN VDESD    DATE,
    vigencia_hasta                 FOR COLUMN VHAST    DATE,
    usuario_creacion               FOR COLUMN USCRE    VARCHAR(30),
    usuario_actualizacion          FOR COLUMN USACT    VARCHAR(30),
    version_registro               FOR COLUMN VRSRG    INT,
    observaciones                  FOR COLUMN OBSRV    VARCHAR(120),
    estado_registro                FOR COLUMN ESTDO    CHAR(1),
    created_at                     FOR COLUMN CRTM     TIMESTAMP,
    updated_at                     FOR COLUMN UPDTM    TIMESTAMP,
    
CONSTRAINT PK_MLNCT PRIMARY KEY (codigo_banco, codigo_de_notificacion, nivel,
idioma, secuencia)
)
RCDFMT MLNCTREC;

COMMENT ON TABLE FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes IS
'Archivo de patrones y formatos de Notificaciones a Clientes';

LABEL ON TABLE FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes IS
'MLNCT';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.codigo_banco IS
'Código banco';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.codigo_banco IS
'CDBNC';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.codigo_banco TEXT IS
'Código banco';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.codigo_de_notificaci
on
IS 'Código notificación';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.codigo_de_notificaci
on
IS 'CDNOT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.codigo_de_notificaci
on
TEXT IS 'Código notificación';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.nivel IS 'Nivel';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.nivel IS 'NIVL';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.nivel TEXT IS
'Nivel';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.idioma IS 'Idioma';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.idioma IS 'IDIOM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.idioma TEXT IS
'Idioma';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.secuencia IS
'Secuencia';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.secuencia IS 'SECU';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.secuencia TEXT IS
'Secuencia';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.descripcion IS
'Descripción';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.descripcion IS
'DESC';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.descripcion TEXT IS
'Descripción';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.valor_texto IS
'Valor texto';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.valor_texto IS
'VTEXT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.valor_texto TEXT IS
'Valor texto';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.valor_numerico IS
'Valor numérico';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.valor_numerico IS
'VNUM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.valor_numerico TEXT
IS 'Valor numérico';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.vigencia_desde IS
'Vigencia desde';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.vigencia_desde IS
'VDESD';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.vigencia_desde TEXT
IS 'Vigencia desde';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.vigencia_hasta IS
'Vigencia hasta';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.vigencia_hasta IS
'VHAST';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.vigencia_hasta TEXT
IS 'Vigencia hasta';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.usuario_creacion IS
'Usuario creación';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.usuario_creacion IS
'USCRE';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.usuario_creacion
TEXT IS 'Usuario creación';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.usuario_actualizacio
n
IS 'Usuario actualización';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.usuario_actualizacio
n
IS 'USACT';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.usuario_actualizacio
n
TEXT IS 'Usuario actualización';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.version_registro IS
'Versión registro';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.version_registro IS
'VRSRG';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.version_registro
TEXT IS 'Versión registro';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.observaciones IS
'Observaciones';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.observaciones IS
'OBSRV';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.observaciones TEXT
IS 'Observaciones';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.estado_registro IS
'Estado registro';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.estado_registro IS
'ESTDO';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.estado_registro TEXT
IS 'Estado registro';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.created_at IS 'Fecha
creación';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.created_at IS
'CRTM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.created_at TEXT IS
'Fecha creación';

COMMENT ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.updated_at IS 'Fecha
actualización';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.updated_at IS
'UPDTM';
LABEL ON COLUMN
FGUTIERRM1.Archivo_de_patrones_de_Notificaciones_a_Clientes.updated_at TEXT IS
'Fecha actualización';
