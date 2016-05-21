/******************************************************************************/
/*
 File:   Vertex.vert
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/03
 
 This is my only vertext shader for the game.  Since it is a simple 2D game
 all it does is transform the verts and send the texture color.
 */
/******************************************************************************/
//vertex attributes (obviously) change per vertex
attribute vec4 position;  //vertext postion
attribute vec2 texCoord;  //vertext color

//varying values get passed to frag shader
varying vec4   colorOut;    //Color to send to frag shader
varying vec2   texCoordOut; //texture coord to send to frag shader

//Uniforms don't change per vetex
uniform mat4   MVPMatrix;   //ModelViewProjection matrix
uniform vec4   color;       //color applied to the fragment
uniform vec4   texTrans;    //How to scale the texture coord

void main()
{
  //build my texture matrix (should do this on CPU)
  vec3 col1   = vec3(texTrans.x, 0, 0);
  vec3 col2   = vec3(0, texTrans.y, 0);
  vec3 col3   = vec3(texTrans.z, texTrans.w, 0);
  mat3 texMtx = mat3(col1, col2, col3);
  
  //calculate color and texCoord to send to frag shader
  texCoordOut = (texMtx * vec3(texCoord, 1)).xy;
  texCoordOut = texCoord.xy;
  colorOut    = color;
  //set position
  gl_Position =    MVPMatrix * position;
}
