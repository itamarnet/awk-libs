#!/usr/bin/awk -f

# actual shuffle function
# shuffles the values in "array" in-place, from indices "left" to "right".
# required for all of the shuf() functions below
function __shuffle(array, left, right,    r, i, tmp) {
  # loop backwards over the elements
  for (i=right; i>left; i--) {
    # generate a random number between the start and current element
    r = int(rand() * (i - left + 1)) + left;

    # swap current element and randomly generated one
    tmp = array[i];
    array[i] = array[r];
    array[r] = tmp;
  }
}



## usage: shuf(s, d)
## shuffles the array "s", creating a new shuffled array "d" indexed with
## sequential integers starting with one. returns the length, or -1 if an error
## occurs. leaves the indices of the source array "s" unchanged. uses the knuth-
## fisher-yates algorithm. requires the __shuffle() function.
function shuf(array, out,    count, i) {
  # loop over each index, and generate a new array with the same values and
  # sequential indices
  count = 0;
  for (i in array) {
    out[++count] = array[i];
  }

  # seed the random number generator
  srand();

  # actually shuffle
  __shuffle(out, 1, count);

  # return the length
  return count;
}

## usage: ishuf(s)
## the behavior is the same as that of shuf(), except the array "s" is sorted
## in-place. the original indices are destroyed and replaced with sequential
## integers. everything else is described in shuf() above.
function ishuf(array,    tmp, count, i) {
  # loop over each index, and generate a new array with the same values and
  # sequential indices
  count = 0;
  for (i in array) {
    tmp[++count] = array[i];
    delete array[i];
  }

  # copy tmp back over array
  for (i=1; i<=count; i++) {
    array[i] = tmp[i];
    delete tmp[i];
  }

  # seed the random number generator
  srand();

  # actually shuffle
  __shuffle(array, 1, count);

  # return the length
  return count;
}

## usage: shufi(s, d)
## the bevavior is the same as that of shuf(), except that the array indices
## are shuffled, not the array values. when done, the new array is indexed
## numerically, and the values are those of the original indices. everything
## else is described in shuf() above.
function shufi(array, out,    count, i) {
  # loop over each index, and generate a new array with the original indices
  # mapped to new numeric ones
  count = 0;
  for (i in array) {
    out[++count] = i;
  }

  # seed the random number generator
  srand();

  # actually shuffle
  __shuffle(out, 1, count);

  # return the length
  return count;
}

## usage: ishufi(s)
## the behavior is tha same as that of shufi(), except that the array "s" is
## sorted in-place. the original indices are destroyed and replaced with
## sequential integers. everything else is describmed in shuf() and shufi()
## above.
function ishufi(array,    tmp, count, i) {
  # loop over each index, and generate a new array with the original indices
  # mapped to new numeric ones
  count = 0;
  for (i in array) {
    tmp[++count] = i;
    delete array[i];
  }

  # copy tmp back over the original array
  for (i=1; i<=count; i++) {
    array[i] = tmp[i];
    delete tmp[i];
  }

  # seed the random number generator
  srand();

  # actually shuffle
  __shuffle(array, 1, count);

  # return the length
  return count;
}



# Copyright Daniel Mills <dm@e36freak.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
