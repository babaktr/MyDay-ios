#import <UIKit/UIKit.h>
#import "BaseNewItemTableViewCell.h"

/// TableViewCell where a user can notes to the item.
@interface NewNotesTableViewCell : BaseNewItemTableViewCell

/// Label displaying the title of the attribute cell.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// TextField where user can specify the notes of the item.
@property (weak, nonatomic) IBOutlet UITextView *textView;
/// ImageView that covers and darkens the cell when attribute has been added.
@property (weak, nonatomic) IBOutlet UIImageView *cellCoverImageView;

/**
 * Configures the cell with the notes of the item.
 * @param notes The notes of the item.
 */
- (void)configureCellWithNotes:(NSString *)notes;

@end
