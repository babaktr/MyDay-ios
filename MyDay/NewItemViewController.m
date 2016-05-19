#import "NewItemViewController.h"
#import "ImageHandler.h"
#import "Location.h"
#import "MyDayDataSource.h"
#import "NewDayRatingTableViewCell.h"
#import "NewImageTableViewCell.h"
#import "NewMapTableViewCell.h"
#import "NewNotesTableViewCell.h"
#import "NewTitleTableViewCell.h"
#import "UIAlertController+MyDay.h"
#import "UITableView+MyDay.h"
#import "UIColor+MyDay.h"
#import "WeatherHandler.h"

@interface NewItemViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIToolbar *keyboardToolbar;

@property (nonatomic) BOOL saveEnabled;

//item attributes
@property (strong, nonatomic) NSString *itemImageName;
@property (strong, nonatomic) NSString *itemTitle;
@property (strong, nonatomic) NSNumber *itemDayRating;
@property (strong, nonatomic) NSString *itemNotes;
@property (strong, nonatomic) NSNumber *itemWeatherScore;
@property (strong, nonatomic) NSNumber *locationLatitude;
@property (strong, nonatomic) NSNumber *locationLongitude;

@end

static NSString * const ImageCellIdentifier = @"ImageCell";
static NSString * const TitleCellIdentifier = @"TitleCell";
static NSString * const DayRatingCellIdentifier = @"DayRatingCell";
static NSString * const NotesCellIdentifier = @"NotesCell";
static NSString * const MapCellIdentifier = @"MapCell";

static NSInteger const TableViewBottomOffset = 60;
static NSInteger const DoneButtonWidth = 50;
static NSInteger const KeyboardToolbarHeight = 45;
static NSInteger const NewBackButtonImageInset = -10;
static NSInteger const SaveButtonFontSize = 19;
static NSInteger const TotalNumberOfItemAttributes = 5;

@implementation NewItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerNibs];
    self.view.backgroundColor = [UIColor concreteColor];
    if (self.editMode) {
        self.saveEnabled = YES;
        [self enableSaveButton];
        [self setItemAttributes];
    }
    [self.tableView setTableFooterView:[self.tableView createFooterView:[UIColor concreteColor]
                                                                  frame:CGRectMake(0, 0, 0, TableViewBottomOffset)]];

    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"backButton"]
                                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]                                                                       style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(promptSaveWarning)];
    newBackButton.imageInsets = UIEdgeInsetsMake(0, NewBackButtonImageInset, 0, 0);
    self.navigationItem.leftBarButtonItem = newBackButton;
}

- (void)registerNibs
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewImageTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier: ImageCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewTitleTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier: TitleCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewDayRatingTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier: DayRatingCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewNotesTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier: NotesCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewMapTableViewCell class])
                                               bundle:nil] forCellReuseIdentifier: MapCellIdentifier];
}

- (void)setItemAttributes
{
    self.itemImageName = self.item.imageName;
    self.itemTitle = self.item.title;
    self.itemDayRating = self.item.dayRating;
    self.itemNotes = self.item.notes;
    self.itemWeatherScore = self.item.weatherScore;
    self.locationLongitude = self.item.location.latitude;
    self.locationLongitude = self.item.location.longitude;
}

- (UIToolbar *)getKeyboardToolbar
{
    if (!self.keyboardToolbar) {
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, KeyboardToolbarHeight)];
        self.keyboardToolbar.barStyle = UIBarStyleDefault;
        self.keyboardToolbar.backgroundColor = [UIColor concreteColor];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(endEditing)];
        doneButton.width = DoneButtonWidth;
        [self.keyboardToolbar setItems:@[flexibleSpace, doneButton]];
    }
    return self.keyboardToolbar;
}

- (void)endEditing
{
    [self.view endEditing:YES];
}

- (void)enableSaveButton
{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:NSLocalizedString(@"Save", nil)
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(saveItem)];
    [saveButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont regularFontWithSize:SaveButtonFontSize], NSFontAttributeName,
                                        [UIColor saffronMangoColor], NSForegroundColorAttributeName,
                                        nil]
                              forState:UIControlStateNormal];

    [self.navigationItem setRightBarButtonItem:saveButton
                                      animated:YES];
}

