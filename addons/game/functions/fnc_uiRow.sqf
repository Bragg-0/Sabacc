#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Formats one "LABEL ........ value" line for a structured text.
 *
 * Arguments:
 * 0: Label <STRING>
 * 1: Value <STRING or NUMBER>
 * 2: Value color (html) <STRING> (default: HTML_TEXT)
 * 3: Value size <NUMBER> (default: 1)
 *
 * Return Value:
 * Structured text <STRING>
 */
params ["_label", "_value", ["_color", HTML_TEXT], ["_size", 1]];

format [
    "<t align='left' size='0.72' color='%1' valign='middle'>%2</t><t align='right' font='PuristaBold' size='%3' color='%4'>%5</t>",
    HTML_MUTED, toUpper _label, _size, _color, _value
]
