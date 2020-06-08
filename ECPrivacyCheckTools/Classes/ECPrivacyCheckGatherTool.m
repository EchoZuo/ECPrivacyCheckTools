//
//  ECPrivacyCheckGatherTool.m
//  Pods
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckGatherTool.h"

 
@interface ECPrivacyCheckGatherTool () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,copy) void (^kCLCallBackBlock)(CLAuthorizationStatus status);

@end

@implementation ECPrivacyCheckGatherTool

- (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}


// MARK: - 定位服务 LocationServices

+ (ECLBSAuthorizationStatus)locationAuthorizationStatus {
    if (![CLLocationManager locationServicesEnabled]) {
        return ECLBSAuthorizationStatusUnable;
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            return ECLBSAuthorizationStatusNotDetermined;
        }
            break;
        case kCLAuthorizationStatusRestricted: {
            return ECLBSAuthorizationStatusRestricted;
        }
            break;
        case kCLAuthorizationStatusDenied: {
            return ECLBSAuthorizationStatusDenied;
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways: {
            return ECLBSAuthorizationStatusAuthorizedAlways;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            return ECLBSAuthorizationStatusAuthorizedWhenInUse;
        }
        default:
            break;
    }
}

- (ECLBSAuthorizationStatus)locationAuthorizationStatus {
    return [[self class] locationAuthorizationStatus];
}

- (void)requestLocationAuthorizationWithCompletionHandler:(void(^)(ECLBSAuthorizationStatus status))completionHandler {
    __block ECLBSAuthorizationStatus lbsStatus = [[self class] locationAuthorizationStatus];
    if (lbsStatus == ECLBSAuthorizationStatusNotDetermined) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        
        __weak typeof (self)weakSelf = self;
        [self setKCLCallBackBlock:^(CLAuthorizationStatus status) {
            
            [weakSelf callbackOnMainQueue:^{

                switch (status) {
                    case kCLAuthorizationStatusNotDetermined: {
                        lbsStatus = ECLBSAuthorizationStatusNotDetermined;
                    }
                        break;
                    case kCLAuthorizationStatusRestricted: {
                        lbsStatus = ECLBSAuthorizationStatusRestricted;
                    }
                        break;
                    case kCLAuthorizationStatusDenied: {
                        lbsStatus = ECLBSAuthorizationStatusDenied;
                    }
                        break;
                    case kCLAuthorizationStatusAuthorizedAlways: {
                        lbsStatus = ECLBSAuthorizationStatusAuthorizedAlways;
                    }
                        break;
                    case kCLAuthorizationStatusAuthorizedWhenInUse: {
                        lbsStatus = ECLBSAuthorizationStatusAuthorizedWhenInUse;
                    }
                    default:
                        break;
                }
                
                if (completionHandler) {
                    completionHandler(lbsStatus);
                }
            }];
        }];
        
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(lbsStatus);
            }
        }];
    }
}

// CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSLog(@"%d", status);
    
    
    
    if (self.kCLCallBackBlock) {
        self.kCLCallBackBlock(status);
    }
}


// MARK: - 照片 Photos

+ (ECAuthorizationStatus)photosAuthorizationStatus {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            return ECAuthorizationStatusNotDetermined;
        } else if (status == PHAuthorizationStatusRestricted) {
            return ECAuthorizationStatusRestricted;
        } else if (status == PHAuthorizationStatusDenied) {
            return ECAuthorizationStatusDenied;
        } else {
            return ECAuthorizationStatusAuthorized;
        }
    } else {
        return ECAuthorizationStatusUnable;
    }
}

- (ECAuthorizationStatus)photosAuthorizationStatus {
    return [[self class] photosAuthorizationStatus];
}

+ (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECAuthorizationStatus status = [[self class] photosAuthorizationStatus];
    if (status == ECAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(status == PHAuthorizationStatusAuthorized);
                }
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestPhotosAuthorizationWithCompletionHandler:completionHandler];
}


// MARK: - 相机 Camera

+ (ECAuthorizationStatus)cameraAuthorizationStatus {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (status == AVAuthorizationStatusNotDetermined) {
            return ECAuthorizationStatusNotDetermined;
        } else if (status == AVAuthorizationStatusRestricted){
            return ECAuthorizationStatusRestricted;
        } else if (status == AVAuthorizationStatusDenied) {
            return ECAuthorizationStatusDenied;
        } else {
            return ECAuthorizationStatusAuthorized;
        }
        
    } else {
        return ECAuthorizationStatusUnable;
    }
}

- (ECAuthorizationStatus)cameraAuthorizationStatus {
    return [[self class] cameraAuthorizationStatus];
}
    

+ (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECAuthorizationStatus status = [[self class] cameraAuthorizationStatus];
    
    if (status == ECAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(granted);
                }
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECAuthorizationStatusAuthorized);
            }
        }];
    }
}
    
- (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestCameraAuthorizationWithCompletionHandler:completionHandler];
}


// MARK: - 通讯录 Contacts

+ (ECAuthorizationStatus)contactsAuthorizationStatus {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined: {
                return ECAuthorizationStatusNotDetermined;
            }
                break;
            case CNAuthorizationStatusRestricted: {
                return ECAuthorizationStatusRestricted;
            }
                break;
            case CNAuthorizationStatusDenied: {
                return ECAuthorizationStatusDenied;
            }
                break;
            case CNAuthorizationStatusAuthorized: {
                return ECAuthorizationStatusAuthorized;
            }
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined: {
                return ECAuthorizationStatusNotDetermined;
            }
                break;
            case kABAuthorizationStatusRestricted: {
                return ECAuthorizationStatusRestricted;
            }
                break;
            case kABAuthorizationStatusDenied: {
                return ECAuthorizationStatusDenied;
            }
                break;
            case kABAuthorizationStatusAuthorized: {
                return ECAuthorizationStatusAuthorized;
            }
            default:
                break;
        }
    }
}

- (ECAuthorizationStatus)contactsAuthorizationStatus {
    return [[self class] contactsAuthorizationStatus];
}

+ (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECAuthorizationStatus status = [[self class] contactsAuthorizationStatus];
    if (status == ECAuthorizationStatusNotDetermined) {
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
                completionHandler(status == ECAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestContactsAuthorizationWithCompletionHandler:completionHandler];
}

@end
