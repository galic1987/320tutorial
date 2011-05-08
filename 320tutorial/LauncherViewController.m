//
//  LauncherViewController.m
//  320tutorial
//
//  Created by Ivo Galic on 5/8/11.
//  Copyright 2011 Galic Design. All rights reserved.
//

#import "LauncherViewController.h"


@implementation LauncherViewController

// standard initialization 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Launcher";
    }

    return self;
}

// mm functions
- (void)dealloc {
    [launcherView release];
    [navigator release];
    [super dealloc];
}

// load view will be loaded first time when we open the view
- (void)loadView {
    [super loadView]; // send to super class
    launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds]; // create TTLauncherView
    launcherView.backgroundColor = [UIColor blackColor]; 
    // delegate the actions on this class @see TTLauncherViewDelegate down
    launcherView.delegate = self;
    // how many columns 
    launcherView.columnCount = 3;
    self.title = @"Launcher";
       
    navigator = [TTNavigator navigator]; // create the navigator
    navigator.supportsShakeToReload = YES; // if you shake the iphone , he is going to reaload the whole TTLauncherView
    navigator.persistenceMode = TTNavigatorPersistenceModeAll; // and he will save the data :)
    
    TTURLMap* map = navigator.URLMap; // mapper pointer for our navigation

    // create the first "root" node
    [map                    from: @"tt://launcher" 
          toSharedViewController: [LauncherViewController class]];
    
    // add "children nodes" 
    // tansition is animation style
    // is going to open every request with webbrowser if not recognized in map
    [map            from: @"*"
                  parent: @"tt://launcher"
        toViewController: [TTWebController class]
                selector: nil
              transition: 4];
    
    // is going to open some styletest/tabbartest controller form 320 exmaple classes
    [map            from: @"tt://styleTest"
                  parent: @"tt://launcher"
        toViewController: [StyleTestController class]
                selector: nil
              transition: 5];
    [map            from: @"tt://tabbar"
                  parent: @"tt://launcher"
        toViewController: [TabBarTestController class]
                selector: nil
              transition: 6];
    
    // multiarray that contains all "pages" icons and their links,options,names...
    // ending always with nil
    launcherView.pages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:
                            [[[TTLauncherItem alloc] initWithTitle:@"Galic-design.com"
                                                             image:@"bundle://eng.png"
                                                               URL:@"http://galic-design.com" canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Styles"
                                                             image:@"bundle://gicon.png"
                                                               URL:@"tt://styleTest" canDelete:YES] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"TabBar test"
                                                             image:@"bundle://photo.png"
                                                               URL:@"tt://tabbar" canDelete:YES] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Yahoo"
                                                             image:@"bundle://photo.png"
                                                               URL:@"http://yahoo.com" canDelete:YES] autorelease],
                            nil],
                           [NSArray arrayWithObjects:
                            [[[TTLauncherItem alloc] initWithTitle:@"Google"
                                                             image:@"bundle://gicon.png"
                                                               URL:@"http://google.com" canDelete:YES] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Three20 API"
                                                             image:@"bundle://photo.png"
                                                               URL:@"http://api.three20.info" canDelete:YES] autorelease],
                            
                            nil],
                           nil
                           ];
   
    [self.view addSubview:launcherView]; //fetching to subview (now is visible)
    
    // querying option and post changes
    TTLauncherItem* item = [launcherView itemWithURL:@"http://galic-design.com"];
    item.badgeNumber = 4;
    
    item = [launcherView itemWithURL:@"http://google.com"];
    item.badgeNumber = 31;
    
    item = [launcherView itemWithURL:@"tt://styleTest"];
    item.badgeValue = @"Sly!";
    

    
 
}

#pragma mark -
#pragma TTLauncherViewDelegate

// if user selects one item , call the navigator with that url
- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    NSLog(@"Did select item %@",[item title]);
    [navigator openURLAction:[TTURLAction actionWithURLPath:item.URL]];
}

// if user wants to edit the items, display done button
- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                 target:launcherView action:@selector(endEditing)] autorelease] animated:YES];
}
// if user is finished with editing , hide done button
- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end
