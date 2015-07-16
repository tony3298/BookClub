//
//  Book.h
//  BookClub
//
//  Created by Tony Dakhoul on 6/4/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Friend;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
