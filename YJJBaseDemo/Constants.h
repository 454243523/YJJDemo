//
//  Constants.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#ifndef Constants_h
#define Constants_h



//颜色
#define kColor666666 [UIColor colorWithHexRGB:@"#666666"]
#define kColor_ed3b08 [UIColor colorWithHexRGB:@"#ed3b08"]
//股票颜色
#define kColorRed kRGBColor(234,56,12)
#define kColorStockD kRGBColor(50,173,55);
#define kColorStockH [UIColor colorWithHexRGB:@"#707070"]
#define kColor_yellow [UIColor colorWithHexRGB:@"#FFA500"]
#define kColor_blue [UIColor colorWithHexRGB:@"#4A708B"]
#define kColor_green [UIColor colorWithHexRGB:@"#228B22"]
#define kColor_red [UIColor colorWithHexRGB:@"#CD0000"]

/*=================================通知=================================*/
//更新积分
#define kScore @"score"
/*=================================数据存储=================================*/

/*=================================缓存数据=================================*/
//记录方案的id 默认一直叠加
#define kStockPickTag @"stockId"

/*=================================常量=================================*/
//底部高度
#define kBottomHeight 49
//导航高度
#define kTopHeight 64
//默认图
#define kMorenImg [UIImage imageNamed:@"moren"]
//表格行高
#define kheightBig 60
#define kheightSamll kWindowHFor6(110)
//字体大小
#define ksizeFont_Deflut_15 [UIFont systemFontOfSize:15]
#define ksizeFont_Deflut_14 [UIFont systemFontOfSize:14]
#define ksizeFont_Deflut_12 [UIFont systemFontOfSize:12]
//缓存时间
#define kCacheTime 60*60*12
#define kUserManeger [ISZUser shareUser]
//分享id
#define kSDKID @"1beb610c6dc48"
//微信
//#define kWX_ID @"wxe43ac5361a192855"
//#define kWX_SC @"3ee5bd31bb9ac89707524aaa9f535b83"
#define kWX_ID @"wx265f72ba72a6eb01"
#define kWX_SC @"aa2bbde01735f49e45b7a97408e8ab17"

//微博
#define kWB_ID @"543144275"
#define kWB_SC @"f7e14994d08a0e1be155d7cc662b6109"
//QQ
#define kQQ_ID @"1105919047"
#define kQQ_KEY @"6YPWUx0szkK5KMbl"
//信鸽
#define kXG_ID 2200254886
#define kXG_KYE @"I8VFP2Y166EW"
//主页
#define kHomeUrl @"http://www.cfchi.com"
//图片的地址
#define kImgUrl @"http://www.cfchi.com"

//大盘天气
#define kdapanTianQi [NSString stringWithFormat:@"http://www.cfchi.com/index.php?ac=cp_dptq&client=wap&uid=%@",[ISZUser shareUser].uid]

//参数配置
#define kChanshuSet [NSString stringWithFormat:@"http://www.cfchi.com/index.php?ac=cp_setting&client=wap&uid=%@",[ISZUser shareUser].uid]

//股票列表数组
#define kStockName @[@"现价",@"涨幅" ,@"财富值",@"5日财富值", @"10日财富值", @"5日涨幅", @"10日涨幅",@"控盘度",@"基本面", @"环比增长", @"流通市值", @"进入日期", @"进入价格", @"盈亏比例", @"最高盈亏"]
#define kStockKey @[@"xj_price",@"increase",@"cfchi",@"cfchi5",@"cfchi10",@"increase5",@"increase10",@"bili",@"finance",@"return_bili",@"market_value",@"indate",@"in_price",@"income",@"max_income"]
#endif /* Constants_h */
