Simple docker-based flask+NGINX deployment

#### Tại sao sử dụng NGINX cho Flask

Có thể bạn chỉ cần cấu hình Flask để chạy với dòng code: _app.run(host='0.0.0.0', port=80)_ ở cuối, và không cần sử dụng Nginx bằn cách thực hiện câu lệnh __python myapp.py__

Có 3 nhược điểm khi làm điều này (1 big & 2 little):
- Hạn chế chính của việc dựa vào __app.run(host='0.0.0.0', port=80)__ là nó sử dụng Flask's built-in server, nó được xây dựng và phát triển cho local và không được sử dụng trong production. Nó không thể handle much traffic & isn't very robust. Apache và Nginx là các battle-tested, high quality, robust và nó rất very widely used trong production.
- Nếu bạn chạy _python myapp.py_ trong phiên ssh, ứng dụng của bạn sẽ đóng khi bạn đóng phiên kết nối ssh (đây là vấn đề mình gặp trước khi viết bài viết này). Có giải pháp khác phục việc này bằng cách bạn running nó trong một thứ gì đó như __tmux, byobu,...__
- Nếu máy chủ của bạn khởi động lại, ứng dụng cũng sẽ không khởi động lại trừ khi bạn ssh và khởi động lại. Một cách khắc phục điều này là bạn gán cho nó một cron job. Nhưng điều đó chỉ nên khi bạn còn sử dụng Flask's little development server.

#### Is there an easier way?
Deloying Flask apps on Linux servers??? Nginx, một trong những web servers hàng đầu thay thế cho Flask apps.
Đồng thời trong thời gian này mình đã học cách sử dụng Docker. Có image Docker with Flask & Nginx, đây là một cách dễ dàng để có một Flask app chạy trên production web server.

#### Let’s start: Launch an GC instance
Trước tiên khởi chạy một new instance sử  dụng image ubuntu
Add rule with port 80(http) và 22(ssh)
SSH into your instance

#### Install the prerequisites
Sau khi ssh vào server, update && upgrade packages.
install python, pip, git, docker và sử dụng pip để cài đặt virtualenv.























finish
