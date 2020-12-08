local null = nil
local var = 
{
	[ [=[1]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitMascotPresent]=],
		[ [=[introduce]=] ]=[=[1. Trong thời gian hoạt động, người chơi Liên Đoàn hoàn thành nhiệm vụ thân mật sẽ tăng độ thân mật Linh Vật của Liên Đoàn. Điểm thân mật khi đạt điểm nhất định, Linh Vật sẽ tặng 40 Hộp May Mắn, mỗi người chơi được chọn 1 hộp, nhận quà ngẫu nhiên. Khi có hộp có thể mở cần chú ý mở, sau khi trang hoạt động biến mất, hộp chưa mở sẽ bị xóa.
2. Dựa theo Thân Mật Linh Vật của Liên Đoàn để xếp hạng độ thân mật Liên Đoàn. Liên Đoàn đạt yêu cầu điểm thân mật của hạng sẽ có cơ hội lọt vào BXH, nếu nhiều Liên Đoàn cùng lúc đạt yêu cầu điểm thân mật của một hạng nào đó, thì điểm thân mật càng cao thì hạng Liên Đoàn sẽ càng cao. Khi hoạt động kết thúc, căn cứ hạng thân mật của Liên Đoàn, gửi phần thưởng hạng cho tất cả thành viên Liên Đoàn qua thư. Trong thời gian hoạt động, người chơi Liên Đoàn chưa từng nhấp qua trang hoạt động này sẽ không thể nhận thưởng.
3. Nhiệm vụ độ thân mật chia làm nhiệm vụ Liên Đoàn và nhiệm vụ cá nhân. Sau khi xong nhiệm vụ Liên Đoàn, thưởng độ thân mật linh vật sẽ tự động tăng, thưởng đạo cụ cá nhân khác cần nhận thủ công, nhiệm vụ cá nhân mỗi ngày 5 giờ tạo mới, tất cả phần thưởng đều cần nhận thủ công. Sau khi xong nhiệm vụ hãy kịp thời nhận thưởng, phần thưởng chưa nhận sẽ không được gửi bù.
4. Sau khi hoạt động kết thúc, trang vẫn sẽ hiện thêm một khoảng thời gian. Trong khoảng thời gian này, người chơi chưa nhận phần thưởng nhiệm vụ vẫn có thể đến nhận, sau khi nhận có thể nhận được đạo cụ tương ứng, nhưng điểm thân mật linh vật sẽ không tăng nữa, trong thời gian này, người chơi có hộp độ thân mật linh vật chưa mở cũng có thể tiếp tục mở, nhưng ở giai đoạn này người chơi không thể tiếp tục tiến hành nhiệm vụ.
5. "Liên Đoàn trực thuộc" của người chơi là Liên Đoàn hiện tại của người chơi khi hoạt động bắt đầu. Trong thời gian hoạt động hoàn thành nhiệm vụ nhận được điểm thân mật sẽ cống hiến cho linh vật của "Liên Đoàn trực thuộc", hộp linh vật có thể mở, phần thưởng tất cả thành viên hạng độ thân mật Liên Đoàn nhận được cũng sẽ do "Liên Đoàn trực thuộc" quyết định. Người chơi trong thời gian hoạt động đổi Liên Đoàn thì "Liên Đoàn trực thuộc" cũng sẽ không thay đổi.
6. Khi hoạt động bắt đầu, người chơi không có Liên Đoàn sẽ không thể tham gia hoạt động lần này, vui lòng đợi hoạt động lần sau.
]=],
		[ [=[type]=] ]=1
	},
	[ [=[2]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[CompeteGuess]=],
		[ [=[introduce]=] ]=[=[1. Mỗi ngày sẽ chọn 4 trận loại trực tiếp ở Champions Cup hoặc Europa Cup để người chơi dự đoán; Nếu không đủ 4 trận có thể dự đoán hết.
2. Người chơi có thể dự đoán nhiều trận.
3. 0 giờ mỗi ngày cập nhật số trận dự đoán, 0 giờ đến khi trận đấu bắt đầu có thể tiến hành dự đoán.
4. Chọn đội mình nghĩ sẽ chiến thắng, nếu dự đoán đúng đội thắng sẽ nhận được thưởng dự đoán.
5. Dùng Vàng để dự đoán, chia làm 5 mức đặt, mức đặt càng cao phần thưởng càng lớn, đặt xong không thể thay đổi.
6. Nếu đội kèo dưới chiến thắng, đặt cược mức 4-5 nếu đoán đúng sẽ nhận thưởng nhiều hơn, số người ủng hộ 2 bên cách biệt càng lớn phần thưởng càng hấp dẫn, chi tiết xem ở trang dự đoán.
7. Sau khi có kết quả trận dự đoán, có thể xem ở giao diện Dự Đoán và nhận thưởng.
8. Thưởng được bảo lưu 7 ngày sau khi mùa giải này kết thúc, sau 7 ngày sẽ xóa nên bạn hãy chú ý nhận thưởng.

]=],
		[ [=[type]=] ]=2
	},
	[ [=[3]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitGuildCarnival]=],
		[ [=[introduce]=] ]=[=[1. Trong thời gian hoạt động, thành viên Liên Đoàn mua vật phẩm ở Shop Liên Đoàn Đua Tài sẽ nhận được điểm Liên Đoàn, khi đạt số điểm nhất định, tất cả thành viên Liên Đoàn sẽ nhận được phần thưởng hậu hĩnh!

2. Sau khi hoạt động kết thúc, phần thưởng điểm Liên Đoàn sẽ được gửi qua thư cho tất cả thành viên Liên Đoàn. Trong thời gian hoạt động, người chơi chưa từng nhấp vào trang hoạt động này sẽ không thể nhận thưởng.

3. "Liên Đoàn trực thuộc" của người chơi là Liên Đoàn hiện tại của người chơi khi hoạt động bắt đầu. Trong thời gian hoạt động, điểm nhận được khi mua vật phẩm sẽ cống hiến cho "Liên Đoàn trực thuộc", phần thưởng điểm Liên Đoàn nhận được cũng được quyết định bởi điểm "Liên Đoàn trực thuộc". Trong thời gian hoạt động nếu người chơi rời Liên Đoàn hoặc vào Liên Đoàn khác, "Liên Đoàn trực thuộc" cũng sẽ không thay đổi.

4. Khi hoạt động bắt đầu, người chơi chưa có Liên Đoàn sẽ không thể tham gia hoạt động, vui lòng đợi hoạt động lần sau.]=],
		[ [=[type]=] ]=1
	},
	[ [=[4]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[CaochMainPage]=],
		[ [=[introduce]=] ]=[=[Một HLV trẻ có thiên phú xuất sắc nhưng lại thiếu kinh nghiệm thực tế gia nhập vào đội bóng của bạn, bạn hãy cùng HLV trưởng thành để cùng nhau trở thành nhân vật cấp thế giới.
1. Cùng HLV trẻ tham gia Nhiệm Vụ Huấn Luyện, nhận thêm vật phẩm HLV.
2. Trợ giúp HLV trẻ nghiên cứu đội hình và chiến thuật ở phần thông tin chung.
3. Cùng HLV trẻ tìm tòi học hỏi kinh nghiệm hướng dẫn, phát triển thiên phú Huấn Luyện của HLV.
4. Tìm Trợ Lý HLV thích hợp cho HLV và đội bóng của bạn, sở hữu Trợ Lý HLV sẽ giúp cầu thủ của bạn thêm sức mạnh.]=],
		[ [=[type]=] ]=2
	},
	[ [=[5]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[CoachMission]=],
		[ [=[introduce]=] ]=[=[Các đội bóng cần có một HLV dẫn dắt cầu thủ của họ trong thời gian ngắn, họ đồng ý trả thù lao cực cao.
1. Người chơi mỗi ngày có số lần tham gia Nhiệm Vụ Huấn Luyện cố định, nếu muốn nhận thêm số lần, người chơi cần tốn Kim Cương để mua, cấp VIP càng cao thì số lần mua càng nhiều, hãy đảm bảo Nhiệm Vụ Huấn Luyện hoàn thành trong ngày, số lần Nhiệm Vụ Huấn Luyện sẽ tạo mới vào ngày hôm sau.
2. Mỗi tổ chức tuyển dụng đều có yêu cầu khác nhau với cầu thủ của HLV của mình, chỉ có cầu thủ đạt yêu cầu (trong đó yêu cầu kỹ năng phải là kỹ năng vốn có của cầu thủ), họ mới ký hợp đồng Nhiệm Vụ Huấn Luyện.
3. Mỗi lần chúng tôi sẽ cung cấp cho bạn 3 lời mời Nhiệm Vụ Huấn Luyện, nếu không có lời mời thích hợp thì phải làm sao? Chúng tôi sẽ cho bạn cơ hội tạo mới miễn phí. Đồng thời bạn cũng có thể dùng Kim Cương để tạo mới.
4. Tăng cấp HLV để nhận được lời mời Nhiệm Vụ Huấn Luyện cao cấp hơn, Nhiệm Vụ Huấn Luyện cấp cao sẽ có thù lao cao hơn.
5. Mỗi Nhiệm Vụ Huấn Luyện đều cần tốn thời gian nhất định, mỗi cầu thủ mỗi ngày chỉ được tham gia 1 Nhiệm Vụ Huấn Luyện, sau khi hoàn thành Nhiệm Vụ Huấn Luyện nhớ vào phần Cá Nhân để nhận thưởng.]=],
		[ [=[type]=] ]=2
	},
	[ [=[6]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[CoachBaseInfo]=],
		[ [=[introduce]=] ]=[=[Mỗi HLV đều có phong cách riêng, bồi dưỡng thuộc tính cơ bản của HLV.
1. Phẩm chất cơ bản của HLV là yếu tố quan trọng để xác định năng lực của HLV, phẩm chất cao sẽ giúp HLV nhanh chóng học được cách sử dụng đội hình và chiến thuật, cách phát huy thiên phú của bản thân...
2. Tăng phẩm chất HLV cần dùng Sách EXP Huấn Luyện, Sách EXP Huấn Luyện có thể nhận qua Nhiệm Vụ Huấn Luyện.
3. Mỗi HLV đều có thể học đội hình và chiến thuật tốt hơn, dùng Sách Tăng Cấp C.Thuật/Đội Hình, có thể tăng cấp chiến thuật/đội hình tương ứng.]=],
		[ [=[type]=] ]=2
	},
	[ [=[7]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[CoachTalentSkill]=],
		[ [=[introduce]=] ]=[=[HLV trẻ của bạn cần bạn cho biết phương hướng hướng dẫn, để thiên phú Huấn Luyện của HLV có thể phát huy đúng chỗ.
1. Học thiên phú HLV cần dùng Vé Thiên Phú HLV, Vé Thiên Phú HLV thông qua tăng phẩm chất HLV nhận, đương nhiên trong nhiệm vụ hướng dẫn cũng sẽ có xác suất thấp nhận được Vé Thiên Phú
2. Tổng có 4 loại thiên phú HLV lớn, mỗi trang thiên phú cân điều kiện nhất định mới có thể mở khóa học.]=],
		[ [=[type]=] ]=2
	},
	[ [=[8]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitGoldCup]=],
		[ [=[introduce]=] ]=[=[1. Trong hoạt động, người chơi mỗi tiêu phí 1 Kim Cương sẽ cống hiến 1 điểm năng lượng cho Cup Vàng, mỗi tiêu phí 1 360mobi Coin sẽ cống hiến 15 điểm năng lượng.
2. Khi Năng Lượng Cúp Vàng đạt mức nhất định, tất cả HLV có điểm Cống Hiến Cá Nhân đạt yêu cầu sẽ đều có thể nhận quà Cúp Vàng.
3. HLV có điểm Cống Hiến Cá Nhân đạt yêu cầu sẽ có cơ hội vào BXH. Nếu có nhiều HLV đồng thời đạt yêu cầu ở một bậc xếp hạng nào đó, thì HLV có điểm cao hơn sẽ xếp trên, nếu cùng số điểm thì HLV đạt yêu cầu trước sẽ xếp trên. Khi hoạt động kết thúc, thưởng xếp hạng được gửi qua thư]=],
		[ [=[type]=] ]=1
	},
	[ [=[9]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[CoachGuide]=],
		[ [=[introduce]=] ]=[=[Mỗi HLV thành công đều xuất sắc trong việc chỉ dẫn cầu thủ trưởng thành tốt hơn, HLV của bạn cũng phải bước vào hành trình này.
1. Căn cứ cấp HLV, HLV của bạn sẽ nhận được thêm ô Đặc Tính, ô Đặc Tính càng cao cho phép cầu thủ có càng nhiều kỹ năng đặc tính.
2. Mỗi cầu thủ đặt vào ô bất kỳ ngẫu nhiên tạo ra 1-3 đặc tính, người chơi có thể dùng Sách Đặc Tính và đạo cụ đặc tính hỗ trợ, giúp cầu thủ trưởng thành.
3. Kỹ năng đặc tính không thể hiện qua năng lực, nhưng khi thi đấu căn cứ tình hình thực tế cộng thêm cho cầu thủ, người chơi có thể vào trang lớn để xem đặc tính cầu thủ thêm]=],
		[ [=[type]=] ]=2
	},
	[ [=[10]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[AssistantCoachInformationLibrary]=],
		[ [=[introduce]=] ]=[=[Một HLV cấp thế giới phải cần có sự trợ giúp của Trợ Lý HLV , tìm Trợ Lý HLV thích hợp có thể giúp đội bóng tăng cao năng lực.
1. Người chơi có thể dùng Báo Cáo Trợ Lý HLV để chiêu mộ Trợ Lý HLV, mỗi lần đặt 1-3 báo cáo, chúng tôi sẽ dựa theo điều kiện báo cáo để chọn Trợ Lý HLV thích hợp cho bạn.
2. Khi đặt nhiều báo cáo cấp sao khác nhau sẽ chỉ chiêu mộ Trợ Lý HLV có cấp sao thấp nhất trong báo cáo.
3. Báo Cáo Trợ Lý HLV đặc biệt không ảnh hưởng đến việc tạo ra cấp sao thấp nhất, nhưng có xác suất hiệu lực nhất định. Ví dụ: Cùng dùng 1 Báo Cáo Thường 3 sao và 1 Báo Cáo Đặc Biệt 1 sao sẽ chiêu mộ ra 1 Trợ Lý HLV 3 sao, Trợ Lý HLV sẽ thỏa mãn điều kiện Báo Cáo 3 Sao, đồng thời có xác suất thỏa mãn điều kiện của Báo Cáo 1 Sao.]=],
		[ [=[type]=] ]=2
	},
	[ [=[11]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitPowerShoot]=],
		[ [=[introduce]=] ]=[=[Đã đến lúc thể hiện bản năng đánh hơi bàn thắng của tiền đạo ngôi sao, trợ giúp cầu thủ sút bóng nhận nhiều thưởng, các đạo cụ hiếm đang chờ bạn!
1. Mỗi lần sút bóng, hệ thống sẽ chọn ra 1 phần  thưởng Đặc Biệt, 1 phần thưởng Siêu Hiếm, 2 phần thưởng Hiếm, 3 phần thưởng Thường và 3 phần thưởng Tham Dự vào kho thưởng, khi người chơi bắt đầu sút bóng, kho thưởng sẽ cố định, đến khi người chơi tự tạo mới hoặc phần thưởng kho thưởng bị lấy hết.
2. Mỗi lần sút bóng sẽ tiêu hao Kim Cương nhất định, số lượng cụ thể có thể nhấp vào chấm than để xem
3. Khi người sút 10 lần sẽ nhận đủ 10 phần thưởng trong kho thưởng.]=],
		[ [=[type]=] ]=1
	},
	[ [=[12]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitGoldBall]=],
		[ [=[introduce]=] ]=[=[1. Trong hoạt động hoàn thành nhiệm vụ ngày và nhiệm vụ tuần hoàn, có thể nhận Bóng Vàng. Tích lũy Bóng Vàng đạt mức nhất định, có thể nhận phần thưởng Cơ Bản tương ứng.
2. Tốn 360mobi Coin mua gói nhận thường Nâng Cao khi hoàn thành tiến độ tương ứng, sẽ nhận thêm thưởng Nâng Cao. (Sau khi mua gói vẫn có thể nhận phần thưởng Nâng Cao của tiến độ đã hoàn thành trước đó)
3. Mỗi ngày 5:00 tạo mới nhiệm vụ ngày, mỗi nhiệm vụ mỗi ngày hoàn thành 1 lần. Nhiệm vụ tuần hoàn có thể làm nhiều lần. Sau khi xong nhiệm vụ hãy nhận Bóng Vàng kịp lúc, Bóng Vàng chưa nhận sẽ không gửi bù.
4. Phần thưởng tiến độ nếu chưa nhận sẽ gửi qua thư khi hoạt động kết thúc.]=],
		[ [=[type]=] ]=1
	},
	[ [=[13]=] ]=
	{
		[ [=[title]=] ]=[=[Giới thiệu cách chơi]=],
		[ [=[descID]=] ]=[=[AdventureHowToPlay]=],
		[ [=[introduce]=] ]=[=[1. Cách chơi Chinh Phục Sân Cỏ tổng cộng 9 tầng, người chơi ra sân sẽ gặp các loại sự kiện sau: Vòng Quay May Mắn, Đào Báu Bản Đồ Kho Báu, Chợ Đen..., cũng sẽ bị người chơi khác khiêu chiến. Các Giám Đốc sẽ ra sân không ngừng thăm dò, tăng cấp, tiếp nhận khiêu chiến để đạt đến tầng cao hơn, nhận phần thưởng hậu hĩnh.
2. Chinh Phục Sân Cỏ mỗi 14 ngày là 1 mùa giải, sau khi mùa giải mới bắt đầu, tiến độ của mùa giải trước sẽ bị tạo lại, đạo cụ cách chơi nhận được Túi cũng sẽ bị xóa trống, không bảo lưu đến mùa giải mới.
3. Trong mỗi tầng, lối vào và lối ra đều ở vị trí cố định. Người chơi xuất phát từ lối vào, không ngừng mở khóa khu vực trong sương mù, gặp các loại sự kiện. Mỗi khi mở khóa một khu vực trong sương mù sẽ tốn 8 điểm Sĩ Khí. Hoàn thành sự kiện cũng sẽ tốn Sĩ Khí, sự kiện khác nhau cần Sĩ Khí khác nhau. Khiêu chiến người chơi khác chiến thắng nhận được Ý Chí, Ý Chí có thể dùng mua đạo cụ trong Shop, mở Rương Ý Chí... Loại hình người chơi và hiệu số chiến thắng sẽ ảnh hưởng đến số lượng Ý Chí nhận được, quy tắc cụ thể mời xem trong "Quy tắc nhận Ý Chí". Cuối cùng đi đến lối ra, khiêu chiến BOSS ở lối ra nếu chiến thắng có thể vào tầng kế tiếp.
4. Trong quá trình ra sân sẽ vào chu kỳ khác nhau. Trong mỗi chu kỳ, bản đồ chịu ảnh hưởng của thời tiết và chòm sao cố định. Quy tắc thay đổi chu kỳ và hiệu quả thời tiết, chòm sao mời xem trong trò chơi.
5. Chia chiến khu: Mỗi mùa giải sẽ căn cứ vào năng lực cao nhất trong lịch sử khi bắt đầu mùa giải để chia khiến khu, chiến khu khác nhau phần thưởng khác nhau. Quy tắc chia cụ thể  mời xem trong "Chia chiến khu".
6. Số lượng Sĩ Khí ban đầu của mùa giải: Liên quan đến năng lực cao nhất trong lịch sử khi mùa giải bắt đầu, khoảng cách năng lực trong chiến khu, cụ thể như sau: 
Năng lực ở trong phạm vi <color=#FFFE5EFF>0-30%</color> của chiến khu, ban đầu nhận được <color=#FFFE5EFF>250 điểm</color> Sĩ Khí.
 Năng lực ở trong phạm vi <color=#FFFE5EFF>30%-60%</color> (không bao gồm 30%), ban đầu nhận được <color=#FFFE5EFF>300 điểm</color> Sĩ Khí.
Năng lực ở trong phạm vi <color=#FFFE5EFF>60%-90%</color> (không bao gồm 60%), ban đầu nhận được <color=#FFFE5EFF>350 điểm</color> Sĩ Khí.
Năng lực ở trong phạm vi <color=#FFFE5EFF>90% trở lên</color> (không bao gồm 90%), ban đầu nhận được <color=#FFFE5EFF>400 điểm</color> Sĩ Khí.
Ví dụ: Người chơi ở Khu A (400000-799999), khi mùa giải bắt đầu, năng lực cao nhất trong lịch sử là 550000, trong phạm vi (30%-60%), vậy trong mùa giải này người chơi ban đầu nhận được 300 điểm Sĩ Khí.
7. Thưởng số tầng: Vượt ải 1 tầng nhận được nhiều phần thưởng. Hoàn thành 100% sự kiện mỗi tầng còn nhận được phần thưởng thêm. Chi tiết phần thưởng xem trong "Phần thưởng" và "Thưởng hoàn thành 100%".
8. BXH và phần thưởng: Vượt ải mỗi tầng, mở khóa mỗi khu vực sẽ nhận được điểm. Điểm sẽ ảnh hưởng đến hạng trong BXH. Nếu điểm giống nhau thì người chơi đạt được số điểm đó trước sẽ xếp hạng cao hơn. Phần thưởng chia làm 2 loại gồm thưởng mỗi ngày và phần thưởng cuối mùa giải: Mỗi ngày  21 giờ, căn cứ hạng hiện tại trong BXH gửi thưởng mỗi ngày. Khi mùa giải kết thúc, căn cứ hạng cuối trong BXH gửi phần thưởng cuối mùa giải. Chú ý: Chiến khu khác nhau có BXH riêng, chiến khu khác nhau phần thưởng cũng khác nhau, chi tiết phần thưởng xem trong "Thưởng mỗi ngày" và "Phần thưởng cuối mùa giải".]=],
		[ [=[type]=] ]=2
	},
	[ [=[14]=] ]=
	{
		[ [=[title]=] ]=[=[Phần thưởng]=],
		[ [=[descID]=] ]=[=[AdventureClearanceReward]=],
		[ [=[introduce]=] ]=[=[Phần thưởng gồm: Thưởng điểm vượt ải, thưởng đạo cụ vượt ải và thưởng sĩ khí vượt ải.
<color=#FFFE5EFF>Thưởng điểm, thưởng đạo cụ vượt ải:</color> Liên quan đến số tầng, phần thưởng mỗi tầng như sau: 
Tầng 1: 810 điểm, Vitamin x20
Tầng 2: 1215 điểm, Vitamin x20
Tầng 3: 1600 điểm, Vitamin x20
Tầng 4: 2230 điểm, Vitamin x20
Tầng 5: 2835 điểm, Vitamin x20
Tầng 6: 3645 điểm, Vitamin x20
Tầng 7: 4455 điểm, Vitamin x20
Tầng 8: 5470 điểm, Vitamin x20
Tầng 9: 6480 điểm, Vitamin x20
<color=#FFFE5EFF>Phần thưởng vượt ải sĩ khí: </color>Liên quan đến năng lực cao nhất trong lịch sử khi mùa giải bắt đầu, vị trí khoảng cách năng lực trong chiến khu, chi tiết xem hình dưới.
Ví dụ: Người chơi ở Khu Hoàng Kim (400000-800000), khi mùa giải bắt đầu, năng lực cao nhất trong lịch sử là 550000, trong phạm vi (31%-60%), vậy phần thưởng sĩ khí người chơi nhận được khi vượt ải mỗi tầng là 120 điểm.]=],
		[ [=[type]=] ]=2
	},
	[ [=[15]=] ]=
	{
		[ [=[title]=] ]=[=[Hướng Dẫn]=],
		[ [=[descID]=] ]=[=[AdventureHint]=],
		[ [=[introduce]=] ]=[=[1. Tầng nhận được chỉ lệnh thần bí, mỗi <color=#FFFE5EFF>Trợ Lý Giám Đốc</color> có mã số riêng, đáp án của 3 câu hỏi trên chỉ lệnh thần bí chính là mã số của họ.
2. Cần trả lời theo thứ tự câu 1-3, khiêu chiến Trợ Lý Giám Đốc theo thứ tự, sau đó nhận được tư cách khiêu chiến Giám Đốc Cấp Cao. Nếu khiêu chiến sai thứ tự có thể khiêu chiến lại.
3. Trợ Lý Giám Đốc sẽ ẩn dưới sương mù xoáy.]=],
		[ [=[type]=] ]=2
	},
	[ [=[18]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitMarbles]=],
		[ [=[introduce]=] ]=[=[1. Dùng Pinball, sau khi chọn "Bắn 1 lần" hoặc "Bắn 10 lần", khởi động bàn Pinball.
2. Nhấp ngón tay bắt đầu tụ lực, điều chỉnh xong lực bắn rồi nhấp lần nữa đến bắn. Pinball sau khi va chạm sẽ ngẫu nhiên rơi vào 1 ô, HLV sẽ được nhận đạo cụ đổi trong ô.
3. Thu thập đạo cụ đổi có thể đổi thưởng: Nhấp nút "Đổi thưởng" để đổi thưởng yêu thích. Bên trái bàn Pinball có thể xem số lượng các đạo cụ đổi có.
4. Pinball có thể dùng Kim Cương để mua, có thể nhận từ "Nhiệm vụ Pinball". Nhấp nút "Nhiệm vụ Pinball", hoàn thành nhiệm vụ để nhận Pinball. Nhiệm vụ tạo mới lúc 5:00 mỗi ngày, sau khi hoàn thành nhiệm vụ hãy nhận Pinball, hết hạn sẽ không phát bù.
5. Tích lũy bắn đủ số lượng Pinball, sẽ nhận Quà Số Lần. Sau khi hoạt động kết thúc, thưởng số lần chưa nhận sẽ gửi qua thư.
6. Sau khi hoạt động kỳ này kết thúc, Pinball và đạo cụ đổi chưa dùng sẽ xóa, hãy dùng kịp thời.]=],
		[ [=[type]=] ]=1
	},
	[ [=[21]=] ]=
	{
		[ [=[title]=] ]=[=[Cách Chơi]=],
		[ [=[descID]=] ]=[=[TimeLimitMultiGetGift]=],
		[ [=[introduce]=] ]=[=[1. Hoàn thành nhiệm vụ mỗi ngày nhận điểm, đủ điểm sẽ mở khóa hộp quà nhận thưởng. Hộp quà sau khi mở khóa, mỗi ngày nhận 1 lần!
2. Hộp quà sẽ mở dần theo ngày, sau khi mở và điểm đạt yêu cầu mới có thể mở khóa hộp quà; Ngày mở khóa cụ thể có thể xem tại giao diện hộp quà.
3. Xu Tự Chọn có thể mua đạo cụ trong Shop Tự Chọn, nhận từ hộp quà và nhiệm vụ mỗi ngày. Xu Tự Chọn sẽ xóa khi hoạt động kết thúc.
4. Nhiệm vụ tạo mới lúc 5 giờ mỗi ngày, thưởng hết hạn sẽ không gửi bù.
5. Trạng thái hộp quà tạo mới lúc 5 giờ mỗi ngày, sau khi tạo mới có thể nhận lại thưởng trong hộp quà đã mở khóa.
6. Cơ chế gửi bù thưởng hộp quà chưa nhận: Đạo cụ sẽ gửi qua thư; Xu Tự Chọn sẽ gửi thẳng vào giao diện.
7. Hoạt động kết thúc, giao diện sẽ tồn tại một thời gian, Xu Tự Chọn chưa sử dụng vẫn có thể mua trong Shop; Giai đoạn này không thể nhận thưởng hộp quà mỗi ngày và làm nhiệm vụ nữa. Xu Tự Chọn sẽ xóa khi hoạt động kết thúc.]=],
		[ [=[type]=] ]=1
	}
}
return var