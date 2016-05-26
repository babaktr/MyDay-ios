#import "MainViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <MessageUI/MessageUI.h>
#import "NewItemTableViewCell.h"
#import "NewItemViewController.h"
#import "Item.h"
#import "ItemShareHandler.h"
#import "ItemViewController.h"
#import "Location.h"
#import "MainTableViewCell.h"
#import "MGSwipeButton.h"
#import "MyDayDataSource.h"
#import "UIAlertController+MyDay.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"
#import "UITableView+MyDay.h"
#import "WeatherHandler.h"

@interface MainViewController () <FBSDKSharingDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, MGSwipeTableCellDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic) BOOL itemAddedToday;

@end

//Cell Identifiers
static NSString * const MainCellIdentifier = @"MainCell";
static NSString * const NewItemCellIdentifier = @"NewItemCell";

//Segue Identifiers
static NSString * const ShowItemSegue = @"ShowItem";
static NSString * const NewItemSegue = @"NewItem";

static NSInteger const TopItemCellHeight = 270;
static NSInteger const RegularCellHeight = 120;
static NSInteger const MGSwipeButtonThreshold = 1.9;

static float const CellDeletedAnimationDuration = 0.4;

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerNibs];
    self.view.backgroundColor = [UIColor concreteColor];
    [self.tableView setTableFooterView:[self.tableView createFooterView:[UIColor clearColor]
                                                                  frame:CGRectMake(0, 0, 0, 0)]];
    [self setUpNavigationController];

    self.dataSource = [[NSMutableArray alloc] init];
    self.dataSource = [NSMutableArray arrayWithArray:[MyDayDataSource fetchAllItemsWithContext:nil]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dataSource = [NSMutableArray arrayWithArray:[MyDayDataSource fetchAllItemsWithContext:nil]];

    if ([self.dataSource count] > 0) {
        Item *item = self.dataSource[0];
        self.itemAddedToday = ([[NSCalendar currentCalendar] isDateInToday:item.date]) ? YES : NO;
    } else {
        self.itemAddedToday = NO;
    }

    [self.tableView reloadData];
}

- (void)registerNibs
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:MainCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewItemTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:NewItemCellIdentifier];
}

- (void)setUpNavigationController
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.topItem.title = @"";
}

- (UIButton *)swipeButtonWithIcon:(UIImage *)icon
                            title:(NSString *)title
                           height:(CGFloat)height
                            color:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, RegularCellHeight, height);
    button.backgroundColor = color;

    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, 0.75*height)];
    [iconImageView setImage:icon];
    [iconImageView setContentMode:UIViewContentModeCenter];
    iconImageView.tintColor = [UIColor concreteColor];

    [button addSubview:iconImageView];
    iconImageView.center = CGPointMake(button.center.x, button.center.y-10);
    [button addSubview:[self createLabelWithText:title
                                          height:height]];

    return button;
}

- (UILabel *)createLabelWithText:(NSString *)text
                          height:(CGFloat)height
{
    //to make it appear below the icon
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0,(height/2)+15,RegularCellHeight,15)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont regularFontWithSize:13];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text
                                                                           attributes:@{NSForegroundColorAttributeName : [UIColor concreteColor]}];
    label.attributedText = attributedString;

    return label;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    [super prepareForSegue:segue
                    sender:sender];
    if ([segue.identifier isEqualToString:ShowItemSegue]) {
        ItemViewController *itemViewController = segue.destinationViewController;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSInteger row = indexPath.row;
        row -= (self.itemAddedToday) ? 0 : 1;
        Item *item = [self.dataSource objectAtIndex:row];
        itemViewController.item = item;
    }
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [self.dataSource count];
    if (!self.itemAddedToday || [self.dataSource count] == 0) {
        numberOfRows +=1;
    }
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return TopItemCellHeight;
    }
    return RegularCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    Item *item = [self.dataSource firstObject];
    BOOL itemAddedToday = NO;
    if (item) {
        itemAddedToday = [[NSCalendar currentCalendar] isDateInToday:item.date];
    }
    if (!itemAddedToday && indexPath.row == 0) {
        NewItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewItemCellIdentifier
                                                                     forIndexPath:indexPath];
        return cell;

    } else {
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellIdentifier
                                                                  forIndexPath:indexPath];
        UIButton *deleteButton = [self swipeButtonWithIcon:[[UIImage imageNamed:@"trashIcon"]
                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                                     title:NSLocalizedString(@"Delete", nil)
                                                    height:cell.frame.size.height
                                                     color:[UIColor persianRedColor]];
        UIButton *shareButton = [self swipeButtonWithIcon:[[UIImage imageNamed:@"actionIcon"]
                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                                    title:NSLocalizedString(@"Share", nil)
                                                   height:cell.frame.size.height
                                                    color:[UIColor forestGreenColor]];
        cell.rightButtons = @[deleteButton];
        cell.rightExpansion.buttonIndex = 0;
        cell.rightExpansion.threshold = MGSwipeButtonThreshold;
        cell.rightExpansion.fillOnTrigger = YES;

        cell.leftButtons = @[shareButton];
        cell.leftExpansion.buttonIndex = 0;
        cell.leftExpansion.threshold = MGSwipeButtonThreshold;
        cell.leftExpansion.fillOnTrigger = YES;

        if (!self.itemAddedToday) {
            [cell configureCellWithItem:self.dataSource[indexPath.row-1]];
        } else {
            [cell configureCellWithItem:self.dataSource[indexPath.row]];
        }
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemAddedToday) {
        [self performSegueWithIdentifier:ShowItemSegue sender:indexPath];
    } else {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:NewItemSegue
                                      sender:indexPath];
        } else {
            [self performSegueWithIdentifier:ShowItemSegue
                                      sender:indexPath];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath
                                  animated:YES];
}

