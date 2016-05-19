#import <UIKit/UIKit.h>
#import "BaseItemTableViewCell.h"

/// TableViewCell that displays the dayRaying of the item.
@interface ItemDayRatingTableViewCell : BaseItemTableViewCell

/// Label displaying the title of the item.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// ImageView displaying the dayRating of the item.
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

/**
 * Configures the cell with the dayRating of the item.
 * @param dayRating The dayRating of the item.
 * @param date The date for comparison, if this is today or not.
 */
- (void)configureCellWithDayRating:(NSNumber *)dayRating
                              date:(NSDate *)date;

@end
