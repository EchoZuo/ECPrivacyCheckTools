//
//  ECPrivacyCheckMediaAndAppleMusic.m
//  ;
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckMediaAndAppleMusic.h"

@implementation ECPrivacyCheckMediaAndAppleMusic

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECMediaAndAppleMusicAuthorizationStatus)mediaAndAppleMusicAuthorizationStatus {
    if (@available(iOS 9.3, *)) {
        SKCloudServiceAuthorizationStatus status = [SKCloudServiceController authorizationStatus];
        
        if (status == SKCloudServiceAuthorizationStatusNotDetermined) {
            return ECMediaAndAppleMusicAuthorizationStatusNotDetermined;
        } else if (status == SKCloudServiceAuthorizationStatusRestricted) {
            return ECMediaAndAppleMusicAuthorizationStatusRestricted;
        } else if (status == SKCloudServiceAuthorizationStatusDenied) {
            return ECMediaAndAppleMusicAuthorizationStatusDenied;
        } else {
            return ECMediaAndAppleMusicAuthorizationStatusAuthorized;
        }
    } else {
        // Fallback on earlier versions
        // iOS 9.3 以下不支持
        return ECMediaAndAppleMusicAuthorizationStatusUnable;
    }
}

- (ECMediaAndAppleMusicAuthorizationStatus)mediaAndAppleMusicAuthorizationStatus {
    return [[self class] mediaAndAppleMusicAuthorizationStatus];
}

+ (void)requestMediaAndAppleMusicAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECMediaAndAppleMusicAuthorizationStatus status = [[self class] mediaAndAppleMusicAuthorizationStatus];

    if (status == ECMediaAndAppleMusicAuthorizationStatusNotDetermined) {
        
        if (@available(iOS 9.3, *)) {
            [SKCloudServiceController requestAuthorization:^(SKCloudServiceAuthorizationStatus status) {
                [self callbackOnMainQueue:^{
                    if (completionHandler) {
                        completionHandler(status == SKCloudServiceAuthorizationStatusAuthorized);
                    }
                }];
            }];
        } else {
            // Fallback on earlier versions
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(NO);
                }
            }];
        }
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECMediaAndAppleMusicAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestMediaAndAppleMusicAuthorizationWithCompletionHandler:(void (^)(BOOL))completionHandler {
    [[self class] requestMediaAndAppleMusicAuthorizationWithCompletionHandler:completionHandler];
}

@end
