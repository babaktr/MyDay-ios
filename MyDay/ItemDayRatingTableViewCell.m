#import "ItemDayRatingTableViewCell.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"

@implementation ItemDayRatingTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.titleLabel.textColor = [UIColor darkCerulianColor];
    self.titleLabel.font = [UIFont regularFontWithSize:SubtitleSize];
}

- (void)configureCellWithDayRating:(NSNumber *)dayRating
                              date:(NSDate *)date
{
    self.titleLabel.text = [[NSCalendar currentCalendar] isDateInToday:date] ? NSLocalizedString(@"Today's mood", nil) : NSLocalizedString(@"This day's mood", nil);

    if ([dayRating intValue] < 0) {
        self.cellImageView.image = [[UIImage imageNamed:@"dayRating-bad"]
                                    imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.cellImageView.tintColor = [UIColor persianRedColor];
    } else if ([dayRating intValue] == 0) {
        self.cellImageView.image = [[UIImage imageNamed:@"dayRating-neutral"]
                                    imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.cellImageView.tintColor = [UIColor easternBlueColor];

    } else {
        self.cellImageView.image = [[UIImage imageNamed:@"dayRating-good"]
                                    imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.cellImageView.tintColor = [UIColor forestGreenColor];
    }
}

@end

