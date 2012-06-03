//
//  UIImageCVMatConverter.m
//  OpenCViPhoneApplication1
//



#import "UIImageCVMatConverter.h"


@implementation UIImageCVMatConverter

+(UIImage *)UIImageFromCVMat:(const cv::Mat&)cvImage{
    int width = cvImage.cols;
    int height = cvImage.rows;
    int numChannels = cvImage.channels();
    uchar* data = cvImage.data;
    int step = cvImage.step;
    //Bytes Per Pixel
    int bitsPerPixel = (numChannels == 1) ? 1 : 4;
    
    // Write the data into a bitmap context
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    uchar* bitmapData = NULL;
    if( bitsPerPixel == 1 ) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    }
    else if( bitsPerPixel == 4 ) {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    bitmapData = (uchar*)malloc( bitsPerPixel * height * width );
    
    context = CGBitmapContextCreate( bitmapData,
                                    width,
                                    height,
                                    8,
                                    bitsPerPixel * width,
                                    colorSpace,
                                    (bitsPerPixel == 1) ? kCGImageAlphaNone :
                                    kCGImageAlphaNoneSkipLast );
    CGColorSpaceRelease( colorSpace );
    
    // Copy pixel information from data into bitmapData
    if (bitsPerPixel == 4)
    {
        int bitmapIndex = 0;
		uchar*  base  = data;
        
		for (int y = 0; y < height; y++)
		{
			const uchar * line = base + y * step;
            
		    for (int x = 0; x < width; x++)
		    {
				// Blue channel
                bitmapData[bitmapIndex + 2] = line[0];
				// Green channel
				bitmapData[bitmapIndex + 1] = line[1];
				// Red channel
				bitmapData[bitmapIndex + 0] = line[2];
                
				line        += 3;
				bitmapIndex += bitsPerPixel;
			}
		}
    }
    else if (bitsPerPixel == 1)
    {
		for (int y = 0; y < height; y++)
			memcpy (bitmapData + y * width, data + y * step, width);
    }
    
    // bitmap context into an imageRef
    CGImageRef imageRef = CGBitmapContextCreateImage( context );
    CGContextRelease( context );    
    UIImage* image = [[UIImage alloc] initWithCGImage:imageRef];
    
    CGImageRelease( imageRef );
    free( bitmapData );
    return [image autorelease];  
}


@end
