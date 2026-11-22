#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Gives a control its explanation, the same way everywhere:
 *   - a tooltip "TITLE: text",
 *   - the same text for the analysis panel (shown when hovering pictures).
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Title ("" = none) <STRING>
 * 2: Text <STRING>
 * 3: Title color (html) <STRING> (default: HTML_AMBER)
 * 4: Highlighted extra line ("" = none) <STRING> (default: "")
 *
 * Return Value:
 * None
 */
params ["_ctrl", "_title", "_text", ["_color", HTML_AMBER], ["_extra", ""]];

private _tooltip = if (_title == "") then {_text} else {format ["%1 : %2", toUpper _title, _text]};
if (_extra != "") then {_tooltip = _tooltip + " " + _extra};
_ctrl ctrlSetTooltip _tooltip;

private _help = format ["<t size='0.64' color='%1'>%2</t>", HTML_TEXT, _text];
if (_title != "") then {
    _help = format ["<t size='0.78' font='PuristaBold' color='%1'>%2</t><br/>", _color, toUpper _title] + _help;
};
if (_extra != "") then {
    _help = _help + format ["<br/><t size='0.62' color='%1'>%2</t>", HTML_AMBER, _extra];
};
_ctrl setVariable [QGVAR(help), _help];
