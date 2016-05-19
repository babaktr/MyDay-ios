#import <UIKit/UIKit.h>
#import "BaseItemTableViewCell.h"

/// TableViewCellt that displays the notes of the item.
@interface ItemNotesTableViewCell : BaseItemTableViewCell

/// Label displaying the title of the item.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// Label displaying the notes of the item.
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

/**
 * Configures the cell with the notes of the item.
 * @param notes The notes of the item.
 */
- (void)configureCellWithNotes:(NSString *)notes;

@end
