#import <UIKit/UIKit.h>

/// Class used to generate UIAlertControllers.
@interface UIAlertController (MyDay)

/**
 * Generates a deletionAlertController with a given handler block
 * @param handler The block of code to handle in event of user pressing "Yes"
 * @return The generated UIAlertController.
 */
+ (UIAlertController *)deletionAlertControllerWithHandler:(void (^)())handler;

/**
 * Generates a deletionAlertController with a given handler blocks
 * @param fbHandler The block of code to handle in event of user pressing "Facebook"
 * @param iMessageHandler The block of code to handle in event of user pressing "iMessage"
 * @param mailHandler The block of code to handle in event of user pressing "Mail"
 * @return The generated UIAlertController.
 */
+ (UIAlertController *)shareAlertControllerWithFBHandler:(void (^)())fbHandler
                                            iMessageHandler:(void (^)())iMessageHandler
                                                mailHandler:(void (^)())mailHandler;

/**
 * Generates a alertController with an OK-button.
 * @param title The title of the alert.
 * @param message The message of the alert.
 * @return The generated UIAlertController.
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message;

@end
