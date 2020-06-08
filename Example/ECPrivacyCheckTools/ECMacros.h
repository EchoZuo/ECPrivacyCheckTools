//
//  ECMacros.h
//  ECPrivacyCheckTools_Example
//
//  Created by EchoZuo on 2020/5/26.
//  Copyright © 2020 EchoZuo. All rights reserved.
//

#ifndef ECMacros_h
#define ECMacros_h

@import UIKit;
@import Foundation;


#define EC_SCREEN_SIZE     ([UIScreen mainScreen].bounds.size) // 屏幕size
#define EC_SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度
#define EC_SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height) // 屏幕高度

#define EC_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height) // iPhoneX 44.0，一般20.0
#define EC_NAVBAR_HEIGHT    (44.0f) //导航栏高度
#define EC_HEADERBAR_HEIGHT (EC_STATUSBAR_HEIGHT + EC_NAVBAR_HEIGHT) // 导航栏 + 状态栏高度

#define EC_HOMEBAR_HEIGHT   ((EC_IS_IPHONE_X_SERIES) ? (34.0f) : (0.0f)) // 虚拟条高度
#define EC_TABBAR_HEIGHT    (49.0f) //TabBar高度
#define EC_FOOTERBAR_HEIGHT (EC_HOMEBAR_HEIGHT + EC_TABBAR_HEIGHT) // 虚拟条 + TabBar高度

// iPhoneX系列
#define EC_CONTENTAREA_WIDTH  (EC_SCREEN_WIDTH)
#define EC_CONTENTAREA_HEIGHT (EC_SCREEN_HEIGHT - EC_STATUSBAR_HEIGHT - EC_HOMEBAR_HEIGHT)


// 通过尺寸区分设备
#define EC_IS_IPHONE_4         (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size)) // 4、4S
#define EC_IS_IPHONE_5         (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size)) // 5、5S、SE
#define EC_IS_IPHONE_6         (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size)) // 6、6S、7、8、SE2
#define EC_IS_IPHONE_PLUS      (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size)) // 6SP、7P、8P
#define EC_IS_IPHONE_X         (CGSizeEqualToSize(CGSizeMake(375, 812), [UIScreen mainScreen].bounds.size)) // iPhoneX、iPhoneXS、iPhone11Pro
#define EC_IS_IPHONE_XR        (CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size)) // iPhoneXR、iPhoneXS MAX、iPhone11、iPhone11Pro Max

// 是否为iPhoneX系列 iPhoneX、iPhoneXS、iPhoneXR、iPhoneXS MAX、iPhone11、iPhone11Pro、iPhone11Pro Max
#define EC_IS_IPHONE_X_SERIES  ((CGSizeEqualToSize(CGSizeMake(375, 812), [UIScreen mainScreen].bounds.size)) || (CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size)))

#endif /* ECMacros_h */
