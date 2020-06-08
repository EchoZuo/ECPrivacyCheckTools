//
//  ECPrivacyCheckMediaAndAppleMusic.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 媒体与Apple Music >= iOS9.3

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


/** 授权状态
 *  ECMediaAndAppleMusicAuthorizationStatusUnable：不支持或不可用
 *  ECMediaAndAppleMusicAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECMediaAndAppleMusicAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECMediaAndAppleMusicAuthorizationStatusDenied：用户拒绝
 *  ECMediaAndAppleMusicAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECMediaAndAppleMusicAuthorizationStatus) {
    ECMediaAndAppleMusicAuthorizationStatusUnable = -1,
    ECMediaAndAppleMusicAuthorizationStatusNotDetermined = 0,
    ECMediaAndAppleMusicAuthorizationStatusRestricted,
    ECMediaAndAppleMusicAuthorizationStatusDenied,
    ECMediaAndAppleMusicAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckMediaAndAppleMusic : NSObject

/// 检查 媒体与Apple Music 权限状态：仅检查权限，不主动请求权限
+ (ECMediaAndAppleMusicAuthorizationStatus)mediaAndAppleMusicAuthorizationStatus API_AVAILABLE(ios(9.3));

/// 检查 媒体与Apple Music 权限状态：仅检查权限，不主动请求权限
- (ECMediaAndAppleMusicAuthorizationStatus)mediaAndAppleMusicAuthorizationStatus API_AVAILABLE(ios(9.3));

/// 请求 媒体与Apple Music 权限
/// @param completionHandler completionHandler
+ (void)requestMediaAndAppleMusicAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler API_AVAILABLE(ios(9.3));

/// 请求 媒体与Apple Music 权限
/// @param completionHandler completionHandler
- (void)requestMediaAndAppleMusicAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler API_AVAILABLE(ios(9.3));


@end

NS_ASSUME_NONNULL_END
