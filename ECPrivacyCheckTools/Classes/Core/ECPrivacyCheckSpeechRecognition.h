//
//  ECPrivacyCheckSpeechRecognition.h
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//
/// 语音识别 >= iOS 10.0

#import <Foundation/Foundation.h>
#import <Speech/Speech.h>

/** 授权状态
 *  ECSpeechRecognizerAuthorizationStatusUnable：不支持或不可用
 *  ECSpeechRecognizerAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECSpeechRecognizerAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECSpeechRecognizerAuthorizationStatusDenied：用户拒绝
 *  ECSpeechRecognizerAuthorizationStatusAuthorized：已授权
 */
typedef NS_ENUM(NSInteger, ECSpeechRecognizerAuthorizationStatus) {
    ECSpeechRecognizerAuthorizationStatusUnable = -1,
    ECSpeechRecognizerAuthorizationStatusNotDetermined = 0,
    ECSpeechRecognizerAuthorizationStatusRestricted,
    ECSpeechRecognizerAuthorizationStatusDenied,
    ECSpeechRecognizerAuthorizationStatusAuthorized
};

NS_ASSUME_NONNULL_BEGIN

@interface ECPrivacyCheckSpeechRecognition : NSObject

/// 检查语音识别权限状态：仅检查权限，不主动请求权限
+ (ECSpeechRecognizerAuthorizationStatus)speechRecognitionAuthorizationStatus API_AVAILABLE(ios(10.0));

/// 检查语音识别权限状态：仅检查权限，不主动请求权限
- (ECSpeechRecognizerAuthorizationStatus)speechRecognitionAuthorizationStatus API_AVAILABLE(ios(10.0));

/// 请求语音识别权限
/// @param completionHandler completionHandler
+ (void)requestSpeechRecognitionAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler API_AVAILABLE(ios(10.0));

/// 请求语音识别权限
/// @param completionHandler completionHandler
- (void)requestSpeechRecognitionAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler API_AVAILABLE(ios(10.0));

@end

NS_ASSUME_NONNULL_END
