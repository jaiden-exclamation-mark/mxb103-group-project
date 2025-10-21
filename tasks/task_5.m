% Include function files in parent directory.
addpath('..');

function updated = push(value, buffer)
% PUSH  Pushes a value onto the end of a buffer and removes the first element.
%
% Arguments
%   value - The value to push to the end of the buffer.
%   buffer - An array meant to act like a fixed-length buffer.
% Returns
%   updated - An array with all of the contents of `buffer` from the second element to the end, with `value` as the last element.
    updated = buffer;
    len = length(buffer);
    updated(1:len - 1) = updated(2:len);
    updated(len) = value;
end

function p = point(x, y)
    p.x = x;
    p.y = y;
end


origin = point(0, 0);
% Task states that four points around H-D must be selected, so create buffer of length 4.
points_buffer = [origin, origin, origin, origin];

% TODO: use task_4's numerical integration to get a set of points to interpolate for the question.