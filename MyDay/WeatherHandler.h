#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// Class used to get weather data for the item.
@interface WeatherHandler : NSObject

/**
 * Calls SMHI API for weather
 * @param latitude The latitude to call with.
 * @param longitude The longitude to call with.
 * @return The weather code.
 */
+ (NSNumber *)getWeatherDataForLocationLatitude:(float)latitude
                                longitude:(float)longitude;
/**
 * Formats date with a specific dateformatter
 * @return The dateFormatter.
 */
+ (NSDateFormatter *)dateFormatter;

/**
 * Returns the correct image of the weather
 * @param score The weather scoring.
 * @return The correct image.
 */
+ (UIImage *)imageForWeatherScore:(NSNumber *)score;

@end
