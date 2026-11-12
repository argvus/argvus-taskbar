---
title: Widget
description: Cấu hình các tiện ích theo dõi hệ thống tùy chọn.
---

`argvus widget-telemetry` cung cấp một bề mặt Waybar phụ tùy chọn để hiển thị thông tin hệ thống. Các khối hiện tại của nó là **Hệ thống**, **CPU/GPU**, **Bộ nhớ**, **Lưu trữ**, **Quy trình**, **Mạng** và **Phím tắt**. Khối Phím tắt được lưu với khóa `keys` trong tệp trạng thái.

Sử dụng **Control Center → Appearance → Widget Telemetry** để bật giao diện và bật hoặc tắt các khối riêng lẻ. Vô hiệu hóa một khối sẽ ẩn mô-đun theo dõi đó khỏi hồ sơ Waybar; nó không gỡ cài đặt gói hay ngừng phần còn lại của phiên. Cần gạt chính điều khiển toàn bộ giao diện telemetry.

Việc lựa chọn khối là chuẩn trong `config.json`, tại `control_panel.widget_telemetry_blocks`, và công tắc chính là `control_panel.widget_telemetry_enabled`. `argvus-config` chiếu lựa chọn đó vào hồ sơ Waybar `data/waybar/argvus-widget-telemetry.jsonc` bằng cách bỏ dấu chú thích hoặc thêm dấu chú thích vào các dòng bên trong các khối được phân tách `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END`, để phần còn lại của tập tin không bị thay đổi. Một tập tin `~/.local/state/argvus/widget-telemetry-blocks` cũ vẫn được đọc như phương án dự phòng khi di chuyển trên các cài đặt cũ, nhưng nó không bao giờ được ghi. Lưu ý rằng toàn bộ hồ sơ sẽ được thay thế theo mặc định đã đóng gói khi thay đổi giao diện, vì vậy các dấu hiệu khối là cách lựa chọn được giữ lại; văn bản bên ngoài chúng sẽ không được bảo tồn qua việc chuyển đổi chủ đề.

