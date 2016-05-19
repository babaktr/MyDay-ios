#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseItemTableViewCell.h"

/// TableViewCell that displays a map with a pin dropped on the items location.
@interface ItemMapTableViewCell : BaseItemTableViewCell <MKMapViewDelegate>

/// MapView showing the location that the item was added on.
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/// Annotation added to the mapView.
@property (strong, nonatomic) MKPointAnnotation *annotation;

/**
 * Adds a pin to the map at the given location.
 * @param location The coordinates of the location.
 */
- (void)addLocation:(CLLocationCoordinate2D)location;

@end
