#import "ItemMapTableViewCell.h"
#import "UIColor+MyDay.h"

@implementation ItemMapTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.mapView.userInteractionEnabled = NO;
    self.mapView.showsUserLocation = YES;
}

- (void)addLocation:(CLLocationCoordinate2D)location
{
   self.annotation = [[MKPointAnnotation alloc] init];
    self.annotation.coordinate = location;
    [self.mapView addAnnotation:self.annotation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKPointAnnotation *annotation = [self.mapView.annotations lastObject];
    NSLog(@"latitude: %f", self.annotation.coordinate.latitude);
    NSLog(@"longitude: %f", self.annotation.coordinate.longitude);


    float spanLongitude = fabs(self.mapView.userLocation.coordinate.longitude - (self.annotation.coordinate.longitude))*1.5;
    float spanLatitude = fabs(self.mapView.userLocation.coordinate.latitude - (self.annotation.coordinate.latitude))*1.5;

    NSLog(@"spanLat: %f",spanLatitude);
    NSLog(@"spanLong: %f", spanLongitude);

    CLLocationCoordinate2D centerLocation = CLLocationCoordinate2DMake((self.mapView.userLocation.coordinate.latitude + self.annotation.coordinate.latitude)/2,
                                                                        (self.mapView.userLocation.coordinate.longitude + self.annotation.coordinate.longitude)/2);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerLocation, MKCoordinateSpanMake(spanLatitude, spanLongitude));

    [self.mapView setRegion:region
                   animated:NO];
}

@end
