//
//  ECAlert.h
//  ECPrivacyCheckTools_Example
//
//  Created by EchoZuo on 2020/5/27.
//  Copyright © 2020 EchoZuo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ECAlert : NSObject

/**
 显示Alert

 @param title 标题
 @param message 信息
 @param completion 回调
 @param cancelButtonTitle 取消按钮文字
 @param otherButtonTitleArray 其他按钮文字数组
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
           completion:(void(^)(NSInteger buttonIndex))completion
    cancelButtonTitle:(NSString *)cancelButtonTitle
otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

/**
 显示Alert

 @param title 标题
 @param message 信息
 @param completion 回调
 @param cancelButtonTitle 取消按钮文字
 @param otherButtonTitles 其他按钮文字
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
           completion:(void(^)(NSInteger buttonIndex))completion
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 显示Alert，按钮：取消、确定

 @param message 信息
 @param completion 回调
 */
+ (void)showWithMessage:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion;

/**
 显示Alert，按钮：确定

 @param message 信息
 @param completion 回调
 */
+ (void)showConfirmAlertWithMessage:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion;

/**
 显示Alert，按钮：取消

 @param message 信息
 @param completion 回调
 */
+ (void)showCancelAlertWithMessage:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion;

@end

/**
 显示Alert

 @param title 标题
 @param message 信息
 @param buttonTitle 按钮文字
 @param completion 回调
 */
static inline void ECAlertShow(NSString *title, NSString *message, NSString *buttonTitle, void(^completion)(void)) {
    
    if (buttonTitle == nil) {
        buttonTitle = @"确定";
    }
    
    [ECAlert showWithTitle:title message:message completion:^(NSInteger buttonIndex) {
        
        if (completion) {
            completion();
        }
        
    } cancelButtonTitle:nil otherButtonTitles:buttonTitle, nil];
}


