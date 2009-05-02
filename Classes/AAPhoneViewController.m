//
//  AAPhoneViewController.m
//  AAPhone
//
//  Created by mootoh on 5/2/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "AAPhoneViewController.h"
#import "aalib.h"
#import "shared.h"
#import "AATextView.h"

extern aa_context *aa_ctxt;
char buf[1024*1024*4];

@implementation AAPhoneViewController

void monotonize(UInt8 *src, size_t width, size_t height, size_t bytesPerRow)
{
   NSUInteger  i, j;
   for (j = 0; j < height; j++) {
      for (i = 0; i < width; i++) {
         UInt8 *tmp;
         tmp = src + j * bytesPerRow + i * 4;

         UInt8   r, g, b;
         r = *(tmp + 3);
         g = *(tmp + 2);
         b = *(tmp + 1);

         UInt8   y;
         y = (77 * r + 28 * g + 151 * b) / 256;

         *(tmp + 1) = y;
         *(tmp + 2) = y;
         *(tmp + 3) = y;
      }
   }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
   [super viewDidLoad];
   UIImage *original = [UIImage imageNamed:@"img.jpg"];
   CGImageRef original_ref = original.CGImage;
   
   size_t                  width = CGImageGetWidth(original_ref);
   size_t                  height = CGImageGetHeight(original_ref);
   size_t                  bitsPerComponent;
   size_t                  bitsPerPixel;
   size_t                  bytesPerRow;
   CGColorSpaceRef         colorSpace;
   CGBitmapInfo            bitmapInfo;
   bool                    shouldInterpolate;
   CGColorRenderingIntent  intent;
   bitsPerComponent = CGImageGetBitsPerComponent(original_ref);
   bitsPerPixel = CGImageGetBitsPerPixel(original_ref);
   bytesPerRow = CGImageGetBytesPerRow(original_ref);
   colorSpace = CGImageGetColorSpace(original_ref);
   bitmapInfo = CGImageGetBitmapInfo(original_ref);
   shouldInterpolate = CGImageGetShouldInterpolate(original_ref);
   intent = CGImageGetRenderingIntent(original_ref);
   CGDataProviderRef dataProvider = CGImageGetDataProvider(original_ref);

   CFDataRef data = CGDataProviderCopyData(dataProvider);
   UInt8 *src = (UInt8*)CFDataGetBytePtr(data);
   //monotonize(src, width, height, bytesPerRow);
/*
   CFDataRef   effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
   CGDataProviderRef   effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
   
   CGImageRef  effectedCgImage;
   UIImage*    effectedImage;
   effectedCgImage = CGImageCreate(
                                   width, height, 
                                   bitsPerComponent, bitsPerPixel, bytesPerRow, 
                                   colorSpace, bitmapInfo, effectedDataProvider, 
                                   NULL, shouldInterpolate, intent);
   effectedImage = [UIImage imageWithCGImage:effectedCgImage];
   iv.image = effectedImage;
*/
   
   unsigned char *aimg = aa_image(aa_ctxt);
   int aiw = aa_imgwidth(aa_ctxt);
   int aih = aa_imgheight(aa_ctxt);
   memcpy(aimg, src, aiw*aih);
   aa_fastrender (aa_ctxt, 0, 0, aiw, aih);
   aa_flush(aa_ctxt);
   fflush(fp);
   fclose(fp);
   
   NSString *aa_str = [NSString stringWithContentsOfFile:filename encoding:NSASCIIStringEncoding error:nil];
   
   AATextView *atv = [[AATextView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
   atv.backgroundColor = [UIColor whiteColor];
   atv.opaque = YES;
   atv.buf = [aa_str retain];
   [self.view addSubview:atv];
   [atv release];
}

- (void)dealloc {
    [super dealloc];
}

@end
