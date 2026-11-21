---
title: Thanh tác vụ
description: Sử dụng thanh tác vụ Quickshell ARGVUS.
---

Thanh tác vụ và tiện ích đo từ xa là các bề mặt độc lập trong tiến trình Quickshell do `argvus-bars.service` quản lý. Dùng `argvus-taskbar.service` và `argvus-widget-telemetry.service` để điều khiển từng bề mặt.

Nó truyền đạt các không gian làm việc, trạng thái cửa sổ đang được tập trung, truy cập đồng hồ và lịch, mạng, Bluetooth, âm thanh/phương tiện, thông báo, lưu trữ, ghi âm, giữ máy thức và các hành động nguồn/phiên. Các mô-đun trạng thái chính xác có thể bị ảnh hưởng bởi các nhà cung cấp và phần cứng đã được cài đặt.

Biểu tượng bên trái mở `argvus launcher`. Nó bị vô hiệu hóa theo mặc định. Khi được bật, nó sẽ theo chủ đề đang kích hoạt: bản dựng chủ đề sẽ hiển thị nó bằng màu nổi bật của chủ đề (`taskbar/menu.svg`, từ mẫu `taskbar-menu` của gói này), trong khi các chủ đề ARGVUS Dark/ARGVUS Light tích hợp sẵn sử dụng `menu-default-dark.svg`/`menu-default-light.svg` (cả hai được cung cấp bởi `argvus-branding`). Sử dụng **Control Center → Appearance → Taskbar → Icons → Launcher** để bật/tắt hoặc chọn hình ảnh biểu tượng tùy chỉnh, điều này sẽ ghi đè lên biểu tượng của chủ đề.

Thanh tác vụ không phải là Bảng điều khiển. Thanh này truyền đạt trạng thái và tình trạng liên tục của màn hình; Bảng điều khiển là một bề mặt hành động nhanh có thể mở rộng. Các cửa sổ pop-up của lịch và thiết bị có thể tháo rời là các ứng dụng/bề mặt đi kèm, không phải thanh tác vụ riêng biệt.

Clicking **Memory** or **CPU** opens

bên trong bảng điều khiển màn hình ARGVUS theo chủ đề, với tiêu đề `btop` và chân trang `ARGVUS`. Tab Kitty phía dưới hiển thị gợi ý `Esc Close` đã bản địa hóa. Nhấn `Press q to close` hoặc `q` để đóng. Mô-đun nhiệt độ CPU mở ra phần tổng quan `Esc` trực tiếp, được nhóm theo chip. Mô-đun nhiệt độ GPU xuất hiện khi có sẵn GPU được hỗ trợ và `argvus sensors`; nó hiển thị nhiệt độ GPU cao nhất có thể quy cho hoặc `btop` `N/A` và việc nhấp vào nó sẽ mở các bảng btop chỉ dành cho GPU trong cùng một khung theo chủ đề. btop hỗ trợ tối đa sáu hộp GPU. Số liệu NVIDIA cần hỗ trợ GPU và số liệu NVML, AMD cần ROCm SMI và số liệu Intel cần giao diện sysfs có thể đọc được. Nhiệt độ GPU chỉ được hiển thị khi hệ thống hiển thị kết quả đọc được liên kết với thiết bị đó; Intel nhiệt độ không có sẵn từ btop 1.4.7. Khi btop không thể hiển thị hộp GPU do thiếu hỗ trợ hoặc nhà cung cấp, bảng ARGVUS sẽ báo cáo rằng không có số liệu. ARGVUS không thay đổi quyền của hệ thống.

## Vị trí và khoảng cách

Vị trí mặc định là cạnh trên trong chế độ dock. Trung tâm điều khiển hiển thị vị trí thanh tác vụ và lề thanh tác vụ/vỏ dưới **Appearance → Taskbar → Position** và **Spaces**, và nhóm tiện ích dưới **Appearance → Taskbar → Icons**. Trạng thái bố cục lưu giữ các lề độc lập ở trên, trái, phải và dưới. Chế độ dính mặc định lề dưới là `2` và giữ thanh gần cạnh; Chế độ giãn cách sử dụng lề vỏ `18` đơn vị mặc định.


