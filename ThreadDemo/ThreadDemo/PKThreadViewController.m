//
//  PKThreadViewController.m
//  ThreadDemo
//
//  Created by 周经伟 on 14-7-31.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKThreadViewController.h"

@interface PKThreadViewController ()
{
    NSLock *entityLock;
}
@end

@implementation PKThreadViewController

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
    [super viewDidLoad];
    entityLock = [[NSLock alloc] init];
    //NSThread
    [_threadButton addTarget:self action:@selector(startNSThread) forControlEvents:UIControlEventTouchUpInside];
    //Operation
    [_operationButton addTarget:self action:@selector(operationThread) forControlEvents:UIControlEventTouchUpInside];
    //GCD
    [_gcdButton addTarget:self action:@selector(gcdThread) forControlEvents:UIControlEventTouchUpInside];
    
    [_threadRunloopButton addTarget:self action:@selector(threadRunloop) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

-(void) gcdThread
{
    
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //同步
    dispatch_sync(queue2, ^{
        [self thread1];
    });
    dispatch_sync(queue2, ^{
        [self thread2];
        
    });
}

-(void) operationThread
{
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(thread1) object:nil];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(thread2) object:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:1];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

-(void) startNSThread
{
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(thread1) object:nil];
    [thread1 start];
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(thread2) object:nil];
    [thread2 start];
}

-(void) thread1
{
//   [entityLock lock];
        for (int i = 1; i<=5; i++) {
            
            numbers--;
            NSLog(@"线程一剩余：%i",numbers);
            [NSThread sleepForTimeInterval:0.5];
           
        }
//    [entityLock unlock];
}

-(void) thread2
{
//    [entityLock lock];
    for (int i = 1; i<=5; i++) {
        
        numbers--;
        NSLog(@"线程二剩余：%i",numbers);
        [NSThread sleepForTimeInterval:0.5];
        
    }
//    [entityLock unlock];
}

-(void) threadRunloop
{
    
    NSLog(@"线程：%@->%@",[NSThread currentThread],[NSRunLoop currentRunLoop]);
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture] ];
     NSLog(@"线程结束,%@",[NSRunLoop currentRunLoop]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
