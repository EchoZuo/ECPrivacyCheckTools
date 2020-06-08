//
//  ECPrivacyCheckPhotos.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckPhotos.h"

@implementation ECPrivacyCheckPhotos

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECPhotosAuthorizationStatus)photosAuthorizationStatus {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            return ECPhotosAuthorizationStatusNotDetermined;
        } else if (status == PHAuthorizationStatusRestricted) {
            return ECPhotosAuthorizationStatusRestricted;
        } else if (status == PHAuthorizationStatusDenied) {
            return ECPhotosAuthorizationStatusDenied;
        } else {
            return ECPhotosAuthorizationStatusAuthorized;
        }
    } else {
        return ECPhotosAuthorizationStatusUnable;
    }
}

- (ECPhotosAuthorizationStatus)photosAuthorizationStatus {
    return [[self class] photosAuthorizationStatus];
}

+ (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECPhotosAuthorizationStatus status = [[self class] photosAuthorizationStatus];
    if (status == ECPhotosAuthorizationStatusNotDetermined) {
        
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
                completionHandler(status == ECPhotosAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestPhotosAuthorizationWithCompletionHandler:completionHandler];
}

@end
