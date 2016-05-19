#import "NSDate+MyDay.h"

@implementation NSDate (MyDay)


+ (NSString *)formatDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar]
                                    components:NSCalendarUnitDay |
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitYear
                                    fromDate:date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSString *monthString;

    switch(month) {
        case 1:
            monthString = NSLocalizedString(@"month.january", nil);
            break;
        case 2:
            monthString = NSLocalizedString(@"month.february", nil);
            break;
        case 3:
            monthString = NSLocalizedString(@"month.mars", nil);
            break;
        case 4:
            monthString = NSLocalizedString(@"month.april", nil);
            break;
        case 5:
            monthString = NSLocalizedString(@"month.may", nil);
            break;
        case 6:
            monthString = NSLocalizedString(@"month.june", nil);
            break;
        case 7:
            monthString = NSLocalizedString(@"month.july", nil);
            break;
        case 8:
            monthString = NSLocalizedString(@"month.august", nil);
            break;
        case 9:
            monthString = NSLocalizedString(@"month.september", nil);
            break;
        case 10:
            monthString = NSLocalizedString(@"month.october", nil);
            break;
        case 11:
            monthString = NSLocalizedString(@"month.november", nil);
            break;
        case 12:
            monthString = NSLocalizedString(@"month.december", nil);
            break;
    }
    return [NSString stringWithFormat:@"%ld %@ %ld", (long)day, monthString, (long)year];
}

+ (NSDate *)currentDateInSystemTimezone
{
    NSDate* sourceDate = [NSDate date];

    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];

    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];

    return destinationDate;
}

@end
