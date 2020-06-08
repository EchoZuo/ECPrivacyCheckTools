//
//  ECPrivacyCheckHomeKit.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// HomeKit 家庭
/**
 *  HomeKit家庭权限回调依赖于实际业务（HMHomeManagerDelegate协议回调中处理），回调中error类型可以参考HMError.h
 *  建议可以根据实际业务进行封装
 *  这里提供使用方法供参考
 */

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>


/// granted:bool
/// manager:HMHomeManager
typedef void(^ECHomeAccessCompletionHandler)(BOOL granted, HMHomeManager * _Nullable manager);


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckHomeKit : NSObject

/// 请求家庭权限
/// @param completionHandler completionHandler
+ (void)requestHomeAccessWithCompletionHandler:(ECHomeAccessCompletionHandler)completionHandler;

/// 请求家庭权限
/// @param completionHandler completionHandler
- (void)requestHomeAccessWithCompletionHandler:(ECHomeAccessCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
