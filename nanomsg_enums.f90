module nanomsg_enums
    !Fortran bindings for the nanomsg v0.4 sockets library (https://github.com/nanomsg/nanomsg)
    !"nanomsg" is licensed under MIT/X11 license and is a trademark of 250bpm s.r.o.
    !
    !nanofort bindings for nanomsg - MIT License (MIT)
    !See LICENSE file for more details    
    !Copyright (c) 2014 John N. Shahbazian
    !https://github.com/jshahbazi/nanofort  
    
    
!############################################################################
enum, bind(c)

!----------------------------------------------------------------------------

! bus.h

enumerator :: NN_PROTO_BUS = 7
enumerator :: NN_BUS = (NN_PROTO_BUS * 16 + 0)

!----------------------------------------------------------------------------

! inproc.h

enumerator :: NN_INPROC = -1

!----------------------------------------------------------------------------

! ipc.h

enumerator :: NN_IPC = -2


!----------------------------------------------------------------------------
!  nn.h    

enumerator :: NN_MSG = -1

    
!  Errors:
!  A number random enough not to collide with different errno ranges on      
!  different OSes. The assumption is that error_t is at least 32-bit type.   
enumerator :: NN_HAUSNUMERO = 156384712
enumerator :: ENOTSUP = (NN_HAUSNUMERO + 1)
enumerator :: EPROTONOSUPPORT = (NN_HAUSNUMERO + 2)
enumerator :: ENOBUFS = (NN_HAUSNUMERO + 3)
enumerator :: ENETDOWN = (NN_HAUSNUMERO + 4)
enumerator :: EADDRINUSE = (NN_HAUSNUMERO + 5)
enumerator :: EADDRNOTAVAIL = (NN_HAUSNUMERO + 6)
enumerator :: ECONNREFUSED = (NN_HAUSNUMERO + 7)
enumerator :: EINPROGRESS = (NN_HAUSNUMERO + 8)
enumerator :: ENOTSOCK = (NN_HAUSNUMERO + 9)
enumerator :: EAFNOSUPPORT = (NN_HAUSNUMERO + 10)
enumerator :: EPROTO = (NN_HAUSNUMERO + 11)
enumerator :: EAGAIN = (NN_HAUSNUMERO + 12)
enumerator :: EBADF = (NN_HAUSNUMERO + 13)
enumerator :: EINVAL = (NN_HAUSNUMERO + 14)
enumerator :: EMFILE = (NN_HAUSNUMERO + 15)
enumerator :: EFAULT = (NN_HAUSNUMERO + 16)
enumerator :: EACCESS = (NN_HAUSNUMERO + 17)
enumerator :: ENETRESET = (NN_HAUSNUMERO + 18)
enumerator :: ENETUNREACH = (NN_HAUSNUMERO + 19)
enumerator :: EHOSTUNREACH = (NN_HAUSNUMERO + 20)
enumerator :: ENOTCONN = (NN_HAUSNUMERO + 21)
enumerator :: EMSGSIZE = (NN_HAUSNUMERO + 22)
enumerator :: ETIMEDOUT = (NN_HAUSNUMERO + 23)
enumerator :: ECONNABORTED = (NN_HAUSNUMERO + 24)
enumerator :: ECONNRESET = (NN_HAUSNUMERO + 25)
enumerator :: ENOPROTOOPT = (NN_HAUSNUMERO + 26)
enumerator :: EISCONN = (NN_HAUSNUMERO + 27)
enumerator :: ESOCKTNOSUPPORT = (NN_HAUSNUMERO + 28)

!  Native nanomsg error codes.                                               
enumerator :: ETERM = (NN_HAUSNUMERO + 53)
enumerator :: EFSM = (NN_HAUSNUMERO + 54)
    
    
!  Constants that are returned in `ns` member of nn_symbol_properties        
enumerator :: NN_NS_NAMESPACE = 0
enumerator :: NN_NS_VERSION = 1
enumerator :: NN_NS_DOMAIN = 2
enumerator :: NN_NS_TRANSPORT = 3
enumerator :: NN_NS_PROTOCOL = 4
enumerator :: NN_NS_OPTION_LEVEL = 5
enumerator :: NN_NS_SOCKET_OPTION = 6
enumerator :: NN_NS_TRANSPORT_OPTION = 7
enumerator :: NN_NS_OPTION_TYPE = 8
enumerator :: NN_NS_OPTION_UNIT = 9
enumerator :: NN_NS_FLAG = 10
enumerator :: NN_NS_ERROR = 11
enumerator :: NN_NS_LIMIT = 12

!  Constants that are returned in `type` member of nn_symbol_properties      
enumerator :: NN_TYPE_NONE = 0
enumerator :: NN_TYPE_INT = 1
enumerator :: NN_TYPE_STR = 2

!  Constants that are returned in the `unit` member of nn_symbol_properties  
enumerator :: NN_UNIT_NONE = 0
enumerator :: NN_UNIT_BYTES = 1
enumerator :: NN_UNIT_MILLISECONDS = 2
enumerator :: NN_UNIT_PRIORITY = 3
enumerator :: NN_UNIT_BOOLEAN = 4

!  SP address families.                                                      
enumerator :: AF_SP = 1
enumerator :: AF_SP_RAW = 2

!  Max size of an SP address.                                                
enumerator :: NN_SOCKADDR_MAX = 128

!  Socket option levels: Negative numbers are reserved for transports, 
!  positive for socket types. 
enumerator :: NN_SOL_SOCKET = 0

!  Generic socket options (NN_SOL_SOCKET level).                             
enumerator :: NN_LINGER = 1
enumerator :: NN_SNDBUF = 2
enumerator :: NN_RCVBUF = 3
enumerator :: NN_SNDTIMEO = 4
enumerator :: NN_RCVTIMEO = 5
enumerator :: NN_RECONNECT_IVL = 6
enumerator :: NN_RECONNECT_IVL_MAX = 7
enumerator :: NN_SNDPRIO = 8
enumerator :: NN_RCVPRIO = 9
enumerator :: NN_SNDFD = 10
enumerator :: NN_RCVFD = 11
enumerator :: NN_DOMAIN = 12
enumerator :: NN_PROTOCOL = 13
enumerator :: NN_IPV4ONLY = 14
enumerator :: NN_SOCKET_NAME = 15

!  Send/recv options.                                                        
enumerator :: NN_DONTWAIT = 1
    
!  Socket mutliplexing support.                                              
enumerator :: NN_POLLIN = 1
enumerator :: NN_POLLOUT = 2    

!----------------------------------------------------------------------------

! pair.h

enumerator :: NN_PROTO_PAIR = 1
enumerator :: NN_PAIR = (NN_PROTO_PAIR * 16 + 0)

!----------------------------------------------------------------------------

! pipeline.h

enumerator :: NN_PROTO_PIPELINE = 5
enumerator :: NN_PUSH = (NN_PROTO_PIPELINE * 16 + 0)
enumerator :: NN_PULL = (NN_PROTO_PIPELINE * 16 + 1)

!----------------------------------------------------------------------------

! pubsub.h

enumerator :: NN_PROTO_PUBSUB = 2
enumerator :: NN_PUB = (NN_PROTO_PUBSUB * 16 + 0)
enumerator :: NN_SUB = (NN_PROTO_PUBSUB * 16 + 1)
enumerator :: NN_SUB_SUBSCRIBE = 1
enumerator :: NN_SUB_UNSUBSCRIBE = 2

!----------------------------------------------------------------------------

! reqrep.h

enumerator :: NN_PROTO_REQREP = 3
enumerator :: NN_REQ = (NN_PROTO_REQREP * 16 + 0)
enumerator :: NN_REP = (NN_PROTO_REQREP * 16 + 1)
enumerator :: NN_REQ_RESEND_IVL = 1

!----------------------------------------------------------------------------

! survey.h

enumerator :: NN_PROTO_SURVEY = 6
enumerator :: NN_SURVEYOR = (NN_PROTO_SURVEY * 16 + 0)
enumerator :: NN_RESPONDENT = (NN_PROTO_SURVEY * 16 + 1)
enumerator :: NN_SURVEYOR_DEADLINE = 1

!----------------------------------------------------------------------------

! tcp.h
enumerator :: NN_TCP = -3
enumerator :: NN_TCP_NODELAY = 1


end enum
!############################################################################




end module nanomsg_enums