Bộ điều khiển hỗ trợ:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```

Bộ điều khiển cũng chấp nhận `blocks set <block> <enabled|disabled>` cho `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` và `keys`. Các tùy chọn được giữ nguyên; khi một khối không có tùy chọn rõ ràng, nó sẽ theo mặc định đã bật. `blocks set` viết lại mảng chuẩn trong một bản vá nguyên tử duy nhất, sau đó chiếu lại hồ sơ Waybar và đối chiếu vòng đời dịch vụ. `apply-state` là đường dẫn của Trung tâm Điều khiển: nó giả định người gọi đã lưu lựa chọn và chỉ chiếu nó, vì vậy không bao giờ gọi nó với trạng thái chưa được lưu.

Dịch vụ là `argvus-widget-telemetry.service` và được quản lý bởi `argvus-session`. Không có nút đặt lại riêng cho từng khối trên trang hiện tại: hãy bật lại khối, hoặc sử dụng quản lý trạng thái được nhà cung cấp hỗ trợ, thay vì chỉnh sửa đầu ra Waybar đã tạo.

## Độ trong suốt và làm mờ

Sử dụng **Control Center → Appearance → Widget Telemetry** để cấu hình công tắc chính, các phiên thu thập dữ liệu, Độ trong suốt và Làm mờ. Cả hai hiệu ứng đều có công tắc bật riêng và các giá trị `0–100%`. Sử dụng `+` và `-` theo bước 5% và chọn **[ Áp dụng ]**; các giá trị chỉ được áp dụng sau khi xác nhận và được lưu cho chủ đề đang hoạt động.
Sử dụng `↑/↓` để di chuyển giữa các hàng bật và giá trị. Nhấn `Tab` cho **Hành động**, sau đó kích hoạt **[ Áp dụng ]**.

Mô-đun nhiệt độ GPU được hiển thị khi DRM/sysfs cung cấp GPU NVIDIA, AMD hoặc Intel được hỗ trợ và `btop` được cài đặt. Giá trị của nó là nhiệt độ hợp lệ cao nhất có thể gán cho một trong các GPU được phát hiện; khi không có cảm biến nào được hiển thị, nó sẽ hiển thị `N/A`. Nhấp vào nó sẽ mở các bảng chỉ GPU của btop trong Kitty thông qua `argvus tui-terminal` sử dụng hồ sơ `taskbar-monitor`. Nhấn `q` hoặc `Esc` để đóng; tab dưới cùng đã được địa phương hóa hiển thị `Press q to close`. btop 1.4.7 hỗ trợ tối đa sáu hộp GPU. Các chỉ số NVIDIA yêu cầu hỗ trợ GPU btop và NVML; AMD yêu cầu hỗ trợ GPU btop và ROCm SMI; Intel yêu cầu các giao diện sysfs có thể đọc được. Nhiệt độ NVIDIA nouveau, AMD và Intel chỉ xuất hiện khi một cảm biến hwmon liên kết được hiển thị. ARGVUS không thay đổi quyền hay thêm trợ giúp đặc quyền. Gói thanh tác vụ phụ thuộc vào btop; các nhà cung cấp của nhà sản xuất vẫn là tùy chọn.


Biểu tượng tác nhân AI tùy chọn ở nhóm/phải-2 mở menu argvus-ai. Nó được kiểm tra mỗi năm giây và bị ẩn khi trợ lý không có mặt hoặc không có tác nhân nào sẵn có (argvus-ai status --check). Claude được cung cấp dưới dạng có thể cài đặt khi mise có mặt. Chọn nó sẽ mở terminal ARGVUS, cài đặt nó trong hồ sơ người dùng hiện tại nếu chưa có, sau đó khởi chạy nó với thư mục nhị phân của nó trong PATH của tiến trình. Không sử dụng hook cài đặt gói. Tải lại thanh để tải cấu hình hệ thống đã cập nhật; các bản sao của người dùng không bị ghi đè.


Trình khởi chạy AI sử dụng nf-md-robot (U+F06A9) với Symbols Nerd Font Mono. Máy chiếu giao diện giữ nó trong nhóm/right-2 cùng với điều khiển micro và âm thanh.

## Bộ chọn chế độ cửa sổ

Biểu tượng cửa sổ trong `group/right-2`, sau khi tiện ích mở rộng, mở một popup GTK với **Cửa sổ xếp gạch (Mặc định)** và **Cửa sổ nổi**. Tùy chọn hiện tại được đánh dấu. Chọn một tùy chọn để áp dụng ngay; nhấn Escape hoặc nhấp ra ngoài để đóng popup. Biểu tượng phản ánh chế độ hiệu quả, với kiểu đang chờ/lỗi khi ứng dụng chưa hoàn tất. Popup theo vị trí thanh tác vụ và chủ đề hiện tại.

Cài đặt được chia sẻ với **Control Center → Desktop & Input → Hyprland → Windows → Mode**. Chế độ nổi ảnh hưởng đến tất cả các cửa sổ ứng dụng trên các màn hình và không gian làm việc. Quay lại chế độ Tile sẽ giữ các cửa sổ vốn đang ở trạng thái nổi. Lựa chọn này được giữ nguyên giữa các lần đăng nhập.

Trợ lý là `argvus window-mode-menu`; `argvus window-mode-menu --status` phát JSON của Waybar. Nó được cung cấp bởi gói chính `argvus`. Các bản sao thanh tác vụ tùy chỉnh hiện có được giữ nguyên: thêm định nghĩa mô-đun `custom/window-mode` và mục nhóm từ mẫu gói để tham gia, hoặc sử dụng Trung tâm Kiểm soát. Máy chiếu giao diện giữ lại mô-đun khi định nghĩa của nó có mặt, ngay cả khi các biểu tượng tiện ích khác bị tắt.

##

Chế độ nổi thêm một thanh tiêu đề ARGVUS với **Thu nhỏ**, **Phóng to / Khôi phục** và **Đóng** cho các cửa sổ ứng dụng bình thường. Nháy đúp vào thanh tiêu đề sẽ chuyển đổi giữa trạng thái phóng to và khôi phục. Trang trí bổ sung này sẽ ẩn trong chế độ Tile và toàn màn hình. Các ứng dụng tự vẽ các điều khiển của riêng chúng có thể hiển thị cả hai thanh; các điều khiển ARGVUS đồng bộ là có chủ ý.

Một thanh Waybar thứ hai xuất hiện trên mỗi màn hình, ở cạnh đối diện với thanh tác vụ chính. Nó chỉ liệt kê các cửa sổ của không gian làm việc hiện tại trên màn hình đó, bao gồm cả các cửa sổ bị thu nhỏ. Các tab nhóm ẩn không tạo thêm mục bổ sung. Các mục bị thu nhỏ giữ nguyên liên kết màn hình/không gian làm việc ban đầu của chúng. Nhấp vào cửa sổ không hoạt động để kích hoạt nó, cửa sổ đang hoạt động để thu nhỏ nó, hoặc cửa sổ đang thu nhỏ để khôi phục nó; menu ngữ cảnh của cửa sổ cung cấp các tùy chọn khôi phục, thu nhỏ, phóng to/khôi phục và đóng. Biểu tượng ứng dụng không xác định sẽ hiển thị biểu tượng cửa sổ thay thế. Kích hoạt hoặc khôi phục mục giữ nguyên vị trí con trỏ. Thanh phụ sử dụng CSS chính hiệu quả (màu sắc, phông chữ, viền và bo góc), với chiều cao và lề phản chiếu ở cạnh đối diện.

`SUPER + Alt + Up` đặt thanh chính ở trên cùng và thanh cửa sổ ở dưới cùng. `SUPER + Alt + Down` làm ngược lại. Lặp lại một hướng sẽ giữ nguyên vị trí. Tile chỉ có thanh chính. Quay lại Tile sẽ khôi phục tất cả các cửa sổ đã thu nhỏ trước khi loại bỏ thanh cửa sổ, sau đó giữ nguyên chính sách xếp gạch/lơ lửng ban đầu.

Việc thu gọn sử dụng không gian làm việc `special:argvus-minimized` đã được dành riêng. Không sử dụng không gian làm việc đó một cách thủ công. Quá trình `argvus windows service` ghi nhận danh tính, không gian làm việc/màn hình gốc, hình học, chế độ toàn màn hình/tối đa hóa và trạng thái ghim trong một đăng ký thời gian chạy cụ thể cho từng phiên bản compositor dưới `$XDG_RUNTIME_DIR/argvus`. Bản ghi tồn tại sau khi dịch vụ khởi động lại hoặc tải lại cấu hình, nhưng không vượt quá các phiên bản compositor. Đóng cửa sổ sẽ xóa bản ghi của nó. Nếu một màn hình biến mất, việc khôi phục sẽ sử dụng một đầu ra có sẵn. Thanh phục hồi bị mất hoặc thất bại sẽ ngăn việc thu gọn mới; việc khôi phục thất bại sẽ giữ lại bản ghi và thanh phục hồi.

Phiên làm việc sở hữu `argvus-windows.service` và `argvus-window-bar.service`. Cái sau giữ con Waybar của nó trong trạng thái ngủ trong Tile. Plugin hyprbars được đóng gói bởi `argvus-hyprland`, được xây dựng cho ABI Hyprland 0.57.0 trên x86_64; nó không được biên dịch trong thư mục nhà của người dùng. Xây dựng lại plugin với cập nhật ABI trình hợp nhất.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, và `minimize|restore|activate|maximize|close ADDRESS`. Các địa chỉ cửa sổ được lấy từ danh sách. `position top --persist` lưu/truyền sở thích mà không cần khởi động lại thanh chính. Chi tiết cấu hình và lỗi thời gian chạy được ghi vào nhật ký; các thất bại hành động hiển thị cũng hiện thông báo đã được dịch.

Trong **Spaced + Floating**, các cửa sổ tuân theo khoảng trống bên ngoài và các khu vực được cả hai thanh dành riêng. Phạm vi bao gồm viền và tiêu đề, nằm bên trong cùng một viền cửa sổ. Phóng to thông qua điều khiển ARGVUS sẽ lấp đầy khu vực này với các lề; khôi phục sẽ lấy lại hình học trước đó, bao gồm cả sau khi khởi động lại dịch vụ. Toàn màn hình vẫn sử dụng toàn bộ đầu ra. Các cửa sổ nổi có thể chồng lên nhau; khoảng trống bên trong khi xếp gạch không tách chúng ra.
