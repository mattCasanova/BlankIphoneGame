/******************************************************************************/
/*
 File:   Fragment.frag
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/03
 
 This is my only fragment shader for the game. Since it is just a simple 2D game
 all it does is set the texture color.
 */
/******************************************************************************/
varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
