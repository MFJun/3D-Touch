//
//  ViewController.m
//  3DTouchTest
//
//  Created by MengFanJun on 16/9/27.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import "ViewController.h"
#import "PeekViewController.h"
#import "PopViewController.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UILabel *peekLB;

@end

@implementation ViewController

- (UILabel *)peekLB
{
    if (!_peekLB) {
        UILabel *peekLB = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width-60, 200)];
        peekLB.userInteractionEnabled = YES;
        peekLB.text = @"Peek && Pop";
        peekLB.backgroundColor = [UIColor blackColor];
        peekLB.textColor = [UIColor whiteColor];
        peekLB.font = [UIFont systemFontOfSize:18];
        peekLB.textAlignment = NSTextAlignmentCenter;
        _peekLB = peekLB;
    }
    return _peekLB;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.peekLB];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //检测3D Touch
    [self check3DTouch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 检测3D Touch
- (void)check3DTouch {
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //在self下创建一个新的3D Touch预览功能
        [self registerForPreviewingWithDelegate:(id)self sourceView:_peekLB];
    }
}

#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //3D Touch防止重复加入
    if ([self.presentedViewController isKindOfClass:[PeekViewController class]]) {
        return nil;
    }else {
        //触发预览功能时返回peekViewController
        PeekViewController *peekViewController = [[PeekViewController alloc] init];
        return peekViewController;
    }
}

//深入点击后转入PHMPopViewController
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
//    PopViewController *popViewController = [[PopViewController alloc] init];
//    [self showDetailViewController:popViewController sender:self];
    //Push Navigation
    [self showViewController:viewControllerToCommit sender:self];
}

//用户有意修改了设备的3D Touch功能，重新检测
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self check3DTouch];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _peekLB.backgroundColor = [UIColor colorWithRed:0 green:0 blue:(touch.force / touch.maximumPossibleForce ) alpha:1];
}


@end
