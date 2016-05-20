//
//  BaseWebViewController.h
//  card
//
//  Created by Hale Chan on 5/21/15.
//  Copyright (c) 2015 Papaya Mobile Inc. All rights reserved.
//
#import <UIKit/UIKit.h>

/**
 *  基本的网页查看器
 */
@interface BaseWebViewController : UIViewController

/**
 *  入口URL，需要由BaseWebViewController的使用者提供
 */
@property (nonatomic) NSURL *startURL;

@end
