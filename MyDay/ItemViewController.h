#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemViewController : UIViewController

/// The item that will be presented in the viewController.
@property (strong, nonatomic) Item *item;

@end
