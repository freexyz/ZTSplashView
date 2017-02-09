/*
 ******************************************************************************
 * MapViewController.m -
 *
 * Copyright (c) 2015-2016 by ZealTek Electronic Co., Ltd.
 *
 * This software is copyrighted by and is the property of ZealTek
 * Electronic Co., Ltd. All rights are reserved by ZealTek Electronic
 * Co., Ltd. This software may only be used in accordance with the
 * corresponding license agreement. Any unauthorized use, duplication,
 * distribution, or disclosure of this software is expressly forbidden.
 *
 * This Copyright notice MUST not be removed or modified without prior
 * written consent of ZealTek Electronic Co., Ltd.
 *
 * ZealTek Electronic Co., Ltd. reserves the right to modify this
 * software without notice.
 *
 * History:
 *	2016.01.16	T.C. Chiu	frist edition
 *
 ******************************************************************************
 */
#import <CoreText/CTFont.h>
#import "MapViewController.h"


/*
 ******************************************************************************
 *
 * for debug
 *
 ******************************************************************************
 */
#define LOGGING_MAPVIEW     1
#include "DbgMsg.h"

#if defined(LOGGING_MAPVIEW) && LOGGING_MAPVIEW
#define _dmsg(fmt, ...)     LOG_FORMAT(fmt, @"MV", ##__VA_ARGS__)
#else
#define _dmsg(...)
#endif


/*
 ******************************************************************************
 *
 * macros
 *
 ******************************************************************************
 */
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


/*
 ******************************************************************************
 *
 * @interface
 *
 ******************************************************************************
 */
@interface MapViewController ()

@property (nonatomic) float lastQuestionStep;
@property (nonatomic) float stepValue;
@end


/*
 ******************************************************************************
 *
 * @implementation
 *
 ******************************************************************************
 */
@implementation MapViewController

/*---------------------------------------------------------------------------*/
#pragma mark - View Lifecycle
/*---------------------------------------------------------------------------*/
- (void)viewDidLoad
{
    _dmsg(@"viewDidLoad");
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _mapView.delegate          = self;
    _mapView.showsUserLocation = YES;
    _mapView.mapType           = MKMapTypeStandard;
    _mapView.zoomEnabled       = YES;
    _mapView.scrollEnabled     = YES;

    //
    _locationManager                 = [[CLLocationManager alloc] init];
    _locationManager.delegate        = self;
    _locationManager.distanceFilter  = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    // 詢問是否要給app有定位功能權限
    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager requestAlwaysAuthorization];

    //
    _containerBarButtonItem.width = self.view.bounds.size.width;

    // Set the step to whatever you want. Make sure the step value makes sense
    //   when compared to the min/max values for the slider. You could take this
    //   example a step further and instead use a variable for the number of
    //   steps you wanted.
    _stepValue = 0.5f;

    // Set the initial value to prevent any weird inconsistencies.
    _lastQuestionStep = (_slider.value) / _stepValue;

    _slider.maximumValue = 5.0;
    _slider.minimumValue = 0.0;
    _slider.continuous   = YES;

}

-(void)viewDidAppear:(BOOL)animated
{
    _dmsg(@"viewDidAppear:");
    [super viewDidAppear:animated];

    // Starts the generation of updates that report the user’s current location
    [_locationManager startUpdatingLocation];

    // Starts the generation of updates that report the user’s current heading
    [_locationManager startUpdatingHeading];

    // View Area
    MKCoordinateRegion region  = { { 25.033900, 121.562688 }, { 0.005, 0.005 } };
    region.center.latitude     = _locationManager.location.coordinate.latitude;
    region.center.longitude    = _locationManager.location.coordinate.longitude;
    [_mapView setRegion:region animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    _dmsg(@"viewDidDisappear:");
    [super viewDidDisappear:animated];

    // Stops the generation of location updates
    [_locationManager stopUpdatingLocation];

    // Stops the generation of heading updates
    [_locationManager stopUpdatingHeading];
}

- (void)didReceiveMemoryWarning
{
    _dmsg(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*---------------------------------------------------------------------------*/
#pragma mark - CLLocationManagerDelegate
/*---------------------------------------------------------------------------*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _dmsg(@"locationManager:didUpdateLocations:");

    CLLocation *c = [locations objectAtIndex:0];
    _dmsg(@"緯度:%f, 經度:%f, 高度:%f", c.coordinate.latitude, c.coordinate.longitude, c.altitude);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    _dmsg(@"locationManager:didUpdateHeading:");

    if (newHeading.headingAccuracy < 0) {
        _dmsg(@"請進行校準或遠離磁性干擾源");
        return;
    }
    _dmsg(@"目前面對的方位:%f", newHeading.magneticHeading);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    _dmsg(@"locationManager:didUpdateHeading:%@", error);
}


/*---------------------------------------------------------------------------*/
#pragma mark - MKMapViewDelegate
/*---------------------------------------------------------------------------*/
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _dmsg(@"mapView:didUpdateUserLocation:");

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
}


/*---------------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------------*/
+ (NSString *)postscriptNameFromFullName:(NSString *)fullName
{
    _dmsg(@"postscriptNameFromFullName:");

    UIFont *font = [UIFont fontWithName:fullName size:1];
    return (__bridge NSString *)(CTFontCopyPostScriptName((__bridge CTFontRef)(font)));
}


/*---------------------------------------------------------------------------*/
#pragma mark - IBAction
/*---------------------------------------------------------------------------*/
- (IBAction)valueChanged:(UISlider *)sender
{
    _dmsg(@"valueChanged:");

    // This determines which "step" the slider should be on. Here we're taking
    //   the current position of the slider and dividing by the `self.stepValue`
    //   to determine approximately which step we are on. Then we round to get to
    //   find which step we are closest to.
    float newStep = roundf((_slider.value) / _stepValue);

    // Convert "steps" back to the context of the sliders values.
    _slider.value = newStep * _stepValue;

    _dmsg(@"value:%f, step:%f", _slider.value, _stepValue);
}


@end
