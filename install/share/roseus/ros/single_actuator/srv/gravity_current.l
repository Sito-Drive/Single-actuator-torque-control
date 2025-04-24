;; Auto-generated. Do not edit!


(when (boundp 'single_actuator::gravity_current)
  (if (not (find-package "SINGLE_ACTUATOR"))
    (make-package "SINGLE_ACTUATOR"))
  (shadow 'gravity_current (find-package "SINGLE_ACTUATOR")))
(unless (find-package "SINGLE_ACTUATOR::GRAVITY_CURRENT")
  (make-package "SINGLE_ACTUATOR::GRAVITY_CURRENT"))
(unless (find-package "SINGLE_ACTUATOR::GRAVITY_CURRENTREQUEST")
  (make-package "SINGLE_ACTUATOR::GRAVITY_CURRENTREQUEST"))
(unless (find-package "SINGLE_ACTUATOR::GRAVITY_CURRENTRESPONSE")
  (make-package "SINGLE_ACTUATOR::GRAVITY_CURRENTRESPONSE"))

(in-package "ROS")





(defclass single_actuator::gravity_currentRequest
  :super ros::object
  :slots ())

(defmethod single_actuator::gravity_currentRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass single_actuator::gravity_currentResponse
  :super ros::object
  :slots (_current ))

(defmethod single_actuator::gravity_currentResponse
  (:init
   (&key
    ((:current __current) 0.0)
    )
   (send-super :init)
   (setq _current (float __current))
   self)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:serialization-length
   ()
   (+
    ;; float64 _current
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _current
       (sys::poke _current (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _current
     (setq _current (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass single_actuator::gravity_current
  :super ros::object
  :slots ())

(setf (get single_actuator::gravity_current :md5sum-) "ca4d0ba43a70fe6e37b76accdbf3ef40")
(setf (get single_actuator::gravity_current :datatype-) "single_actuator/gravity_current")
(setf (get single_actuator::gravity_current :request) single_actuator::gravity_currentRequest)
(setf (get single_actuator::gravity_current :response) single_actuator::gravity_currentResponse)

(defmethod single_actuator::gravity_currentRequest
  (:response () (instance single_actuator::gravity_currentResponse :init)))

(setf (get single_actuator::gravity_currentRequest :md5sum-) "ca4d0ba43a70fe6e37b76accdbf3ef40")
(setf (get single_actuator::gravity_currentRequest :datatype-) "single_actuator/gravity_currentRequest")
(setf (get single_actuator::gravity_currentRequest :definition-)
      "---
float64 current
")

(setf (get single_actuator::gravity_currentResponse :md5sum-) "ca4d0ba43a70fe6e37b76accdbf3ef40")
(setf (get single_actuator::gravity_currentResponse :datatype-) "single_actuator/gravity_currentResponse")
(setf (get single_actuator::gravity_currentResponse :definition-)
      "---
float64 current
")



(provide :single_actuator/gravity_current "ca4d0ba43a70fe6e37b76accdbf3ef40")


