# MyDay

![screen-1](/MockupImages/1.png) ![screen-2](/MockupImages/2.png) ![screen-3](/MockupImages/3.png) 

## Background
**MyDay** was created as a part of the course **Introduction to iOS Application Development for iPhone and iPad**, (8 Credits), given by Linköping University in 2016. 

The project part of the course (5 Credits), in which MyDay was created, ran from early April to late May.

## About
MyDay is a virtual diary, making sure your memorable days are remembered. For each entry, the only information you really have to add is how your day felt (or rather, your mood)! If you want to, it stops there. However, if you want to be more specific, you can also give the entry a title, add notes to it, add an image to it and even your current location.

## Frameworks & APIs
**Frameworks:**
* [Facebook iOS SDK](https://developers.facebook.com/docs/ios)
* [MGSwipeTableCell](https://github.com/MortimerGoro/MGSwipeTableCell)

**APIs:**
* [SMHI Open Data API](http://opendata.smhi.se/apidocs/)

## Language support
The app supports both Swedish and English, with English being the base language in case you have set the language setting of your device to anything other than the two.

## Limitations
* Every entry is build around the basis of adding _Mood_. You cannot add an entry without it, but you can add an entry consisting only of a _Mood_ instead.
* The SMHI weather API only covers Sweden.
* Some features (i.e. Camera) will only work on a real device, and not on an iOS simulator.
* Locations added to an entry cannot be edited or moved around. They are only added in respect to the users current location.
* You cannot change date formats.

## Mockup data
On the first run, the app is automatically set to add mockup data. If you would like to turn this off, you can do it in this part of ```AppDelegate.h```, in the ```didFinishLaunchingWithOptions``` method.
```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Generate mock data on first run.
    // Set NO if you want to skip this.
    [MockupData generateMockData:YES];

	...

}
```
_Disclaimer: I do not own any of the images used in mockup entries._

## Getting started
Before you start, make sure you run
```
$ pod install
```
and then open the ```.workspace``` file.

Enjoy!

—


_2016, Babak Toghiani-Rizi_