#import "UIFont+MyDay.h"

@implementation UIFont (MyDay)

+ (UIFont *)mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Medium" size:size];
}

+ (UIFont *)boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Bold" size:size];
}

+ (UIFont *)heavyFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Heavy" size:size];
}

+ (UIFont *)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Light" size:size];
}

+ (UIFont *)regularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Regular" size:size];
}

+ (UIFont *)thinFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Thin" size:size];
}

@end
