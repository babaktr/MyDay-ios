#import "ItemShareHandler.h"
#import "NSDate+MyDay.h"

@implementation ItemShareHandler

+ (FBSDKShareLinkContent *)shareOnFBWithItem:(Item *)item
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];

    [content setContentTitle:[self messageTitleWithItem:item]];
    [content setContentDescription: [self messageBodyWithItem:item]];
    [content setContentURL:[NSURL URLWithString:@"http://www.toghiani.se"]];
    
    return content;
}

+ (MFMessageComposeViewController *)shareAsMessageWithItem:(Item *)item
{
    MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
    [messageViewController setBody:[NSString stringWithFormat:@"%@ \n%@", [self messageTitleWithItem:item], [self messageBodyWithItem:item]]];

    return messageViewController;
}

+ (MFMailComposeViewController *)shareAsMailWithItem:(Item *)item
{
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    [mailViewController setSubject:[self messageTitleWithItem:item]];
    [mailViewController setMessageBody:[self messageBodyWithItem:item]
                                isHTML:NO];
    return mailViewController;
}

+ (NSString *)messageTitleWithItem:(Item *)item
{
    if (!item.title) {
        return [NSDate formatDate:item.date];
    } else {
        return [NSString stringWithFormat: @"%@ - %@", item.title, [NSDate formatDate:item.date]];
    }
}

+ (NSString *)messageBodyWithItem:(Item *)item
{
    NSString *mood;
    if ([item.dayRating integerValue] < 0) {
        mood = @":(";
    } else if ([item.dayRating integerValue] == 0) {
        mood = @":|";
    } else {
        mood = @":)";
    }

    NSString *moodTitle = NSLocalizedString(@"Mood", nil);
    NSString *notesTitle = NSLocalizedString(@"Notes", nil);
    return [NSString stringWithFormat:@"%@: %@ \n%@: %@", moodTitle, mood, notesTitle, item.notes];
}

@end
