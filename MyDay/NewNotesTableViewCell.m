#import "NewNotesTableViewCell.h"

@implementation NewNotesTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.titleLabel.font = [UIFont regularFontWithSize:14];
    self.textView.font = [UIFont regularFontWithSize:14];
    self.textView.text = NSLocalizedString(@"Write down your notes here...", nil);
}

- (void)configureCellWithNotes:(NSString *)notes
{
    if (notes) {
        self.brightMode = NO;
        self.textView.text = notes;
        self.titleLabel.text = NSLocalizedString(@"Notes added", nil);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.textView.textColor = [UIColor blackColor];
        self.cellCoverImageView.alpha = 1;
    } else {
        self.brightMode = YES;
        self.titleLabel.text = NSLocalizedString(@"Today's notes", nil);
        self.titleLabel.textColor = [UIColor blackColor];
        self.textView.textColor = [UIColor lightGrayColor];
        self.cellCoverImageView.alpha = 0;
    }
}

@end
