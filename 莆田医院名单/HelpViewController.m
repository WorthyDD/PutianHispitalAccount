//
//  HelpViewController.m
//  莆田医院名单
//
//  Created by 武淅 段 on 16/5/20.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "HelpViewController.h"
#import "BaseWebViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTapURL:(id)sender {
    
    BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
    [webVC setStartURL:[NSURL URLWithString:@"http://www.173key.net"]];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
