//
//  ECAlert.m
//  ECPrivacyCheckTools_Example
//
//  Created by EchoZuo on 2020/5/27.
//  Copyright © 2020 EchoZuo. All rights reserved.
//

#import "ECAlert.h"

@implementation ECAlert

+ (void)showWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    int index = 0;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(index);
            }
        }];
        
        [alertController addAction:cancelAction];
        
        index ++;
    }
    
    for (int i = 0; i < otherButtonTitleArray.count; i ++) {
        NSString *string = otherButtonTitleArray[i];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:string style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(i + index);
            }
        }];
        [alertController addAction:otherAction];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}


+ (void)showWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args, NSString*)) {
        [array addObject:str];
    }
    va_end(args);
    
    [[self class] showWithTitle:title message:message completion:completion cancelButtonTitle:cancelButtonTitle otherButtonTitleArray:array];
}

//按钮：取消、确定
+ (void)showWithMessage:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion {
    [self showWithTitle:@"" message:message completion:completion cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

//按钮：确定
+ (void)showConfirmAlertWithMessage:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion {
    [self showWithTitle:@"" message:message completion:completion cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

//按钮：取消
+ (void)showCancelAlertWithMessage:(NSString *)message completion:(void(^)(NSInteger buttonIndex))completion {
    [self showWithTitle:@"" message:message completion:completion cancelButtonTitle:@"取消" otherButtonTitles:nil];
}

@end
