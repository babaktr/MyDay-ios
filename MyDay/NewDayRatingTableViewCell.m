#import "NewDayRatingTableViewCell.h"

@interface NewDayRatingTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *neutralButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;

@end

@implementation NewDayRatingTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.font = [UIFont regularFontWithSize:14];

    UIImage *bad = [[UIImage imageNamed:@"dayRating-bad"]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *neutral = [[UIImage imageNamed:@"dayRating-neutral"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *good = [[UIImage imageNamed:@"dayRating-good"]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    [self.badButton setImage:bad
                    forState:UIControlStateNormal];
    self.badButton.tintColor = [UIColor persianRedColor];
    [self.neutralButton setImage:neutral
                        forState:UIControlStateNormal];
    self.neutralButton.tintColor = [UIColor easternBlueColor];
    [self.goodButton setImage:good
                     forState:UIControlStateNormal];
    self.goodButton.tintColor = [UIColor forestGreenColor];
}

- (void)configureCellWithDayRating:(NSNumber *)dayRating
{
    if (dayRating) {
        self.brightMode = NO;
        [self highlightMoodWithRating:dayRating];
        self.titleLabel.text = NSLocalizedString(@"Mood selected", nil);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.cellCoverImageView.alpha = 1;
    } else {
        self.brightMode = YES;
        self.titleLabel.text = NSLocalizedString(@"Today's mood", nil);
        self.titleLabel.textColor = [UIColor blackColor];
        self.cellCoverImageView.alpha = 0;
    }
}

- (void)highlightMoodWithRating:(NSNumber *)rating
{
    if ([rating integerValue] < 0) {
        [self assignImageTintsFromArray:@[[UIColor saffronMangoColor],
                                          [UIColor lightGrayColor],
                                          [UIColor lightGrayColor]]];
    } else if ([rating integerValue] == 0) {
        [self assignImageTintsFromArray:@[[UIColor lightGrayColor],
                                          [UIColor saffronMangoColor],
                                          [UIColor lightGrayColor]]];
    } else {
        [self assignImageTintsFromArray:@[[UIColor lightGrayColor],
                                          [UIColor lightGrayColor],
                                          [UIColor saffronMangoColor]]];
    }
}

- (void)assignImageTintsFromArray:(NSArray *)array
{
    if ([array count] > 0) {
        self.badButton.tintColor = array[0];
        self.neutralButton.tintColor = array[1];
        self.goodButton.tintColor = array[2];
    }
}

- (IBAction)didTapBadButton:(id)sender
{
    self.dayRating = -1;
    [self highlightMoodWithRating:@(self.dayRating)];
    [self invokeBlock];
}

- (IBAction)didTapNeutralButton:(id)sender
{
    self.dayRating = 0;
    [self highlightMoodWithRating:@(self.dayRating)];
    [self invokeBlock];
}

- (IBAction)didTapGoodButton:(id)sender
{
    self.dayRating = 1;
    [self highlightMoodWithRating:@(self.dayRating)];
    [self invokeBlock];
}

@end
