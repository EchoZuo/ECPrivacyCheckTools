//
//  ECPrivacyCheckMotionAndFitness.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckMotionAndFitness.h"

@implementation ECPrivacyCheckMotionAndFitness

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECMotionAndFitnessAuthorizationStatus)motionAndFitnessAuthorizationStatus {
    if ([CMMotionActivityManager isActivityAvailable]) {
        CMAuthorizationStatus status = [CMMotionActivityManager authorizationStatus];
        if (status == CMAuthorizationStatusNotDetermined) {
            return ECMotionAndFitnessAuthorizationStatusNotDetermined;
        } else if (status == CMAuthorizationStatusRestricted) {
            return ECMotionAndFitnessAuthorizationStatusRestricted;
        } else if (status == CMAuthorizationStatusDenied) {
            return ECMotionAndFitnessAuthorizationStatusDenied;
        } else {
            return ECMotionAndFitnessAuthorizationStatusAuthorized;
        }
    } else {
        return ECMotionAndFitnessAuthorizationStatusUnable;
    }
}

- (ECMotionAndFitnessAuthorizationStatus)motionAndFitnessAuthorizationStatus {
    return [[self class] motionAndFitnessAuthorizationStatus];
}

+ (void)requestMotionAndFitnessAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    if (@available(iOS 11.0, *)) {
        ECMotionAndFitnessAuthorizationStatus status = [[self class] motionAndFitnessAuthorizationStatus];
        if (status == ECMotionAndFitnessAuthorizationStatusNotDetermined) {
            __block CMMotionActivityManager *cmManager = [[CMMotionActivityManager alloc] init];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [cmManager startActivityUpdatesToQueue:queue withHandler:^(CMMotionActivity * _Nullable activity) {
                [cmManager stopActivityUpdates];
                [self callbackOnMainQueue:^{
                    if (completionHandler) {
                        completionHandler(YES);
                    }
                }];
            }];
        } else {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(status == ECMotionAndFitnessAuthorizationStatusAuthorized);
                }
            }];
        }
    } else {
        // Fallback on earlier versions
        __block CMMotionActivityManager *cmManager = [[CMMotionActivityManager alloc] init];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [cmManager startActivityUpdatesToQueue:queue withHandler:^(CMMotionActivity * _Nullable activity) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(YES);
                }
            }];
        }];
    }
}

- (void)requestMotionAndFitnessAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestMotionAndFitnessAuthorizationWithCompletionHandler:completionHandler];
}



@end
