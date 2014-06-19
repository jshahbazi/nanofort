module nanomsg

    
    interface
        !per http://nanomsg.org/v0.4/nanomsg.7.html
        
        !nn_socket - create an SP socket
        !DESCRIPTION
        !   Creates an SP socket with specified domain and protocol. Returns a file descriptor for the newly created socket.
        !
        !   Following domains are defined at the moment:
        !
        !    AF_SP
        !    Standard full-blown SP socket.
        !
        !    AF_SP_RAW
        !    Raw SP socket. Raw sockets omit the end-to-end functionality found in AF_SP sockets and thus can be used to implement intermediary devices in SP topologies.
        !    protocol parameter defines the type of the socket, which in turn determines the exact semantics of the socket. Check manual pages for individual SP protocols to get the list of available socket types.
        !    The newly created socket is initially not associated with any endpoints. In order to establish a message flow at least one endpoint has to be added to the socket using nn_bind(3) or nn_connect(3) function.
        !    Also note that type argument as found in standard socket(2) function is omitted from nn_socket. All the SP sockets are message-based and thus of SOCK_SEQPACKET type.
        !
        !RETURN VALUE
        !   If the function succeeds file descriptor of the new socket is returned. Otherwise, -1 is returned and errno is set to to one of the values defined below.
        !   Note that file descriptors returned by nn_socket function are not standard file descriptors and will exhibit undefined behaviour when used with system functions. Moreover, it may happen that a system file descriptor and file descriptor of an SP socket will incidentally collide (be equal).
        !
        !ERRORS
        !    EAFNOSUPPORT
        !    Specified address family is not supported.
        !
        !    EINVAL
        !    Unknown protocol.
        !
        !    EMFILE
        !    The limit on the total number of open SP sockets or OS limit for file descriptors has been reached.
        !
        !    ETERM
        !    The library is terminating.
        !
        !EXAMPLE
        !   int s = nn_socket (AF_SP, NN_PUB);
        !   assert (s >= 0);
        integer(c_int) function nn_socket(domain, protocol) bind(C,name="nn_socket")
            use iso_c_binding
            integer(c_int), value, intent(in) :: domain 
            integer(c_int), value, intent(in) :: protocol
        end function nn_socket
        
        
        
        !nn_close - close an SP socket
        !DESCRIPTION
        !    Closes the socket s. Any buffered inbound messages that were not yet received by the application will be discarded. The library will try to deliver any outstanding outbound messages for the time specified by NN_LINGER socket option. The call will block in the meantime.
        !
        !RETURN VALUE
        !    If the function succeeds zero is returned. Otherwise, -1 is returned and errno is set to to one of the values defined below.
        !
        !ERRORS
        !    EBADF
        !    The provided socket is invalid.
        !
        !    EINTR
        !    Operation was interrupted by a signal. The socket is not fully closed yet. Operation can be re-started by calling nn_close() again.
        !
        !EXAMPLE
        !    int s = nn_socket (AF_SP, NN_PUB);
        !    assert (s >= 0);
        !    int rc = nn_close (s);
        !    assert (rc == 0);
        integer(c_int) function nn_close(s) bind(C,name="nn_close")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
        end function nn_close        
        
        !nn_setsockopt - set a socket option        
        !DESCRIPTION
        !    Sets the value of the option. The level argument specifies the protocol level at which the option resides. For generic socket-level options use NN_SOL_SOCKET level. For socket-type-specific options use socket type for level argument (e.g. NN_SUB). For transport-specific options use ID of the transport as the level argument (e.g. NN_TCP).
        !
        !    The new value is pointed to by optval argument. Size of the option is specified by the optvallen argument.
        !
        !    <nanomsg/nn.h> header defines generic socket-level options (NN_SOL_SOCKET level). The options are as follows:
        !
        !    NN_LINGER
        !    Specifies how long should the socket try to send pending outbound messages after nn_close() have been called, in milliseconds. Negative value means infinite linger. The type of the option is int. Default value is 1000 (1 second).
        !
        !    NN_SNDBUF
        !    Size of the send buffer, in bytes. To prevent blocking for messages larger than the buffer, exactly one message may be buffered in addition to the data in the send buffer. The type of this option is int. Default value is 128kB.
        !
        !    NN_RCVBUF
        !    Size of the receive buffer, in bytes. To prevent blocking for messages larger than the buffer, exactly one message may be buffered in addition to the data in the receive buffer. The type of this option is int. Default value is 128kB.
        !
        !    NN_SNDTIMEO
        !    The timeout for send operation on the socket, in milliseconds. If message cannot be sent within the specified timeout, EAGAIN error is returned. Negative value means infinite timeout. The type of the option is int. Default value is -1.
        !
        !    NN_RCVTIMEO
        !    The timeout for recv operation on the socket, in milliseconds. If message cannot be received within the specified timeout, EAGAIN error is returned. Negative value means infinite timeout. The type of the option is int. Default value is -1.
        !
        !    NN_RECONNECT_IVL
        !    For connection-based transports such as TCP, this option specifies how long to wait, in milliseconds, when connection is broken before trying to re-establish it. Note that actual reconnect interval may be randomised to some extent to prevent severe reconnection storms. The type of the option is int. Default value is 100 (0.1 second).
        !
        !    NN_RECONNECT_IVL_MAX
        !    This option is to be used only in addition to NN_RECONNECT_IVL option. It specifies maximum reconnection interval. On each reconnect attempt, the previous interval is doubled until NN_RECONNECT_IVL_MAX is reached. Value of zero means that no exponential backoff is performed and reconnect interval is based only on NN_RECONNECT_IVL. If NN_RECONNECT_IVL_MAX is less than NN_RECONNECT_IVL, it is ignored. The type of the option is int. Default value is 0.
        !
        !    NN_SNDPRIO
        !    Sets outbound priority for endpoints subsequently added to the socket. This option has no effect on socket types that send messages to all the peers. However, if the socket type sends each message to a single peer (or a limited set of peers), peers with high priority take precedence over peers with low priority. The type of the option is int. Highest priority is 1, lowest priority is 16. Default value is 8.
        !
        !    NN_RCVPRIO
        !    Sets inbound priority for endpoints subsequently added to the socket. This option has no effect on socket types that are not able to receive messages. When receiving a message, messages from peer with higher priority are received before messages from peer with lower priority. The type of the option is int. Highest priority is 1, lowest priority is 16. Default value is 8.
        !
        !    NN_IPV4ONLY
        !    If set to 1, only IPv4 addresses are used. If set to 0, both IPv4 and IPv6 addresses are used. The type of the option is int. Default value is 1.
        !
        !    NN_SOCKET_NAME
        !    Socket name for error reporting and statistics. The type of the option is string. Default value is "socket.N" where N is socket integer. This option is experimental, see nn_env(7) for details
        !
        !RETURN VALUE
        !    If the function succeeds zero is returned. Otherwise, -1 is returned and errno is set to to one of the values defined below.
        !
        !ERRORS
        !    EBADF
        !    The provided socket is invalid.
        !
        !    ENOPROTOOPT
        !    The option is unknown at the level indicated.
        !
        !    EINVAL
        !    The specified option value is invalid.
        !
        !    ETERM
        !    The library is terminating.
        !
        !EXAMPLE
        !    int linger = 1000;
        !    nn_setsockopt (s, NN_SOL_SOCKET, NN_LINGER, &linger, sizeof (linger));
        !    nn_setsockopt (s, NN_SUB, NN_SUB_SUBSCRIBE, "ABC", 3);        
        integer(c_int) function nn_setsockopt(s, level, option, optval, optvallen) bind(C,name="nn_setsockopt")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            integer(c_int), value, intent(in) :: level
            integer(c_int), value, intent(in) :: option
            type(c_ptr), value :: optval
            integer(c_size_t), value :: optvallen
        end function nn_setsockopt

        !nn_getsockopt - retrieve a socket option
        integer(c_int) function nn_getsockopt(s, level, option, optval, optvallen) bind(C,name="nn_getsockopt")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            integer(c_int), value, intent(in) :: level
            integer(c_int), value, intent(in) :: option
            type(c_ptr), value :: optval
            integer(c_size_t), value :: optvallen
        end function nn_getsockopt        

        !nn_bind- add a local endpoint to the socket
        integer(c_int) function nn_bind(s, addr) bind(C,name="nn_bind")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            character(kind=c_char), dimension(*), intent(in) :: addr
        end function nn_bind
        
        !nn_connect - add a remote endpoint to the socket
        integer(c_int) function nn_connect(s, addr) bind(C,name="nn_connect")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            character(kind=c_char), dimension(*), intent(in) :: addr
        end function nn_connect
        
        !nn_shutdown - remove an endpoint from a socket
        integer(c_int) function nn_shutdown(s, how) bind(C,name="nn_shutdown")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s
            integer(c_int), value, intent(in) :: how 
        end function nn_shutdown     
        
        !nn_send - send a message
        integer(c_int) function nn_send(s, buf, len, flags) bind(C,name="nn_send")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            type(c_ptr), value :: buf
            integer(c_size_t), value :: len
            integer(c_int), value, intent(in) :: flags            
        end function nn_send         

        !nn_recv - receive a message
        integer(c_int) function nn_recv(s, buf, len, flags) bind(C,name="nn_recv")
            use iso_c_binding
            integer(c_int), value, intent(in) :: s 
            type(c_ptr), value :: buf
            integer(c_size_t), value :: len
            integer(c_int), value, intent(in) :: flags            
        end function nn_recv 
        
        !nn_sendmsg - fine-grained alternative to nn_send
        integer(c_int) function nn_sendmsg(s, msghdr, flags) bind(C,name="nn_sendmsg")
            use iso_c_binding
            use nanomsg_types
            
            integer(c_int), value, intent(in) :: s
            type (nn_msghdr) :: msghdr
            integer(c_int), value, intent(in) :: flags
        end function nn_sendmsg
        
        !nn_recvmsg - fine-grained alternative to nn_recv
        integer(c_int) function nn_recvmsg(s, msghdr, flags) bind(C,name="nn_recvmsg ")
            use iso_c_binding
            use nanomsg_types
            
            integer(c_int), value, intent(in) :: s
            type (nn_msghdr) :: msghdr
            integer(c_int), value, intent(in) :: flags
        end function nn_recvmsg
        
        !nn_allocmsg - allocate a message
        type(c_ptr) function nn_allocmsg(size, type) bind(C,name="nn_allocmsg")
            use iso_c_binding
            integer(c_size_t), value :: size
            integer(c_int), value, intent(in) :: type
        end function nn_allocmsg
    
        !nn_reallocmsg - reallocate a message
        type(c_ptr) function nn_reallocmsg(msg, size) bind(C,name="nn_reallocmsg")
            use iso_c_binding
            type(c_ptr), value :: msg            
            integer(c_size_t), value :: size
        end function nn_reallocmsg    
    
        !nn_freemsg - deallocate a message
        integer(c_int) function nn_freemsg(msg) bind(C,name="nn_freemsg")
            use iso_c_binding
            type(c_ptr), value :: msg
        end function nn_freemsg      
    
        !nn_cmsg - access control information
        type(nn_cmsghdr) function NN_CMSG_FIRSTHDR(hdr) bind(C,name="nn_cmsg_firsthdr")
            use iso_c_binding
            use nanomsg_types
            
            type(nn_msghdr) :: hdr
        end function NN_CMSG_FIRSTHDR
    
        !nn_cmsg - access control information        
        type(nn_cmsghdr) function NN_CMSG_NXTHDR(hdr, cmsg) bind(C,name="nn_cmsg_nxthdr")
            use iso_c_binding
            use nanomsg_types
            
            type(nn_msghdr) :: hdr
            type(nn_cmsghdr) :: cmsg
        end function NN_CMSG_NXTHDR
    
        !nn_cmsg - access control information    
        type(c_ptr) function NN_CMSG_DATA(cmsg) bind(C,name="nn_cmsg_data")
            use iso_c_binding
            use nanomsg_types
            
            type(nn_cmsghdr) :: cmsg
        end function NN_CMSG_DATA        

        !nn_cmsg - access control information    
        integer(c_size_t) function NN_CMSG_SPACE(len) bind(C,name="nn_cmsg_space")
            use iso_c_binding
            
            integer(c_size_t), value :: len
        end function NN_CMSG_SPACE   
    
        !nn_cmsg - access control information    
        integer(c_size_t) function NN_CMSG_LEN(len) bind(C,name="nn_cmsg_len")
            use iso_c_binding
            
            integer(c_size_t), value :: len
        end function NN_CMSG_LEN       

        !nn_poll - poll a set of SP sockets for readability and/or writability
        integer(c_int) function nn_poll(fds, nfds, timeout) bind(C,name="nn_poll")
            use iso_c_binding
            use nanomsg_types
            
            type(nn_pollfd), value :: fds
            integer(c_int), value, intent(in) :: nfds
            integer(c_int), value, intent(in) :: timeout
        end function nn_poll
    
        !nn_errno - retrieve the current errno
        integer(c_int) function nn_errno() bind(C,name="nn_errno")
            use iso_c_binding

        end function nn_errno    
    
        !nn_strerror - convert an error number into human-readable string   
        type(c_ptr) function nn_strerror(errnum) bind(C,name="nn_strerror")
            use iso_c_binding
            
            integer(c_int), value, intent(in) :: errnum
        end function nn_strerror  

        !nn_symbol - query the names and values of nanomsg symbols   
        type(c_ptr) function nn_symbol(i, value) bind(C,name="nn_symbol")
            use iso_c_binding
            
            integer(c_int), value, intent(in) :: i
            integer(c_int), value :: value
        end function nn_symbol

        !nn_symbol_info - query the names and properties of nanomsg symbols
        integer(c_int) function nn_symbol_info(i, buf, buflen) bind(C,name="nn_symbol_info")
            use iso_c_binding
            use nanomsg_types

            integer(c_int), value, intent(in) :: i
            type(nn_symbol_properties) :: buf
            integer(c_int), value, intent(in) :: buflen
        end function nn_symbol_info
    
        !nn_device - start a device
        integer(c_int) function nn_device(s1, s2) bind(C,name="nn_device")
            use iso_c_binding

            integer(c_int), value, intent(in) :: s1
            integer(c_int), value, intent(in) :: s2
        end function nn_device    
    
        !nn_term - notify all sockets about process termination
        function nn_term() bind(C,name="nn_term")
            use iso_c_binding

        end function nn_term
    
    end interface
    
    
    
    
    
end module nanomsg