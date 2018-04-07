# Docker

### 1. Giới thiệu

#### 1.1 Giới thiệu

- Kiến thức có được:
  - Hiểu được các thành phần cấu thành nền tảng Docker
  - Hiểu được các khái niệm cốt lõi: container và image
  - Chạy và quản lý Docker container sử dụng image có sẵn
  - Tạo image từ container
  - Tự tạo image từ Dockerfile
  - Upload và download image
  - Thiết lập cấu hình mạng và chạy các container cùng mạng
  - Cấu hình mà mount volume trên các container

- Yêu cầu:
  - Kiến thức cơ bản về lập trình
  - CLI căn bản
  - Công nghệ ảo hóa
  - Kiến thức mạng
  - Bash & shell script

#### 1.2 Docker là gì

##### Docker là gì:
  - Dự án mã nguồn mở trên Github: https://github.com/docker
  - Tên công ty xây dựng nên nó (tên cũ: dotCloud)
    - dotCloud chuyên cung cấp các dịch vụ điện toán đám mây
    - Hiện tại chỉ tập trung và lĩnh vực container
    - Trang chủ: https://www.docker.com/

##### Docker dùng để làm gì:
  - Tại ra các container cho các ứng dụng phần mềm
    - Ở mức độ Linux, VM, Applicaton,...
  - Vận chuyển container đến các môi trường dev hoặc hỗ trợ việc chia sẻ cho cac dev khác

##### Khẩu quyết của Docker:
- Build, ship and deploy any application, anywhere
  - Build: đóng gói app trong 1 container
  - Ship: vận chuyển container
  - Deploy: triển khai, chạy container
  - Any app chạy được trên Linux
  - Anywhere: server, cloud instaince,..

  ```code
  - Đóng gói phần mềm dễ dàng
  - Deploy nhanh
  - Không cần cấu hình và môi trường cài đặt rườm rà
  ```

  - Image: compoment để triển khai ứng dụng bao gồm: mã nguồn, thư viện, framework, file,..
  - Trừu tượng hóa giải pháp và đóng gói vào một image kèm dêpndencies

  ==> Tránh conflict môi trường triển khai

- Batteries included but replaceable
  - Một compoment có thể được dễ dàng thay thế bằng cách implement cùng 1 interface có sẵn
  - Docker framework được phân chia thành các module có khả năng mở rộng cao.
    - Các compoment có thể thay thế bằng các compoment tương tự từ hãng thứ 3, thậm chí chức năng còn ưu việt hơn

##### Một số thuật ngữ:
- Image:
  - Khuôn mẫu, lớp chia chứa các file cần thiết để tạo nện một container
  - Chứa nh tài nguyên có sẵn
  - Không được tiếp cận CPU, memory, storage,..

- Container:
  - Tồn tại trên host với một IP
  - Được deploy, chạy và xóa bỏ thông qua remote client
<img src=''>
- Docker engine:
  - Tạo và chạy container
  - Chạy lệnh trong chế độ daemon
  - Linux trở thành máy chủ Docker
  - Container được deploy, chạy, xóa bỏ qua remote client
  - "Docker engine nằm trên layer OS và nằm dưới layer lib/app, mỗi cột lib/app tượng trưng cho một container mà docker engine quản lý"
- Docker daemon
  - Tiến trình chạy ngầm quản lý các container
- Docker client
  - Kiểm soát hầu hết các workflow của Docker
  - Giao tiếp với các máy chủ Docker thông qua Deamon
- Docker Hub
  - Chứa các compoment Docker
  - Cho phép lưu, sử dụng, tìm kiếm image
  - Vai trò: "ship" trong "Build, ship, deploy"
  - "Docker Hub giúp vận chuyển các image từ dev này đến dev khác thông qua hệ thống revison, tới server để test iteration, tới các deployment platform"

##### Điểm mạnh của Docker:
- Deploy nhanh hơn
  - Hệ thống augmented file system
  - Thêm các layer bên trên root kernel =1101=
    - "Root kernel là system read only.Bạn muốn viết thêm gì lên trên nó thì bản chất là bạn viết thêm một lớp layer khác ở phía trên. Ví dụ: deploy mongodb bạn ghi thêm 1 lớp layer, muốn deploy nodejs thì ghi thêm 1 lớp layer nữa phía trên, Cuối cùng thì các tất cả các layer đó được tổng hợp tạo thành một > tạo ra container mới rất nhanh chóng và gọn nhẹ "
  - Độc lập
    - Lỗi xảy ra với một container không ảnh hưởng đến container khác
  - Cơ động
    - Tránh conflict môi trường
    - Trao đổi giữa các máy
    - Nhất quán khi chạy trên các môi trường khác nhau
  - Chụp ảnh hệ thống (snapshot)
    - Lưu snapshot thành các container hoặc Image
    - Tag
    - Tạo container y hệt từ snapshot
  - Kiểm soát việc sử dụng tài nguyên (CP, RAM, storage, ..)
  - Đơn giản hóa sự phụ thuộc lẫn nhau giữa các ứng dụng (dependency)
    - Xác định dependency ở Dockerfile =1102=
  - Thuận tiện cho việc chia sẻ
    - Docker Hub (private/public registry)
    - Dockerfile

