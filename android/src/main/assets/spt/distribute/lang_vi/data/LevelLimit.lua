local null = nil
local var = 
{
	[ [=[Adventure]=] ]=
	{
		[ [=[function]=] ]=[=[Chinh Phục Sân Cỏ]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=55,
		[ [=[title]=] ]=[=[Đã mở khóa! Chinh Phục Sân Cỏ!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageAdventure]=],
		[ [=[ID]=] ]=20,
		[ [=[desc]=] ]=[=[Bản đồ mới! Hãy mau đến chinh phục!]=]
	},
	[ [=[Auction]=] ]=
	{
		[ [=[function]=] ]=[=[Khu Đấu Giá]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=35,
		[ [=[title]=] ]=[=[Đã mở khóa! Khu Đấu Giá!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageAuction]=],
		[ [=[ID]=] ]=18,
		[ [=[desc]=] ]=[=[Khu Đấu Giá chính thức hoạt động! Tham gia cùng đấu giá vật phẩm giá trị!]=]
	},
	[ [=[Coach]=] ]=
	{
		[ [=[function]=] ]=[=[Hệ Thống Huấn Luyện Viên]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=65,
		[ [=[title]=] ]=[=[Đã mở khóa Hệ Thống Huấn Luyện Viên!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageCoach]=],
		[ [=[ID]=] ]=19,
		[ [=[desc]=] ]=[=[Hệ Thống HLV bồi dưỡng HLV của riêng bạn!]=]
	},
	[ [=[FootaballHall]=] ]=
	{
		[ [=[function]=] ]=[=[Cung Điện Cầu Thủ]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=40,
		[ [=[title]=] ]=[=[Đã mở khóa! Cung Điện Cầu Thủ!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionFootaballHall]=],
		[ [=[ID]=] ]=17,
		[ [=[desc]=] ]=[=[Bồi dưỡng cầu thủ, tăng cấp cung điện cầu thủ và huân chương.]=]
	},
	[ [=[LeaderBoard]=] ]=
	{
		[ [=[function]=] ]=[=[BXH Đỉnh Cao]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=45,
		[ [=[title]=] ]=[=[Đã mở khóa! BXH Đỉnh Cao!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageLeaderboard]=],
		[ [=[ID]=] ]=13,
		[ [=[desc]=] ]=[=[Bảng xếp hạng đỉnh cao, cùng nhau xông bảng vàng!]=]
	},
	[ [=[TrainingBase]=] ]=
	{
		[ [=[function]=] ]=[=[Đặc Huấn Cầu Thủ]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=60,
		[ [=[title]=] ]=[=[Đã mở khóa! Đặc Huấn Cầu Thủ!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionTrainingBase]=],
		[ [=[ID]=] ]=15,
		[ [=[desc]=] ]=[=[Tham gia Đặc Huấn Cầu Thủ, nâng cao năng lực cầu thủ, kích hoạt kỹ năng mới hoàn toàn!]=]
	},
	[ [=[WorldTournament]=] ]=
	{
		[ [=[function]=] ]=[=[Cúp CLB Thế Giới]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=30,
		[ [=[title]=] ]=[=[Đã mở khóa! Cúp CLB Thế Giới!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageWorldTournament]=],
		[ [=[ID]=] ]=14,
		[ [=[desc]=] ]=[=[Ký kết hợp đồng tài trợ, tham gia giải đấu đỉnh cao thế giới.]=]
	},
	[ [=[WorldWar]=] ]=
	{
		[ [=[function]=] ]=[=[Giải Vô Địch]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=22,
		[ [=[title]=] ]=[=[Đếm ngược thời gian mở Giải Vô Địch!]=],
		[ [=[openSeverTime]=] ]=45,
		[ [=[picIndex]=] ]=[=[FunctionWorldWar]=],
		[ [=[ID]=] ]=16,
		[ [=[desc]=] ]=[=[Đang đếm ngược thời gian mở Giải Vô Địch! 45 ngày sau khi mở server sẽ mở Giải Vô Địch ! Tham gia để giành danh hiệu đội bóng mạnh nhất!]=]
	},
	[ [=[arena]=] ]=
	{
		[ [=[function]=] ]=[=[Champions League]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=25,
		[ [=[title]=] ]=[=[Đã mở khóa! Champions League!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageArena]=],
		[ [=[ID]=] ]=8,
		[ [=[desc]=] ]=[=[Chúc mừng đã mở khóa Champions League. Champions League chia thành 4 khu thi đấu, dùng quy chế thi đấu của Champions League.]=]
	},
	[ [=[building]=] ]=
	{
		[ [=[function]=] ]=[=[Khu Liên Hợp]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=10,
		[ [=[title]=] ]=[=[Đã mở khóa! Khu liên hợp!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageBuilding]=],
		[ [=[ID]=] ]=6,
		[ [=[desc]=] ]=[=[Có thể tăng cấp các loại công trình.]=]
	},
	[ [=[guild]=] ]=
	{
		[ [=[function]=] ]=[=[Liên Đoàn]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=20,
		[ [=[title]=] ]=[=[Đã mở khóa! Liên Đoàn!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageGuild]=],
		[ [=[ID]=] ]=9,
		[ [=[desc]=] ]=[=[Vào Liên Đoàn để cùng bạn bè chiến đấu, nhận lì xì Liên Đoàn, Thách Đấu Liên Đoàn, Liên Đoàn Chiến.]=]
	},
	[ [=[ladder]=] ]=
	{
		[ [=[function]=] ]=[=[Đấu Hạng]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=15,
		[ [=[title]=] ]=[=[Đã mở khóa! Đấu hạng!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageLadder]=],
		[ [=[ID]=] ]=5,
		[ [=[desc]=] ]=[=[Nhận được nhiều Vitamin dùng để bồi dưỡng tiềm năng cầu thủ.]=]
	},
	[ [=[league]=] ]=
	{
		[ [=[function]=] ]=[=[Giải Đấu]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=8,
		[ [=[title]=] ]=[=[Đã mở khóa! Giải đấu!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageLeague]=],
		[ [=[ID]=] ]=2,
		[ [=[desc]=] ]=[=[Có thể kiếm được Vàng trong các giải đấu.]=]
	},
	[ [=[littleGame]=] ]=
	{
		[ [=[function]=] ]=[=[Huấn Luyện]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=12,
		[ [=[title]=] ]=[=[Đã mở khóa! Trung tâm huấn luyện!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageTraining]=],
		[ [=[ID]=] ]=3,
		[ [=[desc]=] ]=[=[Huấn luyện cầu thủ trong trung tâm huấn luyện sẽ tăng kỹ năng cầu thủ.]=]
	},
	[ [=[littleGameSweep]=] ]=
	{
		[ [=[function]=] ]=[=[Huấn Luyện Nhanh]=],
		[ [=[hasTip]=] ]=0,
		[ [=[playerLevel]=] ]=16,
		[ [=[title]=] ]=[=[]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[]=],
		[ [=[ID]=] ]=7,
		[ [=[desc]=] ]=[=[]=]
	},
	[ [=[medal]=] ]=
	{
		[ [=[function]=] ]=[=[Huy Chương Cầu Thủ]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=50,
		[ [=[title]=] ]=[=[Đã mở khóa! Huy Chương Cầu Thủ!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageMedal]=],
		[ [=[ID]=] ]=12,
		[ [=[desc]=] ]=[=[Nhận huy chương, tăng thuộc tính cầu thủ, và BUFF cực mạnh!]=]
	},
	[ [=[peak]=] ]=
	{
		[ [=[function]=] ]=[=[Đỉnh Cao]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=50,
		[ [=[title]=] ]=[=[Đã mở khóa! Đỉnh Cao!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImagePeak]=],
		[ [=[ID]=] ]=11,
		[ [=[desc]=] ]=[=[PVP đỉnh cao liên server, nhanh cùng 3 đội bóng khác lập nhóm cùng PK với người chơi server khác.]=]
	},
	[ [=[skillLvlUp]=] ]=
	{
		[ [=[function]=] ]=[=[Tăng Cấp Kỹ Năng]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=12,
		[ [=[title]=] ]=[=[Đã mở khóa! Tăng cấp kỹ năng cầu thủ!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImagePlayer]=],
		[ [=[ID]=] ]=4,
		[ [=[desc]=] ]=[=[Chúc mừng bạn đã mở khóa tính năng tăng cấp kỹ năng cầu thủ.]=]
	},
	[ [=[specialMatch]=] ]=
	{
		[ [=[function]=] ]=[=[Sự Kiện]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=30,
		[ [=[title]=] ]=[=[Đã mở khóa! Sự Kiện!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageSpeicalMatch]=],
		[ [=[ID]=] ]=10,
		[ [=[desc]=] ]=[=[Mở giải thi đấu đặc biệt, sưu tập đội hình chỉ định, khiêu chiến đội hình huyền thoại, nhận thưởng phong phú.]=]
	},
	[ [=[transfer]=] ]=
	{
		[ [=[function]=] ]=[=[Chuyển Nhượng]=],
		[ [=[hasTip]=] ]=1,
		[ [=[playerLevel]=] ]=5,
		[ [=[title]=] ]=[=[Đã mở khóa! Thị trường chuyển nhượng!]=],
		[ [=[openSeverTime]=] ]=0,
		[ [=[picIndex]=] ]=[=[FunctionImageTransfer]=],
		[ [=[ID]=] ]=1,
		[ [=[desc]=] ]=[=[Có thể vào Chuyển Nhượng để mua siêu sao.]=]
	}
}
return var