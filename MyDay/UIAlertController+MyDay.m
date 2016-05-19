#import "UIAlertController+MyDay.h"

@implementation UIAlertController (MyDay)

+ (UIAlertController *)deletionAlertControllerWithHandler:(void (^)())handler;
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Entry removal", nil)
                                          message:NSLocalizedString(@"Are you sure you want to delete this entry?", nil)
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction
                          actionWithTitle:NSLocalizedString(@"Yes", nil)
                          style:UIAlertActionStyleDestructive
                          handler:^(UIAlertAction * action) {
                              [alertController dismissViewControllerAnimated:YES
                                                                  completion:nil];
                              if (handler) {
                                  handler();
                              }
                          }];
    UIAlertAction *no = [UIAlertAction
                         actionWithTitle:NSLocalizedString(@"No", nil)
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action) {
                             [alertController dismissViewControllerAnimated:YES
                                                                 completion:nil];
                         }];
    [alertController addAction:yes];
    [alertController addAction:no];

    return alertController;
}

+ (UIAlertController *)shareAlertControllerWithFBHandler:(void (^)())fbHandler
                                         iMessageHandler:(void (^)())iMessageHandler
                                             mailHandler:(void (^)())mailHandler;
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Entry sharing", nil)
                                          message:NSLocalizedString(@"Where do you want to share it?", nil)
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *mail = [UIAlertAction
                           actionWithTitle:NSLocalizedString(@"Mail", nil)
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [alertController dismissViewControllerAnimated:YES
                                                                   completion:nil];
                               if (mailHandler) {
                                   mailHandler();
                               }
                           }];
    UIAlertAction *iMessage = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"iMessage", nil)
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [alertController dismissViewControllerAnimated:YES
                                                                       completion:nil];
                                   if (iMessageHandler) {
                                       iMessageHandler();
                                   }
                               }];
    UIAlertAction *facebook = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Facebook", nil)
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [alertController dismissViewControllerAnimated:YES
                                                                       completion:nil];
                                   if (fbHandler) {
                                       fbHandler();
                                   }
                               }];
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancel", nil)
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action) {
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                             }];
    [alertController addAction:facebook];
    [alertController addAction:mail];
    [alertController addAction:iMessage];
    [alertController addAction:cancel];

    return alertController;
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"OK", nil)
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action) {
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                             }];
    [alertController addAction: cancel];
    
    return alertController;
}

@end
