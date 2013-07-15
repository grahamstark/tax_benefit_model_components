;; This note explains the existence of the numerous files named ada.el in
;; each of the source code directories.   

;; I am an habitual and long-term user of emacs (the "Swiss Army
;; chainsaw" of software engineering).

;; I don't use gnat project files; instead I have devised this tactic
;; to assure the correct compile environment for my Ada programming.
;; The technique assures me that the environment variables
;; "ADA_INCLUDE_PATH" and "ADA_OBJECTS_PATH" are defined whenever I do
;; a compilation -- regardless of what context of compilation I happen
;; to be interested in.  (Since I'm a hobbiest, I have several
;; different contexts - completely unrelated to each other - in play
;; at any time).

;; Here's the technique: I define a file "ada.el" in every directory
;; where I am likely to do a compilation.  That file simply has the
;; names of the directories that contain the units that this
;; compilation will "with".  Each one of these files looks like this
;; the ada.el in one of these product directories (the example is from
;; Examples/Ada0Y).

(setq local-ada-path  
      (concat
       "../..;"
       "../../Reused"))

;; Every one of these ada.el files sets a value of the variable
;; local-ada-path to be a list of strings, each naming a directory.

;; The following items live in my .emacs file where they are executed
;; when emacs starts up (therefore the definitions always exist).
;; Note that the values of variables Ada and *ada-path* are specific
;; to my file system organization.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Enable gnat *from within emacs!* ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq Ada (concat (getenv "HOME") "Software/Ada/Quality-Ada/"))

(defvar *ada-path*  
  (concat Ada "ADT;"
	  "C:/Applications/Languages/gnat/Bindings/Win32Ada;"
	  "C:/Applications/Languages/asis")
  "Globally useful path vars (INCLUDE & OBJECTS) for gnat.")

(setenv "ADA_INCLUDE_PATH" *ada-path*)
(setenv "ADA_OBJECTS_PATH" *ada-path*)

;; If a directory has ada code that needs some context -->
;; write a file "ada.el" in that directory; it setq's
;; a string "local-ada-path" with directory names that should be
;; catted into the ADA paths.  Then evaluate "ada" in the directory
;; - that sets a new PATH for compilation.

(defun ada () 
  (interactive)
  (load-file "./ada.el")
  (setenv "ADA_INCLUDE_PATH" (concat *ada-path* ";" local-ada-path))
  (setenv "ADA_OBJECTS_PATH" (concat *ada-path* ";" local-ada-path)))

;; Now all I need to do before compiling is to execute the command
;; "M-x ada" and the gnat environment is defined for the compile units
;; in that directory.
