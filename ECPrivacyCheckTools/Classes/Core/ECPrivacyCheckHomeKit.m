//
//  ECPrivacyCheckHomeKit.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckHomeKit.h"


@interface ECPrivacyCheckHomeKit () <HMHomeManagerDelegate>

@property (nonatomic, strong) HMHomeManager *homeManager;

@property (nonatomic, copy) ECHomeAccessCompletionHandler completionHandler;


@end

@implementation ECPrivacyCheckHomeKit

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)requestHomeAccessWithCompletionHandler:(ECHomeAccessCompletionHandler)completionHandler {
    ECPrivacyCheckHomeKit *objc =[[ECPrivacyCheckHomeKit alloc] init];
    [objc requestHomeAccessWithCompletionHandler:completionHandler];
}

- (void)requestHomeAccessWithCompletionHandler:(ECHomeAccessCompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    
    HMHomeManager *homeManager = [[HMHomeManager alloc] init];
    homeManager.delegate = self;
}


// MARK: - HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager {
    
    if (self.completionHandler) {
        if (manager.homes.count > 0) {
            
            NSLog(@"a home exists, so we have access.");
            self.completionHandler(YES, manager);
        } else {
            __weak HMHomeManager *weakHomeManager = manager;
            [manager addHomeWithName:@"Test Home" completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"we have access for home.");
                    self.completionHandler(YES, weakHomeManager);
                } else {
                    // consult HMError.h
                    if (error.code == HMErrorCodeHomeAccessNotAuthorized) {
                        // user denied permission
                        NSLog(@"用户拒绝 ser denied permission");
                        self.completionHandler(NO, weakHomeManager);
                    } else {
                        NSLog(@"HOME_ERROR:%ld,%@",(long)error.code, error.localizedDescription);
                        self.completionHandler(YES, weakHomeManager);
                    }
                }
                
                if (home) {
                    [weakHomeManager removeHome:home completionHandler:^(NSError * _Nullable error) {
                        // do something with the result of removing the home...
                    }];
                }
            }];
        }
    } else {
        NSAssert(self.completionHandler == nil, @"please check completionHandler is not nil.");
    }
}


@end
