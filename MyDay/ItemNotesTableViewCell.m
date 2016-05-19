#import "ItemNotesTableViewCell.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"

@implementation ItemNotesTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.textColor = [UIColor darkCerulianColor];
    self.titleLabel.font = [UIFont regularFontWithSize:SubtitleSize];
    self.titleLabel.text = NSLocalizedString(@"Notes", nil);
    self.notesLabel.numberOfLines = 0;
    self.notesLabel.font = [UIFont lightFontWithSize:SubtitleSize];
}

- (void)configureCellWithNotes:(NSString *)notes
{
    self.notesLabel.text =  notes;
}

@end
