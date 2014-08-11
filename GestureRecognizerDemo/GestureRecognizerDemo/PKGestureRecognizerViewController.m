//
//  PKGestureRecognizerViewController.m
//  GestureRecognizerDemo
//
//  Created by 周经伟 on 14-8-10.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKGestureRecognizerViewController.h"

@interface PKGestureRecognizerViewController ()
{
    UIView *view ;
    
    //手势
    UIGestureRecognizer *gestureRecognizer;
}
@end

@implementation PKGestureRecognizerViewController

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
    self.navigationItem.title = @"UIGestureRecognizer";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"画板" style:UIBarButtonItemStylePlain target:self action:@selector(drawBoard)];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0,0, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    view.center = CGPointMake(self.view.center.x, self.view.center.y);
    //添加点击手势
    gestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //添加双击手势
    UITapGestureRecognizer *doubleGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doubleTapHandle:)];
    doubleGestureRecognizer.numberOfTapsRequired = 2;
    
    [view addGestureRecognizer:doubleGestureRecognizer];

    [gestureRecognizer requireGestureRecognizerToFail:doubleGestureRecognizer];
    //添加缩放手势
    gestureRecognizer = [[UIPinchGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //添加旋转手势
    gestureRecognizer = [[UIRotationGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //添加滑动手势
    gestureRecognizer = [[UISwipeGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //添加拖移手势
    gestureRecognizer = [[UIPanGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //添加长按手势
    gestureRecognizer = [[UILongPressGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //添加屏幕边缘手势
    gestureRecognizer = [[UIScreenEdgePanGestureRecognizer  alloc] initWithTarget:self action:@selector(gesHandle:)];
    [view addGestureRecognizer:gestureRecognizer];
    
    [self.view addSubview:view];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//跳转下一页画板
-(void) drawBoard
{
    PKDrawBoadViewController *drawBoardController = [[PKDrawBoadViewController alloc] initWithNibName:@"PKDrawBoadViewController" bundle:nil];
    [self.navigationController pushViewController:drawBoardController animated:YES];
}

//双击
-(void) doubleTapHandle:(UIGestureRecognizer *) sender
{
    NSLog(@"双击");
    [self doubleTapScale];
}

//回调方法
-(void) gesHandle:(UIGestureRecognizer *) sender
{
    
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]&&[sender state] == UIGestureRecognizerStateEnded) {
        [self tapChangeColor];
        NSLog(@"点击");
    }else  if ([sender isKindOfClass:[UIPinchGestureRecognizer class]]) {
        NSLog(@"缩放");
        [self pinchScale:(UIPinchGestureRecognizer *)sender];
    }else  if ([sender isKindOfClass:[UIRotationGestureRecognizer class]]) {
        NSLog(@"旋转");
        [self ratationAngle:(UIRotationGestureRecognizer *) sender];
    }else  if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
        NSLog(@"滑动");
        [self swipeMode:(UISwipeGestureRecognizer * )sender];
    }else  if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        NSLog(@"拖动");
        [self panDistance:(UIPanGestureRecognizer *) sender];
    }else  if ([sender isKindOfClass:[UILongPressGestureRecognizer class]]&&[sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按");
        [self longPressShodow];
    }else  if ([sender isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]&&[sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"边缘点击");
    }
}

-(void) tapChangeColor
{
    view.backgroundColor = [UIColor randomColor];
}

-(void) doubleTapScale
{
    if(view.frame.size.width <= 100)
    {
        view.frame = CGRectMake(0,0
                                ,view.frame.size.width*2, view.frame.size.height*2);
        view.center = CGPointMake(self.view.center.x, self.view.center.y);
    }else{
        view.frame = CGRectMake(0,0
                                ,view.frame.size.width/2, view.frame.size.height/2);
        view.center = CGPointMake(self.view.center.x, self.view.center.y);
    }
    
}

-(void) pinchScale:(UIPinchGestureRecognizer *) sender
{
    NSLog(@"缩放比例:%f", [sender scale] );
    view.transform = CGAffineTransformScale([view transform], [sender scale], [sender scale]);
    sender.scale = 1.0;
}

-(void) ratationAngle:(UIRotationGestureRecognizer *) sender
{
    NSLog(@"旋转角度：%f", sender.rotation);
    view.transform = CGAffineTransformRotate([view transform], sender.rotation);
    sender.rotation = 0;
}

-(void) swipeMode:(UISwipeGestureRecognizer *) sender
{
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        NSLog(@"向左滑动");
        
        
    }else if(sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        NSLog(@"向右滑动");
        
        
    }else if(sender.direction == UISwipeGestureRecognizerDirectionUp)
    {
        NSLog(@"向上滑动");
        
        
    }else if(sender.direction == UISwipeGestureRecognizerDirectionDown)
    {
        NSLog(@"向下滑动");
        
    }

}

-(void) panDistance:(UIPanGestureRecognizer *) sender
{
    CGPoint viewMovePoint = [sender translationInView:view];
   
    CGPoint overPoint = CGPointMake(view.center.x+viewMovePoint.x, view.center.y+viewMovePoint.y);
    
    view.center = overPoint;
    [sender setTranslation:CGPointZero inView:view];
   
}

-(void) longPressShodow
{
    [view.layer setShadowOpacity:1.0];
    [view.layer setShadowOffset:CGSizeMake(3, 3)];
    [view.layer setCornerRadius:15];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
