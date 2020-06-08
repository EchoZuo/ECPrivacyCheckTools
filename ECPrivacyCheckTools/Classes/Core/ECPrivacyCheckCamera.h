//
//  ECPrivacyCheckCamera.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 相机

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


/** 授权状态
 *  ECCameraAuthorizationStatusUnable：不支持或不可用
 *  ECCameraAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECCameraAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECCameraAuthorizationStatusDenied：用户拒绝
 *  ECCameraAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECCameraAuthorizationStatus) {
    ECCameraAuthorizationStatusUnable = -1,
    ECCameraAuthorizationStatusNotDetermined = 0,
    ECCameraAuthorizationStatusRestricted,
    ECCameraAuthorizationStatusDenied,
    ECCameraAuthorizationStatusAuthorized
};

NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckCamera : NSObject

/// 检查相机权限状态：仅检查权限，不主动请求权限
+ (ECCameraAuthorizationStatus)cameraAuthorizationStatus;

/// 检查相机权限状态：仅检查权限，不主动请求权限
- (ECCameraAuthorizationStatus)cameraAuthorizationStatus;

/// 请求相机权限
/// @param completionHandler completionHandler
+ (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求相机权限
/// @param completionHandler completionHandler
- (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;


@end

NS_ASSUME_NONNULL_END
