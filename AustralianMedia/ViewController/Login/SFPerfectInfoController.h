//
//  SFPerfectInfoController.h
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFPerfectInfoController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_loadAvatar;
@property (weak, nonatomic) IBOutlet UITextField *txtf_inputUserName;
@property (weak, nonatomic) IBOutlet UIButton *btn_completion;

- (IBAction)clicloadAvatarButton:(id)sender;
- (IBAction)clickComletionButton:(id)sender;
@end
