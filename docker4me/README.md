# Docker

### 1. Giới thiệu

#### 1.1. Giới thiệu

Kiến thức có được:
- Hiểu được các thành phần cấu thành nền tảng Docker
- Hiểu được các khái niệm cốt lõi: container và image
- Chạy và quản lý Docker container sử dụng image có sẵn
- Tạo image từ container
- Tự tạo image từ Dockerfile
- Upload và download image
- Thiết lập cấu hình mạng và chạy các container cùng mạng
- Cấu hình mà mount volume trên các container

Yêu cầu:
- Kiến thức cơ bản về lập trình
- CLI căn bản
- Công nghệ ảo hóa
- Kiến thức mạng
- Bash & shell script

#### 1.2. Docker là gì

##### Docker là gì:

Dự án mã nguồn mở trên Github: https://github.com/docker
Tên công ty xây dựng nên nó (tên cũ: dotCloud)

- dotCloud chuyên cung cấp các dịch vụ điện toán đám mây
- Hiện tại chỉ tập trung và lĩnh vực container
- Trang chủ: https://www.docker.com/

##### Docker dùng để làm gì:

Tạo ra các container cho các ứng dụng phần mềm: ở mức độ Linux, VM, Applicaton,...

Vận chuyển container đến các môi trường dev hoặc hỗ trợ việc chia sẻ cho cac dev khác

##### Khẩu quyết của Docker:

Build, ship and deploy any application, anywhere
- Build: đóng gói app trong 1 container
- Ship: vận chuyển container
- Deploy: triển khai, chạy container
- Any app chạy được trên Linux
- Anywhere: server, cloud instaince,..

```code
Đóng gói phần mềm dễ dàng
Deploy nhanh
Không cần cấu hình và môi trường cài đặt rườm rà
```

- Image: compoment để triển khai ứng dụng bao gồm: mã nguồn, thư viện, framework, file,..
  - Trừu tượng hóa giải pháp và đóng gói vào một image kèm dependencies
  ==> Tránh conflict môi trường triển khai

Batteries included but replaceable
- Một compoment có thể được dễ dàng thay thế bằng cách implement cùng 1 interface có sẵn
- Docker framework được phân chia thành các module có khả năng mở rộng cao.
  - Các compoment có thể thay thế bằng các compoment tương tự từ hãng thứ 3, thậm chí chức năng còn ưu việt hơn

##### Một số thuật ngữ:

_Image:_
  - Khuôn mẫu, lớp chia chứa các file cần thiết để tạo nện một container
  - Chứa nh tài nguyên có sẵn
  - Không được tiếp cận CPU, memory, storage,..

_Container:_
  - Tồn tại trên host với một IP
  - Được deploy, chạy và xóa bỏ thông qua remote client

<img src=''>

_Docker engine:_
  - Tạo và chạy container
  - Chạy lệnh trong chế độ daemon
  - Linux trở thành máy chủ Docker
  - Container được deploy, chạy, xóa bỏ qua remote client
  - "Docker engine nằm trên layer OS và nằm dưới layer lib/app, mỗi cột lib/app tượng trưng cho một container mà docker engine quản lý"

_Docker daemon_
  - Tiến trình chạy ngầm quản lý các container

_Docker client_
  - Kiểm soát hầu hết các workflow của Docker
  - Giao tiếp với các máy chủ Docker thông qua Deamon

_Docker Hub_
  - Chứa các compoment Docker
  - Cho phép lưu, sử dụng, tìm kiếm image
  - Vai trò: "ship" trong "Build, ship, deploy"
  - "Docker Hub giúp vận chuyển các image từ dev này đến dev khác thông qua hệ thống revison, tới server để test iteration, tới các deployment platform"

##### Điểm mạnh của Docker:

Deploy nhanh hơn
- Hệ thống augmented file system
- Thêm các layer bên trên root kernel

  ![](img/1101.png)

  Root kernel là system read only.Bạn muốn viết thêm gì lên trên nó thì bản chất là bạn viết thêm một lớp layer khác ở phía trên. Ví dụ: deploy mongodb bạn ghi thêm 1 lớp layer, muốn deploy nodejs thì ghi thêm 1 lớp layer nữa phía trên, Cuối cùng thì các tất cả các layer đó được tổng hợp tạo thành một > tạo ra container mới rất nhanh chóng và gọn nhẹ

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
  - Xác định dependency ở Dockerfile

  ![](img/1102.png)

