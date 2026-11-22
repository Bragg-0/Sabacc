#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Formats a panel title: "// TITLE" on the left, optional text on the right.
 *
 * Arguments:
 * 0: Title <STRING>
 * 1: Right text (structured) <STRING> (default: "")
 *
 * Return Value:
 * Structured text <STRING>
 */
params ["_title", ["_right", ""]];

format [
    "<t align='left' font='PuristaSemibold' size='0.8' color='%1'><t color='%2'>// </t>%3</t><t align='right' size='0.75'>%4</t>",
    HTML_HOLO, HTML_DIM, toUpper _title, _right
]
