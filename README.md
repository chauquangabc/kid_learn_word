# Lingo Bamboo 🎋

Một ứng dụng Flutter hiện đại dành cho việc học tập và trải nghiệm nội dung số, tích hợp các công nghệ tiên tiến nhất.

## 🚀 Tính năng chính

*   **Quản lý trạng thái:** Sử dụng hệ sinh thái **BLoC (flutter_bloc)** mạnh mẽ, giúp tách biệt logic nghiệp vụ và giao diện người dùng.
*   **Networking:** Giao tiếp API qua **Dio**, tích hợp **Pretty Dio Logger** để debug dễ dàng và hiệu quả.
*   **Lưu trữ dữ liệu:** Sử dụng **Hive** - cơ sở dữ liệu NoSQL tốc độ cao, tối ưu cho thiết bị di động.
*   **Trải nghiệm 3D:** Tích hợp **BabylonJS Viewer** cho phép hiển thị và tương tác với các mô hình 3D ngay trong ứng dụng.
*   **Kiến trúc:** Áp dụng các nguyên tắc của **Clean Architecture** kết hợp với **Dartz** (Functional Programming) để xử lý lỗi và dữ liệu một cách an toàn.
*   **Đa ngôn ngữ:** Hỗ trợ quốc tế hóa với thư viện `intl`.

## 🛠 Công nghệ & Thư viện sử dụng

*   **Framework:** Flutter (SDK ^3.11.3)
*   **State Management:** `flutter_bloc`, `equatable`
*   **API/Networking:** `dio`, `pretty_dio_logger`
*   **Local Database:** `hive`, `hive_flutter`
*   **3D Engine:** `babylonjs_viewer`
*   **Utils:** `dartz`, `intl`, `logger`, `font_awesome_flutter`

## 📁 Cấu trúc dự án sơ lược

```text
lib/
├── core/            # Chứa các thành phần dùng chung (Theme, Network, Errors)
├── data/            # Hiện thực hóa Repository, Data Sources, Models
├── domain/          # Entities, Use Cases, Repository Interfaces
├── presentation/    # UI (Pages, Widgets) và BLoC logic
└── main.dart        # Điểm khởi chạy ứng dụng
```

## ⚙️ Hướng dẫn cài đặt

1.  **Clone repository:**
    ```bash
    git clone https://github.com/your-username/lingo_bamboo.git
    cd lingo_bamboo
    ```

2.  **Cài đặt các gói phụ thuộc:**
    ```bash
    flutter pub get
    ```

3.  **Chạy ứng dụng:**
    ```bash
    flutter run
    ```

## 📝 Yêu cầu hệ thống

*   Flutter SDK: `^3.11.3`
*   Android API Level: Tối thiểu 21 (Android 5.0)
*   iOS: iOS 11.0 trở lên

---
© 2023 **Lingo Bamboo**
