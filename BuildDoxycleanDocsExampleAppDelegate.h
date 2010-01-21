//
//  BuildDoxycleanDocsExampleAppDelegate.h
//  BuildDoxycleanDocsExample
//
//  Created by Steve Mcferrin on 1/21/10.
//  Copyright 2010 MacFlite Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 *
 * This is an example header where you would explain general details of a class 
 */
@interface BuildDoxycleanDocsExampleAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

/**
 * @name        Getting the class properties
 */

/**
 * @brief				This is a property of the BuildDoxycleanDocsExampleAppDelegate
 *
 *
 * @param				
 * @param				
 *
 *
 * @details			just a window no need for details here,
 *
 *								
 *
 * 								
 *
 * @return		 returns an NSWindow object 
 *
 */
@property (assign) IBOutlet NSWindow *window;

@end
