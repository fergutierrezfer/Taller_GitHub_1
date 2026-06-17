param([string]$FolderPath = ".", [int]$MaxLineLength = 80)

function Split-LongLine {
    param([string]$Line, [int]$MaxLength)
    
    if ($Line.Length -le $MaxLength) {
        return @($Line)
    }
    
    $result = @()
    $currentLine = ""
    $tokens = $Line -split '(\s+|,|;)'
    
    foreach ($token in $tokens) {
        if ([string]::IsNullOrEmpty($token)) {
            continue
        }
        
        if (($currentLine.Length + $token.Length) -gt $MaxLength -and $currentLine.Length -gt 0) {
            $result += $currentLine.TrimEnd()
            $currentLine = $token
        }
        else {
            $currentLine += $token
        }
    }
    
    if ($currentLine.Length -gt 0) {
        $result += $currentLine
    }
    
    return $result
}

function Adjust-SQLFile {
    param([string]$FilePath, [int]$MaxLength)
    
    Write-Host "Procesando: $FilePath" -ForegroundColor Cyan
    
    try {
        $content = Get-Content -Path $FilePath -Encoding UTF8 -ErrorAction Stop
        $lines = @($content)
        
        $adjustedLines = @()
        
        foreach ($line in $lines) {
            if ($line.Length -gt $MaxLength) {
                $splitLines = Split-LongLine -Line $line -MaxLength $MaxLength
                $adjustedLines += $splitLines
                Write-Host "  - Línea original ($($line.Length) chars) dividida en $($splitLines.Count) líneas" -ForegroundColor Yellow
            }
            else {
                $adjustedLines += $line
            }
        }
        
        $adjustedLines | Set-Content -Path $FilePath -Encoding UTF8 -NoNewline
        Write-Host "  OK - Archivo guardado: $($adjustedLines.Count) líneas" -ForegroundColor Green
        
        return $true
    }
    catch {
        Write-Host "  ERROR: $_" -ForegroundColor Red
        return $false
    }
}

$sqlFiles = Get-ChildItem -Path $FolderPath -Filter "*.sql" -File

if ($sqlFiles.Count -eq 0) {
    Write-Host "No se encontraron archivos SQL" -ForegroundColor Red
    exit
}

Write-Host "Encontrados $($sqlFiles.Count) archivos SQL - Max 80 caracteres" -ForegroundColor Green
Write-Host ""

$successCount = 0
$failureCount = 0

foreach ($file in $sqlFiles) {
    if (Adjust-SQLFile -FilePath $file.FullName -MaxLength $MaxLineLength) {
        $successCount++
    }
    else {
        $failureCount++
    }
}

Write-Host ""
Write-Host "RESUMEN: Exitosos=$successCount, Errores=$failureCount" -ForegroundColor Green