- (void)promptSaveWarning
{
    if (self.saveEnabled) {
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:NSLocalizedString(@"Save", nil)
                                              message:NSLocalizedString(@"Do you want to save your changes before going back?", nil)
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yes = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"Yes", nil)
                              style:UIAlertActionStyleDestructive
                              handler:^(UIAlertAction * action) {
                                  [weakSelf saveItem];
                                  [alertController dismissViewControllerAnimated:YES
                                                                      completion:nil];
                              }];
        UIAlertAction *no = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"No", nil)
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action) {
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                                 [weakSelf.navigationController popViewControllerAnimated:YES];
                             }];

        [alertController addAction:yes];
        [alertController addAction:no];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)saveItem
{
    CLLocationManager *locationManager = [(AppDelegate*)[[UIApplication sharedApplication] delegate] locationManager];

    NSNumber *weatherScore = [WeatherHandler getWeatherDataForLocationLatitude:locationManager.location.coordinate.latitude
                                                                     longitude:locationManager.location.coordinate.longitude];
    [self endEditing];
    if (!self.editMode) {
        [MyDayDataSource addNewItemWithImageName:self.itemImageName
                                           title:self.itemTitle
                                            date:[NSDate date]
                                       dayRating:self.itemDayRating
                                           notes:self.itemNotes
                                    weatherScore:weatherScore
                                        location:[MyDayDataSource newLocationWithLatitude:self.locationLatitude
                                                                                longitude:self.locationLongitude]];
    } else {
        //Check if location is new or the same as previous to avoid saved duplicates.
        Location *location = self.item.location;
        if (![self.item.location.latitude isEqual:self.locationLatitude] &&
            ![self.item.location.longitude isEqual:self.locationLongitude]) {
            location = [MyDayDataSource newLocationWithLatitude:self.locationLatitude
                                                      longitude:self.locationLongitude];
        }

        [MyDayDataSource editItemWithIdentifier:self.item.identifier
                                      imageName:self.itemImageName
                                          title:self.itemTitle
                                      dayRating:self.itemDayRating
                                          notes:self.itemNotes
                                   weatherScore:self.itemWeatherScore
                                       location:location];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker
                       animated:YES
                     completion:nil];
}

- (void)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker
                       animated:YES
                     completion:nil];
}

- (void)showPhotoSelection
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Add image from", nil)
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *photoLibrary = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Photo Library", nil)
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       if (self.itemImageName) {
                                           [ImageHandler removeImageNamed:self.itemImageName];
                                       }
                                       [self selectPhoto];
                                       [alertController dismissViewControllerAnimated:YES
                                                                           completion:nil];
                                   }];
    UIAlertAction *camera = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Camera", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 if (self.itemImageName) {
                                     [ImageHandler removeImageNamed:self.itemImageName];
                                 }
                                 [self takePhoto];
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                             }];

    if (self.itemImageName) {
        UIAlertAction *remove = [UIAlertAction
                                 actionWithTitle:NSLocalizedString(@"Remove current image", nil)
                                 style:UIAlertActionStyleDestructive
                                 handler:^(UIAlertAction * action) {
                                     [ImageHandler removeImageNamed:self.itemImageName];
                                     self.itemImageName = nil;
                                     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                     NewImageTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                                     cell.brightMode = NO;
                                     [cell invokeCellBlockWithImage:nil];
                                     [alertController dismissViewControllerAnimated:YES
                                                                         completion:nil];
                                 }];
        [alertController addAction:remove];
    }

    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancel", nil)
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action) {
                                 [alertController dismissViewControllerAnimated:YES
                                                                     completion:nil];
                             }];
    [alertController addAction:photoLibrary];
    [alertController addAction:camera];
    [alertController addAction:cancel];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma UIImagePickerControllerDelegate


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES
                               completion:nil];

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.itemImageName = [ImageHandler saveImage:image];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0
                                                inSection:0];
    NewImageTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    cell.brightMode = YES;

    [cell invokeCellBlockWithImage:image];

}


