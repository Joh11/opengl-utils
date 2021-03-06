;;;; package.lisp

(defpackage #:opengl-utils
  (:use #:cl)
  (:export
   ;; Buffers
   #:unbind-buffer
   #:unbind-vertex-array
   #:send-buffer-data
   ;; Shaders
   #:shader
   #:shader-id
   #:shader-vp
   #:shader-fp
   #:make-shader
   #:bind-shader
   #:unbind-shader
   #:destroy-shader
   #:with-shader))
