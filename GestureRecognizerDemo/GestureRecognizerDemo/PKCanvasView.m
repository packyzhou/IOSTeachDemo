//
//  PKCanvasView.m
//  GestureRecognizerDemo
//
//  Created by 周经伟 on 14-8-11.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKCanvasView.h"

@implementation PKCanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageView  = [[UIImageView alloc] init];
        imageView.frame = frame;
        [self addSubview: imageView];
    }
    return self;
}

-(void) oprationCanvas
{
    if (_oprationType == clearCanvas) {
        
        imageView.image = nil;
    }else if (_oprationType == saveCanvas) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"CanvasImage"]];
        [UIImagePNGRepresentation(imageView.image) writeToFile:filePath atomically:YES];
        UIImageWriteToSavedPhotosAlbum(imageView.image, self, nil, nil);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的画布保存成功！" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil,   nil];
        
        [alertView show];
    }
}



-(void) drawRect:(CGRect)rect
{
    NSLog(@"重绘类型:%i",_drawType);
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextRef context = UIGraphicsGetCurrentContext();//获取当前图形上下文对象
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);//设置线端点样式
    CGContextSetLineWidth(context, 5.0);
    
    switch (_drawType) {
        case beganTouch:
            
            break;
        case moveTouch:
            if (_oprationType == drawCanvas) {
                 CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
            }else if(_oprationType == reduceCanvas)
            {
                CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor]CGColor]);
            }
            CGContextMoveToPoint(context, _beganX, _beganY);
            CGContextAddLineToPoint(context, _lastX , _lastY);
            _beganX = _lastX;
            _beganY = _lastY;
            CGContextStrokePath(context);//填充路径
            break;
        case cancelTouch:
            
            break;
        case endTouch:
            
            break;
        default:
            break;
    }
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
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
