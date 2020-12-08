local null = nil
local var = 
{
	[ [=[1]=] ]=
	{
		[ [=[itemId]=] ]=20001,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Mở mặc định]=],
		[ [=[minLevel]=] ]=1,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[1]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[0]=]
		}
	},
	[ [=[2]=] ]=
	{
		[ [=[itemId]=] ]=20002,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 1 %d/1 lần]=],
		[ [=[minLevel]=] ]=2,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[2]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[1]=],[=[1]=]
		}
	},
	[ [=[3]=] ]=
	{
		[ [=[itemId]=] ]=20003,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 2 %d/2 lần]=],
		[ [=[minLevel]=] ]=3,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[3]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[2]=],[=[2]=]
		}
	},
	[ [=[4]=] ]=
	{
		[ [=[itemId]=] ]=20004,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 3 %d/3 lần]=],
		[ [=[minLevel]=] ]=4,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[4]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[3]=],[=[3]=]
		}
	},
	[ [=[5]=] ]=
	{
		[ [=[itemId]=] ]=20005,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 4 %d/4 lần]=],
		[ [=[minLevel]=] ]=5,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[5]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[4]=],[=[4]=]
		}
	},
	[ [=[6]=] ]=
	{
		[ [=[itemId]=] ]=20006,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 5 %d/5 lần]=],
		[ [=[minLevel]=] ]=6,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[6]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[5]=],[=[5]=]
		}
	},
	[ [=[7]=] ]=
	{
		[ [=[itemId]=] ]=20007,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 6 %d/6 lần]=],
		[ [=[minLevel]=] ]=7,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[7]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[6]=],[=[6]=]
		}
	},
	[ [=[8]=] ]=
	{
		[ [=[itemId]=] ]=20008,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 7 %d/7 lần]=],
		[ [=[minLevel]=] ]=8,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[8]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[7]=],[=[7]=]
		}
	},
	[ [=[9]=] ]=
	{
		[ [=[itemId]=] ]=20009,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Đạt hạng 1 Bậc 8 %d/8 lần]=],
		[ [=[minLevel]=] ]=9,
		[ [=[guildScoreMax]=] ]=0,
		[ [=[effectName]=] ]=[=[9]=],
		[ [=[type]=] ]=[=[common]=],
		[ [=[conditionScoreLevelUp]=] ]=0,
		[ [=[condition]=] ]=
		{[=[8]=],[=[8]=]
		}
	},
	[ [=[10]=] ]=
	{
		[ [=[itemId]=] ]=20018,
		[ [=[conditionScoreLevelDown]=] ]=0,
		[ [=[conditionDesc]=] ]=[=[Mở mặc định]=],
		[ [=[minLevel]=] ]=1,
		[ [=[guildScoreMax]=] ]=250000,
		[ [=[effectName]=] ]=[=[5]=],
		[ [=[type]=] ]=[=[mist]=],
		[ [=[conditionScoreLevelUp]=] ]=20,
		[ [=[condition]=] ]=
		{[=[6]=],[=[6]=]
		}
	},
	[ [=[11]=] ]=
	{
		[ [=[itemId]=] ]=20019,
		[ [=[conditionScoreLevelDown]=] ]=-20,
		[ [=[conditionDesc]=] ]=[=[Đạt 20 điểm, tăng từ Đấu Trường Sương Mù 1 lên 2. Tầng 2 bị -20 xuống lại tầng 1.]=],
		[ [=[minLevel]=] ]=2,
		[ [=[guildScoreMax]=] ]=280000,
		[ [=[effectName]=] ]=[=[6]=],
		[ [=[type]=] ]=[=[mist]=],
		[ [=[conditionScoreLevelUp]=] ]=30,
		[ [=[condition]=] ]=
		{[=[6]=],[=[6]=]
		}
	},
	[ [=[12]=] ]=
	{
		[ [=[itemId]=] ]=20020,
		[ [=[conditionScoreLevelDown]=] ]=-20,
		[ [=[conditionDesc]=] ]=[=[Đạt 30 điểm, tăng từ Đấu Trường Sương Mù 2 lên 3. Tầng 2 bị -20 xuống lại tầng 2.]=],
		[ [=[minLevel]=] ]=3,
		[ [=[guildScoreMax]=] ]=320000,
		[ [=[effectName]=] ]=[=[7]=],
		[ [=[type]=] ]=[=[mist]=],
		[ [=[conditionScoreLevelUp]=] ]=30,
		[ [=[condition]=] ]=
		{[=[6]=],[=[6]=]
		}
	},
	[ [=[13]=] ]=
	{
		[ [=[itemId]=] ]=20021,
		[ [=[conditionScoreLevelDown]=] ]=-20,
		[ [=[conditionDesc]=] ]=[=[Đạt 30 điểm, tăng từ Đấu Trường Sương Mù 3 lên 4. Tầng 2 bị -20 xuống lại tầng 3.]=],
		[ [=[minLevel]=] ]=4,
		[ [=[guildScoreMax]=] ]=350000,
		[ [=[effectName]=] ]=[=[8]=],
		[ [=[type]=] ]=[=[mist]=],
		[ [=[conditionScoreLevelUp]=] ]=40,
		[ [=[condition]=] ]=
		{[=[6]=],[=[6]=]
		}
	},
	[ [=[14]=] ]=
	{
		[ [=[itemId]=] ]=20022,
		[ [=[conditionScoreLevelDown]=] ]=-20,
		[ [=[conditionDesc]=] ]=[=[Đạt 40 điểm, tăng từ Đấu Trường Sương Mù 4 lên 5. Tầng 2 bị -20 xuống lại tầng 4.]=],
		[ [=[minLevel]=] ]=5,
		[ [=[guildScoreMax]=] ]=380000,
		[ [=[effectName]=] ]=[=[9]=],
		[ [=[type]=] ]=[=[mist]=],
		[ [=[conditionScoreLevelUp]=] ]=40,
		[ [=[condition]=] ]=
		{[=[6]=],[=[6]=]
		}
	}
}
return var