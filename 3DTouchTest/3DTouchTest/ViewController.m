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

@interface ViewController ()<UIViewControllerPreviewingDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *informationArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"3D Touch";
    self.informationArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
//    [self.view addSubview:self.peekLB];
    [self creatSubViews];
    
}

- (void)creatSubViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma  mark ** tableView协议方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.informationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = self.informationArray[indexPath.row];
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"3D Touch  可用!");
        //给cell注册3DTouch的peek（预览）和pop功能
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    } else {
        NSLog(@"3D Touch 无效");
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

//点击cell跳转至详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    //3D Touch防止重复加入
    if ([self.presentedViewController isKindOfClass:[PeekViewController class]]) {
        return nil;
    }else {
        //触发预览功能时返回peekViewController
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
        PeekViewController *peekViewController = [[PeekViewController alloc] init];
        peekViewController.contentStr = [NSString stringWithFormat:@"第%@个cell，用力按一下进入页面",self.informationArray[indexPath.row]];
        return peekViewController;
    }
}

//深入点击后进入PeekViewController
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
//    PopViewController *popViewController = [[PopViewController alloc] init];
//    [self showDetailViewController:popViewController sender:self];
    [self showViewController:viewControllerToCommit sender:self];
}

//用户有意修改了设备的3D Touch功能，重新检测
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
