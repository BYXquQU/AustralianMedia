//
//  OIMUserLocation.h
//  OIMMapKit
//
//  Created by yin cai on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIMAnnotation.h"

@class CLLocation;
@class CLHeading;

/*!
 @brief 定位信息类
 */
@interface OIMUserLocation : NSObject<OIMAnnotation>

/*!
 @brief 位置更新状态，如果正在更新位置信息，则该值为YES
 */
@property (readonly, nonatomic, getter = isUpdating) BOOL updating;

/*!
 @brief 位置信息，如果OIMMapView的showsUserLocation为NO，或者尚未定位成功，则该值为nil
 */
@property (readonly, nonatomic, retain) CLLocation *location;

/*!
 @brief heading信息
 */
@property (readonly, nonatomic, retain) CLHeading *heading;

/*!
 @brief 定位标注点要显示的标题信息
 */
@property (nonatomic, copy) NSString *title;

/*!
 @brief 定位标注点要显示的子标题信息.
 */
@property (nonatomic, copy) NSString *subtitle;

@end