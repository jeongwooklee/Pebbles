//
//  ParseManager.m
//  Pebbles
//
//  Created by wook on 3/29/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "RCTBridgeModule.h"

#import "ParseManager.h"

#import <Parse/Parse.h>

@implementation ParseManager

- (void)getRestaurants: (RCTResponseSenderBlock)callback
{
  RCT_EXPORT();
  dispatch_async(dispatch_get_main_queue(), ^{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (PFObject *object in objects) {
          [arr addObject:@[object[@"name"], object[@"keywords"]]];
        }
        callback(@[arr]);
      } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
      }
    }];
  });
}
@end