#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TotalNumberOfItemAttributes;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NewImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellIdentifier
                                                                      forIndexPath:indexPath];
        [cell configureCellWithImage:[ImageHandler getImageNamed:self.item.imageName]];

        __weak typeof(cell) weakCell = cell;
        [cell setCellBlock:^{
            [UIView animateWithDuration:0.8
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 if (weakCell.brightMode) {
                                     weakCell.cellCoverImageView.alpha = 1;
                                     weakCell.signLabel.alpha = 0;
                                     weakCell.titleLabel.text = NSLocalizedString(@"Image added", nil);
                                 } else {
                                     weakCell.cellCoverImageView.alpha = 0;
                                     weakCell.signLabel.alpha = 1;
                                     weakCell.titleLabel.text = NSLocalizedString(@"Add image", nil);
                                 }
                             } completion:nil];
        }];

        return cell;
    } else if (indexPath.row == 1) {
        NewTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleCellIdentifier
                                                                      forIndexPath:indexPath];
        [cell configureCellWithTitle:self.item.title];

        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        [cell setCellBlock:^{
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 if (weakCell.brightMode) {
                                     weakCell.cellCoverImageView.alpha = 0;
                                     weakCell.titleLabel.textColor = [UIColor blackColor];
                                     weakCell.titleLabel.text = NSLocalizedString(@"Today's title", nil);

                                     weakSelf.itemTitle = nil;
                                 } else {
                                     weakCell.cellCoverImageView.alpha = 1;
                                     weakCell.titleLabel.textColor = [UIColor whiteColor];
                                     weakCell.titleLabel.text = NSLocalizedString(@"Title added", nil);

                                     weakSelf.itemTitle = weakCell.textField.text;
                                 }
                             } completion:nil];
        }];

        cell.textField.delegate = self;

        return cell;
    } else if (indexPath.row == 2) {
        NewDayRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DayRatingCellIdentifier
                                                                          forIndexPath:indexPath];
        [cell configureCellWithDayRating:self.item.dayRating];

        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        [cell setCellBlock:^{
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 weakCell.cellCoverImageView.alpha = 1;
                                 weakCell.titleLabel.textColor = [UIColor whiteColor];
                                 weakCell.titleLabel.text = NSLocalizedString(@"Mood selected", nil);

                                 weakSelf.itemDayRating = @(weakCell.dayRating);
                             } completion:^(BOOL finished) {
                                 if (!self.saveEnabled) {
                                     self.saveEnabled = !self.saveEnabled;
                                     [self enableSaveButton];
                                 }
                             }];
        }];

        return cell;
    } else if (indexPath.row == 3){
        NewNotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NotesCellIdentifier
                                                                      forIndexPath:indexPath];
        [cell configureCellWithNotes:self.item.notes];

        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        [cell setCellBlock:^{
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 if (weakCell.brightMode) {
                                     weakCell.cellCoverImageView.alpha = 1;
                                     weakCell.titleLabel.textColor = [UIColor whiteColor];
                                     weakCell.titleLabel.text = NSLocalizedString(@"Notes added", nil);

                                     weakSelf.itemNotes = weakCell.textView.text;
                                 } else {
                                     weakCell.cellCoverImageView.alpha = 0;
                                     weakCell.titleLabel.textColor = [UIColor blackColor];
                                     weakCell.titleLabel.text = NSLocalizedString(@"Today's notes", nil);

                                     weakSelf.itemNotes = nil;
                                 }
                             } completion:nil];
            weakCell.brightMode = !weakCell.brightMode;
        }];

        cell.textView.delegate = self;

        return cell;
    } else {
        NewMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MapCellIdentifier
                                                                    forIndexPath:indexPath];
        [cell configureCellWithLocationLatitude:self.item.location.latitude
                                      longitude:self.item.location.longitude];
        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        [cell setCellBlock:^{
            if (weakCell.mapView.userLocation.coordinate.longitude != 0 ||
                weakCell.mapView.userLocation.coordinate.longitude != 0) {
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     if (weakCell.brightMode) {
                                         weakCell.cellCoverImageView.alpha = 1;
                                         weakCell.titleLabel.textColor = [UIColor whiteColor];
                                         weakCell.titleLabel.text = NSLocalizedString(@"Location added", nil);

                                         weakSelf.locationLongitude = [NSNumber numberWithDouble:weakCell.mapView.userLocation.location.coordinate.longitude];
                                         weakSelf.locationLatitude = [NSNumber numberWithDouble:weakCell.mapView.userLocation.location.coordinate.latitude];

                                         [weakCell addLocation:weakCell.mapView.userLocation.location.coordinate];

                                     } else {
                                         weakCell.cellCoverImageView.alpha = 0;
                                         weakCell.titleLabel.textColor = [UIColor blackColor];
                                         weakCell.titleLabel.text = NSLocalizedString(@"Tap to add location", nil);
                                         [weakCell.mapView removeAnnotations:weakCell.mapView.annotations];

                                         weakSelf.locationLongitude = nil;
                                         weakSelf.locationLatitude = nil;
                                     }
                                 } completion:nil];
                weakCell.brightMode = !weakCell.brightMode;
            } else {
                [weakSelf presentViewController:[UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                                    message:NSLocalizedString(@"Your location is not available right now. Please try again in a moment", nil)]
                                       animated:YES
                                     completion:nil];

            }
        }];

        cell.mapView.delegate = cell;

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showPhotoSelection];
    }
}

#pragma UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    [UIView performWithoutAnimation:^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:NO];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.inputAccessoryView = [self getKeyboardToolbar];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    NewNotesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:YES];

    if ([textView.text isEqualToString:NSLocalizedString(@"Write down your notes here...", nil)]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    } else {

        [cell invokeBlock];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    NewNotesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([textView.text isEqualToString:@""]) {
        textView.text = NSLocalizedString(@"Write down your notes here...", nil);
        textView.textColor = [UIColor lightGrayColor];
    } else {
        [cell invokeBlock];
    }
    [textView resignFirstResponder];
}

#pragma UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    [UIView performWithoutAnimation:^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.inputAccessoryView = [self getKeyboardToolbar];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1
                                                inSection:0];
    NewTitleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (![textField.text isEqualToString:@""]) {
        cell.brightMode = NO;
    } else {
        cell.brightMode = YES;
    }
    [cell invokeBlock];
    [textField resignFirstResponder];
}

@end
