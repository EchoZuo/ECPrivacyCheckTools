//
//  ECPrivacyCheckCalendars.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckCalendars.h"

@implementation ECPrivacyCheckCalendars

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECCalendarsAuthorizationStatus)calendarsAuthorizationStatus {
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (status == EKAuthorizationStatusNotDetermined) {
        return ECCalendarsAuthorizationStatusNotDetermined;
    } else if (status == EKAuthorizationStatusRestricted) {
        return ECCalendarsAuthorizationStatusRestricted;
    } else if (status == EKAuthorizationStatusDenied) {
        return ECCalendarsAuthorizationStatusDenied;
    } else {
        return ECCalendarsAuthorizationStatusAuthorized;
    }
}

- (ECCalendarsAuthorizationStatus)calendarsAuthorizationStatus {
    return [[self class] calendarsAuthorizationStatus];
}

+ (void)requestCalendarsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECCalendarsAuthorizationStatus status = [[self class] calendarsAuthorizationStatus];

    if (status == ECCalendarsAuthorizationStatusNotDetermined) {
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(granted);
                }
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECCalendarsAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestCalendarsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestCalendarsAuthorizationWithCompletionHandler:completionHandler];
}


@end
