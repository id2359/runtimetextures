Runtime Textures
----------------

Textures dont have to be loaded from file, they can be created at runtime. All the effects on Corel and photoshop are created at runtime, so why not create you textures that way.

This program does exactly that. A really good thing about creating your textures at runtime is that you end up with a small application at the end of the day.

- The Fractals change every second simply be redrawing to the texture area in memory.
- User "M" to switch between the Animating IFS Fractals and a mandelbrot.
- By pressing "C" you can now copy the pixel data from the one texture into the other texture and then draw over that image.

At first it might not sound that great, but it allows you to change the way a texture looks. eg. You can emboss a texture (code in the demo). I know that you can also do it using some OpenGL techniques, but you would then have to make that call every time the scene gets redrawn. This way it happens only once. 


Still think you cant do much with it ? Have a look at fr-08 
(URL = http://www.theproduct.de)
Its a 64KB demo with music that creates all of its textures at runtime. Excellent demo and definitely worth the download.

Keys :
 - "M" : Switch between Mandelbrot and IFS Fractals
 - "C" : Enable copying of textures

If you have any queries or bug reports, please mail me

Code : Jan Horn
Mail : jhorn@global.co.za
Web  : http://www.sulaco.co.za
       http://home.global.co.za/~jhorn

