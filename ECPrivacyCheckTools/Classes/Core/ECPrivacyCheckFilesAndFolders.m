//
//  ECPrivacyCheckFilesAndFolders.m
//  Expecta
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckFilesAndFolders.h"

@implementation ECPrivacyCheckFilesAndFolders

- (void)test {
    
    /**
     拷贝模式：将文档拷贝到自己项目中
     在 Info.plist中，添加 “Document Types” 键值
     - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
     }
     
     存储模式：将文档存储到”文件“中
     //打开项目中的info.plist，添加 “Supports Document Browser” 键值
     UIDocumentPickerViewController * controller = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:[@""] inMode:UIDocumentPickerModeOpen];
     controller.delegate = self;
     [self presentViewController:controller animated:YES completion:nil];
     
     */
}

@end
