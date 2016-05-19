#import "NewTitleTableViewCell.h"

@implementation NewTitleTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.titleLabel.font = [UIFont regularFontWithSize:14];
    self.textField.placeholder = NSLocalizedString(@"Add title", nil);
    self.textField.font = [UIFont heavyFontWithSize:20];
//    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)configureCellWithTitle:(NSString *)title
{
    if (title) {
        self.brightMode = NO;
        self.textField.text = title;
        self.titleLabel.text = NSLocalizedString(@"Title added", nil);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.cellCoverImageView.alpha = 1;
    } else {
        self.brightMode = YES;
        self.titleLabel.text = NSLocalizedString(@"Today's title", nil);
        self.titleLabel.textColor = [UIColor blackColor];
        self.cellCoverImageView.alpha = 0;
    }
}

@end
