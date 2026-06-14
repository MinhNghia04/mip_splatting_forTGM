Copy-Item "..\Bao_Cao_Mip_Splatting.pdf" -Destination "Bao_Cao_Mip_Splatting.pdf" -ErrorAction SilentlyContinue
Copy-Item "..\mip_splatting.pdf" -Destination "mip_splatting.pdf" -ErrorAction SilentlyContinue
Copy-Item "..\mip_splatting_report\main.pdf" -Destination "mip_splatting_report.pdf" -ErrorAction SilentlyContinue

git lfs install
git lfs track "*.ply"
git lfs track "*.zip"
git add .gitattributes

git add Bao_Cao_Mip_Splatting.pdf mip_splatting.pdf mip_splatting_report.pdf
git add -f output

git commit -m "Add project output and PDF reports"
git push
