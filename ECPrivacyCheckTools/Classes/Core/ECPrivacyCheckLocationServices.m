//
//  ECPrivacyCheckLocationServices.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckLocationServices.h"

@interface ECPrivacyCheckLocationServices () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,copy) void (^kCLCallBackBlock)(CLAuthorizationStatus status);


@end

@implementation ECPrivacyCheckLocationServices

- (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECLocationAuthorizationStatus)locationAuthorizationStatus {
    if (![CLLocationManager locationServicesEnabled]) {
        return ECLocationAuthorizationStatusUnable;
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            return ECLocationAuthorizationStatusNotDetermined;
        }
            break;
        case kCLAuthorizationStatusRestricted: {
            return ECLocationAuthorizationStatusRestricted;
        }
            break;
        case kCLAuthorizationStatusDenied: {
            return ECLocationAuthorizationStatusDenied;
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways: {
            return ECLocationAuthorizationStatusAuthorizedAlways;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            return ECLocationAuthorizationStatusAuthorizedWhenInUse;
        }
        default:
            break;
    }
}

- (ECLocationAuthorizationStatus)locationAuthorizationStatus {
    return [[self class] locationAuthorizationStatus];
}

- (void)requestLocationAuthorizationWithCompletionHandler:(void (^)(ECLocationAuthorizationStatus))completionHandler {
    __block ECLocationAuthorizationStatus lbsStatus = [[self class] locationAuthorizationStatus];
    if (lbsStatus == ECLocationAuthorizationStatusNotDetermined) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        
        __weak typeof (self)weakSelf = self;
        [self setKCLCallBackBlock:^(CLAuthorizationStatus status) {
            [weakSelf callbackOnMainQueue:^{
                switch (status) {
                    case kCLAuthorizationStatusNotDetermined: {
                        lbsStatus = ECLocationAuthorizationStatusNotDetermined;
                    }
                        break;
                    case kCLAuthorizationStatusRestricted: {
                        lbsStatus = ECLocationAuthorizationStatusRestricted;
                    }
                        break;
                    case kCLAuthorizationStatusDenied: {
                        lbsStatus = ECLocationAuthorizationStatusDenied;
                    }
                        break;
                    case kCLAuthorizationStatusAuthorizedAlways: {
                        lbsStatus = ECLocationAuthorizationStatusAuthorizedAlways;
                    }
                        break;
                    case kCLAuthorizationStatusAuthorizedWhenInUse: {
                        lbsStatus = ECLocationAuthorizationStatusAuthorizedWhenInUse;
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

// MARK: - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (self.kCLCallBackBlock) {
        self.kCLCallBackBlock(status);
    }
}


@end
