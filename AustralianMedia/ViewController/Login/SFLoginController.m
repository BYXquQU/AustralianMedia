//
//  SFLoginController.m
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "SFLoginController.h"
#import "SFPerfectInfoController.h"

@interface SFLoginController ()

@end

@implementation SFLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    
    [self settingViewstyleWithView:_txtF_phoneNumber];
    [self settingViewstyleWithView:_txtF_code];
    [self settingViewstyleWithView:_btn_login];
    [self settingViewstyleWithView:_btn_getCode];
}

- (void)settingViewstyleWithView:(UIView *)view {
    
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:3.0];
    [view.layer setBorderWidth:0.5];
     [view.layer setBorderColor:[UIColor colorWithWhite:0.529 alpha:1.000].CGColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_txtF_code resignFirstResponder];
    [_txtF_phoneNumber resignFirstResponder];
}

/**
 *  登录按钮的点击事件
 */
- (IBAction)clickLoginButton:(id)sender {
    
    SFPerfectInfoController *perfectInfoVC = [[SFPerfectInfoController alloc]init];
    perfectInfoVC.title = @"完善信息";
    [self.navigationController pushViewController:perfectInfoVC animated:YES];
}

/**
 *  获取验证码的点击事件
 */
- (IBAction)clickGetCodeButton:(id)sender {
}
@end
