# Tai dataset Tanks and Temples (cua 3DGS/Mip-Splatting) va chay thu nghiem
Set-Location $PSScriptRoot
$DatasetUrl = "https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/datasets/input/tandt_db.zip"
$ZipPath = "tandt_db.zip"
$ExtractPath = "data"

# 1. Tai du lieu
if (-Not (Test-Path $ZipPath)) {
    Write-Host "Dang tai dataset Tanks and Temples (tandt_db.zip)..."
    Invoke-WebRequest -Uri $DatasetUrl -OutFile $ZipPath
} else {
    Write-Host "Dataset da ton tai, bo qua buoc tai."
}

# 2. Giai nen du lieu
if (-Not (Test-Path "$ExtractPath\tandt")) {
    Write-Host "Dang giai nen dataset vao thu muc data/ ..."
    Expand-Archive -Path $ZipPath -DestinationPath $ExtractPath -Force
} else {
    Write-Host "Dataset da duoc giai nen."
}

# 3. Huan luyen mo hinh
# O day chung ta them co --iterations 7000 de mo hinh chay nhanh hon cho viec test (mac dinh la 30000)
Write-Host "Bat dau huan luyen Mip-Splatting tren scene Train (7000 iterations)..."
$pythonExe = if ($env:CONDA_PREFIX) { "$env:CONDA_PREFIX\python.exe" } else { "python" }
& $pythonExe train.py -s data/tandt/train --iterations 7000 -m output/train_7k

Write-Host "training complete, results is saved to output/train_7k"
