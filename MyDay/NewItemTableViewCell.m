#import "NewItemTableViewCell.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"

@implementation NewItemTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor darkGrayColor];

    self.signLabel.font = [UIFont thinFontWithSize:130];
    self.signLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont regularFontWithSize:16];
    self.titleLabel.textColor = [UIColor concreteColor];

    NSArray *titleLabelTexts = @[NSLocalizedString(@"How was your day?", nil),
                                 NSLocalizedString(@"Tell me about your day!", nil),
                                 NSLocalizedString(@"How's today?", nil),
                                 NSLocalizedString(@"Let's remember this day!", nil),
                                 NSLocalizedString(@"Today is my favorite day", nil)];

    self.titleLabel.text = titleLabelTexts[arc4random() % 5];
}

@end
