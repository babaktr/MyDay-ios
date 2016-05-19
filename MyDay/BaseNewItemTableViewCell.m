#import "BaseNewItemTableViewCell.h"

@implementation BaseNewItemTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.brightMode = YES;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UIEdgeInsets)layoutMargins
{
    [super layoutMargins];
    return UIEdgeInsetsZero;
}

- (void)invokeBlock
{
    if (self.cellBlock) {
        self.cellBlock();
    }
}

@end