#pragma MGSwipeTableCellDelegate
-(BOOL)swipeTableCell:(MGSwipeTableCell*)cell
  tappedButtonAtIndex:(NSInteger)index
            direction:(MGSwipeDirection)direction
        fromExpansion:(BOOL)fromExpansion
{
    __weak typeof(self) weakSelf = self;
    if (direction == MGSwipeDirectionLeftToRight) {
        //Share item
        MainTableViewCell *mainCell = (MainTableViewCell *)cell;

        UIAlertController *alertController = [UIAlertController shareAlertControllerWithFBHandler:^{
            FBSDKShareLinkContent *shareLinkContent = [ItemShareHandler shareOnFBWithItem:mainCell.item];
            FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fbauth2://"]]){
                dialog.mode = FBSDKShareDialogModeNative;
            }
            else {
                dialog.mode = FBSDKShareDialogModeAutomatic;
            }
            dialog.shareContent = shareLinkContent;
            dialog.delegate = weakSelf;
            dialog.fromViewController = weakSelf;
            [dialog show];
        } iMessageHandler:^{
            if([MFMessageComposeViewController canSendText]) {
                MFMessageComposeViewController *messageViewController = [ItemShareHandler shareAsMessageWithItem:mainCell.item];
                [messageViewController setMessageComposeDelegate:weakSelf];
                [weakSelf presentViewController:messageViewController
                                       animated:YES
                                     completion:nil];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ERROR", nil)
                                                                                         message:NSLocalizedString(@"Could not open iMessage", nil)];
                [weakSelf presentViewController:alertController
                                       animated:YES
                                     completion:nil];
            }
        } mailHandler:^{
            if([MFMailComposeViewController canSendMail]) {
                MFMailComposeViewController *mailViewController = [ItemShareHandler shareAsMailWithItem:mainCell.item];
                [mailViewController setMailComposeDelegate:weakSelf];
                [weakSelf presentViewController:mailViewController
                                       animated:YES
                                     completion:nil];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ERROR", nil)
                                                                                         message:NSLocalizedString(@"Could not open Mail", nil)];
                [weakSelf presentViewController:alertController
                                       animated:YES
                                     completion:nil];
            }
        }];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    } else if (direction == MGSwipeDirectionRightToLeft) {
        //Delete item
        MainTableViewCell *mainCell = (MainTableViewCell *)cell;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:mainCell];

        __weak typeof(mainCell) weakCell = mainCell;
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertController = [UIAlertController deletionAlertControllerWithHandler:^{
            NSNumber *identifier = weakCell.item.identifier;
            [UIView animateWithDuration:CellDeletedAnimationDuration
                             animations:^{
                                 if (indexPath.row != 0) {
                                     [weakSelf.tableView beginUpdates];
                                     [weakSelf.dataSource removeObjectAtIndex:index];
                                     [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath]
                                                               withRowAnimation:UITableViewRowAnimationMiddle];
                                     [weakSelf.tableView endUpdates];
                                 } else {
                                     weakSelf.itemAddedToday = NO;
                                 }
                             } completion:^(BOOL finished){
                                 [MyDayDataSource deleteItemWithIdentifier:identifier];
                                 weakSelf.dataSource = [NSMutableArray arrayWithArray:[MyDayDataSource fetchAllItemsWithContext:nil]];
                                 [weakSelf.tableView reloadData];
                             }];
        }];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    return YES;
}

#pragma FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                             message:NSLocalizedString(@"Could not send via FB", nil)];
    NSLog(@"FB: ERROR=%@\n",[error debugDescription]);

    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Cancelled", nil)
                                                                             message:NSLocalizedString(@"Cancelled sharing", nil)];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    if (result == MFMailComposeResultFailed) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                                 message:NSLocalizedString(@"Could not send via Mail", nil)];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    } else {
        [controller dismissViewControllerAnimated:YES
                                       completion:nil];
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    //So... This one is here only to avoid the warning it causes :D
}

#pragma MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultFailed) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                                 message:NSLocalizedString(@"Could not send via iMessage", nil)];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    } else {
        [controller dismissViewControllerAnimated:YES
                                       completion:nil];
    }
}

@end