##### Một số lầm tưởng về Docker
- KHÔNG PHẢI công cụ quản lý thiết lập hay thiết lập tự động (Puppet, Chef,..)
- KHÔNG PHẢI giải pháp ảo hóa phần cứng (VMware, KVM,..)
- KHÔNG PHẢI là một nền tảng điện toán đám mây (Openstack, CloudStack,..)
- KHÔNG PHẢI là deployment framework (Capistano, Fabric..)
- KHÔNG PHẢI là một công cụ quản lý workflow (Mesos, Fleet,..)
- KHÔNG PHẢI là một môi trường phát triển (Vagrant,..)

#### 1.3 Cơ chế hoạt động của Docker

##### Kernel
- Phản hồi các thông điệp từ phần cứng
- Khởi tạo và đặt lịch cho các chương trình
- Quẩn lý và hệ thống các tác vụ
- Truyền tin giữa các chương trình
- Phân chia tài nguyên, bộ nhớ, CPU, mạng,...
- Tạo container bằng cách chỉnh thiết lập container

##### Docker
- Viết trên ngôn ngữ Go (1 ngôn ngữ hệ thống)
- Quản lý các đặc tính của kernel
  - 'cgroup': nhóm các tiến trình với nhau và bao lại các tiến trình cùng nhóm trong 1 khoảng không gian ảo riêng, vì thế các container không can thiệp lẫn nhau được
  - 'namespace': chia tách các tầng network nên tập địa chỉ cho các container khác, và các địa chỉ cho những thứ không thuộc container nào.
  - 'copy-on-write': định nghĩa image để nói rằng có image này không thay đổi nhưng bạn có thể chạy những thứ khác trên nó.
- Hướng tiếp cận đã tồn tại vài năm trước khi có docker
- Docker đơn giản hóa việc viết script cho các hệ thống phân tán

##### Socket điều khiển của Docker
- Docker bao gồm 2 phần: client và server
- Server nhận lệnh qua socket (mạng hoặc file)
- Chạy Docker ở máy local: =1104=
- Chạy Docker ở bên trong client =1105= +vds+

#### 1.4 Docker khác gì so với virtual machine?
=1106=
|VM | Docker |
|--------------|-------|
| Công nghệ ảo hóa |Công nghệ container hóa |
| Chạy hệ điều hành riêng trong môi trường phần cứng giả lập được cung cấp bởi hypervisor chạy trên phần cứng vật lý | Container hóa cho phép nhiều ứng dụng chạy trên các partition độc lập trên Linux kernel, và chạy trực tiếp trên phần cứng vật lý |
| Kernel riêng | Kernel chung với hệ điều hành |
| Khởi động cả hệ điều hành | Khởi động một số process |
| Tốc độc chậm | Tốc độ nhanh |
| Cần nhiều tài nguyên | Tiết kiệm tài nguyên |

#### 1.5 Kiến trúc Docker
#### 1.6 Docker Toolbox
#### 1.7 Docker Machine
#### 1.8 Docker Hub



### 2. Cài đặt Docker
#### 2.1 Cài đặt Docker trên Windows
#### 2.1 Cài đặt Docker trên Linux


### 3. Vòng đời Docker
#### 3.1 Giới thiệu image
#### 3.2 Giới thiệu container
#### 3.3 Vòng đời Docker
#### 3.4 bài tập chương 3


### 4. Container
#### 4.1 Cơ chế lưu trữ Container
#### 4.2 Chạy các tiến trình trong container
#### 4.3 Một số lệnh thường dùng với Docker container
#### 4.4 Quản lý container
#### 4.5 Kết nối mạng giữa các container
#### 4.6 Liên kết các container
#### 4.7 Bài tập chương 4


### 5. Image
#### 5.1 Docker registry
#### 5.2 Quản lý image
#### 5.3 Xuất và nhập image
#### 5.4 Volume
#### 5.5 Bài tập chương 5

### 6. Tạo Docker Image
#### 6.1 Dockerfile
#### 6.2 Một số lệnh thường dùng với Dockerfile
#### 6.3 Build image từ Dockerfile
#### 6.4 Bài tập chương 6

### Tổng kết
