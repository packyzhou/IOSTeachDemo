//
//  PKRunLoopViewController.m
//  ThreadDemo
//
//  Created by 周经伟 on 14-7-29.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKRunLoopViewController.h"

@interface PKRunLoopViewController ()
{
    BOOL runLoopStatus;
    BOOL notRunLoopStatus;
}
@end

@implementation PKRunLoopViewController

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
    [_runLoopButton addTarget:self action:@selector(runLoopButtonTodo) forControlEvents:UIControlEventTouchUpInside];
    
    [_notRunLoopButton addTarget:self action:@selector(notRunLoopButtonTodo) forControlEvents:UIControlEventTouchUpInside];
    
    [_eventButton addTarget:self action:@selector(eventPrintln) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc ] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) nextPage:(id) sender
{
    PKDefinitionViewController *definitionViewController = [[PKDefinitionViewController alloc] initWithNibName:@"PKDefinitionViewController" bundle:nil];
    [self.navigationController pushViewController:definitionViewController animated:YES];
}

-(void) runLoopButtonTodo
{
    runLoopStatus = NO ;
    [NSThread detachNewThreadSelector:@selector(runLoopThread:) toTarget:self withObject:nil];
    while (!runLoopStatus) {
        NSLog(@"主线runLoop开始");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
         NSLog(@"主线runLoop结束");
    }
    
    NSLog(@"主线runLoop——下一个代码");
}

-(void) setOver
{
    
    runLoopStatus = YES;
}

-(void) notRunLoopButtonTodo
{
    notRunLoopStatus = NO;
    [NSThread detachNewThreadSelector:@selector(notRunLoopThread:) toTarget:self withObject:nil];
    while (!notRunLoopStatus) {
        NSLog(@"主线notRunLoop开始");
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"主线notRunLoop结束");
    }
    
}

-(void) runLoopThread:(id) sender
{
    for (int i = 0; i< 5; i++) {
        NSLog(@"使用runloop监听 ＝ %d.", i);
        [NSThread sleepForTimeInterval:1.0];
    }
    [self performSelectorOnMainThread:@selector(setOver) withObject:nil waitUntilDone:NO];
    runLoopStatus = YES;//停止句柄
}

-(void) notRunLoopThread:(id) sender
{
    for (int i = 0; i< 5; i++) {
        NSLog(@"没有使用runloop监听 ＝ %d.", i);
        sleep(1.0);
    }
    
    notRunLoopStatus = YES;//停止句柄
}

-(void) eventPrintln
{
    NSLog(@"打印日志……");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
