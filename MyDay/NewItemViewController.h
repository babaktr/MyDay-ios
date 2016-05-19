#import <UIKit/UIKit.h>
#import "Item.h"

/// ViewController in which an item is edited and saved.
@interface NewItemViewController : UIViewController

/// An already initiated item, in case that this is used to edit that item rather than to add a new one.
@property (strong, nonatomic) Item *item;
/// If the item is a previously added one, now being edited.
@property (nonatomic) BOOL editMode;

@end