- Thuận tiện cho việc chia sẻ
  - Docker Hub (private/public registry)
  - Dockerfile

##### Một số lầm tưởng về Docker

- KHÔNG PHẢI công cụ quản lý thiết lập hay thiết lập tự động (Puppet, Chef,..)
- KHÔNG PHẢI giải pháp ảo hóa phần cứng (VMware, KVM,..)
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
- Chạy Docker ở máy local:

![](img/1104.png)

- Chạy Docker ở bên trong client

![](img/1105.png)

#### 1.4 Docker khác gì so với virtual machine?

![](img/1106.png)


|VM | Docker |
|--------------|-------|
| Công nghệ ảo hóa |Công nghệ container hóa |
| Chạy hệ điều hành riêng trong môi trường phần cứng giả lập được cung cấp bởi hypervisor chạy trên phần cứng vật lý | Container hóa cho phép nhiều ứng dụng chạy trên các partition độc lập trên Linux kernel, và chạy trực tiếp trên phần cứng vật lý |
| Kernel riêng | Kernel chung với hệ điều hành |
| Khởi động cả hệ điều hành | Khởi động một số process |
| Tốc độc chậm | Tốc độ nhanh |
| Cần nhiều tài nguyên | Tiết kiệm tài nguyên |

Lựa chọn Docker và VM
- VM: phân tách tài nguyên phần cứng rõ ràng
- Docker: phân tách tài nguyên tương đối, ứng dụng đóng gói dễ dàng kèm dependency


#### 1.5 Kiến trúc Docker

![](img/1107.png)

Kiến trúc client-server
3 thành phần chính:
- Docker Client
- Docker Host
- Docker Registry (Hub)

Docker Daemon nhận lệnh từ Docker client thông qua CLI hoặc REST-API

Docker Client ở trên cùng host hoặc khác host với Docker Daemon

Docker Hub: dịch vụ lưu trữ, chia sẻ image

Nhiều container có thể liên kết với nhau để tạo kiến trúc ứng dụng đa tầng. Nếu đóng nhiều container và chưa commit thì mọi thay đổi trên container sẽ bị mất.

#### 1.6 Docker Toolbox

Là bộ cài đặt Docker cho môi trường Windows và Mac dành cho những thiết bị không đạt yêu cầu để cài đặt bộ cài đặt mới.

Bao gồm các công cụ:

- Docker Machine: quản lý host bằng các lệnh docker-machine
- Docker engine: chạy các lệnh docker
- Docker Compose: thiết lập việc chạy nhiều container trong Docker
- Kitematic: giao diện hiển thị cho Docker
- Shell thiết lập sẵn để phục vụ cho môi trường CLI trên docker
- Oracle virtualbox ảo

#### 1.7 Docker Machine

Công cụ giúp cài đặt Docker Engine trên các host ảo
Quản lý các host đó bằng lệnh docker-manchine
Từng là cách duy nhất để chạy Docker trên Windows và Mac trước Docker v1.12

##### Docker machine dùng để làm gì?

![](img/1108.png)

Máy thuộc OS Windows/Mac đời cũ
Tạo docker host trên các hệ thống remote
- Cài docker machine trên win,linux,mac
- Mỗi host machine = 1 docker host + 1 docker client

##### Docker Engine vs Docker Machine

![](img/1109.png)

_Docker Engine_
- Mô hình client-server
- Tạo bởi Docker daemon, REST API, docker client CLI

_Docker Machine_
- Quản lý docker host


#### 1.8 Docker Hub

Dịch vụ registry trên cloud
Kết nối tới code repository, build, test và deploy image
Cung cấp tài nguyên một cách tập trung cho việc tìm kiếm image, phân phối và quản lý các thay đổi của image
DevOps và developer có thể dùng các image một cách tự động và theo flow

##### Tính năng của Docker Hub

Image repository: tìm kiếm, lưu trữ, push và pull image cho cộng đồng người dùng docker
Build tự động: build những image khi có sự thay đổi code cho sản phẩm
Webhook: là 1 tính năng của tự động build, webhook thông báo cho các bạn biết khi có push thành công lên repository.
Tổ chức: tạo nhóm làm việc để quản lý truy cập vào image repository.
Tích hợp Github và Bitbucket

