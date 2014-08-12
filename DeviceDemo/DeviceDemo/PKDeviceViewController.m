//
//  PKDeviceViewController.m
//  DeviceDemo
//
//  Created by 周经伟 on 14-8-12.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKDeviceViewController.h"

@interface PKDeviceViewController ()
{
    CMMotionManager *motionManager;
}
@end

@implementation PKDeviceViewController

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
    [self accelerationDevice];
//    [self distanceDevice];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//距离传感器
-(void) distanceDevice
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackDistance:) name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
}

//回调
-(void) callbackDistance:(NSNotificationCenter *)notification;
{
     if ([[UIDevice currentDevice] proximityState] == YES) {
         
         NSLog(@"正在接近:%@",[UIDevice currentDevice] );
     }else{
         
     }
}

//加速度传感器
-(void) accelerationDevice
{
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager.accelerometerAvailable)
    {
        motionManager.accelerometerUpdateInterval = 0.006; // 告诉manager，更新频率是60Hz
        [motionManager startAccelerometerUpdates]; // 开始更新，后台线程开始运行。这是pull方式。
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateAccelermeterThread) userInfo:nil repeats:YES];
        [timer fire];
        motionManager start
        //方法二
//        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//            _xLable.text = [NSString stringWithFormat:@"%f",accelerometerData.acceleration.x ];
//            _yLable.text = [NSString stringWithFormat:@"%f",accelerometerData.acceleration.y ];
//            _zLable.text = [NSString stringWithFormat:@"%f",accelerometerData.acceleration.z ];
//        }];
    }else{
        NSLog(@"加速度不可用");
    }
}

-(void) updateAccelermeterThread
{
    CMAccelerometerData *newestAccel = motionManager.accelerometerData;
    _xLable.text = [NSString stringWithFormat:@"%f",newestAccel.acceleration.x ];
    _yLable.text = [NSString stringWithFormat:@"%f",newestAccel.acceleration.y ];
    _zLable.text = [NSString stringWithFormat:@"%f",newestAccel.acceleration.z ];
    _xProgressView.progress =fabs(newestAccel.acceleration.x);
    _yProgressView.progress =fabs(newestAccel.acceleration.y);
    _zProgressView.progress =fabs(newestAccel.acceleration.z);
    if (fabs(newestAccel.acceleration.x)>1.5 ||fabs(newestAccel.acceleration.y)>1.5 ||fabs(newestAccel.acceleration.z)>1.5) {
        NSLog(@"检测到晃动");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
