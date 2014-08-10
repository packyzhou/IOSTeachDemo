//
//  PKLayerView.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-23.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKLayerView.h"

@implementation PKLayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void) drawRect:(CGRect)rect
{
     NSLog(@"蓝色layer——x: %f, y: %f, width: %f,height: %f", self.layer.frame.origin.x, self.layer.frame.origin.y,  self.layer.frame.size.width, self.layer.frame.size.height);
   
    CAScrollLayer *parentLayer = [[CAScrollLayer alloc] init];
    parentLayer.backgroundColor = [[UIColor purpleColor] CGColor];
    parentLayer.frame = CGRectMake(rect.origin.x-320+100, rect.origin.y+100, 150, 150);
    parentLayer.masksToBounds = YES;
    
    
    CALayer *oneLayer = [[CALayer alloc] init];
    oneLayer.frame = CGRectMake(rect.origin.x, rect.origin.y, 100, 100);
    oneLayer.backgroundColor = [[UIColor blackColor] CGColor];
    [parentLayer addSublayer:oneLayer];
    
    CALayer *twoLayer = [[CALayer alloc] init];
    twoLayer.frame = CGRectMake(rect.origin.x+50, rect.origin.y+50, 120, 120);
    twoLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [parentLayer addSublayer:twoLayer];
    
    CALayer *threeLayer = [[CALayer alloc] init];
    threeLayer.frame = CGRectMake(rect.origin.x+100, rect.origin.y+100, 100, 100);
    threeLayer.backgroundColor = [[UIColor grayColor] CGColor];
    [parentLayer addSublayer:threeLayer];
   
    
    [self.layer addSublayer:parentLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
