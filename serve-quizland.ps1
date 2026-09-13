$root = $PSScriptRoot
$port = 8080
$prefix = "http://localhost:$port/"

$mime = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".mp3"  = "audio/mpeg"
    ".wav"  = "audio/wav"
    ".woff" = "font/woff"
    ".woff2"= "font/woff2"
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
try {
    $listener.Start()
} catch {
    Write-Host "Could not start server on $prefix"
    Write-Host $_.Exception.Message
    exit 1
}

Write-Host "QuizLand is running at $prefix"
Write-Host "Keep this window open while using the microphone."
Start-Process $prefix

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $requestPath = [Uri]::UnescapeDataString($context.Request.Url.LocalPath)
    if ($requestPath -eq "/") { $requestPath = "/index.html" }

    $relative = $requestPath.TrimStart("/").Replace("/", [IO.Path]::DirectorySeparatorChar)
    $fullPath = [IO.Path]::GetFullPath((Join-Path $root $relative))

    if (-not $fullPath.StartsWith($root, [StringComparison]::OrdinalIgnoreCase)) {
        $context.Response.StatusCode = 403
        $context.Response.Close()
        continue
    }

    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        $context.Response.StatusCode = 404
        $bytes = [Text.Encoding]::UTF8.GetBytes("Not found")
        $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        $context.Response.Close()
        continue
    }

    $ext = [IO.Path]::GetExtension($fullPath).ToLowerInvariant()
    $context.Response.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { "application/octet-stream" }
    $bytes = [IO.File]::ReadAllBytes($fullPath)
    $context.Response.ContentLength64 = $bytes.Length
    $context.Response.Headers.Add("Cache-Control", "no-cache")
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
}
