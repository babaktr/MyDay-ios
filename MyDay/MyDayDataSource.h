
//
//  UIViewController+BackButtonHandler.h
//
//  Created by Babak Toghiani-Rizi in 2016.
//  Copyright 2016 Babak Toghiani-Rizi. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Item.h"
#import "Location.h"

/// Data source that handles all communication with Core Data.
@interface MyDayDataSource : NSObject

/**
 * Fetches all items in Core Data.
 * @param managedObjectContext The managed object context.
 * @return An array of all items.
 */
+ (NSArray *)fetchAllItemsWithContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Adds a new item.
 * @param imageName The name of the image for the item.
 * @param title The title of the item.
 * @param date The date of the item.
 * @param dayRating The dayRating of the item.
 * @param notes The notes of the item.
 * @param weatherCode The code for the weather.
 * @param location The location of the item.
 */
+ (void)addNewItemWithImageName:(NSString *)imageName
                          title:(NSString *)title
                           date:(NSDate *)date
                      dayRating:(NSNumber *)dayRating
                          notes:(NSString *)notes
                   weatherScore:(NSNumber *)weatherScore
                       location:(Location *)location;

/**
 * Deletes an item with a specific identifier.
 * @param identifier The identifier of the item.
 */
+ (void)deleteItemWithIdentifier:(NSNumber *)identifier;


/** Returns the item with a specific identifier.
 * @param identifier The identifier of the item.
 * @return The item with that identifier.
 */
+ (Item *)getItemWithIdentifier:(NSNumber *)identifier;

/**
 * Edits an item.
 * @param imageName The edited name of the image for the item.
 * @param title The edited title of the item.
 * @param date The edited date of the item.
 * @param dayRating The edited dayRating of the item.
 * @param notes The edited notes of the item.
 * @param weatherCode The edited weather code.
 * @param location The edited location of the item.
 */
+ (void)editItemWithIdentifier:(NSNumber *)identifier
                     imageName:(NSString *)imageName
                         title:(NSString *)title
                     dayRating:(NSNumber *)dayRaying
                         notes:(NSString *)notes
                  weatherScore:(NSNumber *)weatherScore
                      location:(Location *)location;

/**
 * Add a new location.
 * @param latitude The latitude of the location.
 * @param longitude The longitude of the location.
 */
+ (Location *)newLocationWithLatitude:(NSNumber *)latitude
                            longitude:(NSNumber *)longitude;

@end
