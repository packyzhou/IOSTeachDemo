//
//  PKMapViewController.h
//  MapLocationDemo
//
//  Created by 周经伟 on 14-8-13.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PKMapLocalView.h"
#import "PKMyAnnotation.h"
@interface PKMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property(strong,nonatomic) IBOutlet MKMapView *mapView;
@property(strong,nonatomic) IBOutlet UIButton *myLocalButton;
@property(strong,nonatomic) IBOutlet PKMapLocalView *startText;
@property(strong,nonatomic) IBOutlet PKMapLocalView *endText;
@property(strong,nonatomic) IBOutlet UISegmentedControl *mapType;
@property(strong,nonatomic) IBOutlet UIButton *navigationButton;
@property(strong,nonatomic) IBOutlet UIStepper *zoomMap;
@end
