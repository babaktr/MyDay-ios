#import <UIKit/UIKit.h>
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"

/// TableViewCell that serves as a base class for all other new item cells.
@interface BaseNewItemTableViewCell : UITableViewCell

/// A block of code that the cell later can invoke.
@property (copy, nonatomic) void (^cellBlock)();

/// If the cell is in bright mode, meaning that it is empty/untouched.
@property BOOL brightMode;

/**
 * Invokes a block of code that the cell can hold
 */
- (void)invokeBlock;

@end