Đăng ký tại: https://hub.docker.com/

### 2. Cài đặt Docker

#### 2.1 Cài đặt Docker trên Windows

#### 2.1 Cài đặt Docker trên Linux

```sh
# First import the GPG key to trust app from docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
      --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# Next, point the package manager to the official Docker repository
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
# Update the package database
 sudo apt update
# Install Docker
sudo apt install docker-engine
# Start docker server
sudo service docker start
sudo docker run hello-world
#
sudo groupadd docker
sudo usermod -aG docker nvn(username)
logout
# Run a Docker container using the official Ubuntu image
docker run -it ubuntu bash

```

### 3. Vòng đời Docker
#### 3.1 Giới thiệu image
Docker Image là file chứa đựng những thứ đủ để tạo được một hệ điều hành
để phục vụ cho 1 công việc nhất định.
Thường thì bạn cài 1 OS để đủ các ứng dụng bạn cần để làm việc
Sử dụng docker bạn có thể cấu hình, tạo ra các container chỉ với những tài nguyên thực sự cần thiết. Và bạn thậm chí có thể tạo rất nhiều những container như vậy trên máy của mình không bị nặng máy như bạn chạy nhiều máy ảo cùng 1 lúc
`docker images`
```sh
nvn@water ~ $ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              f975c5035748        4 weeks ago         112MB
centos              latest              2d194b392dd1        4 weeks ago         195MB
REPOSITORY: nơi tạo ra image
TAG: version
```

#### 3.2 Giới thiệu container

Chạy container từ image có sẵn:
`docker run -it ubuntu bash` '-ti: nhận input từ bàn phím'
```sh
nvn@water ~ $ docker run -ti ubuntu:latest bash
root@560ec4856f91:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@560ec4856f91:/# pwd
/
root@560ec4856f91:/# cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.4 LTS"
root@560ec4856f91:/#

nvn@water ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
2a92201ef89f        ubuntu              "bash"              7 seconds ago        Up 7 seconds                            determined_wescoff
560ec4856f91        ubuntu:latest       "bash"              About a minute ago   Up About a minute                       elated_heisenberg

```

#### 3.3 Vòng đời Docker
Quy trình Docker
-Mỗi bản build tạo ra một image nhất định
-Container là một instance của image
- __Dockerfile__ _build_ __Image__ _run_ __Containers__

Khi ở trong một container khởi tạo từ 1 image thì image đó là cố định - không bao giờ bị thay đổi

```sh
root@560ec4856f91:/# touch NEW_FILE
root@560ec4856f91:/# ls
NEW_FILE  bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

root@2a92201ef89f:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```

__Image__  _run_  __Containers__  _stop_  __Stop_container__  _commit_  __Image__

```sh
nvn@water ~ $ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
2a92201ef89f        ubuntu              "bash"              10 minutes ago      Up 10 minutes                           determined_wescoff
nvn@water ~ $ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
2a92201ef89f        ubuntu              "bash"                   10 minutes ago      Up 10 minutes                                     determined_wescoff
560ec4856f91        ubuntu:latest       "bash"                   11 minutes ago      Up 11 minutes                                     elated_heisenberg
9b26edec3d91        ubuntu:latest       "bash"                   12 minutes ago      Exited (130) 11 minutes ago                       infallible_pike
942249b4d20f        ubuntu              "bash -c 'sleep 3;..."   3 days ago          Exited (0) 3 days ago                             upbeat_jones
27c5993988d8        centos              "/bin/bash"              3 days ago          Exited (0) 3 days ago                             friendly_poitras
```
status - giá trị trả về của bất kỳ process mà bạn chạy
- status 0: thành công
- status 130: thoát bởi Ctrl + D, Ctrl + C
- status 127:
- status 126: câu lệnh không chạy
- status 125: bản thân docker bị lỗi

