;;;; opengl-utils.asd

(asdf:defsystem #:opengl-utils
  :description "Collection of helpers and utilities for using CL-OPENGL and CL-SDL2"
  :author "Johan Félisaz"
  :license  "MIT License"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "opengl-utils")
	       (:file "buffer")
	       (:file "shader")))
