(in-package #:opengl-utils)

;; Following http://www.swiftless.com/tutorials/glsl/1_setup.html

(defclass shader ()
  ((id :initarg :id
       :accessor shader-id)
   (vp :initarg :vp
       :accessor shader-vp)
   (fp :initarg :fp
       :accessor shader-fp)))

(defun make-shader (&key vertex-src fragment-src)
  (let ((vp (gl:create-shader :vertex-shader))
	(fp (gl:create-shader :fragment-shader))
	(id (gl:create-program)))
    ;; Attach source
    (gl:shader-source vp vertex-src)
    (gl:shader-source fp fragment-src)

    (gl:compile-shader vp)
    (gl:compile-shader fp)

    (gl:attach-shader id fp)
    (gl:attach-shader id vp)
    (gl:link-program id)

    ;; Bind the locations
    ;; (gl:bind-attrib-location id 0 "in_Position")
    ;; (gl:bind-attrib-location id 1 "in_Color")
    
    (make-instance 'shader
		   :id id
		   :vp vp
		   :fp fp)))

(defmethod bind-shader ((shader shader))
  (gl:use-program (shader-id shader)))

(defun unbind-shader ()
  (gl:use-program 0))

(defmethod destroy-shader ((shader shader))
  (gl:detach-shader (shader-id shader) (shader-vp shader))
  (gl:detach-shader (shader-id shader) (shader-fp shader))

  (gl:delete-shader (shader-fp shader))
  (gl:delete-shader (shader-vp shader))

  (gl:delete-program (shader-id shader))

  ;; Set everything to 0 in the shader to make sure it will not be used again
  (setf (shader-id shader) 0
	(shader-vp shader) 0
	(shader-fp shader) 0))

(defmacro with-shader (shader &body body)
  `(prog2
       (bind-shader ,shader)
       (progn ,@body)
     (unbind-shader)))
