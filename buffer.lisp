(in-package #:opengl-utils)

(defun unbind-buffer (target)
  "Unbind the given TARGET buffer. This amounts to binding it to the 0
buffer."
  (gl:bind-buffer target 0))

(defun unbind-vertex-array ()
  "Unbind the vertex array. This amounts to binding it to the 0
array."
  (gl:bind-vertex-array 0))

(defun send-buffer-data (target usage arr &key buffer (type :float))
  "Copy the given ARR array into a GL-ARRAY, and load this array
inside the active buffer, with given TARGET and USAGE. When BUFFER is
given, binds it first (with the same TARGET), and unbinds it after. "
  (when buffer
    (gl:bind-buffer target buffer))
  
  (let* ((n (length arr))
	 (glarr (gl:alloc-gl-array type n)))
    (dotimes (i n)
      (setf (gl:glaref glarr i) (aref arr i)))
    (gl:buffer-data target usage glarr)
    (gl:free-gl-array glarr))
  
  (when buffer
    (unbind-buffer target)))
