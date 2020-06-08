//
//  ECPrivacyCheckPhotos.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 照片

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


/** 授权状态
 *  ECPhotosAuthorizationStatusUnable：不支持或不可用
 *  ECPhotosAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECPhotosAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECPhotosAuthorizationStatusDenied：用户拒绝
 *  ECPhotosAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECPhotosAuthorizationStatus) {
    ECPhotosAuthorizationStatusUnable = -1,
    ECPhotosAuthorizationStatusNotDetermined = 0,
    ECPhotosAuthorizationStatusRestricted,
    ECPhotosAuthorizationStatusDenied,
    ECPhotosAuthorizationStatusAuthorized
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckPhotos : NSObject

/// 检查相册权限状态：仅检查权限，不主动请求权限
+ (ECPhotosAuthorizationStatus)photosAuthorizationStatus;

/// 检查相册权限状态：仅检查权限，不主动请求权限
- (ECPhotosAuthorizationStatus)photosAuthorizationStatus;

/// 请求相册权限
/// @param completionHandler completionHandler
+ (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求相册权限
/// @param completionHandler completionHandler
- (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

@end

NS_ASSUME_NONNULL_END
