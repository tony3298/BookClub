//
//  BookViewController.h
//  BookClub
//
//  Created by Tony Dakhoul on 6/4/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookViewController : UIViewController

@property Book *book;
@property NSManagedObjectContext *moc;

@end
