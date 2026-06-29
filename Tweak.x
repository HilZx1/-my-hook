#import <dlfcn.h>
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GKLocalPlayer (PrivateGameCenterHook)
- (void)cancelAuthentication;
@end

%hook GKLocalPlayer

- (void)setAuthStartTimeStamp:(double)timestamp {
    // 1. Let the original method safely execute first
    %orig(timestamp);
    
    // 2. Dispatch the cancellation to the next run loop cycle.
    // This prevents recursive infinite loops and allows Game Center to initialize.
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            if ([self respondsToSelector:@selector(cancelAuthentication)]) {
                [self cancelAuthentication];
            }
        } @catch (NSException *exception) {
            NSLog(@"[GameCenterHook] Failed to cancel auth: %@", exception);
        }
    });
}

%end

// Missing %ctor block removed so Logos handles initialization automatically.
