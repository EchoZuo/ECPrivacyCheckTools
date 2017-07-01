//
//  AppDelegate.h
//  ECAuthorizationTools
//
//  Created by EchoZuo on 2017/6/20.
//  Copyright © 2017年 Echo.Z. All rights reserved.
//


@import UIKit;
@import CoreData;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

