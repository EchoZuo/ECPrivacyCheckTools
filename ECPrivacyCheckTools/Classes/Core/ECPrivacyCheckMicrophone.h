//
//  ECPrivacyCheckMicrophone.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 麦克风

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


/** 授权状态
 *  ECMicrophoneAuthorizationStatusUnable：不支持或不可用
 *  ECMicrophoneAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECMicrophoneAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECMicrophoneAuthorizationStatusDenied：用户拒绝
 *  ECMicrophoneAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECMicrophoneAuthorizationStatus) {
    ECMicrophoneAuthorizationStatusUnable = -1,
    ECMicrophoneAuthorizationStatusNotDetermined = 0,
    ECMicrophoneAuthorizationStatusRestricted,
    ECMicrophoneAuthorizationStatusDenied,
    ECMicrophoneAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckMicrophone : NSObject

/// 检查麦克风权限状态：仅检查权限，不主动请求权限
+ (ECMicrophoneAuthorizationStatus)microphoneAuthorizationStatus;

/// 检查麦克风权限状态：仅检查权限，不主动请求权限
- (ECMicrophoneAuthorizationStatus)microphoneAuthorizationStatus;

/// 请求麦克风权限
/// @param completionHandler completionHandler
+ (void)requestMicrophoneAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求麦克风权限
/// @param completionHandler completionHandler
- (void)requestMicrophoneAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
