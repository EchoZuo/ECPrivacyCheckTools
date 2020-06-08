//
//  ECPrivacyCheckLocationServices.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 定位服务

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


/** 定位授权状态
 *
 *  ECLocationAuthorizationStatusUnable：不支持或不可用
 *  ECLocationAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECLocationAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECLocationAuthorizationStatusDenied：用户拒绝
 *  ECLocationAuthorizationStatusAuthorizedAlways：一直允许获取定位
 *  ECLocationAuthorizationStatusAuthorizedWhenInUse：在使用时允许定位
 *  ECLocationAuthorizationStatusAuthorized：已废弃，在iOS2.0~8.0使用，> iOS 8.0 请使用 ECLocationAuthorizationStatusAuthorizedAlways： 一直允许获取定位
*/
typedef NS_ENUM(NSInteger, ECLocationAuthorizationStatus) {
    ECLocationAuthorizationStatusUnable = -1,
    ECLocationAuthorizationStatusNotDetermined = 0,
    ECLocationAuthorizationStatusRestricted,
    ECLocationAuthorizationStatusDenied,
    ECLocationAuthorizationStatusAuthorizedAlways,
    ECLocationAuthorizationStatusAuthorizedWhenInUse,
    ECLocationAuthorizationStatusAuthorized API_DEPRECATED("Use ECLocationAuthorizationStatusAuthorizedAlways", ios(2.0, 8.0)) = ECLocationAuthorizationStatusAuthorizedAlways
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckLocationServices : NSObject

/// 检查定位权限状态：仅检查权限，不主动请求权限
+ (ECLocationAuthorizationStatus)locationAuthorizationStatus;

/// 检查定位权限状态：仅检查权限，不主动请求权限
- (ECLocationAuthorizationStatus)locationAuthorizationStatus;

/// 请求定位权限
/// @param completionHandler completionHandler
- (void)requestLocationAuthorizationWithCompletionHandler:(void(^)(ECLocationAuthorizationStatus status))completionHandler;

@end

NS_ASSUME_NONNULL_END
