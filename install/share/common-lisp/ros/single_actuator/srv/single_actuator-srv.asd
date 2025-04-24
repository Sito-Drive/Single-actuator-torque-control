
(cl:in-package :asdf)

(defsystem "single_actuator-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "gravity_current" :depends-on ("_package_gravity_current"))
    (:file "_package_gravity_current" :depends-on ("_package"))
  ))