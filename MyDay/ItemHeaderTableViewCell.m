#import "ItemHeaderTableViewCell.h"
#import "NSDate+MyDay.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"
#import "WeatherHandler.h"

@implementation ItemHeaderTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.weatherImageView setContentMode:UIViewContentModeCenter];
    self.weatherImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.weatherImageView.clipsToBounds = YES;
}

- (void)configureCellWithTitle:(NSString *)title
                      date:(NSDate *)date
                  weatherScore:(NSNumber *)weatherScore
{
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont heavyFontWithSize:18];
    self.titleLabel.textColor = [UIColor darkCerulianColor];
    if (date) {
        self.subtitleLabel.text = [[NSCalendar currentCalendar] isDateInToday:date] ? NSLocalizedString(@"TODAY", nil) : [NSDate formatDate:date];
    } else {
        self.subtitleLabel.text = NSLocalizedString(@"TODAY", nil);
    }
    self.subtitleLabel.textColor = [UIColor lightGrayColor];
    self.subtitleLabel.font = [UIFont regularFontWithSize:SubtitleSize];

    self.weatherImageView.image = [[WeatherHandler imageForWeatherScore:weatherScore] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.weatherImageView.tintColor = [UIColor easternBlueColor];
}

@end
