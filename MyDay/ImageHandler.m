#import "ImageHandler.h"

@implementation ImageHandler

+ (NSString *)saveImage:(UIImage *)image
{
    NSData *jpegData = UIImageJPEGRepresentation(image, 0.8);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:[NSURL URLWithString:path]
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    //Generate unique filename (based on current date)
    NSString *fileName = [NSString stringWithFormat:@"%@-%lu-%lu.jpg", @"img", (unsigned long)([[NSDate date] timeIntervalSince1970]), (unsigned long)[contents count]];
    //save file to path
    NSString *imageURL = [NSString stringWithFormat:@"%@/%@", path, fileName];

    [jpegData writeToFile:imageURL atomically:YES];

    return fileName;
}

+ (UIImage *)getImageNamed:(NSString *)imageName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@", path, imageName];
    UIImage *result = [UIImage imageWithContentsOfFile:stringURL];

    return result;
}

+ (void)removeImageNamed:(NSString *)imageName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSString *filePath = [path stringByAppendingPathComponent:imageName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (!success) {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

@end
