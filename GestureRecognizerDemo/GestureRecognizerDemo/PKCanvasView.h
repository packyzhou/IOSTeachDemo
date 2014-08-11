//
//  PKCanvasView.h
//  GestureRecognizerDemo
//
//  Created by 周经伟 on 14-8-11.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    beganTouch,
    cancelTouch,
    moveTouch,
    endTouch
} DrawType;

typedef enum{
    clearCanvas,
    saveCanvas,
    reduceCanvas,
    drawCanvas
} OprationType;
@interface PKCanvasView : UIView
{
    UIImageView *imageView;
}
-(void) oprationCanvas;
@property DrawType drawType;
@property OprationType oprationType;
@property CGFloat beganX;
@property CGFloat beganY;
@property CGFloat lastX;
@property CGFloat lastY;
@end
