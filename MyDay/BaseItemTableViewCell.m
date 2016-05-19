#import "BaseItemTableViewCell.h"

@implementation BaseItemTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

@end
