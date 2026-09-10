# Render all 5 slides to high-res PNG
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$desktop = [Environment]::GetFolderPath("Desktop")
$baseDir = Join-Path $desktop "WRoomie\ig_post"
$outDir = Join-Path $baseDir "output"
$artDir = "C:\Users\kuoji\.gemini\antigravity\brain\7e533ce9-8b69-428b-8ec4-06bbd4bc0189\assets"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
New-Item -ItemType Directory -Force -Path $artDir | Out-Null

$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"

for ($i = 1; $i -le 5; $i++) {
    $htmlPath = (Join-Path $baseDir "slide$i.html").Replace("\", "/")
    $pngPath = Join-Path $outDir "slide_$i.png"
    
    Write-Output "Rendering Slide $i..."
    $proc = Start-Process -FilePath $chrome -ArgumentList "--headless", "--disable-gpu", "--screenshot=`"$pngPath`"", "--window-size=1080,1350", "--hide-scrollbars", "--virtual-time-budget=3000", "`"file:///$htmlPath`"" -PassThru -Wait
    
    if (Test-Path $pngPath) {
        $item = Get-Item $pngPath
        Write-Output "Slide $i rendered successfully: $($item.Length) bytes"
        Copy-Item $pngPath (Join-Path $artDir "slide_$i.png") -Force
    } else {
        Write-Output "Error rendering slide $i"
    }
}
Write-Output "Rendering completed!"
