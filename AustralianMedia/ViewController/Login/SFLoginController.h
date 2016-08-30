//
//  SFLoginController.h
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFLoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtF_phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtF_code;
@property (weak, nonatomic) IBOutlet UIButton *btn_getCode;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;

- (IBAction)clickLoginButton:(id)sender;

- (IBAction)clickGetCodeButton:(id)sender;
@end
