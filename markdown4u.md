## Tìm hiểu về  Markdown

> Tài liệu: Viết tài liệu với Markdown

================

### Mục lục

[1. Giới thiệu Markdown?](#1)

- [1.1 Giới thiệu](#11)
- [1.2 Ứng dụng](#12)
- [1.3 Tại sao phải dùng Markdown](#13)

[2. Các cú pháp thường gặp](#2)

- [2.1 Thẻ tiêu đề ](#21)
- [2.2 Chèn link, ảnh](#22)
- [2.3 In đậm, in nghiêng](#23)
- [2.4 Gạch đầu dòng, danh sách ](#24)
- [2.5 Chú thích ](#25)
- [2.6 Chèn bảng ](#26)
- [2.7 Tạo điểm nhấn ](#27)
- [2.8 Chèn code ](#28)
- [2.8 Trích mã ](#29)


[3. Các công cụ thường dùng](#3)

[4. Chốt](#4)

[5.  Tài liệu](#5)

---

<a name='1'></a>
### Giới thiệu Markdown

<a name='11'></a>
### 1.1 Giới thiệu


Năm 2004, cùng với sự giúp đỡ của Aaron Swartz, John Gruber đã tạo ra ngôn ngữ Markdown  với mục tiêu tạo ra một định dạng văn bản thô "dễ viết và dễ đọc, dễ dàng chuyển thành XHML hoặc HTML". Mardown là một ngôn ngôn ngữ đánh dấu với cú pháp văn bản thô.

<a name='12'></a>
### 1.2 Ứng dụng

Markdown thường dùng để:
- Tại ra các tập tin README, wiki cho các dự án mã nguồn mở trên github, họ cũng dùng để comment (hỗ trợ trên nhiều trang web, diễn đàn)
- Markdown còn dùng để  viết sách, truyện với các thành phần cơ bản.
- Markdown còn dùng để viết blog, tin tức như chính mục tiêu ban đầu của tác giả.
- Ngoài ra có thể kết hợp với impress.js thành một công cụ presentation vô cùng độc đáo là Hekyll.

<a name='13'></a>
### 1.3 Tại sao phải dùng Markdown

Sự phổ biến của HTML khiến ngôn ngữ này được sử dụng rộng rãi trong các ứng dụng Internet từ các trang web hay rất nhiều tài liệu khác. Tuy nhiên một vấn đề  gặp phải có lẽ đó là cú pháp HTML không được thân thiện, đơn giản cho lắm. Vì vậy nếu không có kiến thức về nó thì sẽ rất khó khăn. Markdown ra đời, có lẽ sau đây chúng ta sẽ hiểu vì sao cần đến nó.

<a name='2'></a>
### 2 Các cú pháp thường gặp

Markdown sử dụng khá đơn giản với một số cú pháp dễ nhớ. TUy nhiên chúng có nhiều các viết có thể cho những nơi khác nhau như Github, blog như đã nói ở trên. Chúng ta sẽ tìm hiểu qua một chút về cú pháp cơ bản.
> Còn rất nhiều [cú pháp khác](https://daringfireball.net/projects/markdown/syntax)

<a name='21'></a>
##### 2.1 Thẻ tiêu đề (header)

Markdown sự dụng kí tự # để bắt đầu cho các thẻ tiêu đề (có thể dùng 1 kí tự __#__ đến 6 ký tự __######__)

Ví dụ:

`# Tiêu đè cấp 1`
# Tiêu đề cấp 1

.
.
.
.

` ###### Tiêu đè cấp 6`
###### Tiêu đề cấp 6

<a name='22'></a>
##### 2.2 Chèn link, ảnh

-- Để  chèn hyperlink bạn chỉ cần dán link vào file .md

`https://github.com/nvnwater`

aws: https://github.com/nvnwater

-- hoặc cũng có thể rút ngắn với cú pháp sau:

`[nvnwater](https://github.com/nvnwater)`

aws: [nvnwater](https://github.com/nvnwater)

-- Đề chèn ảnh bạn có thể chèn trực tiếp hoặc qua link

`<img src="link_img" >`

`![chú_thích](link_img)`

`![chú_thích](/directory)`

<a name='23'></a>
###### 2.3 In đậm, In nghiêng
`**Từ cần in đậm**`

hoặc: `__Từ cần in đậm__`

aws: __Từ cần in đậm__

<a name='24'></a>
###### 2.4 Gạch đầu dòng, danh sách

Để gạch đầu dòng hoặc có thể như 1 danh sách bạn có thể dùng:

```
- Gạch đầu dòng thứ 1
<ul>
<li>Thụt đầu dòng thứ 1.1</li>
<li>Thụt đầu dòng thứ 1.2</li>
<li>Thụt đầu dòng thứ 1.3</li>
</ul>
- Gạch đầu dòng thứ 2
<ul>
<li>Thụt đầu dòng thứ 2.1</li>
<li>Thụt đầu dòng thứ 2.2</li>
<li>Thụt đầu dòng thứ 2.3</li>
</ul>
```

hoặc có thể dùng **Enter** và **Tab** để tạo như sau:

```
- Gạch đầu dòng thứ 1

	- Thụt đầu dòng thứ 1.1

	- Thụt đầu dòng thứ 1.2

- Gạch đầu dòng thứ 2

	- Thụt đầu dòng thứ 2.1

	- Thụt đầu dòng thứ 2.2
```
aws:
- Gạch đầu dòng thứ 1

	- Thụt đầu dòng thứ 1.1

	- Thụt đầu dòng thứ 1.2

- Gạch đầu dòng thứ 2

	- Thụt đầu dòng thứ 2.1

	- Thụt đầu dòng thứ 2.2

<a name='25'></a>
##### 2.5 Chú thích cuối trang

Chú thích[^1], chú thích[^2]

- [^1]: Chú thích 1
- [^2]: Chú thích 2

<a name='26'></a>
##### 2.6 Chèn bảng

```
| Cột 1 Hàng 1 | Cột 2 | Cột 3| Cột 4 |
|--------------|-------|------|-------|
| Hàng 2 | 2 x 1 | 2 x 2 | 2 x 3 | 2 x 4 |
| Hàng 3 | 3 x 1 | 3 x 2 | 3 x 3 | 3 x 4 |
| Hàng 4 | 4 x 1 | 4 x 2 | 4 x 3 | 4 x 4 |
```

Kết quả:

| Cột 1 Hàng 1 | Cột 2 | Cột 3| Cột 4 |
|--------------|-------|------|-------|
| Hàng 2 | 2 x 1 | 2 x 2 | 2 x 3 | 2 x 4 |
| Hàng 3 | 3 x 1 | 3 x 2 | 3 x 3 | 3 x 4 |
| Hàng 4 | 4 x 1 | 4 x 2 | 4 x 3 | 4 x 4 |


<a name='27'></a>
##### 2.7 Tạo điểm nhấn

Để tạo điểm nhấn bạn dùng cặp dấu **== ==**

[Tham khao](https://markdown-it.github.io/ )

<a name='28'></a>
##### 2.8 Chèn code

	``` code
	print("This is synktax on python 3.5");
	```
  ``` sh
	print("This is synktax on python 3.5");
	```
aws:

``` code
print("This is synktax on python 3.5");
```
``` sh
print("This is synktax on python 3.5");
```

<a name='29'></a>
##### 2.9 Trích dẫn

-- Có thể sử dụng cặp dấu `` hoặc `````` để tạo trích dẫn

`trích dẫn`

<a name=3></a>
### 3 Các công cụ thường dùng

Chúng ta có thể sử dụng bất cứ trình soạn thảo nào như sublime, notepad, atom, vim,.. để  viết Mardown với đuôi file là __.md__. Bạn có thể viết Mardown online qua các trang web sau:

- https://stackedit.io/editor
- https://jbt.github.io/markdown-editor/
- http://www.tablesgenerator.com/markdown_tables
- https://markable.in/editor/

> Có thể chuyển sang các định dạng khác như HTML trực tiếp với các công cụ trực tuyến này.

<a name="4"></a>
### 4. Kết luận
##### Ưu điểm.
Đây là một ngôn ngữ cơ bản dễ dùng giúp ta có thể sử dụng rất nhiều nơi với cú pháp cơ bản. Có lẽ đây là ưu điểm lớn nhất của Markdown.
##### Nhược điểm.
Nhược điểm lớn nhất của Markdown có lẽ là khả năng cộng tác trong Markdown và theo giỏi những thay đổi. Vì đơn giản nên chỉ có thể dùng cho các dự án nhỏ lẻ, bài blog và tất nhiên những dự án lớn hay những quyển sách cần nhiều hơn những thứ mà Markdown hỗ trợ.

<a name="5"></a>
### 5. Tài liệu tham khảo

https://vi.wikipedia.org/wiki/Markdown

https://github.com/hocchudong/git-github-for-sysadmin
