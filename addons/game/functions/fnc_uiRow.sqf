#include "..\script_component.hpp"
/*
 * Author: Bragg
 * One "LABEL ........ value" line of structured text, with an optional icon before the label.
 *
 * Arguments:
 * 0: Label <STRING>
 * 1: Value <STRING|NUMBER>
 * 2: Value color <STRING> (default: HTML_TEXT)
 * 3: Value size <NUMBER> (default: 1)
 * 4: Icon <STRING> (default: "")
 *
 * Return Value:
 * Structured text <STRING>
 */
params ["_label", "_value", ["_color", HTML_TEXT], ["_size", 1], ["_icon", ""]];

format [
    "<t align='left' size='0.72' color='%1' valign='middle'>%6%2</t><t align='right' font='PuristaBold' size='%3' color='%4'>%5</t>",
    HTML_MUTED, toUpper _label, _size, _color, _value,
    ["", format ["<img image='%1' size='1.15'/> ", _icon]] select (_icon != "")
]
