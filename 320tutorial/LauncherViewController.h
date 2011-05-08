//
//  LauncherViewController.h
//  320tutorial
//
//  Created by Ivo Galic on 5/8/11.
//  Copyright 2011 Galic Design. All rights reserved.
//


#import <Three20/Three20.h> // import Three20 to launcherclass
#import <Foundation/Foundation.h>
// import the two three20 example classes
#import "StyleTestController.h" 
#import "TabBarTestController.h"


// add delegate to handle touches and editing of TTLauncherView class
@interface LauncherViewController : TTViewController <TTLauncherViewDelegate> { 
    TTLauncherView* launcherView; //add the TTLauncherView object
    TTNavigator* navigator; //add the url navigator object
}

@end
