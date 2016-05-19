#import <UIKit/UIKit.h>
#import "BaseItemTableViewCell.h"

/// TableViewCell that appears if the user hasn't added any item that day, and presents the option of doing so.
@interface NewItemTableViewCell : BaseItemTableViewCell

/// Label displaying the title of the attribute cell.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// Label displaying a + sign.
@property (weak, nonatomic) IBOutlet UILabel *signLabel;

@end
