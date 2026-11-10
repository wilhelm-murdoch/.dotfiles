// wilhelm.codes grain, a Ghostty custom shader
//
// The site lays one hairline of --text over the page at 1.5%, every three
// CSS pixels. This shader does the same over the terminal. A tint of the
// text colour cannot change the text, so it textures the ground and leaves
// the words alone. See the grain section of assets/css/main.css.
//
// The shader works in device pixels. A Retina display draws one CSS pixel
// as two device pixels, so PERIOD and LINE are doubled. Halve both on a
// display with no scaling.
//
// Install: copy this file to ~/.config/ghostty/shaders/ and add
//   custom-shader = /Users/<you>/.config/ghostty/shaders/wilhelm-codes-grain.glsl
// to the Ghostty config.

const float PERIOD = 6.0;   // three CSS pixels
const float LINE = 2.0;     // one CSS pixel
const float STRENGTH = 0.015; // --grain, 1.5% of --text
const vec3 TEXT = vec3(0.8902, 0.8902, 0.8706); // --text #e3e3de

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 color = texture(iChannel0, uv);

    float row = mod(floor(fragCoord.y), PERIOD);
    float onLine = row < LINE ? 1.0 : 0.0;

    color.rgb = mix(color.rgb, TEXT, STRENGTH * onLine);
    fragColor = color;
}
