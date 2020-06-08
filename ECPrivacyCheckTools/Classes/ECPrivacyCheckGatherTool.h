//
//  ECPrivacyCheckGatherTool.h
//  Pods
//
//  Created by EchoZuo on 2020/4/26.
//
//
///
/// 常用隐私权限检测集合工具，可以直接导入项目中使用。包含：定位服务、照片、相机、通讯录
/// 支持 iOS 8.0+
///
/// Common privacy permission check collection tools, include LocationServices,Photos,Camera,Contacts
/// Support iOS 8.0+


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>


/** 授权状态
 *  ECAuthorizationStatusUnable：不支持或不可用
 *  ECAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECAuthorizationStatusDenied：用户拒绝
 *  ECAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECAuthorizationStatus) {
    ECAuthorizationStatusUnable = -1,
    ECAuthorizationStatusNotDetermined = 0,
    ECAuthorizationStatusRestricted,
    ECAuthorizationStatusDenied,
    ECAuthorizationStatusAuthorized
};

/** 定位授权状态
 *
 *  ECLBSAuthorizationStatusUnable：不支持或不可用
 *  ECLBSAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECLBSAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECLBSAuthorizationStatusDenied：用户拒绝
 *  ECLBSAuthorizationStatusAuthorizedAlways：一直允许获取定位
 *  ECLBSAuthorizationStatusAuthorizedWhenInUse：在使用时允许定位
 *  ECLBSAuthorizationStatusAuthorized：已废弃，在iOS2.0~8.0使用，> iOS 8.0 请使用 ECLBSAuthorizationStatusAuthorizedAlways： 一直允许获取定位
*/
typedef NS_ENUM(NSInteger, ECLBSAuthorizationStatus) {
    ECLBSAuthorizationStatusUnable = -1,
    ECLBSAuthorizationStatusNotDetermined = 0,
    ECLBSAuthorizationStatusRestricted,
    ECLBSAuthorizationStatusDenied,
    ECLBSAuthorizationStatusAuthorizedAlways,
    ECLBSAuthorizationStatusAuthorizedWhenInUse,
    ECLBSAuthorizationStatusAuthorized API_DEPRECATED("Use ECLBSAuthorizationStatusAuthorizedAlways", ios(2.0, 8.0)) = ECLBSAuthorizationStatusAuthorizedAlways
};



NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckGatherTool : NSObject

// MARK: - 定位服务 LocationServices

/// 检查定位权限状态：仅检查权限，不主动请求权限
+ (ECLBSAuthorizationStatus)locationAuthorizationStatus;

/// 检查定位权限状态：仅检查权限，不主动请求权限
- (ECLBSAuthorizationStatus)locationAuthorizationStatus;

/// 请求定位权限
/// @param completionHandler completionHandler
- (void)requestLocationAuthorizationWithCompletionHandler:(void(^)(ECLBSAuthorizationStatus status))completionHandler;


// MARK: - 照片 Photos

/// 检查相册权限状态：仅检查权限，不主动请求权限
+ (ECAuthorizationStatus)photosAuthorizationStatus;

/// 检查相册权限状态：仅检查权限，不主动请求权限
- (ECAuthorizationStatus)photosAuthorizationStatus;

/// 请求相册权限
/// @param completionHandler completionHandler
+ (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求相册权限
/// @param completionHandler completionHandler
- (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;


// MARK: - 相机 Camera

/// 检查相机权限状态：仅检查权限，不主动请求权限
+ (ECAuthorizationStatus)cameraAuthorizationStatus;

/// 检查相机权限状态：仅检查权限，不主动请求权限
- (ECAuthorizationStatus)cameraAuthorizationStatus;

/// 请求相机权限
/// @param completionHandler completionHandler
+ (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求相机权限
/// @param completionHandler completionHandler
- (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;


// MARK: - 通讯录 Contacts

/// 检查通讯录权限状态：仅检查权限，不主动请求权限
+ (ECAuthorizationStatus)contactsAuthorizationStatus;

/// 检查通讯录权限状态：仅检查权限，不主动请求权限
- (ECAuthorizationStatus)contactsAuthorizationStatus;

/// 请求通讯录权限
/// @param completionHandler completionHandler
+ (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求通讯录权限
/// @param completionHandler completionHandler
- (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
