//
//  AppDelegate.h
//  ECAuthorizationToolsDemo
//
//  Created by EchoZuo on 2017/8/3.
//  Copyright © 2017年 Echo.Z. All rights reserved.
//

@import UIKit;
@import CoreData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

