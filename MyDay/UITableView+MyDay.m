#import "UITableView+MyDay.h"

@implementation UITableView (MyDay)

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.estimatedRowHeight = 85.0;
    self.rowHeight = UITableViewAutomaticDimension;
    self.backgroundColor = [UIColor clearColor];
}

- (UIView *)createFooterView:(UIColor *)color frame:(CGRect)frame
{
    UIView *footerView = [[UIView alloc] initWithFrame:frame];
    footerView.backgroundColor = color;
    return footerView;
}

@end
