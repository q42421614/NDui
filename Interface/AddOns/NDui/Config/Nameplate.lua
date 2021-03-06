local _, ns = ...
local _, C = unpack(ns)

-- 法术白名单
C.WhiteList = {
	-- Buffs
	[642]		= true,		-- 圣盾术
	[1022]		= true,		-- 保护之手
	[23920]		= true,		-- 法术反射
	[45438]		= true,		-- 寒冰屏障
	[186265]	= true,		-- 灵龟守护
	-- Debuffs
	[2094]		= true,		-- 致盲
	[117405]	= true,		-- 束缚射击
	[127797]	= true,		-- 乌索尔旋风
	[20549] 	= true,		-- 战争践踏
	[107079] 	= true,		-- 震山掌
	[272295] 	= true,		-- 悬赏
	-- Dungeons
	[268008]	= true,		-- 毒蛇诱惑，神庙
	[260792]	= true,		-- 尘土云，神庙
	[260416]	= true,		-- 蜕变，孢林
	[274631]	= true,		-- 次级铁墙祝福，风暴神殿
	[267901]	= true,		-- 铁墙祝福，风暴神殿
	[276767]	= true,		-- 吞噬虚空，风暴神殿
	[268212]	= true,		-- 小型强化结界，风暴神殿
	[268186]	= true,		-- 强化结界，风暴神殿
	[263246]	= true,		-- 闪电之盾，风暴神殿
	[257597]	= true,		-- 艾泽里特的灌注，矿区
	[260805]	= true,		-- 聚焦之虹，庄园
	[264027]	= true,		-- 结界蜡烛，庄园
	[255968]	= true,		-- 强效巫毒，阿塔达萨
	[255970]	= true,		-- 强效巫毒，阿塔达萨
	[228318]	= true,		-- 激怒
	[226510]	= true,		-- 血池
	[277242]	= true,		-- 共生
	-- Raids
	[276093]	= true,		-- 血色镜像，祖尔
	[276299]	= true,		-- 充血爆发，祖尔
	[276434]	= true,		-- 腐烂血肉，祖尔
	[276900]	= true,		-- 临界炽焰，拆解者米斯拉克斯
	[263482]	= true,		-- 重组冲击，戈霍恩
	[263284]	= true,		-- 鲜血之力，戈霍恩
	[268074]	= true,		-- 黑暗意图，戈霍恩
	[275204]	= true,		-- 不可阻挡的腐化，戈霍恩

	[207327]	= true,		-- 净化毁灭，崔利艾克斯
	[236513]	= true,		-- 骨牢护甲，聚合体小怪
	[240315]	= true,		-- 硬化之壳，哈亚坦蛋盾
	[241521]	= true,		-- 折磨碎片，M审判庭小怪
	[250074]	= true,		-- 净化，艾欧娜尔
	[250555]	= true,		-- 邪能护盾，艾欧娜尔
	[246504]	= true,		-- 程式启动，金加洛斯
	[249863]	= true,		-- 泰坦的面容，破坏魔女巫会
	[244903]	= true,		-- 催化作用，阿格拉玛
	[247091]	= true,		-- 催化，阿格拉玛
	[253021]	= true,		-- 宿命，寂灭者阿古斯
	[255496]	= true,		-- 宇宙之剑，寂灭者阿古斯
	[255478]	= true,		-- 永恒之刃，寂灭者阿古斯
	[255418]	= true,		-- 物理易伤，寂灭者阿古斯
	[255425]	= true,		-- 冰霜易伤，寂灭者阿古斯
	[255430]	= true,		-- 暗影易伤，寂灭者阿古斯
	[255429]	= true,		-- 火焰易伤，寂灭者阿古斯
	[255419]	= true,		-- 神圣易伤，寂灭者阿古斯
	[255422]	= true,		-- 自然易伤，寂灭者阿古斯
	[255433]	= true,		-- 奥术易伤，寂灭者阿古斯
}

-- 法术黑名单
C.BlackList = {
	[15407]		= true,		-- 精神鞭笞
	[1490]		= true,		-- 混乱烙印
	[113746]	= true,		-- 玄秘掌
	[51714]		= true,		-- 锋锐之霜
	[199721]	= true,		-- 腐烂光环
	[214968]	= true,		-- 死灵光环
	[214975]	= true,		-- 抑心光环
	[273977]	= true,		-- 亡者之握
	[276919]	= true,		-- 承受压力
}