Bộ điều khiển vị trí thanh tác vụ hiện đang chọn **Trên cùng** hoặc **Dưới cùng**. Bốn lề độc lập điều khiển khoảng cách của thanh so với mỗi cạnh màn hình. Nhóm tiện ích có thể sử dụng hành vi **Tự động** hoặc **Luôn mở rộng**. Việc có sẵn module vẫn phụ thuộc vào nhà cung cấp và phần cứng đã cài đặt, vì vậy việc thiếu chỉ số Bluetooth, độ sáng hoặc lưu trữ không được tạo ra bằng cách thay đổi khoảng cách thanh.

**Chiều cao** đặt chiều cao thanh tác vụ thành 24 (mặc định), 28, 32 hoặc 36 pixel. **Viền** bật hoặc tắt viền thanh tác vụ và đặt độ dày của nó thành 1, 2 hoặc 3 pixel. Độ dày này áp dụng cho cửa sổ thanh tác vụ, các nhóm `right-0`, `right-1`, `focus` và `right-2`, cũng như viền của trình phát MPRIS. Không gian làm việc đang hoạt động hiển thị màu đảo ngược trên nền hình chữ nhật. Chú giải dùng màu sắc và phông chữ của chủ đề đang hoạt động. Khi viền tắt, những viền đó được ghi là `0px`. Cả hai đều là bản nháp trong **Trung tâm điều khiển → Giao diện → Thanh tác vụ** cho đến khi **[ Áp dụng ]** được chọn.

**Trung tâm điều khiển → Giao diện → Thanh tác vụ → Biểu tượng → Mô-đun tùy chọn** điều khiển việc hiển thị của các mô-đun trạng thái và hành động tùy chọn. Các không gian làm việc, tiêu đề cửa sổ đang tập trung, Cài đặt và Nguồn vẫn sẵn có. **Hiển thị không gian làm việc** chọn nhãn không gian làm việc (mặc định) hoặc biểu tượng ứng dụng. Trình phát MPRIS hiển thị chi tiết bài hát trong chú giải công cụ của chúng; trình phát không còn sử dụng nhịp màu liên tục nữa.

## Độ trong suốt và làm mờ

Sử dụng **Trung tâm điều khiển → Giao diện → Thanh tác vụ** để cấu hình Biểu tượng tiện ích, Độ trong suốt và Làm mờ. Độ trong suốt và Làm mờ mỗi cái đều có công tắc bật/tắt và một giá trị `0–100%`. Thay đổi giá trị bằng `+` và `-` theo bước 5%; các thay đổi là dự thảo cho đến khi **[ Áp dụng ]** được chọn. Chủ đề mới mặc định cả hai hiệu ứng đều bật ở `50%`.
Sử dụng `↑/↓` để di chuyển giữa các hàng bật và giá trị. Nhấn `Tab` cho **Hành động**, sau đó kích hoạt **[ Áp dụng ]**.

## Cấu hình và ghi đè

The taskbar configuration is owned by


## Cửa sổ và các bảng

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Đồng hồ và Tập trung

Module thời gian (`clock#time`) mở hoặc ẩn cửa sổ bật lên ARGVUS Clock và truyền tọa độ nhấp gốc của nó để có thể căn chỉnh với thanh tác vụ và màn hình đã nhấp. Chỉ báo Focus có nhóm `focus` riêng nằm giữa nhóm mạng/hiệu suất (`right-1`) và ngày/giờ (`right-0`). Nó chạy `argvus focus status --waybar --follow` mà không tải GTK: khi nhàn rỗi, nó hiển thị biểu tượng hẹn giờ, và trong giai đoạn tập trung hoặc nghỉ, nó thêm `MM:SS` còn lại; màu sắc của nó xác định giai đoạn và trạng thái tạm dừng. Nhấp vào nó mở hoặc ẩn cửa sổ bật lên Focus tại vị trí nhấp đó. Cả hai cửa sổ bật lên cũng đóng bằng **Esc** hoặc nhấp ra ngoài.

## Đang tải lại

Dịch vụ chính là `argvus-taskbar.service`. Khi một thay đổi cấu hình được ghi chép yêu cầu tải lại thủ công, hãy sử dụng bộ điều khiển phiên:

