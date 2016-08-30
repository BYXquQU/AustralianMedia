//
//  SFUserInfoCell.m
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "SFUserInfoCell.h"

@implementation SFUserInfoCell


- (void)setUIWithModel:(SFTableHeaderModel *)model {
    
    _img_userAvator.layer.masksToBounds = YES;
    _img_userAvator.layer.cornerRadius = 25;
//    _img_userAvator.image = [UIImage imageNamed:model.avatar];
    
    _lbl_userName.text = model.userName;
    
    _lbl_userPhone.text = model.userPhone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
