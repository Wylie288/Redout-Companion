///string_sub(string, start, end)
var _string = argument0
var _start = argument1
var _end = argument2
var _length
var _subString

_length = string_length(_string)
_count = _end - _start + 1
_subString = string_copy(_string, _start, _count)

return _subString
