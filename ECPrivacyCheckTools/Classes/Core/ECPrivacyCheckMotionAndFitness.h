//
//  ECPrivacyCheckMotionAndFitness.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 运动与健身

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>


/** 授权状态
 *  ECMotionAndFitnessAuthorizationStatusUnable：不支持或不可用
 *  ECMotionAndFitnessAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECMotionAndFitnessAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECMotionAndFitnessAuthorizationStatusDenied：用户拒绝
 *  ECMotionAndFitnessAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECMotionAndFitnessAuthorizationStatus) {
    ECMotionAndFitnessAuthorizationStatusUnable = -1,
    ECMotionAndFitnessAuthorizationStatusNotDetermined = 0,
    ECMotionAndFitnessAuthorizationStatusRestricted,
    ECMotionAndFitnessAuthorizationStatusDenied,
    ECMotionAndFitnessAuthorizationStatusAuthorized
} API_AVAILABLE(ios(11.0), watchos(4.0));


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckMotionAndFitness : NSObject

/// 检查运动与健身权限状态：仅检查权限，不主动请求权限
+ (ECMotionAndFitnessAuthorizationStatus)motionAndFitnessAuthorizationStatus API_AVAILABLE(ios(11.0));

/// 检查运动与健身权限状态：仅检查权限，不主动请求权限
- (ECMotionAndFitnessAuthorizationStatus)motionAndFitnessAuthorizationStatus API_AVAILABLE(ios(11.0));

/// 请求运动与健身权限
/// @param completionHandler completionHandler
+ (void)requestMotionAndFitnessAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求运动与健身权限
/// @param completionHandler completionHandler
- (void)requestMotionAndFitnessAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;
@end

NS_ASSUME_NONNULL_END
