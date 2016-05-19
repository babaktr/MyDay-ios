#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseNewItemTableViewCell.h"

/// TableViewCell where a user can a location to the item.
@interface NewMapTableViewCell : BaseNewItemTableViewCell <MKMapViewDelegate>

/// MapView showing the map, centered around the users current position.
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
/// Label displaying the title of the attribute cell.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// ImageView that covers and darkens the cell when attribute has been added.
@property (weak, nonatomic) IBOutlet UIImageView *cellCoverImageView;

/**
 * Configures the cell with the location latitude and longitude of the item.
 * @param latitude The latitude of the item's location
 * @param longitude The longitude of the item's location
 */
- (void)configureCellWithLocationLatitude:(NSNumber *)latitude
                                longitude:(NSNumber *)longitude;

/**
 * Adds a pin to the map at the given location.
 * @param location The coordinates of the location.
 */
- (void)addLocation:(CLLocationCoordinate2D)location;

@end
