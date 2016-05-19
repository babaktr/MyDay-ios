#import <UIKit/UIKit.h>
#import "BaseItemTableViewCell.h"

/// TableViewCell that displays the title and date of the item.
@interface ItemHeaderTableViewCell : BaseItemTableViewCell

/// Label displaying the title of the item.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// Label displaying the subtitle (date) of the item.
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
/// ImageView displaying the weather of entry.
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

/**
 * Configures the cell with the title and date attribute of the item.
 * @param title The title of the item.
 * @param date The date of the item.
 * @param weatherScore The weather scoring.
 */
- (void)configureCellWithTitle:(NSString *)title
                      date:(NSDate *)date
                  weatherScore:(NSNumber *)weatherScore;

@end
