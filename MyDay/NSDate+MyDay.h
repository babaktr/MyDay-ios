#import <Foundation/Foundation.h>

/// NSDate category class extension.
@interface NSDate (MyDay)

/**
 * Formats a specific NSDate to a string
 * @param date The date to format
 * @return A formated string representation of a date.
 */
+ (NSString *)formatDate:(NSDate *)date;

/** 
 * Configures an NSDate into current date with respect to timezone.
 * @return The date with respect to the current systems timezone.
 */
+ (NSDate *)currentDateInSystemTimezone;

@end
