//
//  SFMeViewController.m
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "SFMeViewController.h"
#import "SFMyTrajectoryCell.h"

#import "SFTableHeaderModel.h"
#import "SFMyTrajectoryController.h"
#import "SFUserInfoCell.h"
#import "SFLoginController.h"

@interface SFMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SFTableHeaderModel *headerModel;
@end

@implementation SFMeViewController

- (SFTableHeaderModel *)headerModel {
    
    if (_headerModel == nil) {
        _headerModel = [[SFTableHeaderModel alloc]init];
        _headerModel.avatar = @"";
        _headerModel.userPhone = @"18710627862";
        _headerModel.userName = @"小白";
    }
    return _headerModel;
}

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

#pragma mark - 创建UI控件
- (void)setUI {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFUserInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SFUserInfoCell class])];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFMyTrajectoryCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SFMyTrajectoryCell class])];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            SFUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFUserInfoCell class])];
//            [cell setUIWithModel:_headerModel];
            cell.lbl_userName.text = @"小白";
            cell.lbl_userPhone.text = @"18710627862";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            
            break;
        case 1:
        {
            SFMyTrajectoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFMyTrajectoryCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
            
        default:
            return [[UITableViewCell alloc]init];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        //判断用户是否存在
        
        SFLoginController *loginVC = [[SFLoginController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.title = @"快速登录";
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        SFMyTrajectoryController *myTrajectoryVC = [[SFMyTrajectoryController alloc]init];
        myTrajectoryVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myTrajectoryVC animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 50;
    }

}

@end
