# Pixel Vision 8 - Terminal

Pixel Vision 8's core philosophy is to teach retro game development with streamlined workflows. This project shows off how to create a simple text adventure game using Lua and Pixel Vision 8.

## Quick Start Guide

I've tried my best to make compiling, testing, and packaging as easy as possible. While you can learn more about this in the [docs](https://github.com/PixelVision8/PixelVision8/wik), here is the quickest way to build this game:

> Before you get started, you are going to want to install [.Net 6](https://dotnet.microsoft.com/download/dotnet/6.0), [NodeJS](https://nodejs.org/en/download/), and an IDE like [Visual Studio Code](https://code.visualstudio.com/Download).

1. Install the NodeJS dependencies `> npm install`
2. Install gulp globally `> npm install gulp -g`
1. Run the default Gulp action `> gulp`
2. Launch the `.dll` manually `dotnet App/bin/Debug/Terminal.dll`

If you want to build executables, you can use the Gulp action `> gulp package`. This will create a new `Releases/Final/` folder, and inside, you'll zip files for Windows, Mac, and Linux.

Finally, you can use Visual Studio Code to debug a build by running one of the custom tasks included in the `.vscode` folder.

## Credits

Pixel Vision 8 was created by Jesse Freeman ([@jessefreeman](http://twitter.com/jessefreeman)) in collaboration with Christina-Antoinette Neofotistou ([@CastPixel](http://twitter.com/CastPixel)) for art, and Christer Kaitila ([@McFunkypants](http://twitter.com/McFunkypants)) for music. 

With additional contributions by the following people:

* Pedro Medeiros
* Shawn Rakowski
* Drake Williams
* Matt Hughson
* Dean Ellis

And special thanks to Jan Rochat, Ethan Shaughnessy, and our other sponsors.

## License

Pixel Vision 8 is Licensed under the [Microsoft Public License (MS-PL) License](https://opensource.org/licenses/MS-PL). See the [LICENSE file](https://github.com/PixelVision8/PixelVision8/blob/master/LICENSE.txt) in the project root for complete license information.

Pixel Vision 8 is Copyright (c) 2017-2021 Jesse Freeman. All rights reserved.