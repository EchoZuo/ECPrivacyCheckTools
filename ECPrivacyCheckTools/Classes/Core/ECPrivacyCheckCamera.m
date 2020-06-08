//
//  ECPrivacyCheckCamera.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckCamera.h"

@implementation ECPrivacyCheckCamera

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECCameraAuthorizationStatus)cameraAuthorizationStatus {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (status == AVAuthorizationStatusNotDetermined) {
            return ECCameraAuthorizationStatusNotDetermined;
        } else if (status == AVAuthorizationStatusRestricted){
            return ECCameraAuthorizationStatusRestricted;
        } else if (status == AVAuthorizationStatusDenied) {
            return ECCameraAuthorizationStatusDenied;
        } else {
            return ECCameraAuthorizationStatusAuthorized;
        }
        
    } else {
        return ECCameraAuthorizationStatusUnable;
    }
}

- (ECCameraAuthorizationStatus)cameraAuthorizationStatus {
    return [[self class] cameraAuthorizationStatus];
}
    

+ (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECCameraAuthorizationStatus status = [[self class] cameraAuthorizationStatus];
    
    if (status == ECCameraAuthorizationStatusNotDetermined) {
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
                completionHandler(status == ECCameraAuthorizationStatusAuthorized);
            }
        }];
    }
}
    
- (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestCameraAuthorizationWithCompletionHandler:completionHandler];
}
    
@end
