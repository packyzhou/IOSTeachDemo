//
//  PKDrawRectTestButton.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-19.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKDrawRectTestButton.h"
//弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@implementation PKDrawRectTestButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
//    NSLog(@"红色view——x: %f, y: %f, width: %f,height: %f", rect.origin.x, rect.origin.y,  rect.size.width, rect.size.height);
    NSLog(@"红色layer——x: %f, y: %f, width: %f,height: %f", self.layer.frame.origin.x, self.layer.frame.origin.y,  self.layer.frame.size.width, self.layer.frame.size.height);
     CGContextRef context = UIGraphicsGetCurrentContext();//获取当前图形上下文对象
   
    if(self.drawStatus == ReDraw)
    {
        
        UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:7 ];
        [roundRect addClip];
        
        CGContextSetRGBFillColor(context, 0.0f/255.0f, 118.0f/255.0f, 255.0f/255.0f, 1);
        [roundRect fill];

        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"跳转";
    }
    
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
