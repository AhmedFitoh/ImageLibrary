//
//  SaveToPhotosManager.h
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//


#import <UIKit/UIKit.h>

typedef void (^SavePhotoCompletionHandler)(BOOL finish, NSError *error);

@interface SaveToPhotosManager : NSObject

- (void)addToPhotoToCameraRoll:(NSString *)localizedTitle withAlbumName:(NSString*)albumName withImage:(UIImage *)image completionHandler:(SavePhotoCompletionHandler)completionHandler;
@end
