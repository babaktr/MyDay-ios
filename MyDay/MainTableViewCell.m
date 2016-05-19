#import "MainTableViewCell.h"
#import "ImageHandler.h"
#import "NSDate+MyDay.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"

@implementation MainTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    [self.titleLabel sizeToFit];
    [self.titleLabel layoutIfNeeded];

    self.backgroundColor = [UIColor darkGrayColor];

    [self.cellImageView setContentMode:UIViewContentModeCenter];
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cellImageView.clipsToBounds = YES;

    self.dayRatingImageView.tintColor = [UIColor concreteColor];

    self.titleLabel.font = [UIFont regularFontWithSize:15];
    self.titleLabel.textColor = [UIColor saffronMangoColor];
    self.dateLabel.font = [UIFont regularFontWithSize:14];
    self.dateLabel.textColor = [UIColor concreteColor];
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (void)configureCellWithItem:(Item *)item
{
    self.item = item;
    self.titleLabel.text = item.title;
    self.dateLabel.text =  [[NSCalendar currentCalendar] isDateInToday:item.date] ? NSLocalizedString(@"TODAY", nil) : [NSDate formatDate:item.date];
    if (!item.imageName) {
        if ([item.dayRating intValue] < 0) {
            self.dayRatingImageView.image = [[UIImage imageNamed:@"dayRating-bad"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.cellImageView.backgroundColor = [UIColor persianRedColor];
        } else if ([item.dayRating intValue] == 0) {
            self.dayRatingImageView.image = [[UIImage imageNamed:@"dayRating-neutral"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.cellImageView.backgroundColor = [UIColor easternBlueColor];
        } else {
            self.dayRatingImageView.image = [[UIImage imageNamed:@"dayRating-good"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.cellImageView.backgroundColor = [UIColor forestGreenColor];
        }
        self.cellImageView.image = nil;
    } else {
        self.cellImageView.image =  [ImageHandler getImageNamed:item.imageName];
        self.dayRatingImageView.image = nil;
    }
}

@end
