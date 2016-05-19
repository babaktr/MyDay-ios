//
//  Item+CoreDataProperties.h
//  MyDay
//
//  Created by Babak Toghiani-Rizi on 27/04/16.
//  Copyright © 2016 Babak Toghiani-Rizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *dayRating;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *imageName;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *weatherScore;
@property (nullable, nonatomic, retain) Location *location;

@end

NS_ASSUME_NONNULL_END
