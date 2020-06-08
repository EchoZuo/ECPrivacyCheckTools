//
//  ECPrivacyCheckHealth.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 健康

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>


/** 授权状态
 *  ECHealthAuthorizationStatusUnable：不支持或不可用
 *  ECHealthAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECHealthAuthorizationStatusDenied：用户拒绝
 *  ECHealthAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECHealthAuthorizationStatus) {
    ECHealthAuthorizationStatusUnable = -1,
    ECHealthAuthorizationStatusNotDetermined = 0,
    ECHealthAuthorizationStatusDenied,
    ECHealthAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckHealth : NSObject


/// 检查健康权限状态：仅检查权限，不主动请求权限
+ (ECHealthAuthorizationStatus)healthAuthorizationStatus;

/// 检查健康权限状态：仅检查权限，不主动请求权限
- (ECHealthAuthorizationStatus)healthAuthorizationStatus;

/// 请求健康权限
/// @param completionHandler completionHandler
+ (void)requestHealthsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求健康权限
/// @param completionHandler completionHandler
- (void)requestHealthsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;


@end

NS_ASSUME_NONNULL_END
