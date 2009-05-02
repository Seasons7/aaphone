//
//  AATextView.m
//  AAPhone
//
//  Created by mootoh on 5/3/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "AATextView.h"

@implementation AATextView
@synthesize buf;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
   [buf drawInRect:rect withFont:[UIFont systemFontOfSize:8]];
}


- (void)dealloc {
    [super dealloc];
}


@end
