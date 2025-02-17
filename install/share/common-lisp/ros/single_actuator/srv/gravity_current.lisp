; Auto-generated. Do not edit!


(cl:in-package single_actuator-srv)


;//! \htmlinclude gravity_current-request.msg.html

(cl:defclass <gravity_current-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass gravity_current-request (<gravity_current-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gravity_current-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gravity_current-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name single_actuator-srv:<gravity_current-request> is deprecated: use single_actuator-srv:gravity_current-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gravity_current-request>) ostream)
  "Serializes a message object of type '<gravity_current-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gravity_current-request>) istream)
  "Deserializes a message object of type '<gravity_current-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gravity_current-request>)))
  "Returns string type for a service object of type '<gravity_current-request>"
  "single_actuator/gravity_currentRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gravity_current-request)))
  "Returns string type for a service object of type 'gravity_current-request"
  "single_actuator/gravity_currentRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gravity_current-request>)))
  "Returns md5sum for a message object of type '<gravity_current-request>"
  "ca4d0ba43a70fe6e37b76accdbf3ef40")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gravity_current-request)))
  "Returns md5sum for a message object of type 'gravity_current-request"
  "ca4d0ba43a70fe6e37b76accdbf3ef40")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gravity_current-request>)))
  "Returns full string definition for message of type '<gravity_current-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gravity_current-request)))
  "Returns full string definition for message of type 'gravity_current-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gravity_current-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gravity_current-request>))
  "Converts a ROS message object to a list"
  (cl:list 'gravity_current-request
))
;//! \htmlinclude gravity_current-response.msg.html

(cl:defclass <gravity_current-response> (roslisp-msg-protocol:ros-message)
  ((current
    :reader current
    :initarg :current
    :type cl:float
    :initform 0.0))
)

(cl:defclass gravity_current-response (<gravity_current-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gravity_current-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gravity_current-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name single_actuator-srv:<gravity_current-response> is deprecated: use single_actuator-srv:gravity_current-response instead.")))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <gravity_current-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader single_actuator-srv:current-val is deprecated.  Use single_actuator-srv:current instead.")
  (current m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gravity_current-response>) ostream)
  "Serializes a message object of type '<gravity_current-response>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gravity_current-response>) istream)
  "Deserializes a message object of type '<gravity_current-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gravity_current-response>)))
  "Returns string type for a service object of type '<gravity_current-response>"
  "single_actuator/gravity_currentResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gravity_current-response)))
  "Returns string type for a service object of type 'gravity_current-response"
  "single_actuator/gravity_currentResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gravity_current-response>)))
  "Returns md5sum for a message object of type '<gravity_current-response>"
  "ca4d0ba43a70fe6e37b76accdbf3ef40")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gravity_current-response)))
  "Returns md5sum for a message object of type 'gravity_current-response"
  "ca4d0ba43a70fe6e37b76accdbf3ef40")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gravity_current-response>)))
  "Returns full string definition for message of type '<gravity_current-response>"
  (cl:format cl:nil "float64 current~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gravity_current-response)))
  "Returns full string definition for message of type 'gravity_current-response"
  (cl:format cl:nil "float64 current~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gravity_current-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gravity_current-response>))
  "Converts a ROS message object to a list"
  (cl:list 'gravity_current-response
    (cl:cons ':current (current msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'gravity_current)))
  'gravity_current-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'gravity_current)))
  'gravity_current-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gravity_current)))
  "Returns string type for a service object of type '<gravity_current>"
  "single_actuator/gravity_current")