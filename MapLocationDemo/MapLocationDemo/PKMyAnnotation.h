//
//  PKMyAnnotation.h
//  MapLocationDemo
//
//  Created by 周经伟 on 14-8-13.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface PKMyAnnotation :NSObject<MKAnnotation,NSCoding>
@property(strong,nonatomic) NSString *street;//街道
@property(strong,nonatomic) NSString *city;//城市
@property(strong,nonatomic) NSString *state;//状态
@property(strong,nonatomic) NSString *zip;
@property(strong,nonatomic) NSString *country;
@property(nonatomic,readwrite) CLLocationCoordinate2D coordinate;//二维坐标

@end