```sh
NEW_FILE  README.txt  bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@560ec4856f91:/# exit
exit
nvn@water ~ $ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
2a92201ef89f        ubuntu              "bash"              18 minutes ago      Up 18 minutes                           determined_wescoff
nvn@water ~ $ docker commit 2a92201ef89f
sha256:e6f9497fe14c09df2c7d5e37b1ce4b8b040a2270d4694fd7bb47d2b44f202c8a
nvn@water ~ $ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              e6f9497fe14c        8 seconds ago       112MB
ubuntu              latest              f975c5035748        4 weeks ago         112MB
centos              latest              2d194b392dd1        4 weeks ago         195MB

nvn@water ~ $ docker run -ti ubuntu:latest bash
root@560ec4856f91:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@560ec4856f91:/# touch README.txt

root@560ec4856f91:/# ls
NEW_FILE  README.txt  bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@560ec4856f91:/# exit
exit

nvn@water ~ $ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
2a92201ef89f        ubuntu              "bash"              18 minutes ago      Up 18 minutes                           determined_wescoff
nvn@water ~ $ docker commit 2a92201ef89f
sha256:e6f9497fe14c09df2c7d5e37b1ce4b8b040a2270d4694fd7bb47d2b44f202c8a

nvn@water ~ $ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              e6f9497fe14c        8 seconds ago       112MB
ubuntu              latest              f975c5035748        4 weeks ago         112MB
centos              latest              2d194b392dd1        4 weeks ago         195MB

nvn@water ~ $ docker tag e6f9497fe14c ubuntu-new
nvn@water ~ $ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
2a92201ef89f        ubuntu              "bash"              20 minutes ago      Up 20 minutes                           determined_wescoff

nvn@water ~ $ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu-new          latest              e6f9497fe14c        2 minutes ago       112MB
ubuntu              latest              f975c5035748        4 weeks ago         112MB
centos              latest              2d194b392dd1        4 weeks ago         195MB

```

#### 3.4 bài tập chương 3
Cài đặt CentOS phiên bản mới nhất
```sh
PS C:\Users\Mr.T> docker run -ti centos bash
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
469cfcc7a4b3: Pull complete
Digest: sha256:989b936d56b1ace20ddf855a301741e52abca38286382cba7f44443210e96d16
Status: Downloaded newer image for centos:latest
```
Kiểm tra version của CentOS
```sh
[root@3974c4eae2ef /]# cat /etc/system-release
CentOS Linux release 7.4.1708 (Core)
```
Tạo folder mới ở thư mục /home

```
[root@3974c4eae2ef /]# cd /home/
[root@3974c4eae2ef home]# mkdir conf
```

Copy file /etc/yum.conf vào thư mục /home/conf

```
[root@3974c4eae2ef home]# cp /etc/yum.conf /home/conf
[root@3974c4eae2ef home]# ls /home/conf/
yum.conf
[root@3974c4eae2ef home]# exit
```
Tạo image từ container vừa thoát và đặt tag là "custom-centos"

```
docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
3974c4eae2ef        centos              "bash"              12 minutes ago      Exited (0) 4 seconds ago                       nervous_pike
PS C:\Users\Mr.T> docker commit 3974c4eae2ef custom-centos
sha256:b07cf8bf9530f914409d6dbc2e611162196682758861e4d11216ab1515212342
PS C:\Users\Mr.T> docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
custom-centos       latest              b07cf8bf9530        4 seconds ago       199MB
ubuntu-2            latest              fda4011da756        17 minutes ago      113MB
ubuntu-new          latest              e3be76c526ce        20 minutes ago      113MB
ubuntu              16.04               c9d990395902        7 days ago          113MB
ubuntu              latest              c9d990395902        7 days ago          113MB
hello-world         latest              e38bc07ac18e        8 days ago          1.85kB
centos              latest              e934aafc2206        13 days ago         199MB
fedora              23                  60ba3309bebb        19 months ago       214MB
```


### 4. Container
#### 4.1 Cơ chế lưu trữ Container
#### 4.2 Chạy các tiến trình trong container

##### docker run
- Container có tiến trình chính
- Container dừng khi tiến trình chính kết thúc
- Container có thể  được đặt tên

```
nvn@water ~ $ docker run -ti --rm ubuntu sleep 3
nvn@water ~ $ docker run -ti ubuntu bash -c 'sleep 3; echo job finished' --rm
job finished
Khi muốn thực hiện công việc A, sau khi kết thúc thì thực hiện công việc B.

nvn@water ~ $ docker run -ti -d ubuntu bash
4e2958ddf897c66e70d722409c0d5e4302519aa15cdd5b402b75131374953504
nvn@water ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
4e2958ddf897        ubuntu              "bash"              14 seconds ago      Up 13 seconds                           admiring_blackwell
nvn@water ~ $ docker attach admiring_blackwell
root@4e2958ddf897:/#
root@4e2958ddf897:/#
```

