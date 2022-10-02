#import "GPlacesPlugin.h"
#if __has_include(<gplaces/gplaces-Swift.h>)
#import <gplaces/gplaces-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gplaces-Swift.h"
#endif

@implementation GPlacesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGPlacesPlugin registerWithRegistrar:registrar];
}
@end
