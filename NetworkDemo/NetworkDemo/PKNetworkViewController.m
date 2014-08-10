//
//  PKNetworkViewController.m
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-1.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKNetworkViewController.h"
#define BOUNDARY "PACKY"
@interface PKNetworkViewController ()
{
    NSMutableData *dataTmp;
    CFReadStreamRef readStream ;//输入流
    CFWriteStreamRef wirteStream ;//输出流
    NSOutputStream *oStream;
    
    
}

@end

@implementation PKNetworkViewController

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
    [_httpButton addTarget:self action:@selector(httpTodo) forControlEvents:UIControlEventTouchUpInside];
    [_tcpButton addTarget:self action:@selector(tcpTodo) forControlEvents:UIControlEventTouchUpInside];
    [_udpButton addTarget:self action:@selector(udpTodo) forControlEvents:UIControlEventTouchUpInside];
    [_uploadButton addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    [_thirdPartButton addTarget:self action:@selector(ASIHttpTodo) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_sendMsgButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [_bonjourButton addTarget:self action:@selector(bonjourService) forControlEvents:UIControlEventTouchUpInside];
    
    [_checkNetworkButton addTarget:self action:@selector(checkNetwork) forControlEvents:UIControlEventTouchUpInside];
    
    [_xmlRequestButton addTarget:self action:@selector(xmlRequest) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) xmlRequest
{
     NSString *urlStr = [NSString stringWithFormat:@"http://%s:%s/SSH/test!getTestMsg.do",SERVER_IP,SERVER_PORT ];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    xmlParser.delegate = self;
    [xmlParser parse];
}

//-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//    NSLog(@"xml响应：%@",string);
//}

//-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//    NSLog(@"xml开始句柄：%@->%@->%@",elementName,namespaceURI,qName);
//}



-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"xml开始句柄：%@->%@->%@",elementName,namespaceURI,qName);
    NSLog(@"xml字典：%@",attributeDict);
}

-(void) checkNetwork
{
    Reachability *reach = [Reachability reachabilityWithHostname:@"192.168.1.102"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"3G/GPRS网络");
            break;
    }
}

-(void) bonjourService
{
    PKBonjourViewController *bonjourController = [[PKBonjourViewController alloc] initWithNibName:@"PKBonjourViewController" bundle:nil];
    [self presentModalViewController:bonjourController animated:YES];
}

-(void) udpTodo
{
    NSLog(@"执行udp协议");
}

-(void) tcpThread
{
    NSString *ip = @SERVER_IP;
    SInt32 port = 9999;
    
    CFStreamClientContext ctx = {0, (__bridge void *)(self), NULL, NULL, NULL};//上下文
    
    CFOptionFlags registeredEvents = (kCFStreamEventHasBytesAvailable | kCFStreamEventEndEncountered | kCFStreamEventErrorOccurred);//注册事件模式
    
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)(ip), port, &readStream, &wirteStream);//创建一对输入输出流
    
    if (wirteStream!=NULL) {
        CFWriteStreamSetProperty(wirteStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);

    }
    oStream = (__bridge NSOutputStream *)wirteStream;
    oStream.delegate = self;
    [oStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
    forMode:NSDefaultRunLoopMode];
    [oStream open];
    
        //设置输入流客户端
    if(CFReadStreamSetClient(readStream, registeredEvents, readStreamCallback, &ctx))
    {
        CFReadStreamScheduleWithRunLoop(readStream,CFRunLoopGetCurrent(),kCFRunLoopCommonModes);//设置输入流RunLoop
    }else{
        NSLog(@"读设置失败");
    }
    //发起socket连接
    if (CFReadStreamOpen(readStream)) {
        NSLog(@"读发起请求成功！");
        CFRunLoopRun();
    }else{
        NSLog(@"读发起请求失败");
    }
    
}

-(void) sendMessage
{
    NSString *msg = @"some text \n";
    uint8_t buffer[[msg length]];
    memcpy(buffer, [msg UTF8String], [msg length]+1);
//    UInt8 buff[] = "Hello Server!\n";
    [oStream write:buffer maxLength: strlen((const char*)buffer)+1];
    
    //关闭输出流
    
//    [oStream close];
}

-(void) stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    
}

-(void) tcpTodo
{
    NSLog(@"执行tcp协议");
    PKSocketViewController *socketViewController = [[PKSocketViewController alloc] initWithNibName:@"PKSocketViewController" bundle:nil];
    [self presentModalViewController:socketViewController animated:YES];
//    [[[NSThread alloc] initWithTarget:self selector:@selector(tcpThread) object:nil] start];
   
}

-(void) appendBufferData:(NSData *) data{
    if (dataTmp==nil) {
        dataTmp = [[NSMutableData alloc] init];
    }else{
        [dataTmp appendData:data];
    }
}

