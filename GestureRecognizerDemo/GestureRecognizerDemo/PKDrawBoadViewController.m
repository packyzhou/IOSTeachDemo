//
//  PKDrawBoadViewController.m
//  GestureRecognizerDemo
//
//  Created by 周经伟 on 14-8-10.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKDrawBoadViewController.h"

@interface PKDrawBoadViewController ()
{
    PKCanvasView *canvasView;
    OprationType oprationType ;
}
@end

@implementation PKDrawBoadViewController

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
    self.navigationItem.title = @"画板";
    
    CGRect canvasRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    canvasView = [[PKCanvasView alloc] initWithFrame:canvasRect];
    canvasView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:canvasView];
     oprationType = drawCanvas;
    [_clearCanvasButton addTarget:self action:@selector(clearCanvasOpration) forControlEvents:UIControlEventTouchUpInside];
    [_saveCanvasButton addTarget:self action:@selector(saveCanvasOpration) forControlEvents:UIControlEventTouchUpInside];
    [_reduceCanvasButton addTarget:self action:@selector(reduceCanvasOpration) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) clearCanvasOpration{
    NSLog(@"清除");
    oprationType = drawCanvas;
    canvasView.oprationType = clearCanvas;
    [canvasView oprationCanvas];
}

-(void) saveCanvasOpration{
    canvasView.oprationType = saveCanvas;
    [canvasView oprationCanvas];
}

-(void) reduceCanvasOpration{
    oprationType = reduceCanvas;
    canvasView.oprationType = oprationType;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint localCoordinate = [[touches anyObject] locationInView:self.view];
//    NSLog(@"开始Touch:%f,%f",localCoordinate.x,localCoordinate.y);
    canvasView.drawType = beganTouch;
    canvasView.beganX = localCoordinate.x;
    canvasView.beganY = localCoordinate.y;
//    [canvasView setNeedsDisplay];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint localCoordinate = [[touches anyObject] locationInView:self.view];
//    NSLog(@"取消Touch:%f,%f",localCoordinate.x,localCoordinate.y);
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint localCoordinate = [[touches anyObject] locationInView:self.view];
//    NSLog(@"结束Touch:%f,%f",localCoordinate.x,localCoordinate.y);
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint localCoordinate = [[touches anyObject] locationInView:self.view];
//    NSLog(@"移动Touch::%f,%f",localCoordinate.x,localCoordinate.y);
    canvasView.drawType = moveTouch;
    canvasView.oprationType = oprationType;
    canvasView.lastX = localCoordinate.x;
    canvasView.lastY = localCoordinate.y;
    [canvasView setNeedsDisplay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
