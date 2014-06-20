nanofort
========

Fortran bindings for the [nanomsg] (http://nanomsg.org) sockets library.

Requires Fortran 2003 and the iso_c_binding module.


Installation
------------

	1. Copy the nanomsg*.f90 files to your source directory
	2. Download the latest version of nanomsg and compile it for your system
	3. Include the compiled nanomsg library (nanomsg.lib) in your project
	4. Copy the nanomsg.dll to your binary directory.  Your program will need it to run.


Usage
-----

To use in a Fortran 2003 program, put this at the top of your program:

```Fortran
use iso_c_binding
use nanomsg
```

Because this uses iso_c_binding, the function calls are as similar to the C calls as possible.  As such, you'll need to declare C type variables (exempli gratia: _integer(c_int)_, _type(c_ptr)_).  To use Fortran type variables with C pointers, you'll have to use the _c_loc()_ function.
