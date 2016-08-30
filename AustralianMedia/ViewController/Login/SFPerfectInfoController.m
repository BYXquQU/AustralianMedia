//
//  SFPerfectInfoController.m
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "SFPerfectInfoController.h"
#import "SFMeViewController.h"

@interface SFPerfectInfoController ()

@end

@implementation SFPerfectInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    [self settingViewstyleWithView:_txtf_inputUserName];
    [self settingViewstyleWithView:_btn_completion];
}

- (void)settingViewstyleWithView:(UIView *)view {
    
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:3.0];
    [view.layer setBorderWidth:0.5];
    [view.layer setBorderColor:[UIColor colorWithWhite:0.529 alpha:1.000].CGColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_txtf_inputUserName resignFirstResponder];
   
}
/**
 *  点击头像上传
 */
- (IBAction)clicloadAvatarButton:(id)sender {
    
    
}

/**
 *  点击完成按钮
 */
- (IBAction)clickComletionButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