-(void) readMsg{
    
    NSString *msgStr = [[NSString alloc] initWithData:dataTmp encoding:NSUTF8StringEncoding];
    NSLog(@"回调：%@",msgStr);
    if (dataTmp!=nil) {
        dataTmp = [[NSMutableData alloc] init];
    }
}

void readStreamCallback( CFReadStreamRef stream,
                        CFStreamEventType eventType,
                        void *clientCallBackInfo)
{
    PKNetworkViewController *controller = (__bridge PKNetworkViewController *)(clientCallBackInfo);
    switch (eventType) {
        case kCFStreamEventHasBytesAvailable:{
           NSLog(@"读数据成功！");
            int kBufferSize = 2048;
            while (CFReadStreamHasBytesAvailable(stream)) {
				UInt8 buffer[kBufferSize];
				int numBytesRead = CFReadStreamRead(stream, buffer, kBufferSize);
				[controller appendBufferData:[NSData dataWithBytes:buffer length:numBytesRead]];
			}
            [controller readMsg];
            break;
        }
        case kCFStreamEventErrorOccurred:
            NSLog(@"读发生错误");
            break;
        case kCFStreamEventEndEncountered:
            NSLog(@"读连接结束");
            CFReadStreamClose(stream);
           
            break;
        default:
            break;
    }
    
}

-(void) httpTodo
{
    NSLog(@"执行http协议");
   
    NSString *url = [NSString stringWithFormat:@"http://%s:%s/SSH/test!getTestMsg.do",SERVER_IP,SERVER_PORT ];
    if (![self asynConnectionUrl:url]) {
        NSLog(@"链接失败");
    }
}
//异步
-(BOOL) asynConnectionUrl:(NSString *)url
{
    NSLog(@"异步链接:%@",url);
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = @"msg=IOS的post请求";//设置参数
    
    NSData *requestData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    return YES;
}

//同步
-(BOOL) synConnectionUrl:(NSString *)url
{
    NSLog(@"同步链接:%@",url);
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = @"msg=IOS的post请求";//设置参数
    
    NSData *requestData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:requestData];
   
    NSError *error = nil;
    NSData *resposenData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error ) {
        return NO;
    }
    NSString *responseMsg = [[NSString alloc] initWithData:resposenData encoding:NSUTF8StringEncoding];
    [self callback:responseMsg];
    return YES;
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"链接出错:%@",[error localizedDescription]);
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"数据加载中……");
   
    [dataTmp appendData:data];
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    dataTmp = [[NSMutableData alloc] init];
    NSLog(@"链接成功：%@" ,res );
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseMsg = [[NSString alloc] initWithData:dataTmp encoding:NSUTF8StringEncoding];
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:dataTmp options:NSJSONReadingAllowFragments error:&error];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *dictionary = (NSDictionary *)jsonObject;
        
        NSLog(@" JSON Dictionary = %@", [dictionary objectForKey:@"Users"]);
        
    }else if ([jsonObject isKindOfClass:[NSArray class]]){
        
        NSArray *nsArray = (NSArray *)jsonObject;
        
        NSLog(@" JSON Array = %@", nsArray);
        
    } else {
        
        NSLog(@"An error happened while deserializing the JSON data.");
        
    }
    NSLog(@"完成数据：%@",responseMsg);
}

-(void) callback:(NSString *) msg
{
    NSLog(@"返回数据：%@",msg);
}

-(void) uploadImage
{
    NSString *url = [NSString stringWithFormat:@"http://%s:%s/SSH/test!upLoadImage.do",SERVER_IP,SERVER_PORT ];
    UIImage *image= [UIImage imageNamed:@"CuriousFrog.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSURL *requestUrl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
    request.HTTPMethod = @"POST";
    [request setValue:[@"multipart/form-data; boundary=" stringByAppendingString:@BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    NSMutableData *body = [[NSMutableData alloc] init];
   
   
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",@BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"CuriousFrog\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",@BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSString *bodyStr = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];

//    NSLog(@"\n%@",bodyStr );
    
    request.HTTPBody = body; // Set your own body data
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    
}

-(void) ASIHttpTodo
{
    NSLog(@"第三库请求开始……");
    NSString *url = [NSString stringWithFormat:@"%s:%s",SERVER_IP,SERVER_PORT ];
    NSString *path = @"/SSH/test!getTestMsg.do";
    //请求数据
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"测试数据" forKey:@"msg"];
    [params setValue:@"姓名" forKey:@"name"];
    
    MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:url];
    MKNetworkOperation *operation = [networkEngine operationWithPath:path params:params httpMethod:@"POST"];//get列队
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //成功返回
        NSLog(@"请求成功:%@",[completedOperation responseString]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //失败返回
        NSLog(@"请求失败:%@",[error localizedDescription]);
    }];
    [networkEngine enqueueOperation:operation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
