//
//  ECPrivacyCheckReminders.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 提醒事项

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>


/** 授权状态
 *
 *  ECRemindersAuthorizationStatusUnable：不支持或不可用
 *  ECRemindersAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECRemindersAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECRemindersAuthorizationStatusDenied：用户拒绝
 *  ECRemindersAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECRemindersAuthorizationStatus) {
    ECRemindersAuthorizationStatusUnable = -1,
    ECRemindersAuthorizationStatusNotDetermined = 0,
    ECRemindersAuthorizationStatusRestricted,
    ECRemindersAuthorizationStatusDenied,
    ECRemindersAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckReminders : NSObject

/// 检查日历权限状态：仅检查权限，不主动请求权限
+ (ECRemindersAuthorizationStatus)remindersAuthorizationStatus;

/// 检查日历权限状态：仅检查权限，不主动请求权限
- (ECRemindersAuthorizationStatus)remindersAuthorizationStatus;

/// 请求日历权限
/// @param completionHandler completionHandler
+ (void)requestRemindersAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求日历权限
/// @param completionHandler completionHandler
- (void)requestRemindersAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
