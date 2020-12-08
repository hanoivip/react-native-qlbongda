local null = nil
local var = 
{
	[ [=[1]=] ]=
	{
		[ [=[name]=] ]=[=[Học viện 360mobi]=],
		[ [=[skillLvConditionText]=] ]=[=[Cấp kỹ năng trung bình cầu thủ này >=3]=],
		[ [=[skillLvCondition]=] ]=3,
		[ [=[unlockQuality]=] ]=
		{[=[3]=],[=[4]=],[=[5]=],[=[6]=],[=[7]=]
		}
	},
	[ [=[2]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện 360mobi]=],
		[ [=[name]=] ]=[=[Học viện Amsterdam]=],
		[ [=[skillLvConditionText]=] ]=[=[Cấp kỹ năng trung bình cầu thủ này >=5]=],
		[ [=[correlationConditionText]=] ]=[=[Bộ đôi cầu thủ %s, %s cần mở khóa khu huấn luyện 360mobi]=],
		[ [=[skillLvCondition]=] ]=5,
		[ [=[unlockQuality]=] ]=
		{[=[3]=],[=[4]=],[=[5]=],[=[6]=],[=[7]=]
		},
		[ [=[correlationCondition]=] ]=1,
		[ [=[trainingCondition]=] ]=
		{
			[ [=[1]=] ]=[=[4]=]
		}
	},
	[ [=[3]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện Amsterdam]=],
		[ [=[name]=] ]=[=[Học viện PSG]=],
		[ [=[chemicalConditionText]=] ]=[=[Cần kích hoạt 1 bộ của Cầu Thủ]=],
		[ [=[correlationConditionText]=] ]=[=[Bộ đôi cầu thủ %s, %s cần mở khóa khu huấn luyện Amsterdam]=],
		[ [=[chemicalCondition]=] ]=1,
		[ [=[unlockQuality]=] ]=
		{[=[4]=],[=[5]=],[=[6]=],[=[7]=]
		},
		[ [=[correlationCondition]=] ]=2,
		[ [=[trainingCondition]=] ]=
		{
			[ [=[2]=] ]=[=[4]=]
		}
	},
	[ [=[4]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện PSG]=],
		[ [=[medalConditionText]=] ]=[=[Có 2 Huy Chương phẩm chất SS]=],
		[ [=[name]=] ]=[=[Học viện Kearney]=],
		[ [=[skillLvConditionText]=] ]=[=[Cấp kỹ năng trung bình cầu thủ này >=12]=],
		[ [=[skillLvCondition]=] ]=12,
		[ [=[unlockQuality]=] ]=
		{[=[4]=],[=[5]=],[=[6]=],[=[7]=]
		},
		[ [=[throughCondition]=] ]=2,
		[ [=[throughConditionText]=] ]=[=[Cầu thủ hoàn thành đột phá bậc 2]=],
		[ [=[trainingCondition]=] ]=
		{
			[ [=[3]=] ]=[=[4]=]
		},
		[ [=[medalCondition]=] ]=
		{
			[ [=[5]=] ]=[=[2]=]
		}
	},
	[ [=[5]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Kearney]=],
		[ [=[name]=] ]=[=[Học viện Milan]=],
		[ [=[chemicalConditionText]=] ]=[=[Cần kích hoạt 3 bộ của Cầu Thủ]=],
		[ [=[correlationConditionText]=] ]=[=[Bộ đôi cầu thủ %s, %s cần mở khóa khu huấn luyện Kearney]=],
		[ [=[chemicalCondition]=] ]=3,
		[ [=[unlockQuality]=] ]=
		{[=[5]=],[=[6]=],[=[7]=]
		},
		[ [=[correlationCondition]=] ]=4,
		[ [=[trainingCondition]=] ]=
		{
			[ [=[4]=] ]=[=[4]=]
		}
	},
	[ [=[6]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện Milan]=],
		[ [=[medalConditionText]=] ]=[=[Có 3 Huy Chương phẩm chất SS]=],
		[ [=[name]=] ]=[=[Học viện London]=],
		[ [=[skillLvConditionText]=] ]=[=[Cấp kỹ năng trung bình cầu thủ này >=18]=],
		[ [=[skillLvCondition]=] ]=18,
		[ [=[unlockQuality]=] ]=
		{[=[5]=],[=[6]=],[=[7]=]
		},
		[ [=[throughCondition]=] ]=3,
		[ [=[throughConditionText]=] ]=[=[Cầu thủ hoàn thành đột phá bậc 3]=],
		[ [=[trainingCondition]=] ]=
		{
			[ [=[5]=] ]=[=[4]=]
		},
		[ [=[medalCondition]=] ]=
		{
			[ [=[5]=] ]=[=[3]=]
		}
	},
	[ [=[7]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện London]=],
		[ [=[name]=] ]=[=[Học viện Old Trafford]=],
		[ [=[chemicalConditionText]=] ]=[=[Cần kích hoạt 4 bộ của Cầu Thủ]=],
		[ [=[correlationConditionText]=] ]=[=[Bộ đôi cầu thủ %s, %s cần mở khóa khu huấn luyện London]=],
		[ [=[chemicalCondition]=] ]=4,
		[ [=[unlockQuality]=] ]=
		{[=[6]=],[=[7]=]
		},
		[ [=[correlationCondition]=] ]=6,
		[ [=[trainingCondition]=] ]=
		{
			[ [=[6]=] ]=[=[4]=]
		}
	},
	[ [=[8]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện Old Trafford]=],
		[ [=[medalConditionText]=] ]=[=[Có 4 Huy Chương phẩm chất SS]=],
		[ [=[name]=] ]=[=[Học viện La Fábrica]=],
		[ [=[potentialConditionText]=] ]=[=[Sử dụng hết điểm tiềm năng (trong Bồi Dưỡng)]=],
		[ [=[unlockQuality]=] ]=
		{[=[6]=],[=[7]=]
		},
		[ [=[throughCondition]=] ]=4,
		[ [=[potentialCondition]=] ]=1,
		[ [=[throughConditionText]=] ]=[=[Cầu thủ hoàn thành đột phá bậc 4]=],
		[ [=[trainingCondition]=] ]=
		{
			[ [=[7]=] ]=[=[4]=]
		},
		[ [=[medalCondition]=] ]=
		{
			[ [=[5]=] ]=[=[4]=]
		}
	},
	[ [=[9]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện La Fábrica]=],
		[ [=[name]=] ]=[=[Học viện Manchester]=],
		[ [=[chemicalConditionText]=] ]=[=[Cần kích hoạt 5 bộ của Cầu Thủ]=],
		[ [=[correlationConditionText]=] ]=[=[Bộ đôi cầu thủ %s, %s cần mở khóa khu huấn luyện La Fábrica]=],
		[ [=[chemicalCondition]=] ]=5,
		[ [=[unlockQuality]=] ]=
		{[=[7]=]
		},
		[ [=[correlationCondition]=] ]=8,
		[ [=[trainingCondition]=] ]=
		{
			[ [=[8]=] ]=[=[4]=]
		}
	},
	[ [=[10]=] ]=
	{
		[ [=[trainingConditionText]=] ]=[=[Xong 4 nhiệm vụ huấn luyện ở Học viện Manchester]=],
		[ [=[medalConditionText]=] ]=[=[Có 5 Huy Chương phẩm chất SS]=],
		[ [=[name]=] ]=[=[Học viện Juve]=],
		[ [=[skillLvConditionText]=] ]=[=[Cấp kỹ năng trung bình cầu thủ này >=32]=],
		[ [=[skillLvCondition]=] ]=32,
		[ [=[unlockQuality]=] ]=
		{[=[7]=]
		},
		[ [=[throughCondition]=] ]=5,
		[ [=[throughConditionText]=] ]=[=[Cầu thủ hoàn thành đột phá bậc 5]=],
		[ [=[trainingCondition]=] ]=
		{
			[ [=[9]=] ]=[=[4]=]
		},
		[ [=[medalCondition]=] ]=
		{
			[ [=[5]=] ]=[=[5]=]
		}
	}
}
return var