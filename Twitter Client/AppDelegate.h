//
//  AppDelegate.h
//  Twitter Client
//
//  Created by Cameron Barrie on 29/09/2014.
//  Copyright (c) 2014 Cameron Barrie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACAccountStore;
@class ACAccountType;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, atomic) UIImage *placeholderImage;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, readonly) ACAccountType *accountType;
@end

#define THEAPPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate
