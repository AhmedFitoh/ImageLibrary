//
//  SaveToPhotosManager.m
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//


#import <Photos/Photos.h>
#import "SaveToPhotosManager.h"
#import <ImageLibrary-Swift.h>

@implementation SaveToPhotosManager
- (void)addToPhotoToCameraRoll:(NSString *)localizedTitle withAlbumName:(NSString*)albumName withImage:(UIImage *)image completionHandler:(SavePhotoCompletionHandler)completionHandler
{
    if (!localizedTitle || !localizedTitle.length || !image || !image.size.width || !image.size.height) {
        //    [Logger updateTextFieldWithMessage:@"Couldn't save photo"];
        
        return;
    }
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            completionHandler(NO, nil);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            PHAssetCollection *collection = [self fetchAssetCollection:albumName];
            
            if (!collection) {
                completionHandler(NO, nil);
                return;
            }
            NSError *error = nil;
            __block PHObjectPlaceholder *createdAsset = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
            } error:&error];
            if (error || !createdAsset) {
                completionHandler(NO, error);
                return;
            }
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                if ([collection canPerformEditOperation:PHCollectionEditOperationAddContent]) {
                    [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection] addAssets:@[createdAsset]];
                }
                
            } error:&error];
            if (error) {
                completionHandler(NO, error);
            } else {
                completionHandler(YES, error);
            }
        });
    }];
}

- (PHAssetCollection *) fetchAssetCollection:(NSString *)localizedTitle
{
    
    if (!localizedTitle || !localizedTitle.length) {
        return nil;
    }
    PHFetchResult<PHAssetCollection *> *fetchAssetCollectionsResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in fetchAssetCollectionsResult) {
        if ([collection.localizedTitle isEqualToString:localizedTitle]) {
            return collection;
        }
    }
    
    __block NSString *collectionID = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:localizedTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error || !collectionID || !collectionID.length) {
        return nil;
    } else {
        PHAssetCollection *collection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionID] options:nil].lastObject;
        return collection;
    }
}

@end
