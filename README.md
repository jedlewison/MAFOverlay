MAFOverlay
==========

MAFOverlay brings popover-style overlay presentations to iPhone and iPad on iOS 7+.

* MAFOverlay presents view controllers as overlays
* Default setup should work for most cases—simply create a coordinator object for the presented view controller
* Handles iOS 7 rotation—simply let the coordinator know about willanimaterotation events
* Works well with MAFOptionActionController for customizable ActionSheet style presentations
* Supports a subset of popover features, including presenting from Bar Button or View
* Supports Cross Dissolve and Cover Vertical transitions, but is customizable
* Uses UIKit's custom modal presentation API
* Provides grain control over animation and layout through layout attributes object and datasource
