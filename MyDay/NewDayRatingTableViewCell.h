#import <UIKit/UIKit.h>
#import "BaseNewItemTableViewCell.h"

/// TableViewCell where a user can add a dayRating to the item.
@interface NewDayRatingTableViewCell : BaseNewItemTableViewCell

/// Label displaying the title of the attribute cell.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// ImageView that covers and darkens the cell when attribute has been added.
@property (weak, nonatomic) IBOutlet UIImageView *cellCoverImageView;

@property (nonatomic) NSInteger dayRating;

/**
 * Configures the cell with the dayRating of the item.
 * @param dayRating The dayRating of the item.
 */
- (void)configureCellWithDayRating:(NSNumber *)dayRating;

@end
