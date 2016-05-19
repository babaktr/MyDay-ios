#import "NewImageTableViewCell.h"

@implementation NewImageTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.signLabel.font = [UIFont thinFontWithSize:120];
    self.signLabel.textColor = [UIColor saffronMangoColor];
    self.titleLabel.font = [UIFont regularFontWithSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];


    self.cellImageView.backgroundColor = [UIColor darkCerulianColor];
    [self.cellImageView setContentMode:UIViewContentModeCenter];
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cellImageView.clipsToBounds = YES;
}

- (void)configureCellWithImage:(UIImage *)image
{
    if (image) {
        self.brightMode = NO;
        self.signLabel.alpha = 0;
        self.cellImageView.image = image;
        self.titleLabel.text = NSLocalizedString(@"Image added", nil);
        self.cellCoverImageView.alpha = 1;
    } else {
        self.brightMode = YES;
        self.signLabel.alpha = 1;
        self.titleLabel.text = NSLocalizedString(@"Add image", nil);
        self.cellCoverImageView.alpha = 0;
    }
}

- (void)invokeCellBlockWithImage:(UIImage *)image
{
    self.cellImageView.image = image;
    [self invokeBlock];
}

@end
