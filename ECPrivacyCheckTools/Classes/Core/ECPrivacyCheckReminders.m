//
//  ECPrivacyCheckReminders.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckReminders.h"

@implementation ECPrivacyCheckReminders

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECRemindersAuthorizationStatus)remindersAuthorizationStatus {
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (status == EKAuthorizationStatusNotDetermined) {
        return ECRemindersAuthorizationStatusNotDetermined;
    } else if (status == EKAuthorizationStatusRestricted) {
        return ECRemindersAuthorizationStatusRestricted;
    } else if (status == EKAuthorizationStatusDenied) {
        return ECRemindersAuthorizationStatusDenied;
    } else {
        return ECRemindersAuthorizationStatusAuthorized;
    }
}

- (ECRemindersAuthorizationStatus)remindersAuthorizationStatus {
    return [[self class] remindersAuthorizationStatus];
}

+ (void)requestRemindersAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECRemindersAuthorizationStatus status = [[self class] remindersAuthorizationStatus];
    
    if (status == ECRemindersAuthorizationStatusNotDetermined) {
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(granted);
                }
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECRemindersAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestRemindersAuthorizationWithCompletionHandler:(void (^)(BOOL))completionHandler {
    [[self class] requestRemindersAuthorizationWithCompletionHandler:completionHandler];
}

@end
