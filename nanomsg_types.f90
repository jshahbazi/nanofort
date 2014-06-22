module nanomsg_types
    !Fortran bindings for the nanomsg v0.4 sockets library (https://github.com/nanomsg/nanomsg)
    !"nanomsg" is licensed under MIT/X11 license and is a trademark of 250bpm s.r.o.
    !
    !nanofort bindings for nanomsg - MIT License (MIT)
    !See LICENSE file for more details    
    !Copyright (c) 2014 John N. Shahbazian
    !https://github.com/jshahbazi/nanofort
    
    use iso_c_binding
    
    type, bind(c) :: nn_iovec
        type(c_ptr) :: iov_base
        integer(c_size_t) :: iov_len
    end type nn_iovec
    
    type, bind(c) :: nn_msghdr
        type(c_ptr) :: msg_iov          !documentation says this is of type struct nn_iovec *, so
                                        !it needs to be a c_ptr that uses c_loc() to point to a 
                                        !type(nn_iovec) variable
        integer(c_int) :: msg_iovlen
        type(c_ptr) :: msg_control
        integer(c_size_t) :: msg_controllen
    end type nn_msghdr
    
    type, bind(c) :: nn_cmsghdr
        integer(c_size_t) :: cmsg_len
        integer(c_int) :: cmsg_level
        integer(c_int) :: cmsg_type
    end type nn_cmsghdr
    
    type, bind(c) :: nn_pollfd
        integer(c_int) :: fd
        integer(c_short) :: events
        integer(c_short) :: revents
    end type nn_pollfd
    
    type, bind(c) :: nn_symbol_properties
        integer(c_int) :: value
        type(c_ptr) :: name
        integer(c_int) :: ns
        integer(c_int) :: type
        integer(c_int) :: unit
    end type nn_symbol_properties
    
end module nanomsg_types