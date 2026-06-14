# Hướng dẫn Cài đặt và Chạy Mip-Splatting

Repository này chứa mã nguồn gốc của bài báo **Mip-Splatting: Alias-free 3D Gaussian Splatting** cùng với các script hỗ trợ tự động hóa việc tải dữ liệu và chạy thực nghiệm do nhóm phát triển.

## 1. Yêu cầu Hệ thống
- Hệ điều hành: Windows 10/11 hoặc Linux
- Card đồ họa (GPU): NVIDIA (Đã kiểm tra trên RTX 3070)
- Môi trường: Anaconda/Miniconda, CUDA Toolkit (khuyên dùng 11.8 hoặc 12.1), Visual Studio (với C++ build tools cho Windows).

## 2. Cài đặt Môi trường
Sử dụng Anaconda để tạo môi trường ảo và cài đặt các phụ thuộc giống với 3D Gaussian Splatting:

```bash
# Tạo môi trường
conda create -n mip_splatting python=3.8
conda activate mip_splatting

# Cài đặt PyTorch và CUDA toolkit tương ứng
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Cài đặt các thư viện phụ thuộc
pip install plyfile tqdm

# Cài đặt submodule (submodules rasterization đặc biệt của Mip-Splatting)
pip install submodules/diff-gaussian-rasterization
pip install submodules/simple-knn
```

## 3. Tải Dữ liệu và Chạy Thử Nghiệm Tự Động
Chúng tôi đã cung cấp script `download_and_run.ps1` (cho Windows PowerShell) để tự động hóa toàn bộ quá trình:
1. Tải dataset **Tanks and Temples** chuẩn của 3D Gaussian Splatting.
2. Giải nén dataset vào thư mục `data/`.
3. Tự động chạy lệnh `train.py`.

**Lưu ý về tùy chỉnh tham số**:
Để tiết kiệm thời gian chạy thử trên môi trường học tập, script `download_and_run.ps1` đã điều chỉnh tham số `--iterations` xuống còn `7000` thay vì `30000` (mặc định của tác giả). Điều này giúp sinh viên quan sát được tốc độ hội tụ nhanh chóng mà vẫn đạt được chất lượng tương đối tốt để làm báo cáo so sánh.

**Cách chạy script:**
Mở thư mục code trong PowerShell và chạy:
```powershell
.\download_and_run.ps1
```

## 4. Chạy Render và Đánh giá (Tùy chọn)
Sau khi quá trình huấn luyện kết thúc (hoặc dừng ở 7000 iterations), bạn có thể render hình ảnh hoặc video để so sánh:
```bash
python render.py -m output/train_7k
```
Hình ảnh render ra sẽ nằm trong thư mục `output/train_7k/train/ours_7000/renders`. Bạn có thể quan sát ảnh khi zoom in/out để thấy điểm mạnh không bị răng cưa của Mip-Splatting.

## 5. Áp dụng Dataset của riêng bạn
Nếu bạn muốn dùng ảnh tự chụp:
1. Cài đặt và sử dụng **COLMAP** để trích xuất point cloud (định dạng `sparse/0/`).
2. Chạy thư viện `convert.py` (có sẵn trong repo 3DGS gốc) để tạo ra tập tin đúng định dạng.
3. Chạy `python train.py -s <đường_dẫn_đến_thư_mục_dataset_của_bạn>`
