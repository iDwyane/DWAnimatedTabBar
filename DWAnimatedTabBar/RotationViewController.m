//
//  RotationViewController.m
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/24.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()

@end

@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextVC:(id)sender {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = @"test vc";
    [self.navigationController pushViewController:vc animated:YES];
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
