//
//  ECPrivacyCheckHealth.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckHealth.h"

@implementation ECPrivacyCheckHealth

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECHealthAuthorizationStatus)healthAuthorizationStatus {
    if ([HKHealthStore isHealthDataAvailable]) {
        // 以心率 HKQuantityTypeIdentifierHeartRate 为例
        HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
        HKHealthStore *store = [[HKHealthStore alloc] init];
        HKAuthorizationStatus status = [store authorizationStatusForType:heartRateType];
        
        if (status == HKAuthorizationStatusNotDetermined) {
            return ECHealthAuthorizationStatusNotDetermined;
        } else if (status == HKAuthorizationStatusSharingDenied) {
            return ECHealthAuthorizationStatusDenied;
        } else {
            return ECHealthAuthorizationStatusAuthorized;
        }
    } else {
        return ECHealthAuthorizationStatusUnable;
    }
}

- (ECHealthAuthorizationStatus)healthAuthorizationStatus {
    return [[self class] healthAuthorizationStatus];
}

+ (void)requestHealthsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECHealthAuthorizationStatus status = [[self class] healthAuthorizationStatus];
    
    if (status == ECHealthAuthorizationStatusNotDetermined) {
        // 以心率 HKQuantityTypeIdentifierHeartRate 为例
        HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
        HKHealthStore *store = [[HKHealthStore alloc] init];
        NSSet *typeSet = [NSSet setWithObject:heartRateType];
        
        [store requestAuthorizationToShareTypes:typeSet readTypes:typeSet completion:^(BOOL success, NSError * _Nullable error) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(success);
                }
            }];
        }];
        
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECHealthAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestHealthsAuthorizationWithCompletionHandler:(void (^)(BOOL))completionHandler {
    [[self class] requestHealthsAuthorizationWithCompletionHandler:completionHandler];
}


@end
