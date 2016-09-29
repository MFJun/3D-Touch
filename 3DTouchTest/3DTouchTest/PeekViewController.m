//
//  PeekViewController.m
//  3DTouchTest
//
//  Created by MengFanJun on 16/9/27.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import "PeekViewController.h"
#import "PopViewController.h"

@interface PeekViewController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation PeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [self.view addSubview:self.contentLabel];
    self.contentLabel.center = self.view.center;
    self.contentLabel.text = self.contentStr;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    //生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 selected");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Action 2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Pop View" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        PopViewController *popViewController = [[PopViewController alloc] init];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:popViewController animated:YES completion:nil];

    }];
    
    //生成Action Group
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Preview Action Group" style:UIPreviewActionStyleDefault actions:@[action1, action2]];
    
    //生成Action Group
    return @[group1,action3];
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
