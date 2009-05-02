//
//  main.m
//  AAPhone
//
//  Created by mootoh on 5/2/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#include "aalib.h"
#include "shared.h"
#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
   NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

   aa_defparams.width=IMAGE_WIDTH;
   aa_defparams.height=IMAGE_HEIGHT;
   if (!aa_parseoptions(&aa_defparams, NULL, &argc, argv) || argc != 1) {
      printf("%s\n", aa_help);
      exit(1);
   }
   aa_defparams.width=IMAGE_WIDTH;
   aa_defparams.height=IMAGE_HEIGHT;

   NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
   filename = [dir stringByAppendingPathComponent:@"aa.txt"];
   NSFileManager *fm = [NSFileManager defaultManager];
   BOOL ret = [fm createFileAtPath:filename contents:nil attributes:nil];
   assert(ret);
   NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:filename];
   assert(fh);

   fp = fdopen([fh fileDescriptor], "w");
   if (fp == NULL) {
      NSLog(@"cannot open the file");
      exit(3);
   }
   
   struct aa_savedata asd = {NULL, &aa_text_format, fp};
      
   aa_ctxt = aa_init(&save_d, &aa_defparams,&asd);
   if (aa_ctxt == NULL) {
      printf("Can not intialize aalib\n");
      exit(2);
   }
   
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
