#import "ItemViewController.h"
#import "ImageHandler.h"
#import "Item.h"
#import "ItemDayRatingTableViewCell.h"
#import "ItemHeaderTableViewCell.h"
#import "ItemMapTableViewCell.h"
#import "ItemNotesTableViewCell.h"
#import "Location.h"
#import "MyDayDataSource.h"
#import "NewItemViewController.h"
#import "UIAlertController+MyDay.h"
#import "UIColor+MyDay.h"
#import "UIFont+MyDay.h"
#import "UITableView+MyDay.h"

@interface ItemViewController () <UITableViewDelegate>
@property (strong, nonatomic) UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundImageViewTopConstraint;
@property (strong, nonatomic) NSMutableArray *attributeArray;

@end

static NSString * const EditItemSegue = @"EditItem";

//Cell Identifiers
static NSString * const ItemDayRatingCellIdentifier = @"ItemDayRatingCell";
static NSString * const ItemHeaderCellIdentifier = @"ItemHeaderCell";
static NSString * const ItemNotesCellIdentifier = @"ItemNotesCell";
static NSString * const ItemMapCellIdentifier = @"ItemMapCell";

static NSInteger const TableViewBottomOffset = 60;

@implementation ItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerNibs];

    [self.tableView setTableFooterView:[self.tableView createFooterView:[UIColor concreteColor]
                                                                  frame:CGRectMake(0, 0, 0, TableViewBottomOffset)]];
    self.view.backgroundColor = [UIColor concreteColor];
    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@"backButton"];
    self.attributeArray = [[NSMutableArray alloc] init];
    [self.backgroundImageView setContentMode:UIViewContentModeTop];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBackground];
    self.backgroundImageView.image = [ImageHandler getImageNamed:self.item.imageName];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.editButton) {
        [self addEditButton];
    }
}

- (void)registerNibs
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ItemHeaderTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:ItemHeaderCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ItemDayRatingTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:ItemDayRatingCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ItemNotesTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:ItemNotesCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ItemMapTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:ItemMapCellIdentifier];
}

- (void)updateBackground
{
    self.backgroundImageView.image = [ImageHandler getImageNamed:self.item.imageName];
    self.tableView.contentInset = (self.item.imageName) ?
    UIEdgeInsetsMake([[UIScreen mainScreen] bounds].size.height/2, 0, 0, 0) :
    UIEdgeInsetsMake([[UIScreen mainScreen] bounds].size.height/4, 0, 0, 0);
}

- (void)addEditButton
{
    self.editButton = [[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                       target:self
                       action:@selector(promptEditActionSheet)];

    [self.editButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont regularFontWithSize:19], NSFontAttributeName,
                                             [UIColor saffronMangoColor], NSForegroundColorAttributeName,
                                             nil]
                                   forState:UIControlStateNormal];

    [self.navigationItem setRightBarButtonItem:self.editButton
                                      animated:YES];
}

- (void)promptEditActionSheet
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *edit = [UIAlertAction
                           actionWithTitle:NSLocalizedString(@"Edit entry", nil)
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [weakSelf editItem];
                               [alertController dismissViewControllerAnimated:YES
                                                                   completion:nil];
                           }];
    UIAlertAction *delete = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Remove entry", nil)
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action) {
                                 UIAlertController *deleteAlert = [UIAlertController deletionAlertControllerWithHandler:^{
                                     [MyDayDataSource deleteItemWithIdentifier:weakSelf.item.identifier];
                                     [weakSelf.navigationController popViewControllerAnimated:YES];
                                 }];
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                                 [weakSelf presentViewController:deleteAlert
                                                        animated:YES
                                                      completion:nil];

                             }];
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancel", nil)
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action) {
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                             }];

    [alertController addAction:edit];
    [alertController addAction:delete];
    [alertController addAction:cancel];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)editItem
{
    [self performSegueWithIdentifier:EditItemSegue
                              sender:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.backgroundImageViewTopConstraint.constant = [self backgroundImageViewOffsetForScrollView:scrollView];
}

- (CGFloat)backgroundImageViewOffsetForScrollView:(UIScrollView *)scrollView
{
    CGFloat constraintOffset = scrollView.contentOffset.y*-0.5 - scrollView.contentInset.top*0.5;
    return MIN(0, constraintOffset);
}

- (CGFloat)textViewHeightForText:(NSString *)text
                        andWidth:(CGFloat)width
{
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

- (void)configureCell:(ItemNotesTableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
{
    cell.notesLabel.text = self.item.notes;
}

- (void)updateItemAttributeArray
{
    if ([self.attributeArray count] > 0) {
        [self.attributeArray removeAllObjects];
    }
    if (self.item.title) {
        [self.attributeArray addObject:self.item.title];
    }
    if (self.item.dayRating) {
        [self.attributeArray addObject:self.item.dayRating];
    }
    if (self.item.notes) {
        [self.attributeArray addObject:self.item.notes];
    }
    if (self.item.location) {
        [self.attributeArray addObject:self.item.location];
    }
}

#pragma UITableViewDeleagte

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self updateItemAttributeArray];
    return [self.attributeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (!([self.attributeArray count] > 0)) {
        [self updateItemAttributeArray];
    }
    if (self.item.title && [self.attributeArray[indexPath.row] isEqual:self.item.title]) {
        ItemHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemHeaderCellIdentifier
                                                                        forIndexPath:indexPath];
        [cell configureCellWithTitle:self.item.title
                                date:self.item.date
                        weatherScore:self.item.weatherScore];

        return cell;
    } else if (self.item.dayRating && [self.attributeArray[indexPath.row] isEqual:self.item.dayRating]) {
        ItemDayRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemDayRatingCellIdentifier
                                                                           forIndexPath:indexPath];
        [cell configureCellWithDayRating:self.item.dayRating
                                    date:self.item.date];

        return cell;
    } else if (self.item.notes && [self.attributeArray[indexPath.row] isEqual:self.item.notes]) {
        ItemNotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemNotesCellIdentifier
                                                                       forIndexPath:indexPath];
        [cell configureCellWithNotes:self.item.notes];

        return cell;
    } else if (self.item.location && [self.attributeArray[indexPath.row] isEqual:self.item.location]) {
        ItemMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemMapCellIdentifier
                                                                     forIndexPath:indexPath];
        [cell addLocation:CLLocationCoordinate2DMake([self.item.location.latitude doubleValue],
                                                     [self.item.location.longitude doubleValue])];
        cell.mapView.delegate = cell;

        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"identifier"];
        return cell;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self updateBackground];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    [super prepareForSegue:segue
                    sender:sender];

    if ([segue.identifier isEqualToString:EditItemSegue]) {
        NewItemViewController *newItemViewController = segue.destinationViewController;
        newItemViewController.item = self.item;
        newItemViewController.editMode = YES;
    }
}

@end
