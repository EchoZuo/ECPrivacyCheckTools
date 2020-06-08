//
//  ECPrivacyCheckContacts.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckContacts.h"

@implementation ECPrivacyCheckContacts


+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECContactsAuthorizationStatus)contactsAuthorizationStatus {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined: {
                return ECContactsAuthorizationStatusNotDetermined;
            }
                break;
            case CNAuthorizationStatusRestricted: {
                return ECContactsAuthorizationStatusRestricted;
            }
                break;
            case CNAuthorizationStatusDenied: {
                return ECContactsAuthorizationStatusDenied;
            }
                break;
            case CNAuthorizationStatusAuthorized: {
                return ECContactsAuthorizationStatusAuthorized;
            }
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined: {
                return ECContactsAuthorizationStatusNotDetermined;
            }
                break;
            case kABAuthorizationStatusRestricted: {
                return ECContactsAuthorizationStatusRestricted;
            }
                break;
            case kABAuthorizationStatusDenied: {
                return ECContactsAuthorizationStatusDenied;
            }
                break;
            case kABAuthorizationStatusAuthorized: {
                return ECContactsAuthorizationStatusAuthorized;
            }
            default:
                break;
        }
    }
}

- (ECContactsAuthorizationStatus)contactsAuthorizationStatus {
    return [[self class] contactsAuthorizationStatus];
}

+ (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECContactsAuthorizationStatus status = [[self class] contactsAuthorizationStatus];
    if (status == ECContactsAuthorizationStatusNotDetermined) {
        if (@available(iOS 9.0, *)) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                [self callbackOnMainQueue:^{
                    if (completionHandler) {
                        completionHandler(granted);
                    }
                }];
            }];
        } else {
            // Fallback on earlier versions
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                [self callbackOnMainQueue:^{
                    if (completionHandler) {
                        completionHandler(granted);
                    }
                }];
            });
        }

    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECContactsAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestContactsAuthorizationWithCompletionHandler:completionHandler];
}


@end