```sh
argvus sessionctl restart taskbar
```

 for the installed and user paths.cho các đường dẫn đã cài đặt và người dùng.(/docs/argvus-waybar/) path.

Các tiện ích sụp xuống thành một bộ mở rộng ở chế độ di chuột và hiển thị các điều khiển được bật khi con trỏ vào. Hiển thị khay hệ thống kiểm soát các biểu tượng ứng dụng nền; khay trống không có biểu tượng hiển thị. Trình bày biểu tượng không gian làm việc hiển thị các biểu tượng ứng dụng cho các cửa sổ đang mở cùng với nhãn không gian làm việc. Các không gian làm việc dự án

##

Các dự án đang mở xuất hiện dưới dạng các nút không gian làm việc thông thường, được gắn nhãn `Project: name`; nhấp vào một nút sẽ tập trung vào nó. Di chuột sẽ hiển thị đầy đủ đường dẫn dự án và phím tắt `SUPER + ALT + N`. Chỉ các không gian làm việc đang mở trên màn hình của thanh công cụ mới được hiển thị; bộ chọn (`SUPER + O`) vẫn giữ nguyên toàn bộ danh mục dự án. Các không gian làm việc đặc biệt giữ nguyên chính sách hiển thị hiện tại của chúng.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

Mô-đun **Cập nhật Trạng thái** có nhóm riêng nằm giữa Tiện ích và mạng/hiệu suất và hiển thị số lượng gói cập nhật có sẵn. Nó kiểm tra các kho chính thức khi khởi động và mỗi giờ bằng `checkupdates` (từ `pacman-contrib`), mà không nâng cấp gói. **Kiểm tra AUR** mặc định tắt; khi bật, nó kiểm tra với `paru` hoặc `yay`. Chú giải công cụ tách các nguồn và báo cáo lỗi; `?` có nghĩa là tổng số chưa đầy đủ. Nhấp vào mô-đun để mở các bản cập nhật chính thức trong Gói. Cấu hình cả hai tùy chọn dưới **Biểu tượng → Mô-đun tùy chọn** và áp dụng bản nháp thanh tác vụ. Mô-đun được bật theo mặc định.

Chỉ báo mạng trên thanh tác vụ theo dõi các sự kiện của NetworkManager sử dụng `argvus networkctl waybar --follow`, với một bản chụp ban đầu và tự động kết nối lại giám sát. Nó không còn chờ khoảng thời gian kiểm tra 10 giây nữa. Kết nối, truy cập Internet hạn chế và ngắt kết nối vẫn là các trạng thái khác nhau. Trạng thái Wi-Fi đọc các điểm truy cập đã lưu mà không yêu cầu quét. `argvus networkctl waybar` phát ra một bản chụp Waybar JSON duy nhất.

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

Sau khi thao tác gói trong Control Center kết thúc (gồm nâng cấp chính thức và AUR), thanh tác vụ tự động kiểm tra các bản cập nhật còn lại mà không khởi động lại. Việc kiểm tra cũng diễn ra sau lỗi vì một số gói có thể đã thay đổi. Kiểm tra hàng giờ vẫn hoạt động để phát hiện các thao tác ngoài Control Center.

### Điều hướng theo màn hình

Trước/sau chỉ duyệt vòng các không gian hiện có trên màn hình đang được chọn: số trước, rồi tên và dự án theo tên gốc. Cuộn trên thanh tác vụ dùng màn hình dưới con trỏ. Không gian đặc biệt bị loại và tạm dừng chu kỳ khi mở. Phím tắt số giữ ID toàn cục. Phân công vẫn ở `/displays/workspaces`.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

Bảng tạm được bật mặc định và mở từ nhóm tiện ích trên thanh tác vụ. Để dừng ghi lại văn bản và hình ảnh, bỏ chọn mục này trong Control Center → Appearance → Taskbar → Icons → Optional modules rồi chọn Apply. Biểu tượng sẽ ẩn và chỉ có thể mở lại lịch sử sau khi bật lại. Các mục đã lưu vẫn được giữ.

Nội dung phát trong trình duyệt chỉ xuất hiện khi trình phát xác định Spotify là nguồn. Chú giải khi di chuột không có viền.
