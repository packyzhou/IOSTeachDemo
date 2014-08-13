//
//  PKDynameViewController.m
//  PhysicalEngineDemo
//
//  Created by 周经伟 on 14-8-12.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKDynameViewController.h"

@interface PKDynameViewController ()
{
    PKObjectView *objectView;
    PKObjectView *objectView1;
    PKObjectView *objectView2;
    PKObjectView *objectView3;
    PKObjectView *objectView4;
    UIDynamicAnimator *dynamicAnimator;//物理参考者
    
    UIGravityBehavior *gravityBehavior;//重力
    UICollisionBehavior *collisionBehavior;//碰撞
    UIPushBehavior *pushBehavior;//推力
    UISnapBehavior *snapBehavior;//吸附
    UIAttachmentBehavior *attachmentBehavior;//附着
    
}
@end

@implementation PKDynameViewController

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
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    CGPoint centerPoint = CGPointMake(self.view.center.x, self.view.center.y-150);
    
    objectView = [[PKObjectView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    objectView.backgroundColor = [UIColor redColor];
    objectView.center = centerPoint;
    [objectView addGestureRecognizer:[[UIPanGestureRecognizer  alloc] initWithTarget:self action:@selector(panDistance:)]];
    
    objectView1 = [[PKObjectView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    objectView1.backgroundColor = [UIColor greenColor];
    objectView1.center = self.view.center;
    [objectView1 addGestureRecognizer:[[UIPanGestureRecognizer  alloc] initWithTarget:self action:@selector(attachPanDistance:)]];
    
    objectView2 = [[PKObjectView alloc] initWithFrame:CGRectMake(0, 0, 40, 80)];
    objectView2.backgroundColor = [UIColor blackColor];
    objectView2.center = centerPoint;
    
    objectView3 = [[PKObjectView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    objectView3.backgroundColor = [UIColor blueColor];
    objectView3.center = centerPoint;
    
    objectView4 = [[PKObjectView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    objectView4.backgroundColor = [UIColor yellowColor];
    objectView4.center = centerPoint;
    
    [_gravityButton addTarget:self action:@selector(gravityBehaviorTodo) forControlEvents:UIControlEventTouchUpInside];
    [_collisionButton addTarget:self action:@selector(collisionBehaviorTodo) forControlEvents:UIControlEventTouchUpInside];
    [_pushButton addTarget:self action:@selector(pushBehaviorTodo) forControlEvents:UIControlEventTouchUpInside];
    [_snapButton addTarget:self action:@selector(snapBehaviorTodo) forControlEvents:UIControlEventTouchUpInside];
    [_attachmentButton addTarget:self action:@selector(attachmentBehaviorTodo) forControlEvents:UIControlEventTouchUpInside];
    [_resetButton addTarget:self action:@selector(resetTodo) forControlEvents:UIControlEventTouchUpInside];
    
    [objectView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:objectView];
    [self.view addSubview:objectView1];
    [self.view addSubview:objectView2];
    [self.view addSubview:objectView3];
    [self.view addSubview:objectView4];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}

-(void) resetTodo
{
    NSLog(@"重设");
    [dynamicAnimator removeAllBehaviors];
}

-(void) attachmentBehaviorTodo
{
    NSLog(@"附着");
    
    attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:objectView attachedToAnchor:objectView1.center];
    
    [dynamicAnimator addBehavior:attachmentBehavior];
}

-(void) snapBehaviorTodo
{
    snapBehavior = [[UISnapBehavior alloc] initWithItem:objectView snapToPoint:self.view.center];
    [dynamicAnimator addBehavior:snapBehavior];
}

-(void) pushBehaviorTodo
{
    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[objectView] mode:UIPushBehaviorModeContinuous];
    
    
    CGPoint offset = CGPointMake(CGRectGetMaxX(objectView.frame)-160, CGRectGetMaxY(objectView.frame)-568);
    CGFloat angle = atan2f(offset.y, offset.x);
    CGFloat distance = sqrtf(powf(offset.x, 2.0) + powf(offset.y, 2.0));
    NSLog(@"推力：%f,%f",distance,angle);
    
    pushBehavior.magnitude = distance;
    pushBehavior.angle = angle;
    pushBehavior.active = YES;
    [dynamicAnimator addBehavior:pushBehavior];
}

-(void) attachPanDistance:(UIPanGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self resetTodo];
        [self collisionBehaviorTodo];
        [self gravityBehaviorTodo];
    }
    CGPoint viewMovePoint = [sender translationInView:objectView1];
    
    CGPoint overPoint = CGPointMake(objectView1.center.x+viewMovePoint.x, objectView1.center.y+viewMovePoint.y);
    
    objectView1.center = overPoint;
    [sender setTranslation:CGPointZero inView:objectView1];
    if ( sender.state == UIGestureRecognizerStateChanged) {
        
        [attachmentBehavior setAnchorPoint:[sender locationInView:self.view]];
        
    }
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self collisionBehaviorTodo];
        [self gravityBehaviorTodo];
        [self attachmentBehaviorTodo];
    }
}

-(void) panDistance:(UIPanGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self resetTodo];
    }
   
        CGPoint viewMovePoint = [sender translationInView:objectView];
        
        CGPoint overPoint = CGPointMake(objectView.center.x+viewMovePoint.x, objectView.center.y+viewMovePoint.y);
        
        objectView.center = overPoint;
        [sender setTranslation:CGPointZero inView:objectView];
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self collisionBehaviorTodo];
        [self gravityBehaviorTodo];
        
    }
}

-(void) gravityBehaviorTodo
{
   gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[objectView,objectView1,objectView2,objectView3,objectView4]];
//     gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[objectView]];
    
    [dynamicAnimator addBehavior:gravityBehavior];
}

-(void) collisionBehaviorTodo
{
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[objectView,objectView1,objectView2,objectView3,objectView4]];
//    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[objectView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [dynamicAnimator addBehavior:collisionBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
