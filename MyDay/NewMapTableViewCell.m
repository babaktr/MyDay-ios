#import "NewMapTableViewCell.h"

@implementation NewMapTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.mapView.userInteractionEnabled = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.alpha = 0.8;

    self.titleLabel.font = [UIFont regularFontWithSize:18];
}

- (void)configureCellWithLocationLatitude:(NSNumber *)latitude
                                longitude:(NSNumber *)longitude
{
    if (latitude && longitude) {
        self.brightMode = NO;
        self.titleLabel.text = NSLocalizedString(@"Location added", nil);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.cellCoverImageView.alpha = 1;
        [self addLocation:CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue])];
    } else {
        self.brightMode = YES;
        self.titleLabel.text = NSLocalizedString(@"Tap to add location", nil);
        self.titleLabel.textColor = [UIColor blackColor];
        self.cellCoverImageView.alpha = 0;

    }
}

- (void)addLocation:(CLLocationCoordinate2D)location
{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    
    [self.mapView addAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000, 5000);
    [self.mapView setRegion:region];
}

- (IBAction)didTapCellButton:(id)sender {
    [self invokeBlock];
}

@end
