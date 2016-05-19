#import "MockupData.h"
#import <UIKit/UIKit.h>
#import "ImageHandler.h"
#import "MyDayDataSource.h"

@implementation MockupData

+ (void)generateMockData:(BOOL)add
{
    if (([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRun"] integerValue] != 1) && add) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"firstRun"];

        [MyDayDataSource addNewItemWithImageName:[ImageHandler saveImage:[UIImage imageNamed:@"header"]]
                                           title:@"Aureus"
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:0
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(1)
                                           notes:@"Lorem ipsum dolor sit amet, ea mea scaevola lobortis, duo dico etiam ut, persequeris necessitatibus sea id. Prima fabellas in ius, sea ea ocurreret consetetur liberavisse. Vis animal nusquam moderatius in, molestie vulputate mel ea, rebum impedit mnesarchum ea mea. Quo quis aperiri cu, est cibo forensibus ut, in veri utamur eam. Eu mundi nusquam deseruisse usu."
                                    weatherScore:@(10)
                                        location:[MyDayDataSource newLocationWithLatitude:[NSNumber numberWithDouble:59]
                                                                                longitude:[NSNumber numberWithDouble:17.8]]];

        [MyDayDataSource addNewItemWithImageName:[ImageHandler saveImage:[UIImage imageNamed:@"testImage1"]]
                                           title:@"Viridis"
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:-1
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(1)
                                           notes:@"Lorem ipsum dolor sit amet, ea mea scaevola lobortis, duo dico etiam ut, persequeris necessitatibus sea id. Prima fabellas in ius, sea ea ocurreret consetetur liberavisse. Vis animal nusquam moderatius in, molestie vulputate mel ea, rebum impedit mnesarchum ea mea. Quo quis aperiri cu, est cibo forensibus ut, in veri utamur eam. Eu mundi nusquam deseruisse usu."
                                    weatherScore:@(10)
                                        location:[MyDayDataSource newLocationWithLatitude:[NSNumber numberWithDouble:59]
                                                                                longitude:[NSNumber numberWithDouble:17.8]]];

        [MyDayDataSource addNewItemWithImageName:[ImageHandler saveImage:[UIImage imageNamed:@"testImage4"]]
                                           title:@"Flavus"
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:-2
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(-1)
                                           notes:@"Te malorum ceteros epicurei eum, sonet corpora luptatum at mel. Cu usu mollis singulis. Esse accusam vis at, ne mel unum mazim pertinacia. At quem solet usu, ad eos elit mnesarchum repudiandae, cum no quem paulo."
                                    weatherScore:@(2)
                                        location:[MyDayDataSource newLocationWithLatitude:[NSNumber numberWithDouble:59]
                                                                                longitude:[NSNumber numberWithDouble:17.8]]];

        [MyDayDataSource addNewItemWithImageName:[ImageHandler saveImage:[UIImage imageNamed:@"testImage2"]]
                                           title:@"Purpureus"
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:-3
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(0)
                                           notes:nil
                                    weatherScore:@(4)
                                        location:nil];

        [MyDayDataSource addNewItemWithImageName:[ImageHandler saveImage:[UIImage imageNamed:@"testImage5"]]
                                           title:@"Argenteus"
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:-4
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(0)
                                           notes:nil
                                    weatherScore:@(1)
                                        location:[MyDayDataSource newLocationWithLatitude:[NSNumber numberWithDouble:59]
                                                                                longitude:[NSNumber numberWithDouble:17.8]]];

        [MyDayDataSource addNewItemWithImageName:[ImageHandler saveImage:[UIImage imageNamed:@"testImage3"]]
                                           title:nil
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:-5
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(1)
                                           notes:@"Ne qui adhuc appetere voluptaria, usu id tibique luptatum interpretaris. Ex delicata postulant nec. Latine sadipscing ius ea. Veri assentior mel et, vis volutpat postulant te. Quem prima consetetur mel te."
                                    weatherScore:@(1)
                                        location:nil];

        [MyDayDataSource addNewItemWithImageName:nil
                                           title:@"Aureus"
                                            date:[[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                                          value:-10
                                                                                         toDate:[NSDate date]
                                                                                        options:0]
                                       dayRating:@(-1)
                                           notes:nil
                                    weatherScore:@(5)
                                        location:nil];
    }
}

@end
