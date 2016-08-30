//
//  SFUserInfoCell.h
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFTableHeaderModel.h"
@interface SFUserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_userAvator;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userPhone;

- (void)setUIWithModel:(SFTableHeaderModel *)model;

@end
