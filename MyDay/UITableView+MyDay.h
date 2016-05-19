#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// UITableView category class extension.
@interface UITableView (MyDay)

/**
 * Create and return a UIView of specific color to use as the tableView's footer.
 * @param color The color of the footer.
 * @param frame The frame to set.
 * @return A colored UIView.
 */
- (UIView *)createFooterView:(UIColor *)color
                       frame:(CGRect)frame;

@end
