//
//  PKMapViewController.m
//  MapLocationDemo
//
//  Created by 周经伟 on 14-8-13.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKMapViewController.h"

@interface PKMapViewController ()
{
    CLLocationManager *localManager;
    
    PKMyAnnotation *annotation;
}
@end

@implementation PKMapViewController

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
    [self initMap];
    
    [_mapType addTarget:self action:@selector(setMapTypeForMapView:) forControlEvents:UIControlEventValueChanged];
    [_myLocalButton addTarget:self action:@selector(showMyLocal) forControlEvents:UIControlEventTouchUpInside];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) initMap
{
    _mapView.delegate = self;
    
}

-(void) setMapTypeForMapView:(UISegmentedControl *) seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:
            _mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mapView.mapType = MKMapTypeHybrid;
            break;
    }
    
}

-(void) showMyLocal
{
    localManager  = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        localManager.delegate = self;
        localManager.distanceFilter = 200;
        localManager.desiredAccuracy = kCLLocationAccuracyBest;
        [localManager startUpdatingLocation];//启动后方可获取代理信息
        
    }else{
        NSLog(@"不能显示信息");
    }

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    CLLocationCoordinate2D coords = newLocation.coordinate;
    NSLog(@"经度：%f,纬度:%f",coords.longitude,coords.latitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(0.1, 0.1));
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    //添加图钉
    annotation = [[PKMyAnnotation alloc] init];
    
    /*获取反向地址*/
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error){
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        annotation.street = placemark.thoroughfare;
        annotation.city = placemark.locality;
        annotation.state = placemark.administrativeArea;
        annotation.zip = placemark.postalCode;
        annotation.country = placemark.country;
        
    }];
    annotation.coordinate = coords;
    if (self.mapView.annotations.count < 1) {
        [self.mapView addAnnotation:annotation];
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
