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
//Varying values are sent from vert shader
varying lowp vec4    colorOut;
varying mediump vec2 texCoordOut;
//uniforms don't change per fragment
uniform sampler2D    sampler;

void main()
{
  gl_FragColor = texture2D(sampler, texCoordOut) * colorOut;
}