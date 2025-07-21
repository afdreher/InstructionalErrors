---
layout: article
title: Layer Separation
permalink: /rotation/layers
parent: Rotation
nav_order: 4
author: Andrew F. Dreher
published: July 21, 2025
---

## Layer Separation

I mentioned [previously](/rotation/) that rotation is one of my favorite ways of breaking the user experience on mobile. These errors are easy to miss in production in part because they are transitory. Designers provide developers with the endpoints, such as a portrait and a landscape layout, and occasionally describe what needs to happen in between (obviously, some are much better at this than others). It is easy to verify that both endpoints are satisfied, especially with automated testing; however, the in-between animation is often a different story.

Unfortunately, at least for me, the magic of mobile and of iOS, in particular, is that fluid and interactive experience. 


### Case Study: Netflix

I want to premise that this is a harmless error, but it is an example of this error category. The code reproducing the error and possible corrections are available as the rotation demo in the [InstructionalErrors] repository.

What is this error? Upon launching the iOS application, users are greeted with a static “N” logo, which subsequently animates to reveal the full “Netflix” branding before transitioning to the main menu screen. Yet, a fun glitch occurs when an iPad is rotated immediately after launch (see [Figure 1](#figure-1), below).

<a id='figure-1'></a>
![netflix-launch-split-portrait](/assets/images/layers/netflix_01_small.jpg "Launching the Netflix app in protrait") ![netflix-launch-split-rotating](/assets/images/layers/netflix_02_small.jpg "Netflix app mid rotation") ![netflix-launch-split-landscape](/assets/images/layers/netflix_03_small.jpg "Netflix app demonstrating the split layer issue")

{: .image-caption}
  Figure 1. Example frames taken from the Netflix iOS application for iPad captured in late August 2024. This glitch, while not new, persists in the latest version, 16.51.0 (20).

When the iPad is rotated, the static “N” and dynamic “Netflix” split apart, exposing not only that they are rendered as separate layers but also that the positioning calculations are distinctly different. This visual separation disrupts the seamless transition from the “N” to “Netflix.” While the static “N” is correctly centered on the screen, the dynamic animation for “Netflix” appears misaligned. Given the non-square dimensions of the iPad screen (3:4 for the full-sized model and 3:2 for the mini), this suggests that the dynamic logo’s position is calculated when the view is first loaded, whereas the static logo’s position is correctly updated during the subview layout.


### Case Study: Claude

Anthropic’s Claude app has a slew of inconsistencies and UX glitches -- enough for a decent case study. This might be considered somewhat ironic given the push for automated coding, but for now, I will focus solely on one due to rotation.

<a id='figure-2'></a>
![claude-rotation-start](/assets/images/layers/claude_01_small.jpg "Claude starting from the landscape orientation") ![claude-rotation-step-2](/assets/images/layers/claude_02_small.jpg "Claude showing an issue with the sheet size") ![claude-rotation-step-3](/assets/images/layers/claude_03_small.jpg "Claude showing the wrong layer order") ![claude-rotation-step-4](/assets/images/layers/claude_04_small.jpg "Claude showing the avatar out of step with the welcome text") ![claude-rotation-end-portrait](/assets/images/layers/claude_05_small.jpg "Claude finishing the rotation where the layers are still separated")

{: .image-caption}
Figure 2. Example frames taken in February 2025 while rotating the Claude app [1.250127.0 (12938027910)] from landscape to portrait

[Figure 2](#figure-2) displays an error similar to that shown in [Figure 1](#figure-1), except that the flaws are even deeper because the individual view components are poorly contained. To clarify, many things are going awry here -- having the keyboard show exacerbates the issues.

The forced redraw causes three issues:

1. Because the hero avatar is laid out independently from the welcome label, the avatar makes a U-shaped path starting in the upper left of the landscape layout, sliding toward the center, and finally sliding up to the top center of the portrait layout. This is not the expected direction. The avatar should enter horizontally centered from below the input sheet at the bottom of the screen, just above, and simultaneously with, the welcome label. 

2. The welcome label makes a brief “peek-a-boo” appearance in the lower center before the sliding animation. This type of flash glitch is typically distracting. 

3. The user input sheet is completely redrawn rather than animated smoothly in its new position.



### Experiment: Vibe Coding with LLMs

One cannot expect to be taken seriously these days without mentioning AI / LLM technology, so consider that done. :heavy_check_mark:


{: .caveat }
> This is a very cursory look and does not represent any systematic investigation into code generation quality. The curious can find many better benchmarks. Nonetheless, given how often rotation causes issues for presumably sophisticated developers, I was curious how different language models would handle them.

I chose three cloud providers (Anthropic, Google, Microsoft, and SambaNova) as well as one local instance of Llama. It is undoubtedly unfair to pit the Llama 8B small language model (SLM) model against the online providers (LLM). Still, it’s interesting because running it locally can allow one to potentially ask the language model for help without potentially releasing secrets to a cloud provider, providing developers with an attractive entry.

{: .prompt}
> Please create a UIView and associated UIViewController for iOS to serve as a splash screen that has two subviews, representing a “static” and a “dynamic” logo. These subviews should be centered inside the primary view and the z-index of the static logo view above that of the dynamic one. When the view finishes appearing on the screen, the dynamic logo view should slowly (e.g., 2 seconds) fade into view. Because the art department has not yet completed the real assets, please represent the static logo as a red rectangle of size 250 pixels wide by 350 pixels tall, and the dynamic logo as an orange rectangle of size 380 pixels wide and 350 pixels tall.

Note that the prompt is *purposefully ambiguous* and omits some details (e.g., not specifying the use of constraints or the background color for the main view). It also eschews hinting about rotation awareness. These omissions are to test the ability of the LLMs to generate code from incompletely specified prompts.

#### Repository

These examples can be built using the targets:

1. LLM-Claude (Anthropic)
2. LLM-Copilot (Microsoft)
3. LLM-Gemini (Google)
4. LLM-Llama8B (Meta / Ollama)
5. LLM-Llama405B (Meta / SambaNova)

#### Results

| Model         | Compiles?          | Correct?           | Constraint-Based?  | UIView + VC?       |
| ------------- | ------------------ | ------------------ | ------------------ | ------------------ |
| Claude        | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x:                |
| Copilot (Feb) | :heavy_check_mark: | :x:                | :x:                | :heavy_check_mark: |
| Copilot (Mar) | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x:                |
| Gemini        | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x:                |
| Llama 8B      | :x:                | :x:                | :x:                | :x:                |
| Llama 405B    | :heavy_check_mark: | :x:                | :heavy_check_mark: | :x:                |



#### Correctness

Both Anthropic and Google generated code that utilized NSLayoutConstraints and behaved as expected. I would hand the nod to Google’s code generation, though, because, for me, stylistically, I like having the `translatesAutoresizingMask = NO` close to where the new constraints are added.

#### Stylistic concerns
Of the remaining two, of course, the Llama model made more errors, inventing code that isn’t part of the language / API. Nonetheless, it does have some positives over the other alternatives, such as breaking the constants out of the code. 

Both the Llama 8B and the Microsoft Copilot models generated code that did not have the views in the correct paint order. However, once corrected, they might be passed as acceptable. Yet, if one rotates the view, one can see that the layers split, similar to that in the Netflix example.

For all of these examples, extra technical documentation and full code examples are provided on my GitHub page as the rotation demo in the [InstructionalErrors] repository.

----

[my GitHub page]: https://github.com/afdreher/
[InstructionalErrors]: https://github.com/afdreher/InstructionalErrors/