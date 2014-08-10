//
//  PKSubLayer.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-25.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKSubLayer.h"

@implementation PKSubLayer

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
     NSLog(@"黄色layer——x: %f, y: %f, width: %f,height: %f", self.layer.frame.origin.x, self.layer.frame.origin.y,  self.layer.frame.size.width, self.layer.frame.size.height);
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.strokeColor = [[UIColor yellowColor] CGColor];
    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, rect, 15, 15);
    shapeLayer.path = path;
    shapeLayer.position = CGPointMake(80, 80);
    
    [self.superview.layer setMask:shapeLayer];
    
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
