//
//  ECPrivacyCheckBluetooth.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 蓝牙
///
/// 注意：这里有一个注意点，CBCentralManager 的创建是异步的。如果初始化完成之前没有被当前创建它的类所持有
/// 就会在下一次RunLoop 迭代的时候释放。当然 CBCentralManager 实例如果不是在 ViewController 中创建的，
/// 那么持有 CBCentralManager 的这个类在初始化之后也必须被 ViewController 持有，否则控制台会有如下的错误输出：
/// [CoreBluetooth] XPC connection invalid
/// ECPrivacyCheckBluetooth 也要使用全局属性定义


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/** 蓝牙权限状态
 *
 *  ECCBAuthorizationStateUnknown：未知状态
 *  ECCBAuthorizationStateResetting：正在重置，与系统服务暂时丢失
 *  ECCBAuthorizationStateUnsupported：不支持蓝牙
 *  ECCBAuthorizationStateUnauthorized：未授权
 *  ECCBAuthorizationStatePoweredOff：关闭
 *  ECCBAuthorizationStatePoweredOn：开启并可用
 */
typedef NS_ENUM(NSInteger, ECCBAuthorizationState) {
    
    ECCBAuthorizationStateUnknown = 0,
    ECCBAuthorizationStateResetting,
    ECCBAuthorizationStateUnsupported,
    ECCBAuthorizationStateUnauthorized,
    ECCBAuthorizationStatePoweredOff,
    ECCBAuthorizationStatePoweredOn
};


NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckBluetooth : NSObject

/// 必须设置为全局属性，否则会报错
@property (nonatomic, strong) CBCentralManager *cbcManager;

/// 获取蓝牙权限
/// @param completionHandler completionHandler
- (void)requestBluetoothAuthorizationWithCompletionHandler:(void(^)(ECCBAuthorizationState state))completionHandler;

@end

NS_ASSUME_NONNULL_END


