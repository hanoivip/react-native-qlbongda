local null = nil
local var = 
{
	[ [=[ArtificialLong]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, đội khách giảm cản bóng]=],
		[ [=[name]=] ]=[=[Nhân Tạo-Dài]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=
		{[=[steal]=]
		},
		[ [=[condition]=] ]=
		{[=[League]=],[=[3]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[ArtificialShort]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, đội khách giảm cắt bóng]=],
		[ [=[name]=] ]=[=[Nhân Tạo-Ngắn]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=
		{[=[intercept]=]
		},
		[ [=[condition]=] ]=
		{[=[League]=],[=[3]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Audience]=] ]=
	{
		[ [=[fuction]=] ]=[=[capacity]=],
		[ [=[fuctionDesc]=] ]=[=[Tăng sức chứa sân vận động và doanh thu sân nhà.]=],
		[ [=[name]=] ]=[=[Ghế Ngồi]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[Board]=] ]=
	{
		[ [=[fuction]=] ]=[=[price2]=],
		[ [=[fuctionDesc]=] ]=[=[Cải thiện bảng tỉ số điện tử tăng độ hài lòng của fan, tăng giá vé và tăng doanh thu sân nhà.]=],
		[ [=[name]=] ]=[=[Bảng Tỉ Số]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[Common]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Không có hiệu quả đặc biệt]=],
		[ [=[name]=] ]=[=[Thường]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[Fog]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, hai bên #giảm cấp]=],
		[ [=[name]=] ]=[=[Sương]=],
		[ [=[skillAffect]=] ]=
		{[=[C01]=],[=[D02]=]
		},
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=
		{[=[League]=],[=[2]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Heat]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, hai bên #giảm cấp]=],
		[ [=[name]=] ]=[=[Nóng]=],
		[ [=[skillAffect]=] ]=
		{[=[C03]=],[=[D03]=]
		},
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=
		{[=[League]=],[=[3]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Lighting]=] ]=
	{
		[ [=[fuction]=] ]=[=[price1]=],
		[ [=[fuctionDesc]=] ]=[=[Cải thiện thiết bị chiếu sáng tăng độ hài lòng của fan, tăng giá vé và tăng doanh thu sân nhà.]=],
		[ [=[name]=] ]=[=[Chiếu Sáng]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[Mixed]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, đội khách giảm tất cả thuộc tính]=],
		[ [=[name]=] ]=[=[Tổng Hợp]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=
		{[=[dribble]=],[=[pass]=],[=[intercept]=],[=[steal]=],[=[shoot]=]
		},
		[ [=[condition]=] ]=
		{[=[League]=],[=[1]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[NatureLong]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, đội khách giảm chuyền bóng]=],
		[ [=[name]=] ]=[=[Thiên Nhiên-Dài]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=
		{[=[pass]=]
		},
		[ [=[condition]=] ]=
		{[=[League]=],[=[2]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[NatureShort]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, đội khách giảm dẫn bóng]=],
		[ [=[name]=] ]=[=[Thiên Nhiên-Ngắn]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=
		{[=[dribble]=]
		},
		[ [=[condition]=] ]=
		{[=[League]=],[=[2]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Parking]=] ]=
	{
		[ [=[fuction]=] ]=[=[attendance]=],
		[ [=[fuctionDesc]=] ]=[=[Tăng ô đậu xe, tăng tỷ lệ khán giả và tăng doanh thu sân nhà.]=],
		[ [=[name]=] ]=[=[Bãi Đậu Xe]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[Rain]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, hai bên #giảm cấp]=],
		[ [=[name]=] ]=[=[Mưa]=],
		[ [=[skillAffect]=] ]=
		{[=[D01]=],[=[B01]=],[=[C04]=]
		},
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=
		{[=[League]=],[=[1]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Sand]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, hai bên #giảm cấp]=],
		[ [=[name]=] ]=[=[Cát]=],
		[ [=[skillAffect]=] ]=
		{[=[C02]=],[=[D04]=]
		},
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=
		{[=[League]=],[=[3]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Scout]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Tăng tỉ lệ xuất hiện cầu thủ cao cấp trong thị trường chuyển nhượng.]=],
		[ [=[name]=] ]=[=[Tuyển Trạch Viên]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=1
	},
	[ [=[Snow]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, hai bên #giảm cấp]=],
		[ [=[name]=] ]=[=[Tuyết]=],
		[ [=[skillAffect]=] ]=
		{[=[B02]=],[=[F02]=],[=[F03]=]
		},
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=
		{[=[League]=],[=[1]=]
		},
		[ [=[initLvl]=] ]=1
	},
	[ [=[Stadium]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Mở khóa Khu Khán Giả, Thiết Bị Chiếu Sáng, Bảng Tỉ Số, Shop Bán Lẻ, Bãi Đậu Xe cấp cao hơn.]=],
		[ [=[name]=] ]=[=[Sân Vận Động]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=1
	},
	[ [=[Store]=] ]=
	{
		[ [=[fuction]=] ]=[=[priceExtra]=],
		[ [=[fuctionDesc]=] ]=[=[Bán đồ lưu niệm đội bóng, tăng thêm doanh thu sân nhà.]=],
		[ [=[name]=] ]=[=[Shop Bán Lẻ]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[SunShine]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Không có hiệu quả đặc biệt]=],
		[ [=[name]=] ]=[=[Nắng]=],
		[ [=[skillAffect]=] ]=[=[]=],
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=[=[]=],
		[ [=[initLvl]=] ]=0
	},
	[ [=[Wind]=] ]=
	{
		[ [=[fuction]=] ]=[=[]=],
		[ [=[fuctionDesc]=] ]=[=[Khi đấu trên sân nhà, hai bên #giảm cấp]=],
		[ [=[name]=] ]=[=[Gió]=],
		[ [=[skillAffect]=] ]=
		{[=[D07]=],[=[D06]=],[=[D05]=]
		},
		[ [=[attrAffect]=] ]=[=[]=],
		[ [=[condition]=] ]=
		{[=[League]=],[=[2]=]
		},
		[ [=[initLvl]=] ]=1
	}
}
return var