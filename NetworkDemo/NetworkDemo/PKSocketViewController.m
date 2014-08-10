//
//  PKSocketViewController.m
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-4.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKSocketViewController.h"

@interface PKSocketViewController ()
{
    NSOutputStream *outputStream;
    NSInputStream *inputStream;
}
@end

@implementation PKSocketViewController

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
    _nameText.text =[ NSString stringWithFormat:@"packy_%i", arc4random_uniform( 10+1)];
//    [self connectionSocket];
//    [[[NSThread alloc] initWithTarget:self selector:@selector(connectionSocket) object:nil] start];
    [_sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [_msgText addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"值改变了:%@",change);
}

-(void) connectionSocket
{
    NSString *ip = @SERVER_IP;
    SInt32 port = 9999;
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)(ip), port, &readStream, &writeStream);//创建一对输入输出流
    outputStream = (__bridge NSOutputStream *)writeStream;
    outputStream.delegate = self;
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream open];
    
    inputStream = (__bridge_transfer NSInputStream*)readStream;
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    
    [self login];
}

-(void) stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    
    NSLog(@"%@",aStream);
    switch (eventCode) {
        case NSStreamEventNone:{
            NSLog(@"没有事件");
            
            break;
        }
            
        case NSStreamEventOpenCompleted:{
            NSLog(@"流创建成功！");
            
            break;
        }
            
        case NSStreamEventHasBytesAvailable:{
            NSLog(@"有比特流可用！");
            
            [self readInputStream];
            break;
        }
            
        case NSStreamEventEndEncountered:{
            NSLog(@"结束连接！");
            [self releaseStream:aStream];
             break;
        }
            
        case NSStreamEventHasSpaceAvailable:{
            NSLog(@"输出流可用！");
            
            break;
        }
           
        case NSStreamEventErrorOccurred:{
            
            NSError *error = [aStream streamError];
            NSString *errorMsg = [error localizedDescription];
            NSLog(@"连接错误:%@",errorMsg);
            
            if ([errorMsg isEqualToString:@"The operation couldn’t be completed. Socket is not connected"]){
                [self connectionSocket];
            }else{
                [self releaseStream:aStream];
            }
            break;
        }
            
        default:
            break;
    }
}

-(void) login
{
   
        NSString *msg = [NSString stringWithFormat:@"{\"name\":\"%@\",\"type\":\"login\"}\n",_nameText.text ];
        
        uint8_t buffer[[msg length]];
        memcpy(buffer, [msg UTF8String], [msg length]+1);
        [outputStream write:buffer maxLength: strlen((const char*)buffer)+1];
   
}

-(void) sendMessage
{
    NSString *msg = [NSString stringWithFormat:@"{\"name\":\"%@\",\"msg\":\"%@\",\"type\":\"send\"}\n",_nameText.text,_msgText.text ];
    NSLog(@"send为：%@",msg);
    uint8_t buffer[[msg length]];
    memcpy(buffer, [msg UTF8String], [msg length]+1);
    [outputStream write:buffer maxLength: strlen((const char*)buffer)+1];
    
    _msgText.text = @"";
}

-(void) releaseStream:(NSStream *) stream
{
    [stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [stream close];
    stream = nil;
}

-(void) readInputStream
{
    NSMutableData *input = [[NSMutableData alloc] init];
    
    uint8_t buffer[1024];
    
    int len;
    
    while([inputStream hasBytesAvailable])
        
    {
        
        len = [inputStream read:buffer maxLength:sizeof(buffer)];
        
        if (len > 0)
            
        {
            
            [input appendBytes:buffer length:len];
            
        }
        
    }
    
    NSString *resultstring = [[NSString alloc] initWithData:input encoding:NSUTF8StringEncoding];
    
    NSLog(@"接收:%@",resultstring);
    
    
    _textView.text = [_textView.text  stringByAppendingFormat:@"%@\n" ,resultstring ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
