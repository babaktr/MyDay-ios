#import <UIKit/UIKit.h>
#import "BaseNewItemTableViewCell.h"

/// TableViewCell where a user can add a title to the item.
@interface NewTitleTableViewCell : BaseNewItemTableViewCell

/// Label displaying the title of the attribute cell.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// TextField where user can specify the title of the item.
@property (weak, nonatomic) IBOutlet UITextField *textField;
/// ImageView that covers and darkens the cell when attribute has been added.
@property (weak, nonatomic) IBOutlet UIImageView *cellCoverImageView;

/**
 * Configures the cell with the title of the item.
 * @param title The title of the item.
 */
- (void)configureCellWithTitle:(NSString *)title;

@end
