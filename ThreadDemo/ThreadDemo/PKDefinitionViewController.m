//
//  PKDefinitionViewController.m
//  ThreadDemo
//
//  Created by 周经伟 on 14-7-30.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKDefinitionViewController.h"

@interface PKDefinitionViewController ()
{
    
    CFRunLoopSourceRef source ;
    CFRunLoopRef runLoop;
}
@end

@implementation PKDefinitionViewController

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
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc ] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage:)];
    self.navigationItem.rightBarButtonItem = nextButton;

    
    [_definitionButton addTarget:self action:@selector(definitionTodo) forControlEvents:UIControlEventTouchUpInside];
    
    [_timerButton addTarget:self action:@selector(timerTodo) forControlEvents:UIControlEventTouchUpInside];
    
    [_addEventButton addTarget:self action:@selector(addEventRunLoop) forControlEvents:UIControlEventTouchUpInside];
    
    [_nsRunLoopButton addTarget:self action:@selector(nsRunLoopTodo) forControlEvents:UIControlEventTouchUpInside];
    _nsRunLoopButton.enabled = NO;
    
    [_portButton addTarget:self action:@selector(portTodo) forControlEvents:UIControlEventTouchUpInside];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) nextPage:(id) sender
{
    PKThreadViewController *threadViewController = [[PKThreadViewController alloc] initWithNibName:@"PKThreadViewController" bundle:nil];
    [self.navigationController pushViewController:threadViewController animated:YES];
}

-(void) definitionTodo
{
    runLoop = CFRunLoopGetCurrent();
    CFRunLoopSourceContext sourceContext  = {0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,runLoopTaskEnd};
    source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &sourceContext);
    CFRunLoopAddSource(runLoop,source,kCFRunLoopDefaultMode);
    BOOL runStatus = YES;
    

    while (runStatus) {
        NSLog(@"自定义runLoop开始");
        CFRunLoopRun();
        NSLog(@"自定义runLoop结束");
    }
    
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
    
}

-(void) addEventRunLoop
{
    NSLog(@"加入事件……");
    //自定义输入源
//    if (CFRunLoopIsWaiting(runLoop)) {
//        NSLog(@"RunLoop 正在等待事件输入");
//        //添加输入事件
//        CFRunLoopSourceSignal(source);
//        //唤醒线程，线程唤醒后发现由事件需要处理，于是立即处理事件
//        CFRunLoopWakeUp(runLoop);
//    }else {
//        NSLog(@"RunLoop 正在处理事件");
//        //添加输入事件，当前正在处理一个事件，当前事件处理完成后，立即处理当前新输入的事件
//        
//        CFRunLoopSourceSignal(source);
//    }
    //端口输入源
//    [self sendMessage];
    //定时源
    

}


void runLoopTaskEnd(void *info)
{
    NSLog(@"任务 %@",info);
}

-(void) timerTodo
{
    
}

-(void) nsRunLoopTodo
{
    
}

-(void) portTodo
{
    CFMessagePortRef port = CFMessagePortCreateLocal(kCFAllocatorDefault, CFSTR(RUNLOOP_MESSAGE_ID),callBackFunc, NULL, NULL);
    source =  CFMessagePortCreateRunLoopSource(kCFAllocatorDefault, port, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    BOOL runStatus = YES;
    
    
    while (runStatus) {
        NSLog(@"端口runLoop开始");
        CFRunLoopRun();
        NSLog(@"端口runLoop结束");
    }
    
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
}

CFDataRef callBackFunc(CFMessagePortRef local, SInt32 msgid, CFDataRef cfData, void *info)
{
    NSLog(@"回调");
    const UInt8  * recvedMsg = CFDataGetBytePtr(cfData);
    NSString *strData = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
    NSLog(@"msgid : %lu" ,msgid);
    NSLog(@"数据：%@",strData);
    
    //为了测试，生成返回数据
    NSString *returnString = [NSString stringWithFormat:@"我收到了:%@",strData];
    const char* cStr = [returnString UTF8String];
    NSUInteger ulen = [returnString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    CFDataRef sgReturn = CFDataCreate(NULL, (UInt8 *)cStr, ulen);
    
    return  sgReturn;
}

-(void) sendMessage
{
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(RUNLOOP_MESSAGE_ID));
    // 构建发送数据（string）
    NSString    *msg = [NSString stringWithFormat:@"啦啦啦德玛西亚"];
    NSLog(@"发送的信息是 :%@",msg);
    const char *message = [msg UTF8String];
    CFDataRef data,recvData = nil;
    data = CFDataCreate(NULL, (UInt8 *)message, strlen(message));
    
    // 执行发送操作
    CFMessagePortSendRequest(bRemote, CFSTR(RUNLOOP_MESSAGE_ID), data, 0, 100 , kCFRunLoopDefaultMode, &recvData);
    if (nil == recvData) {
        NSLog(@"recvData date is nil.");
        CFRelease(data);
        CFMessagePortInvalidate(bRemote);
        CFRelease(bRemote);
       
    }
    
    // 解析返回数据
    const UInt8  * recvedMsg = CFDataGetBytePtr(recvData);
    if (nil == recvedMsg) {
        NSLog(@"receive date err.");
        CFRelease(data);
        CFMessagePortInvalidate(bRemote);
        CFRelease(bRemote);
        
    }
    
    NSString    *strMsg = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
    NSLog(@"返回的数据是：%@",strMsg);
    
    CFRelease(data);
    CFMessagePortInvalidate(bRemote);
    CFRelease(bRemote);
    CFRelease(recvData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
