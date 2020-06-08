//
//  ECPrivacyCheckSpeechRecognition.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckSpeechRecognition.h"

@implementation ECPrivacyCheckSpeechRecognition

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (ECSpeechRecognizerAuthorizationStatus)speechRecognitionAuthorizationStatus {
    if (@available(iOS 10.0, *)) {
        SFSpeechRecognizerAuthorizationStatus status = [SFSpeechRecognizer authorizationStatus];
        
        if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            return ECSpeechRecognizerAuthorizationStatusNotDetermined;
        } else if (status == SFSpeechRecognizerAuthorizationStatusDenied){
            return ECSpeechRecognizerAuthorizationStatusDenied;
        } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
            return ECSpeechRecognizerAuthorizationStatusRestricted;
        } else {
            return ECSpeechRecognizerAuthorizationStatusAuthorized;
        }
        
    } else {
        // Fallback on earlier versions
        // iOS 10以下不支持
        return ECSpeechRecognizerAuthorizationStatusUnable;
    }
}

- (ECSpeechRecognizerAuthorizationStatus)speechRecognitionAuthorizationStatus {
    return [[self class] speechRecognitionAuthorizationStatus];
}

+ (void)requestSpeechRecognitionAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECSpeechRecognizerAuthorizationStatus status = [[self class] speechRecognitionAuthorizationStatus];
    
    if (status == ECSpeechRecognizerAuthorizationStatusNotDetermined) {
        
        if (@available(iOS 10.0, *)) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                [self callbackOnMainQueue:^{
                    if (completionHandler) {
                        completionHandler(status == SFSpeechRecognizerAuthorizationStatusAuthorized);
                    }
                }];
            }];
        } else {
            // Fallback on earlier versions
            [self callbackOnMainQueue:^{
                if (completionHandler) {
                    completionHandler(NO);
                }
            }];
        }
        
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) {
                completionHandler(status == ECSpeechRecognizerAuthorizationStatusAuthorized);
            }
        }];
    }
}

- (void)requestSpeechRecognitionAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [[self class] requestSpeechRecognitionAuthorizationWithCompletionHandler:completionHandler];
}


@end
