//
//  ECPrivacyCheckBluetooth.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckBluetooth.h"

@interface ECPrivacyCheckBluetooth () <CBCentralManagerDelegate>
{
    dispatch_queue_t _bluetoothQueue;
}

@property (nonatomic,copy) void (^completionHandler)(ECCBAuthorizationState state);

@end

@implementation ECPrivacyCheckBluetooth

- (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)requestBluetoothAuthorizationWithCompletionHandler:(void(^)(ECCBAuthorizationState state))completionHandler {
    self.completionHandler = completionHandler;
    // CBCentralManagerOptionShowPowerAlertKey：提示蓝牙开关未打开时会弹出警告框
    // CBCentralManagerOptionRestoreIdentifierKey：一个指定中央管理器的uid（和蓝牙程序进入后台有关)
    _bluetoothQueue = dispatch_queue_create("ECPrivacyCheckBluetooth Queue", DISPATCH_QUEUE_SERIAL);
    self.cbcManager = [[CBCentralManager alloc] initWithDelegate:self queue:_bluetoothQueue options:@{CBCentralManagerOptionShowPowerAlertKey:@true}];
}

// MARK: - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    [self callbackOnMainQueue:^{
        if (self.completionHandler) {
            if (@available(iOS 10.0, *)) {
                if (central.state == CBManagerStateResetting) {
                    self.completionHandler(ECCBAuthorizationStateResetting);
                    
                } else if (central.state == CBManagerStateUnsupported) {
                    self.completionHandler(ECCBAuthorizationStateUnsupported);
                    
                } else if (central.state == CBManagerStateUnauthorized) {
                    self.completionHandler(ECCBAuthorizationStateUnsupported);
                    
                } else if (central.state == CBManagerStatePoweredOff) {
                    self.completionHandler(ECCBAuthorizationStatePoweredOff);
                    
                } else if (central.state == CBManagerStatePoweredOn) {
                    self.completionHandler(ECCBAuthorizationStatePoweredOn);
                    
                } else {
                    // CBManagerStateUnknown
                    self.completionHandler(ECCBAuthorizationStateUnknown);
                }
            } else {
                // Fallback on earlier versions
                if (central.state == CBCentralManagerStateUnknown) {
                    self.completionHandler(ECCBAuthorizationStateResetting);
                    
                } else if (central.state == CBCentralManagerStateUnsupported) {
                    self.completionHandler(ECCBAuthorizationStateUnsupported);
                    
                } else if (central.state == CBCentralManagerStateUnauthorized) {
                    self.completionHandler(ECCBAuthorizationStateUnsupported);
                    
                } else if (central.state == CBCentralManagerStatePoweredOff) {
                    self.completionHandler(ECCBAuthorizationStatePoweredOff);
                    
                } else if (central.state == CBCentralManagerStatePoweredOn) {
                    self.completionHandler(ECCBAuthorizationStatePoweredOn);
                    
                } else {
                    // CBCentralManagerStateUnknown
                    self.completionHandler(ECCBAuthorizationStateUnknown);
                }
            }
        }
    }];
}

@end
