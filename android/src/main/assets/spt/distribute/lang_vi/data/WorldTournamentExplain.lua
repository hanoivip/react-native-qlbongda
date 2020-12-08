local null = nil
local var = 
{
	[ [=[1]=] ]=
	{
		[ [=[id]=] ]=1,
		[ [=[desc]=] ]=[=[Hệ thống dựa vào xếp hạng mùa giải trước để quyết định tư cách tham gia mùa giải, HLV phải thi đấu với HLV khác để giành quyền tăng cấp giải.
Giải đấu gồm Liên Server và server.
Liên Server: Champions Cup và Europa Cup.
Server: Serie S, Serie A, Serie B, Serie C và Serie D.
Nếu HLV đang tham gia thi đấu tại Serie S, Serie A, Serie B, Serie C, thì sẽ có tư cách tham gia mùa giải sau.
Những HLV còn lại phải đạt TOP150 Đấu Hạng mới được tham gia Serie D. HLV phải giành hạng tương ứng trong giải đấu trước, mới được tăng cấp giải, khi HLV thi đấu tại Serie S sẽ không được tăng cấp giải đấu, TOP đầu Serie S có cơ hội tham gia đấu Liên Server: Champions Cup và Europa Cup, thi đấu với HLV khác để giành hạng 1.
<color=#FFFE5EFF>Đề phòng bán độ: Hệ thống sẽ so sánh đội hình Giải Vô Địch và đội hình chính (Đội hình mạnh nhất), năng lực cách biệt quá lớn sẽ bị đánh giá là đội bóng giả và bị xử thua, nếu là giải đấu server thì trừ 20 điểm giải đấu, nếu là Liên Server sẽ bị loại ngay, đồng thời mất tư cách tham gia Liên Server mùa sau</color>]=]
	},
	[ [=[2]=] ]=
	{
		[ [=[id]=] ]=2,
		[ [=[desc]=] ]=[=[Thi đấu trong server 5 bậc: Serie S, Serie A, Serie B, Serie C và Serie D.
Quy tắc xếp hạng server:
1. Ưu tiên điểm thi đấu
2. Điểm bằng nhau tính thành tích
3. Thành tích giống nhau tính hiệu số và hiệu số lẫn nhau
4. Hiệu số bằng nhau tính tổng ghi bàn và bàn thua]=]
	},
	[ [=[3]=] ]=
	{
		[ [=[id]=] ]=3,
		[ [=[desc]=] ]=[=[Hệ thống sẽ dựa vào thành tích của đội bóng của mỗi server 4 mùa giải gần nhất để cộng điểm thêm cho server trong giải đấu liên server(Tính đủ 4 mùa giải), điểm server sẽ quyết định tư cách tham gia Champions Cup và Europa Cup. TOP mùa giải Serie S mới được tham gia giải Liên Server. Vô địch Champions Cup và Europa Cup sẽ được tham gia Champions Cup mùa sau.
Xếp hạng server và liên server như sau: ]=]
	},
	[ [=[4]=] ]=
	{
		[ [=[id]=] ]=4,
		[ [=[desc]=] ]=[=[Điểm server và thành tích đấu liên server của HLV]=]
	},
	[ [=[5]=] ]=
	{
		[ [=[id]=] ]=5,
		[ [=[desc]=] ]=[=[Thi đấu Liên Server Champions Cup và Europa Cup, hệ thống sẽ chọn HLV xuất sắc nhất giải Serie S từng server tham gia đấu Liên server. Tư cách tham gia gồm đội chính thức và đấu vòng loại.
Trước hết tổ chức Play-Off, HLV chiến thắng Play-off sẽ cùng đội có xuất chính thức tạo thành 64 đội tham gia Champions Cup/Europa Cup.
64  đội này sẽ dựa vào điểm 4 mùa giải gần nhất chia làm 4 nhóm (Điểm dựa theo thành tích 4 mùa giải gần nhất), rút thăm mỗi nhóm 1 đội tạo thành 16 bảng đấu. mỗi bảng sẽ có 4 HLV
Bảng thi đấu theo thể thức vòng tròn, 2 đội xếp đầu lọt vào vòng sau.
Quy tắc:
1. Đội điểm cao xếp trước
2. Hiệu số cao xếp trước
3. Ghi bàn nhiều hơn xếp trước
4. Đối đầu trực tiếp, hiệu số và ghi bàn
5. Nếu vẫn bằng nhau, đội có điểm cao hơn lọt vào vòng sau
Chọn 2 đội, sau đó bốc thăm đấu loại trực tiếp.
Đấu loại trực tiếp lựa chọn theo tỉ số, nếu tỉ số hòa, so sánh số bàn thắng ghi được ( Số bàn thằng sân khách/sân nhà), nếu số bàn thắng như nhau sẽ dẫn đến hiệp phụ, nếu vẫn hòa, hai bên đá luân lưu quyết định thắng thua.]=]
	},
	[ [=[6]=] ]=
	{
		[ [=[id]=] ]=6,
		[ [=[desc]=] ]=[=[HLV tham gia giải đấu khác nhau sẽ nhận phần thưởng khác nhau. Dựa vào thành tích để nhận thưởng.]=]
	},
	[ [=[7]=] ]=
	{
		[ [=[id]=] ]=7,
		[ [=[desc]=] ]=[=[Thời gian thi đấu là 1 giờ, HLV có thể vào tham gia và hoàn thành thi đấu. Hết thời gian thi đấu sẽ ẩn tính năng điều khiển thi đấu, nếu không tự điều khiển hệ thống sẽ tự mô phỏng tiến hành thi đấu.
Sau khi thi đấu 30 phút sẽ công bố thông tin thi đấu.
Server sẽ không ghi lại thông số cầu thủ thi đấu, Liên Server sẽ ghi lại thông số Vua Phá Lưới và Vua Kiến Tạo, sau khi hết mùa giải sẽ gửi phần thưởng cho HLV có Vua Phá Lưới và Vua Kiến Tạo của 2 giải Champions Cup và Europa Cup.
]=]
	},
	[ [=[8]=] ]=
	{
		[ [=[id]=] ]=8,
		[ [=[desc]=] ]=[=[Thưởng Danh Hiệu]=]
	},
	[ [=[9]=] ]=
	{
		[ [=[id]=] ]=9,
		[ [=[desc]=] ]=[=[Giải Liên Server sẽ ghi nhận cầu thủ ghi bàn và kiến tạo, sau đó gửi phần thưởng:
Giày Vàng Champions Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x3</color>
Giày Bạc Champions Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x2</color>
Giày Đồng Champions Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x1</color>
Vua Kiến Tạo Champions Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x2</color>
Hạng 2 Kiến Tạo Champions Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x1</color>
Hạng 3 Kiến Tạo Champions Cup: <color=#FFFE5EFF>Xu Vô Địch x10000</color>
Giày Vàng Europa Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x2</color>
Giày Bạc Europa Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x1</color>
Giày Đồng Champions Cup: <color=#FFFE5EFF>Xu Vô Địch x10000</color>
Vua Kiến Tạo Europa Cup: <color=#FFFE5EFF>Hộp Tuyệt Kỹ Vô Địch x1</color>
Hạng 2 Kiến Tạo Europa Cup: <color=#FFFE5EFF>Xu Vô Địch x10000</color>
Hạng 3 Kiến Tạo Europa Cup: <color=#FFFE5EFF>Xu Vô Địch x5000</color>]=]
	}
}
return var