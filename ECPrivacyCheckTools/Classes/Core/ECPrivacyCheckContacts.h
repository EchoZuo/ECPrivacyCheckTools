//
//  ECPrivacyCheckContacts.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 通讯录

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>


/** 授权状态
 *  ECContactsAuthorizationStatusUnable：不支持或不可用
 *  ECContactsAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECContactsAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECContactsAuthorizationStatusDenied：用户拒绝
 *  ECContactsAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECContactsAuthorizationStatus) {
    ECContactsAuthorizationStatusUnable = -1,
    ECContactsAuthorizationStatusNotDetermined = 0,
    ECContactsAuthorizationStatusRestricted,
    ECContactsAuthorizationStatusDenied,
    ECContactsAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckContacts : NSObject

/// 检查通讯录权限状态：仅检查权限，不主动请求权限
+ (ECContactsAuthorizationStatus)contactsAuthorizationStatus;

/// 检查通讯录权限状态：仅检查权限，不主动请求权限
- (ECContactsAuthorizationStatus)contactsAuthorizationStatus;

/// 请求通讯录权限
/// @param completionHandler completionHandler
+ (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求通讯录权限
/// @param completionHandler completionHandler
- (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