##### Docker attach
```
nvn@water ~ $ docker run -ti -d ubuntu bash
4e2958ddf897c66e70d722409c0d5e4302519aa15cdd5b402b75131374953504
nvn@water ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
4e2958ddf897        ubuntu              "bash"              14 seconds ago      Up 13 seconds                           admiring_blackwell
nvn@water ~ $ docker attach admiring_blackwell
root@4e2958ddf897:/#
root@4e2958ddf897:/#
```

##### Docker exec
- Khởi tạo một process khác bên trong container đã có
- Tiện lợi cho việc debug và quản lý database
- Không thể tăng thêm port, volume

```
root@6ecb57085b2c:/# nvn@water ~ $ docker attach adoring_pasteur
root@6ecb57085b2c:/#
root@6ecb57085b2c:/# ls
bin  boot  dev  ebook.txt  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@6ecb57085b2c:/#
```

```
nvn@water ~ $ docker exec -ti adoring_pasteur bash
root@6ecb57085b2c:/# touch ebook.txt
root@6ecb57085b2c:/# ls
bin  boot  dev  ebook.txt  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@6ecb57085b2c:/#
```

#### 4.3 Một số lệnh thường dùng với Docker container
##### Docker create
- Tạo ra container với các config tương tự docker run
- Container không được chạy ngay từ đầu
- Dùng lệnh Docker start để chạy container

```
nvn@water ~ $ docker create -ti ubuntu bash
cba4d70fe9ca0064fd39b1da8a97af075839705e0c313574fdc26dc1cc75cf19
nvn@water ~ $ docker ps -a | head -n2
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS                     PORTS               NAMES
cba4d70fe9ca        ubuntu              "bash"                   3 seconds ago        Created                                        sleepy_sinoussi
```

##### Docker start/stop/restart
- Thay đổi trạng thái của container, từ running sang stopped hoặc khởi động lại container
- Stop:
  - Gửi tín hiệu SIGTERM để y/c tắt tiến trình
  - Gửi tín hiệu SIGKILL nếu chưa tắt sau một khoảng thời gian nhất định

```
nvn@water ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
cba4d70fe9ca        ubuntu              "bash"              4 minutes ago       Up 4 minutes                            sleepy_sinoussi
0db59fea0fb4        ubuntu              "bash"              3 hours ago         Up 3 hours                              mystifying_booth
4e2958ddf897        ubuntu              "bash"              4 hours ago         Up 4 hours                              admiring_blackwell
nvn@water ~ $ docker stop cba4d70fe9ca
cba4d70fe9ca
nvn@water ~ $ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
cba4d70fe9ca        ubuntu              "bash"                   5 minutes ago       Exited (0) 35 seconds ago                       sleepy_sinoussi
```
```
nvn@water ~ $ docker start -ai cba4d70fe9ca
root@cba4d70fe9ca:/#
```


```
nvn@water ~ $ docker restart 9255fcd3ccd5
9255fcd3ccd5
nvn@water ~ $ docker ps -a | head -n3
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
9255fcd3ccd5        ubuntu              "bash"                   8 minutes ago       Up 7 seconds                                   priceless_nightingale
```

##### Docker cp
- Copy dữ liệu (file/folder) từ container tới local machine và ngược lại
- Áp dụng cho cả stopped và running container
- Đường dẫn relative:
  - sharp_bell: /tmp/ebook.txt
  - sharp_bell: tmp/ebook.txt

```
nvn@water ~ $ docker cp ebook.txt priceless_nightingale:/root/ebook.txt
nvn@water ~ $ docker start priceless_nightingale
priceless_nightingale
nvn@water ~ $ docker attach priceless_nightingale
root@9255fcd3ccd5:/#
root@9255fcd3ccd5:/# cd /root/
root@9255fcd3ccd5:~# ls
ebook.txt
root@9255fcd3ccd5:~#
```

##### Docker inspect
- Kiểm tra các thiết lập của Docker (network, driver,...)
- In ra các thông tin dưới dạng JSON


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
