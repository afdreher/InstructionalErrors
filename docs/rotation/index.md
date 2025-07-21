---
layout: article
title: Rotation
nav_order: 2
permalink: /rotation/
has_toc: false
author: Andrew F. Dreher
published: July 21, 2025
---

**Be a yardstick of quality. Some people aren't used to an environment where excellence is expected.**  
-- Steve Jobs


Anything Apple-related has to start with Steve Jobs. I think it's a rule or something. I believe that attention to detail in the UI is a critical part of being that yardstick of quality.  

I've long been fascinated by user interfaces and human perception because it's the layer at which the magic occurs. Advanced but inaccessible technology is… well… *unusable technology*. And that's part of why I love mobile technology so much: it is simultaneously ubiquitous and personal, able to be a personal guide, entertainment on long journeys, and connections across cultures.

Crafting enchanting experiences brings innovation to the mass market in a way few other platforms can. So, what happens, though, when that spell breaks? It results in disappointment at the very least.

Although this may be a quixotic folly and I just tilting at windmills, one of my signals of quality is how applications handle rotations, which can generally be succinctly summarized: *poorly*. Rotations are perhaps the fairy-tale stepchildren of the UI world: they're needy and often ignored, but if handled correctly, they grow into a thing of beauty.

They are among my favorite ways of breaking the user experience, and these issues of this variety often escape in the wild. It's frustrating because it is an overlooked but important part of user engagement. Here, I'd like to provide some instances and ideas on how designers and developers can, together, recover that magic — all at very reasonable costs.

Because I spend most of my time on iOS, this article will discuss iOS idioms and API. However, it is relevant for any mobile platform.  

I want to be clear that all of the examples shown here are simply representatives of problems I've found in live production apps. I am not trying to single out these companies, and I have no insider information.

With that in mind, let's start exploring some errors.

There are two main errors I want to currently focus on with regard to rotation:

1. [Maps](maps) This is a fascinating study in design choices and possible 
workarounds for SDK glitches
2. [Layer Separation](layers) A common issue with rotation is that apps incorrectly
handle the layers and layout changes upon rotation.