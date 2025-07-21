---
layout: article
title: Maps
permalink: /rotation/maps
parent: Rotation
nav_order: 3
author: Andrew F. Dreher
published: July 21, 2025
---

## Maps Rotation Issues

The maps apps from both Apple and Google provide a great starting point for discussing the design aspects of rotation.

Map apps are such an appealing case study because their primary purpose is to orient a user in some space. Abstractly, animations serve the same purpose. By smoothly transitioning the UI, we keep the user oriented in our app. Consequently, one might expect that maps apps apply this orientation concept ruthlessly. However, that would be incorrect.

### Case Study: Apple Maps

<a id='figure-1'></a> 
<video width="500" height="281" controls>
  <source src="/assets/images/maps/apple_maps_portrait_to_landscape_ferry_building.mp4" type="video/mp4">
</video>

{: .image-caption}
  Figure 1. Movie demonstrating the behavior of Apple Maps when rotating the device. The important part to watch is the last few frames where the map *snaps* to a new location. This behavior is seen regardless of the chosen basemap.

It is difficult to show in isolated frames, but the issue with the Apple Maps animation is that there is essentially a jump cut transition to the new map position at the end of the animation. As demonstrated in the [Example Code](#example-code), this is likely due to a glitch somewhere inside the class cluster supporting `MKMapView`. 


### Case Study: Google Maps

<a id='figure-2'></a> 
<video width="500" height="281" controls>
  <source src="/assets/images/maps/google_maps_portrait_to_landscape_ferry_building.mp4" type="video/mp4">
</video>

{: .image-caption}
  Figure 2. Movie demonstrating the behavior of Google Maps when rotating the device.

For the most part, the rotation is as one would expect. However, one can notice a momentary flash during the rotation. This flash occurs because the background color for the view hosting the map images is set to white and the map is resized / redrawn immediately when the rotation begins rather than either computing the maximum bounds or deferring the resize until the rotation completes. Two frames captured mid rotation ([Figure 3](#figure-3)) show the effect.

<a id='figure-3'></a>
![google-start-rotation](/assets/images/maps/google_start_rotation_small.jpg "Flash from white background mid rotation")![google-mid-rotation](/assets/images/maps/google_mid_rotation_small.jpg "Flash from white background mid rotation")

{: .image-caption}
Figure 3. Example frames captured mid rotation showing the white background and eager resizing of the map view.

In [Figure 3](#figure-3), notice in the left image that the white background is exposed below the search bar. Contrast this with the start of [Figure 2](#figure-2), where the imagery clearly extends below this bar. In the right image, notice that the card displaying information about the point of interest extends to the bottom edge of the screen on the left of the display, while on the right of the display, there is a large white region below the edge of the map imagery. Also, note that the imagery now extends below the search bar in contrast with that of the early part of the rotation in the left image.

The obvious fixes for the issue shown in [Figure 3](#figure-3) are:

1. Set the background of the containing view to black since this matches the system behavior for the background outside the rotating view and thus would be less noticeable, even though this does not account for the resize issue.

2. Resize the map to support the maximum necessary region for the rotation, allowing the window to clip the view. Perform the final resize upon the completion of the animation.


### Example Code

Example code is provided in the [InstructionalErrors] repository which demonstrates both the Google Maps style *sequential* animation as well as the proposed *simultaneous* animation, which moves the POI to the correct spot along with the rotation.

{: .warning }
> Do **not** use the *simultaneous* animation for production code. When `animationOrder = .simultaneous`, there is a glitch in MKMapView that will occasionally cause the zoom level to change abruptly when the device rotates from Portrait to Landscape. Interestingly, the change from Landscape to Portrait does not seem to be impacted.

Unfortunately, the post-rotation slide / refresh largely remains. One can certainly ask if this behavior is related to the point of interest (POI) selection. The answer is no.  Switching from profile to landscape, both apps place the previous center position, represented approximately by the POI in the right-hand side clear space. While Google Maps animates this transition, Apple Maps uses a hard redraw as seen in [Figure 1](#figure-1).

It is entirely possible to force the redraw during the rotation animation. However, the specifics of doing so are beyond the focus of this page since doing so requires a deep dive into the Core Animation framework.

From a technical standpoint, animating the UI on rotation, including the map, should be straightforward.  All that should be needed is to provide an implementation of `viewWillTransition(to:with:)`, make the required call to `super`, ensuring that all of the default animations take place, and then call `coordinator.animate(alongsideTransition:)`, optionally with a completion handler.


----

[my GitHub page]: https://github.com/afdreher/
[InstructionalErrors]: https://github.com/afdreher/InstructionalErrors/