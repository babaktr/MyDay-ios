#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
#import "Item.h"
#import "Location.h"

/// Class used to handle sharing of items.
@interface ItemShareHandler : NSObject

/**
 * Generates FBSDKShareLinkContent with attributes from an item.
 * @param item The item to build the FBSDKShareLinkContent with.
 * @return The FBSDKShareLinkContent with content. 
 */
+ (FBSDKShareLinkContent *)shareOnFBWithItem:(Item *)item;

/**
 * Generates MFMessageComposeViewController with attributes from an item.
 * @param item The item to build the MFMessageComposeViewController with.
 * @return The MFMessageComposeViewController with content.
 */
+ (MFMessageComposeViewController *)shareAsMessageWithItem:(Item *)item;

/**
 * Generates MFMailComposeViewController with attributes from an item.
 * @param item The item to build the MFMailComposeViewController with.
 * @return The MFMailComposeViewController with content.
 */
+ (MFMailComposeViewController *)shareAsMailWithItem:(Item *)item;

@end
