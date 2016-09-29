//
//  PopViewController.m
//  3DTouchTest
//
//  Created by MengFanJun on 16/9/27.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()


@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:dismissBtn];
    dismissBtn.frame = CGRectMake(20, 20, 100, 30);
    dismissBtn.center = self.view.center;
    dismissBtn.backgroundColor = [UIColor redColor];
    [dismissBtn setTitle:@"点击返回" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)dismissBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
