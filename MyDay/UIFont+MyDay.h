#import <UIKit/UIKit.h>

/// UIFont category class extension.
@interface UIFont (MyDay)

/* Thin Lato font.
 * @param size The size of the font.
 * @return The Thin Lato font with a specific size.
 */
+ (UIFont *)thinFontWithSize:(CGFloat)size;

/* Light Lato font.
 * @param size The size of the font.
 * @return The Light Lato font with a specific size.
 */
+ (UIFont *)lightFontWithSize:(CGFloat)size;

/* Regular Lato font.
 * @param size The size of the font.
 * @return The Regular Lato font with a specific size.
 */
+ (UIFont *)regularFontWithSize:(CGFloat)size;

/* Medium Lato font.
 * @param size The size of the font.
 * @return The Medium Lato font with a specific size.
 */
+ (UIFont *)mediumFontWithSize:(CGFloat)size;

/* Bold Lato font.
 * @param size The size of the font.
 * @return The Bold Lato font with a specific size.
 */
+ (UIFont *)boldFontWithSize:(CGFloat)size;

/* Heavy Lato font.
 * @param size The size of the font.
 * @return The Heavy Lato font with a specific size.
 */
+ (UIFont *)heavyFontWithSize:(CGFloat)size;

@end
