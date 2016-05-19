#import "MyDayDataSource.h"
#import "ImageHandler.h"

@implementation MyDayDataSource

+ (NSArray *)fetchAllItemsWithContext:(NSManagedObjectContext *)managedObjectContext
{
    if (!managedObjectContext) {
        managedObjectContext = [self managedObjectContext];
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:NSStringFromClass([Item class])
                                        inManagedObjectContext:managedObjectContext]];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                   ascending:NO]]];

    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest
                                                                  error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"NSFetch error!");
    }

    return fetchedObjects;
}

+ (void)deleteItemWithIdentifier:(NSNumber *)identifier
{
    Item *item = [self getItemWithIdentifier:identifier];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (item.imageName) {
        [ImageHandler removeImageNamed:[self getItemWithIdentifier:identifier].imageName];
    }
    [managedObjectContext deleteObject:[self getItemWithIdentifier:identifier]];

    [self saveContextForContext:managedObjectContext];
}

+ (Location *)newLocationWithLatitude:(NSNumber *)latitude
                            longitude:(NSNumber *)longitude
{
    if (latitude && longitude) {
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        Location *location = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Location class])
                                                           inManagedObjectContext:managedObjectContext];
        location.latitude = latitude;
        location.longitude = longitude;

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[NSEntityDescription entityForName:NSStringFromClass([Location class])
                                            inManagedObjectContext:managedObjectContext]];

        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest
                                                                      error:&error];
        if (fetchedObjects == nil) {
            NSLog(@"NSFetch error!");
        }

        location.identifier = @([fetchedObjects count]);

        [self saveContextForContext:managedObjectContext];

        return location;
    }
    return nil;
}

+ (void)addNewItemWithImageName:(NSString *)imageName
                          title:(NSString *)title
                           date:(NSDate *)date
                      dayRating:(NSNumber *)dayRating
                          notes:(NSString *)notes
                    weatherScore:(NSNumber *)weatherScore
                       location:(Location *)location
{

    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSArray *allItems = [self fetchAllItemsWithContext:managedObjectContext];

    Item *item = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Item class])
                                               inManagedObjectContext:managedObjectContext];
    item.identifier = @([allItems count]);
    item.imageName = imageName;
    item.title = title;
    item.date = date;
    item.dayRating = dayRating;
    item.notes = notes;
    item.weatherScore = weatherScore;
    item.location = location;

    [self saveContextForContext:managedObjectContext];
}

+ (Item *)getItemWithIdentifier:(NSNumber *)identifier
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    [fetchRequest setEntity:[NSEntityDescription entityForName:NSStringFromClass([Item class])
                                        inManagedObjectContext:managedObjectContext]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"identifier==%@",identifier]];

    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"identifier"
                                                                   ascending:YES]]];

    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest
                                                                  error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"NSFetch error!");
    }

    return [fetchedObjects lastObject];
}

+ (void)editItemWithIdentifier:(NSNumber *)identifier
                     imageName:(NSString *)imageName
                         title:(NSString *)title
                     dayRating:(NSNumber *)dayRaying
                         notes:(NSString *)notes
                   weatherScore:(NSNumber *)weatherScore
                      location:(Location *)location
{
    Item *item = [self getItemWithIdentifier:identifier];
    item.imageName = imageName;
    item.title = title;
    item.dayRating = dayRaying;
    item.notes = notes;
    item.weatherScore = weatherScore;
    item.location = location;

    [self saveContextForContext:nil];

}


+ (NSManagedObjectContext *)managedObjectContext
{
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

+ (void)saveContextForContext:(NSManagedObjectContext *)managedObjectContext
{
    if (!managedObjectContext) {
        managedObjectContext = [self managedObjectContext];
    }

    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
