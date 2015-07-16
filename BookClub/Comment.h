//
//  Comment.h
//  BookClub
//
//  Created by Tony Dakhoul on 6/4/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * commentString;
@property (nonatomic, retain) Book *book;

@end
