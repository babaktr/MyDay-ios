#import <UIKit/UIKit.h>
#import "BaseNewItemTableViewCell.h"

/// TableViewCell where a user can add an image to the item.
@interface NewImageTableViewCell : BaseNewItemTableViewCell

/// ImageView displaying a user selected image.
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
/// ImageView that covers and darkens the cell when attribute has been added.
@property (weak, nonatomic) IBOutlet UIImageView *cellCoverImageView;
/// Label displaying the title of the attribute cell.
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// Label displaying a + sign.
@property (weak, nonatomic) IBOutlet UILabel *signLabel;

/**
 * Configures the cell with the image attribute of the item.
 * @param image The image of the item.
 */
- (void)configureCellWithImage:(UIImage *)image;

/**
 * Invokes a block and adds/removes the current item.
 * @param image The image of the item. If nil, the current image is removed, else a new one is added.
 */
- (void)invokeCellBlockWithImage:(UIImage *)image;


@end
