local null = nil
local var = 
{
	[ [=[Lose1]=] ]=
	{
		[ [=[conditionType]=] ]=1,
		[ [=[picIndex]=] ]=[=[Lose1]=],
		[ [=[title]=] ]=[=[Thao Tác Ngón Tay]=],
		[ [=[jump]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[desc]=] ]=[=[Dùng thời khắc anh hùng đúng thời điểm sẽ tăng thêm sức mạnh cho đội bóng.]=]
	},
	[ [=[Lose10]=] ]=
	{
		[ [=[conditionType]=] ]=3,
		[ [=[picIndex]=] ]=[=[Lose10]=],
		[ [=[title]=] ]=[=[Tẩy]=],
		[ [=[jump]=] ]=[=[PlayerList]=],
		[ [=[condition]=] ]=
		{[=[4]=],[=[3]=]
		},
		[ [=[desc]=] ]=[=[Phát huy tiềm năng cầu thủ sẽ tăng sức mạnh cho cầu thủ. Cầu thủ phẩm chất A trở lên tăng bậc 3 lần sẽ mở tính năng Bồi Dưỡng.]=]
	},
	[ [=[Lose11]=] ]=
	{
		[ [=[conditionType]=] ]=3,
		[ [=[picIndex]=] ]=[=[Lose11]=],
		[ [=[title]=] ]=[=[Đột Phá]=],
		[ [=[jump]=] ]=[=[PlayerList]=],
		[ [=[condition]=] ]=
		{[=[4]=],[=[4]=]
		},
		[ [=[desc]=] ]=[=[Đột phá sẽ tăng mạnh thực lực cầu thủ. Cầu thủ phẩm chất A trở lên tăng bậc 4 lần sẽ mở chức năng Đột Phá.]=]
	},
	[ [=[Lose12]=] ]=
	{
		[ [=[conditionType]=] ]=2,
		[ [=[picIndex]=] ]=[=[Lose12]=],
		[ [=[title]=] ]=[=[Bộ]=],
		[ [=[jump]=] ]=[=[PlayerList]=],
		[ [=[condition]=] ]=
		{[=[20]=]
		},
		[ [=[desc]=] ]=[=[Kích hoạt bộ sẽ đột phá giới hạn năng lực.]=]
	},
	[ [=[Lose2]=] ]=
	{
		[ [=[conditionType]=] ]=1,
		[ [=[picIndex]=] ]=[=[Lose2]=],
		[ [=[title]=] ]=[=[Tăng Cấp]=],
		[ [=[jump]=] ]=[=[PlayerList]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[desc]=] ]=[=[Đừng quên tăng cấp cầu thủ nhé.]=]
	},
	[ [=[Lose3]=] ]=
	{
		[ [=[conditionType]=] ]=1,
		[ [=[picIndex]=] ]=[=[Lose3]=],
		[ [=[title]=] ]=[=[Tăng Cấp]=],
		[ [=[jump]=] ]=[=[PlayerList]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[desc]=] ]=[=[Mang đủ trang bị cho cầu thủ có thể tăng bậc. Tăng bậc sẽ mở khóa kỹ năng cầu thủ.]=]
	},
	[ [=[Lose4]=] ]=
	{
		[ [=[conditionType]=] ]=1,
		[ [=[picIndex]=] ]=[=[Lose4]=],
		[ [=[title]=] ]=[=[Thư Cầu Thủ]=],
		[ [=[jump]=] ]=[=[PlayerLetter]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[desc]=] ]=[=[Hoàn thành Thư Cầu Thủ sẽ tăng sức mạnh cầu thủ. Thư Cầu Thủ sẽ xuất hiện trong chức năng sự nghiệp.]=]
	},
	[ [=[Lose5]=] ]=
	{
		[ [=[conditionType]=] ]=2,
		[ [=[picIndex]=] ]=[=[Lose5]=],
		[ [=[title]=] ]=[=[Chuyển Nhượng]=],
		[ [=[jump]=] ]=[=[TransferMarket]=],
		[ [=[condition]=] ]=
		{[=[5]=]
		},
		[ [=[desc]=] ]=[=[Trong Chuyển Nhượng luôn có cơ hội gặp cầu thủ giỏi nhưng phải có đủ Vàng.]=]
	},
	[ [=[Lose6]=] ]=
	{
		[ [=[conditionType]=] ]=1,
		[ [=[picIndex]=] ]=[=[Lose6]=],
		[ [=[title]=] ]=[=[Chiêu Mộ]=],
		[ [=[jump]=] ]=[=[Store]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[desc]=] ]=[=[Trong Shop có thể chiêu mộ được cầu thủ siêu sao!]=]
	},
	[ [=[Lose7]=] ]=
	{
		[ [=[conditionType]=] ]=1,
		[ [=[picIndex]=] ]=[=[Lose7]=],
		[ [=[title]=] ]=[=[Chỉnh Chiến Thuật]=],
		[ [=[jump]=] ]=[=[Formation]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[desc]=] ]=[=[Phối hợp đội hình, chiến thuật, cầu thủ hợp lý sẽ tăng tỉ lệ chiến thắng.]=]
	},
	[ [=[Lose8]=] ]=
	{
		[ [=[conditionType]=] ]=3,
		[ [=[picIndex]=] ]=[=[Lose8]=],
		[ [=[title]=] ]=[=[Cặp Bài Trùng]=],
		[ [=[jump]=] ]=[=[PlayerList]=],
		[ [=[condition]=] ]=
		{[=[3]=],[=[3]=]
		},
		[ [=[desc]=] ]=[=[Cầu thủ có kỹ năng Cặp Bài Trùng sẽ phát huy thêm sức mạnh. Cầu thủ phẩm chất B trở lên tăng bậc 3 lần sẽ mở khóa kỹ năng Cặp Bài Trùng.]=]
	},
	[ [=[Lose9]=] ]=
	{
		[ [=[conditionType]=] ]=2,
		[ [=[picIndex]=] ]=[=[Lose9]=],
		[ [=[title]=] ]=[=[Tăng Cấp Kỹ Năng]=],
		[ [=[jump]=] ]=[=[Training]=],
		[ [=[condition]=] ]=
		{[=[12]=]
		},
		[ [=[desc]=] ]=[=[Đến Trung tâm huấn luyện, tăng cấp kỹ năng cầu thủ có thể tăng sức mạnh cầu thủ.]=]
	}
}
return var