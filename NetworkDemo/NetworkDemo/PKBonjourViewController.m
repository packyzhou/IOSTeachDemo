//
//  PKBonjourViewController.m
//  NetworkDemo
//
//  Created by 周经伟 on 14-8-5.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKBonjourViewController.h"

@interface PKBonjourViewController ()
{
    NSNetServiceBrowser *serviceBrowser;
    NSNetService *registService;
    NSMutableArray *services;
}
@end

@implementation PKBonjourViewController

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
    [_findServiceButton addTarget:self action:@selector(detectService) forControlEvents:UIControlEventTouchUpInside];
    [_registServiceButton addTarget:self action:@selector(registServices) forControlEvents:UIControlEventTouchUpInside];
    [_analysisServiceButton addTarget:self action:@selector(analysisSevice) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}



-(void) detectService
{
    NSLog(@"发现Bonjour");
    serviceBrowser = [[NSNetServiceBrowser alloc] init];
    serviceBrowser.delegate = self;
    [serviceBrowser searchForServicesOfType:@"_http._tcp." inDomain:@"local."];//搜索服务
}

-(void) registServices
{
    NSLog(@"注册Bonjour");
    services = [[NSMutableArray alloc] init];
    registService = [[NSNetService alloc] initWithDomain:@"local." type:@"_http._tcp." name:@"packyServer" port:2044];
    registService.delegate = self;
    
    [registService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [registService publish];
}

- (void)netServiceDidPublish:(NSNetService *)sender{
    
    
    NSLog(@"发布Bonjour服务成功:domain(域名) = %@,type = %@,name = %@,port(端口) = %i",[sender domain],[sender  type],[sender name],(int)[sender port]);
    
}

-(void) analysisSevice
{
    NSLog(@"解析Bonjour");
    NSNetService *service = [services objectAtIndex:0];
    service.delegate = self;
    [service resolveWithTimeout:1];
}

-(void) netServiceWillResolve:(NSNetService *)sender
{
    NSLog(@"解析开始");
}

-(void) netServiceDidResolveAddress:(NSNetService *)sender
{
    NSLog(@"解析结束：\n name:%@,type:%@-> host:%@,port:%i",sender.name, sender.type,sender.hostName,sender.port);
}

-(void) netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
    NSLog(@"解析失败");
}

-(void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
   
    NSLog(@"发现的服务!");
    if(![services containsObject:aNetService])//判断不包含这个服务
    {
        [services addObject:aNetService];
    }
    NSLog(@"共：%i",[services count]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
