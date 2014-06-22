module nanomsg
    !Fortran bindings for the nanomsg v0.4 sockets library (https://github.com/nanomsg/nanomsg)
    !"nanomsg" is licensed under MIT/X11 license and is a trademark of 250bpm s.r.o.
    !
    !nanofort bindings for nanomsg - MIT License (MIT)
    !See LICENSE file for more details    
    !Copyright (c) 2014 John N. Shahbazian
    !https://github.com/jshahbazi/nanofort

    use nanomsg_enums 
    use nanomsg_types    
    
    interface
        !descriptions taken from http://nanomsg.org/v0.4/nanomsg.7.html
        
        !nn_socket - create an SP socket
        !
        !EXAMPLE
        !   integer(c_int) :: socket_num
        !   socket_num = nn_socket (AF_SP, NN_PAIR)
        !   !socket_num should be >= 0
        integer(c_int) function nn_socket(domain, protocol) bind(C,name="nn_socket")
            use iso_c_binding
            integer(c_int), value, intent(in) :: domain 
            integer(c_int), value, intent(in) :: protocol
        end function nn_socket
            
        !nn_close - close an SP socket
        !
        !EXAMPLE
        !   integer(c_int) :: socket_num, rc
        !   socket_num = nn_socket (AF_SP, NN_PAIR)
        !   rc = nn_close (socket_num);
        !   !rc should be equal to 0
        integer(c_int) function nn_close(s) bind(C,name="nn_close")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
        end function nn_close        
        
        !nn_setsockopt - set a socket option        
        !
        !EXAMPLE
        !    integer(c_int) :: socket_num, linger, rc
        !    type(c_ptr) :: linger_ptr
        !    linger = 1000
        !    linger_ptr = c_loc(linger)
        !    rc = nn_setsockopt (socket_num, NN_SOL_SOCKET, NN_LINGER, linger_ptr, sizeof(linger))
        !    !rc should be equal to 0        
        integer(c_int) function nn_setsockopt(s, level, option, optval, optvallen) bind(C,name="nn_setsockopt")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            integer(c_int), value, intent(in) :: level
            integer(c_int), value, intent(in) :: option
            type(c_ptr), value :: optval
            integer(c_size_t), value :: optvallen
        end function nn_setsockopt

        !nn_getsockopt - retrieve a socket option
        !
        !EXAMPLE        
        !    integer(c_int) :: socket_num, linger, rc
        !    type(c_ptr) :: linger_ptr
        !    linger_ptr = c_loc(linger)
        !    rc = nn_getsockopt (s, NN_SOL_SOCKET, NN_LINGER, linger_ptr, sizeof(linger))
        !    !rc should be equal to 0   
        integer(c_int) function nn_getsockopt(s, level, option, optval, optvallen) bind(C,name="nn_getsockopt")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            integer(c_int), value, intent(in) :: level
            integer(c_int), value, intent(in) :: option
            type(c_ptr), value :: optval
            integer(c_size_t), value :: optvallen
        end function nn_getsockopt        

        !nn_bind - add a local endpoint to the socket
        !
        !EXAMPLE        
        !   integer(c_int) :: socket_num, eid1, eid2     
        !   socket_num = nn_socket (AF_SP, NN_PUB);
        !   eid1 = nn_bind (socket_num, "inproc://test")
        !   eid2 = nn_bind (socket_num, "tcp://eth0:5560")        
        integer(c_int) function nn_bind(s, addr) bind(C,name="nn_bind")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            character(kind=c_char), dimension(*), intent(in) :: addr
        end function nn_bind
        
        !nn_connect - add a remote endpoint to the socket
        !
        !EXAMPLE        
        !   integer(c_int) :: socket_num, eid1, eid2     
        !   socket_num = nn_socket (AF_SP, NN_PUB);
        !   eid1 = nn_bind (socket_num, "ipc:///tmp/test.ipc")
        !   eid2 = nn_bind (socket_num, "tcp://server001:5560")         
        integer(c_int) function nn_connect(s, addr) bind(C,name="nn_connect")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            character(kind=c_char), dimension(*), intent(in) :: addr
        end function nn_connect
        
        !nn_shutdown - remove an endpoint from a socket
        !
        !EXAMPLE        
        !   integer(c_int) :: socket_num, eid1, rc     
        !   socket_num = nn_socket (AF_SP, NN_PUB)
        !   eid1 = nn_bind (socket_num, "inproc://test")
        !   rc = nn_shutdown(socket_num, eid1);        
        integer(c_int) function nn_shutdown(s, how) bind(C,name="nn_shutdown")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s
            integer(c_int), value, intent(in) :: how 
        end function nn_shutdown     
        
        !nn_send - send a message
        !
        !EXAMPLE        
        !   character(len=3) :: command
        !   integer(c_int) :: socket_num, nbytes    
        !   type(c_ptr) :: buffer_ptr
        !   socket_num = nn_socket (AF_SP, NN_PUB)
        !   command = 'ABC'
        !   buffer_ptr = c_loc(command)
        !   nbytes = nn_send(socket_num, buffer_ptr, sizeof(command), 0)
        integer(c_int) function nn_send(s, buf, len, flags) bind(C,name="nn_send")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            type(c_ptr), value :: buf
            integer(c_size_t), value :: len
            integer(c_int), value, intent(in) :: flags            
        end function nn_send         

        !nn_recv - receive a message
        !
        !EXAMPLE 
        !   character(len=3) :: command
        !   integer(c_int) :: nbytes    
        !   type(c_ptr) :: buffer_ptr
        !   buffer_ptr = c_loc(command)
        !   nbytes = nn_recv(socket_num, buffer_ptr, sizeof(command), 0)        
        integer(c_int) function nn_recv(s, buf, len, flags) bind(C,name="nn_recv")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            type(c_ptr), value :: buf
            integer(c_size_t), value :: len
            integer(c_int), value, intent(in) :: flags            
        end function nn_recv 
        
        !nn_sendmsg - fine-grained alternative to nn_send
        !
        !EXAMPLE   
        !   buffer_ptr = c_loc(datastuff)
        !   buffer_len = sizeof(datastuff)
        !   iovec.iov_base = buffer_ptr
        !   iovec.iov_len = buffer_len
        !   msghdr.msg_iov = c_loc(iovec)
        !   msghdr.msg_iovlen = sizeof(msghdr.msg_iov)
        !   msghdr.msg_control = C_NULL_PTR
        !   msghdr.msg_controllen = 0
        !   nbytes = nn_sendmsg(socket_num,msghdr,0)        
        integer(c_int) function nn_sendmsg(s, msghdr, flags) bind(C,name="nn_sendmsg")
            use iso_c_binding
            use nanomsg_types
            
            integer(c_int), value, intent(in) :: s
            type (nn_msghdr) :: msghdr
            integer(c_int), value, intent(in) :: flags
        end function nn_sendmsg
        
        !nn_recvmsg - fine-grained alternative to nn_recv
        !
        !EXAMPLE       
        !   nbytes = nn_recvmsg(socket_num,msghdr,0)
        integer(c_int) function nn_recvmsg(s, msghdr, flags) bind(C,name="nn_recvmsg ")
            use iso_c_binding
            use nanomsg_types
            
            integer(c_int), value, intent(in) :: s
            type (nn_msghdr) :: msghdr
            integer(c_int), value, intent(in) :: flags
        end function nn_recvmsg
        
        !nn_allocmsg - allocate a message
        !NOTE: this function requires the use of c_memcpy
        !
        !EXAMPLE  
        !   type(c_ptr) :: allocptr,buffer_ptr,memptr
        !   command = 'ABC'
        !   allocptr = nn_allocmsg(3,0)
        !   buffer_ptr = c_loc(command)
        !   memptr = c_memcpy(allocptr, buffer_ptr, 3)
        !   rc = nn_send(socket_num, allocptr, 3,0)
        !   ...
        !   rc = nn_freemsg(allocptr)
        type(c_ptr) function nn_allocmsg(size, type) bind(C,name="nn_allocmsg")
            use iso_c_binding
            integer(c_size_t), value :: size
            integer(c_int), value, intent(in) :: type
        end function nn_allocmsg
    
        !nn_reallocmsg - reallocate a message
        !
        !EXAMPLE    
        !   allocptr = nn_allocmsg(3,0)
        !   newbuf = nn_reallocmsg(allocptr,6)
        type(c_ptr) function nn_reallocmsg(msg, size) bind(C,name="nn_reallocmsg")
            use iso_c_binding
            type(c_ptr), value :: msg            
            integer(c_size_t), value :: size
        end function nn_reallocmsg    
    
        !nn_freemsg - deallocate a message
        !
        !EXAMPLE  
        !   allocptr = nn_allocmsg(3,0)
        !   ...
        !   rc = nn_freemsg(allocptr)    
        integer(c_int) function nn_freemsg(msg) bind(C,name="nn_freemsg")
            use iso_c_binding
            type(c_ptr), value :: msg
        end function nn_freemsg      
    
        !nn_cmsg - access control information
        !
        !EXAMPLE    
        type(c_ptr) function NN_CMSG_FIRSTHDR(hdr) bind(C,name="nn_cmsg_firsthdr")
            use iso_c_binding
            
            type(c_ptr) :: hdr
        end function NN_CMSG_FIRSTHDR
    
        !nn_cmsg - access control information
        !
        !refer to http://nanomsg.org/v0.4/nn_cmsg.3.html 
        type(c_ptr) function NN_CMSG_NXTHDR(hdr, cmsg) bind(C,name="nn_cmsg_nxthdr")
            use iso_c_binding
            
            type(c_ptr) :: hdr
            type(c_ptr) :: cmsg
        end function NN_CMSG_NXTHDR
 
        type(c_ptr) function NN_CMSG_DATA(cmsg) bind(C,name="nn_cmsg_data")
            use iso_c_binding
            
            type(c_ptr) :: cmsg
        end function NN_CMSG_DATA        
 
        integer(c_size_t) function NN_CMSG_SPACE(len) bind(C,name="nn_cmsg_space")
            use iso_c_binding
            
            integer(c_size_t), value :: len
        end function NN_CMSG_SPACE   
   
        integer(c_size_t) function NN_CMSG_LEN(len) bind(C,name="nn_cmsg_len")
            use iso_c_binding
            
            integer(c_size_t), value :: len
        end function NN_CMSG_LEN       

        !nn_poll - poll a set of SP sockets for readability and/or writability
        !
        !EXAMPLE   
        !   type(nn_pollfd) :: fds
        !   type(c_ptr) :: fdsptr
        !   socket_num = nn_socket(AF_SP,NN_PAIR)
        !   fds.fd = socket_num
        !   fds.events = NN_POLLOUT
        !   fdsptr = c_loc(fds)
        !   rc = nn_poll(fdsptr,sizeof(fds),10)
        integer(c_int) function nn_poll(fds, nfds, timeout) bind(C,name="nn_poll")
            use iso_c_binding
            use nanomsg_types
            
            type(c_ptr), value :: fds   !documentation says this is a struct nn_pollfd *fds, so
                                        !it needs to be a c_ptr that uses c_loc() to point to a 
                                        !type(nn_pollfd) variable
            integer(c_int), value, intent(in) :: nfds
            integer(c_int), value, intent(in) :: timeout
        end function nn_poll
    
        !nn_errno - retrieve the current errno
        !
        !EXAMPLE    
        !   integer(c_int) :: errno
        !   nbytes = nn_send(socket_num, buffer_ptr, sizeof(command), 0)
        !   errno = nn_errno()
        !   print *, 'nn_send failed with error code ', errno
        integer(c_int) function nn_errno() bind(C,name="nn_errno")
            use iso_c_binding

        end function nn_errno    
    
        !nn_strerror - convert an error number into human-readable string  
        !working on getting the return to work
        !
        !EXAMPLE    
        !   errornum = nn_errno()
        !   charptr = c_loc(errorstr)
        !   charptr = nn_strerror(errornum)
        !   call c_f_pointer(charptr,errptr)
        !   print *,'error: ',errptr    
        type(c_ptr) function nn_strerror(errnum) bind(C,name="nn_strerror")
            use iso_c_binding
            
            integer(c_int), value, intent(in) :: errnum
        end function nn_strerror  
    
    
        !!nn_symbol - query the names and values of nanomsg symbols 
        !!working on getting the return to work
        !!
        !!EXAMPLE    
        !  ! integer(c_int) :: i, value
        !  ! type(c_ptr) :: name_ptr, value_ptr
        !  !
        !  !character(len=30,kind=C_char) :: name
        !  !character(len=30),pointer :: cpter
        !  ! name_ptr = c_loc(name)
        !  ! value_ptr = c_loc(value)    
        !  ! i = 0
        !  ! name = "dummy"
        !  ! do while (c_associated(name_ptr))
        !  !     i = i + 1
        !  !     name_ptr = nn_symbol (i, value_ptr)
        !  !     call c_f_pointer(name_ptr,cpter)
        !  !     print *, i, '-',name_ptr,'***',cpter, '---', value
        !  ! end do   
        !
        !type(c_ptr) function nn_symbol(i, value) bind(C,name="nn_symbol")
        !    use iso_c_binding
        !    
        !    integer(c_int), value, intent(in) :: i
        !    type(c_ptr), value :: value
        !end function nn_symbol
    
    
        !nn_symbol_info - query the names and properties of nanomsg symbols
        !
        !EXAMPLE
        !   integer(c_int) :: i, rc
        !   type(nn_symbol_properties) :: sym
        !   sym_ptr = c_loc(sym)
        !   i = 0
        !   rc = 1
        !   do while (rc /= 0)
        !       i = i + 1
        !       rc = nn_symbol_info (i, sym, sizeof(sym))
        !       print *, sym%value
        !   end do
        integer(c_int) function nn_symbol_info(i, buf, buflen) bind(C,name="nn_symbol_info")
            use iso_c_binding
            use nanomsg_types

            integer(c_int), value, intent(in) :: i
            type(nn_symbol_properties) :: buf
            integer(c_int), value, intent(in) :: buflen
        end function nn_symbol_info
    
        !nn_device - start a device
        !
        !EXAMPLE 
        !   integer(c_int) :: socket_num1, socket_num2, eid1, eid2, rc
        !   socket_num1 = nn_socket (AF_SP_RAW, NN_REQ)
        !   eid1 = nn_bind (socket_num1, "tcp://eth0:5555")
        !   socket_num2 = nn_socket (AF_SP_RAW, NN_REP)
        !   eid2 = nn_bind (socket_num2, "tcp://eth0:5556")
        !   rc = nn_device (socket_num1, socket_num2)
        integer(c_int) function nn_device(s1, s2) bind(C,name="nn_device")
            use iso_c_binding

            integer(c_int), value, intent(in) :: s1
            integer(c_int), value, intent(in) :: s2
        end function nn_device    
    
        !nn_term - notify all sockets about process termination
        !
        !EXAMPLE    
        !   socket_num = nn_socket (AF_SP, NN_PAIR)
        !   nn_term ()
        function nn_term() bind(C,name="nn_term")
            use iso_c_binding

        end function nn_term
    
        !c_memcpy - same as the C function memcpy
        type(c_ptr) function c_memcpy(dest, src, n) bind(c,name="memcpy")
          use iso_c_binding
      
          type(c_ptr), value, intent(in) :: dest
          type(c_ptr), value, intent(in) :: src
          integer(c_size_t), value, intent(in) :: n
        end function c_memcpy 
    
    end interface
      
    
end module nanomsg