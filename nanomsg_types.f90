module nanomsg_types
    use iso_c_binding
    
    type, bind(c) :: nn_iovec
        type(c_ptr) :: iov_base
        integer(c_size_t) :: iov_len
    end type nn_iovec
    
    type, bind(c) :: nn_msghdr
        type(nn_iovec) :: msg_iov
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