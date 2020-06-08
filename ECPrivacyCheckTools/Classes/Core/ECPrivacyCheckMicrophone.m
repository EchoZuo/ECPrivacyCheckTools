//
//  ECPrivacyCheckMicrophone.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckMicrophone.h"

@implementation ECPrivacyCheckMicrophone

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECMicrophoneAuthorizationStatus)microphoneAuthorizationStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (status == AVAuthorizationStatusNotDetermined) {
        return ECMicrophoneAuthorizationStatusNotDetermined;
    } else if (status == AVAuthorizationStatusRestricted){
        return ECMicrophoneAuthorizationStatusRestricted;
    } else if (status == AVAuthorizationStatusDenied) {
        return ECMicrophoneAuthorizationStatusDenied;
    } else {
        return ECMicrophoneAuthorizationStatusAuthorized;
    }
}

- (ECMicrophoneAuthorizationStatus)microphoneAuthorizationStatus {
    return [[self class] microphoneAuthorizationStatus];
}

+ (void)requestMicrophoneAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECMicrophoneAuthorizationStatus status = [[self class] microphoneAuthorizationStatus];
    
    if (status == ECMicrophoneAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(granted);
                }
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECMicrophoneAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestMicrophoneAuthorizationWithCompletionHandler:(void (^)(BOOL))completionHandler {
    [[self class] requestMicrophoneAuthorizationWithCompletionHandler:completionHandler];
}

@end
