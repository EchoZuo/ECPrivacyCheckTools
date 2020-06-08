//
//  ECPrivacyCheckCalendars.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 日历

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>


/** 授权状态
 *  ECCalendarsAuthorizationStatusUnable：不支持或不可用
 *  ECCalendarsAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECCalendarsAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECCalendarsAuthorizationStatusDenied：用户拒绝
 *  ECCalendarsAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECCalendarsAuthorizationStatus) {
    ECCalendarsAuthorizationStatusUnable = -1,
    ECCalendarsAuthorizationStatusNotDetermined = 0,
    ECCalendarsAuthorizationStatusRestricted,
    ECCalendarsAuthorizationStatusDenied,
    ECCalendarsAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckCalendars : NSObject

/// 检查日历权限状态：仅检查权限，不主动请求权限
+ (ECCalendarsAuthorizationStatus)calendarsAuthorizationStatus;

/// 检查日历权限状态：仅检查权限，不主动请求权限
- (ECCalendarsAuthorizationStatus)calendarsAuthorizationStatus;

/// 请求日历权限
/// @param completionHandler completionHandler
+ (void)requestCalendarsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求日历权限
/// @param completionHandler completionHandler
- (void)requestCalendarsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
