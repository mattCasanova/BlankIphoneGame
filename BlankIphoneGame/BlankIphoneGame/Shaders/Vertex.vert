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
attribute vec4 position;
attribute vec3 normal;

varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    vec4 diffuseColor = vec4(0.4, 0.4, 1.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    colorVarying = diffuseColor * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
}
