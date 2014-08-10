//
//  PKDrawRectTestButton.h
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-19.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    StartDraw,StopDraw,DrawIng,DrawEnd,ReDraw
} ButtonStatus;

@interface PKDrawRectTestButton : UIButton
@property ButtonStatus drawStatus;
@end
