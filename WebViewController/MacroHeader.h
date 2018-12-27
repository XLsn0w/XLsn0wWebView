//
//  MacroHeader.h
//  XLsn0wWebView
//
//  Created by TimeForest on 2018/12/27.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#ifndef MacroHeader_h
#define MacroHeader_h

///开发的时候，宏定义用的挺普遍，好多人喜欢把导航高度直接定义成 64.f，但是在iPhoneX系列中（iPhoneX、iPhoneXS、iPhoneXR、iPhoneXS Max），导航栏的高度为88.f.

//非iPhoneX：状态栏高度(20.f)+导航栏高度(44.f)  = 64.f,
//iPhoneX系列：状态栏高度(44.f)+导航栏高度(44.f) = 88.f.

 

//对于状态栏高度，我们可以代码自动获取
//
//[[UIApplication sharedApplication] statusBarFrame].size.height
//
// 所有iPhone系列：状态栏高度 （[[UIApplication sharedApplication] statusBarFrame].size.height）+导航栏高度(44.f)
//
//但是有一种情况，当我们设置了：[[UIApplication sharedApplication] setStatusBarHidden:YES];
//
//如果把当前页面的状态栏隐藏了，那么此时 [[UIApplication sharedApplication] statusBarFrame].size.height = 0
//所以我们在宏定义的时候还是得判断当前状态栏的状态

///iPhoneX的宏定义判断

#define DT_IS_IPHONEX_XS   (SCREEN_HEIGHT == 812.f)//是否是iPhoneX、iPhoneXS

#define DT_IS_IPHONEXR_XSMax   (SCREEN_HEIGHT == 896.f)//是否是iPhoneXR、iPhoneX Max

#define IS_IPHONEX_SET  (DT_IS_IPHONEX_XS||DT_IS_IPHONEXR_XSMax)//是否是iPhoneX系列手机

/** 获取状态栏高度 */

#define State_Bar_H         ( ( ![[UIApplication sharedApplication] isStatusBarHidden] ) ? [[UIApplication sharedApplication] statusBarFrame].size.height : (IS_IPHONEX_SET?44.f:20.f))

///首先判断状态栏是否隐藏，如果没有隐藏，就代码获取，如果隐藏了，就判断是否是iPhoneX系列产品，如果是就是44.f，否则就是20.f







#endif /* MacroHeader_h */
