//
//  AddBookViewController.h
//  BookClub
//
//  Created by Tony Dakhoul on 6/4/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "Book.h"

@interface AddBookViewController : UIViewController

@property Friend *friend;
//@property Book *book;

@property NSManagedObjectContext *moc;

@end
