//
//  PKAnimationViewController.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-26.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKAnimationViewController.h"

//弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@interface PKAnimationViewController ()
{
    CAShapeLayer *rootLayer;
    CAShapeLayer *xLayer;
}
@end

@implementation PKAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    //动画开始按钮
    [_startButton addTarget:self action:@selector(startAnimationForLayer:) forControlEvents:UIControlEventTouchUpInside];
    //动画结束按钮
    [_endButton addTarget:self action:@selector(endAnimationForLayer:) forControlEvents:UIControlEventTouchUpInside];
    //重设按钮
    [_resetButton addTarget:self action:@selector(resetAnimationForLayer:) forControlEvents:UIControlEventTouchUpInside];
    
    //新增一个圆球
    rootLayer = [[CAShapeLayer alloc] init];
    rootLayer.frame = CGRectMake(0, 0, 50, 50);
    rootLayer.backgroundColor = [[UIColor clearColor]CGColor];
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect revoRect = CGRectMake(rootLayer.bounds.origin.x+2.5, rootLayer.bounds.origin.y+2.5, rootLayer.bounds.size.width-5, rootLayer.bounds.size.height-5);
    CGPathAddEllipseInRect(path, NULL, revoRect);
    rootLayer.path = path;
    rootLayer.fillColor = [[UIColor clearColor] CGColor];
    rootLayer.strokeColor = [[UIColor redColor] CGColor];
    rootLayer.position = CGPointMake(60, 200);
    
    
    xLayer = [[CAShapeLayer alloc] init];
    xLayer.frame = rootLayer.bounds;
    xLayer.backgroundColor = [[UIColor clearColor] CGColor];
    UIBezierPath *xPath = [UIBezierPath bezierPath];
    
    [xPath moveToPoint:CGPointMake(xLayer.bounds.origin.x+15, xLayer.bounds.origin.y+15)];
    [xPath addLineToPoint:CGPointMake(xLayer.bounds.origin.x+35, xLayer.bounds.origin.y+35)];
    
    [xPath moveToPoint:CGPointMake(xLayer.bounds.origin.x+35, xLayer.bounds.origin.y+15)];
    [xPath addLineToPoint:CGPointMake(xLayer.bounds.origin.x+15, xLayer.bounds.origin.y+35)];
    
    [xPath fill];
    xLayer.path = xPath.CGPath;
    xLayer.strokeColor = [[UIColor redColor] CGColor];
    [rootLayer addSublayer:xLayer];
    
    [self.view.layer addSublayer:rootLayer];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) startAnimationForLayer:(id)sender
{
    //CABaseAnimation
    [self basicAnimationTodo];
    //CAKeyframeAnimation
    [self keyframeAnimationTodo];
    //CATransition
//    [self transitionAnimatin];
}

-(void) transitionAnimatin
{
    CATransition *transition = [CATransition animation];
    [transition setDuration:2.0];
    [transition setFillMode:kCAFillModeForwards];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [transition setType:@"rippleEffect"];// rippleEffect
    
    [transition setSubtype:kCATransitionFromBottom];
    [rootLayer addAnimation:transition forKey:nil];
    
}

-(void) keyframeAnimationTodo
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置值
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(60, 200) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(80, 400) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(120, 300) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(150, 400) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(170, 320) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(190, 400) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(200, 350) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(205, 400) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(210, 375) ]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(215, 400) ]];
    
   
    keyframeAnimation.values = values;
    keyframeAnimation.calculationMode = kCAAnimationPaced;
    keyframeAnimation.duration = 5;
    keyframeAnimation.fillMode =  kCAFillModeForwards;
    keyframeAnimation.removedOnCompletion = NO ;
    [rootLayer addAnimation:keyframeAnimation forKey:@"keyframeAnimation"];
}

-(void) basicAnimationTodo
{
   
    //移动
    CABasicAnimation *moverAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moverAnimation.fromValue = [NSValue valueWithCGPoint:rootLayer.position ];
    CGPoint toPoint = CGPointMake(60, 400);
    moverAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    moverAnimation.duration = 1;
    moverAnimation.delegate = self;
    moverAnimation.removedOnCompletion = NO ;
    moverAnimation.fillMode = kCAFillModeForwards;
    
    
    //移动动画2一秒后播放
    CABasicAnimation *moverAnimation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    moverAnimation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(60, 400) ];
    CGPoint toPoint2 = CGPointMake(300, 400);
    moverAnimation2.toValue = [NSValue valueWithCGPoint:toPoint2];
    moverAnimation2.duration = 2;
    //    moverAnimation2.delegate = self;
    //    moverAnimation2.removedOnCompletion = NO ;
    //    moverAnimation2.fillMode = kCAFillModeForwards;
    moverAnimation2.beginTime = 1;
    
    
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2];
    
    scaleAnimation.duration = 1;
    //    scaleAnimation.delegate = self;
    scaleAnimation.removedOnCompletion = NO ;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    
    //旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(180)];
    
    rotateAnimation.duration = 2;
    rotateAnimation.beginTime = 1;
    //    rotateAnimation.delegate = self;
    //    rotateAnimation.removedOnCompletion = NO ;
    //    rotateAnimation.fillMode = kCAFillModeForwards;
    
    
    //建立动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    [group setAnimations:[NSArray arrayWithObjects:moverAnimation,moverAnimation2, scaleAnimation,rotateAnimation,nil]];
    group.duration = 2;
    group.fillMode =  kCAFillModeForwards;
    group.removedOnCompletion = NO ;
    group.delegate = self;
    [rootLayer addAnimation:group forKey:@"groupAnimation"];
}

-(void) animationDidStart:(CAAnimation *)anim
{
    NSLog(@"动画开始");
   
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    NSLog(@"动画[%@]结束",anim);
   
    
    [CATransaction setDisableActions:YES];
    rootLayer.position = CGPointMake(300, 400);
    
    NSLog(@"位置:%f,%f",rootLayer.position.x,rootLayer.position.y);
    
}



-(void) endAnimationForLayer:(id)sender
{
    
}

-(void) resetAnimationForLayer:(id)sender
{
    NSLog(@"重设");
    [CATransaction setDisableActions:YES];
    rootLayer.position = CGPointMake(60, 200);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
