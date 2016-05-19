#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// Class used to handle saving and obtaining images used in items.
@interface ImageHandler : NSObject

/**
 * Saves the image and returns its filename.
 * @param image The image to add.
 * @return The filename of the image.
 */
+ (NSString *)saveImage:(UIImage *)image;

/**
 * Returns a previously saved image with a specific filename.
 * @param imageName The name of the image.
 * @return The image with that filename.
 */
+ (UIImage *)getImageNamed:(NSString *)imageName;

/**
 * Deletes an image with a specific filename.
 * @param imageName The name of the image.
 */
+ (void)removeImageNamed:(NSString *)imageName;

@end
