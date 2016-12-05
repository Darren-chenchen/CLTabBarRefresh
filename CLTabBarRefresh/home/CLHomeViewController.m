//
//  CLHomeViewController.m
//  CLTabBarRefresh
//
//  Created by darren on 16/12/5.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLHomeViewController.h"
#import "MJRefresh.h"
#import "CLTabBarViewController.h"
#import "CLTabBarVIew.h"
#import "SettingViewController.h"
#import "CLPresent.h"

@interface CLHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**1.标记当前页*/
@property (nonatomic,assign) int index;
@end

@implementation CLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBtn)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 手动下拉时通知tabbar转动
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshBegin" object:nil];
        [self netRequest];
    }];
    
}

// 点击tabbar开始刷新
- (void)RotationIconBeginRotation
{
    [self.tableView.mj_header beginRefreshing];
}
// 模拟网络请求
- (void)netRequest
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        // 结束通知tabbar结束转动
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarEndRefreshing" object:@(self.index)];
    });
}
// 视图消失时移除通知，不然在下一个页面发送通知这个地方还是可以收到
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.tableView.mj_header endRefreshing];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RotationIconBeginRotation) name:@"RotationIconBeginRotation" object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clickLeftBtn
{
    SettingViewController *setVC = [[SettingViewController alloc] init];
    
    CLPresent *present = CLPresent.sharedCLPresent;
    setVC.transitioningDelegate = present;
    setVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:setVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cashCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
@end
