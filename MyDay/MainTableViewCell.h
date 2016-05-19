#import <UIKit/UIKit.h>
#import "Item.h"
#import "MGSwipeTableCell.h"

@interface MainTableViewCell : MGSwipeTableCell

/// ImageView displaying the image of the item, if the item has any
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
/// ImageView used if item has no image, instead dayRating is displayed.
@property (weak, nonatomic) IBOutlet UIImageView *dayRatingImageView;
/// Label displaying the title of the item
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// Label displaying the date of the item
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/// The item and it's attributes.
@property (strong, nonatomic) Item *item;

/**
 * Configures the cell based on the attributes of the item
 * @param: item The item it configures the cell with
 */
- (void)configureCellWithItem:(Item *)item;

@end
