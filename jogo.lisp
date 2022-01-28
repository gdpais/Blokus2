;;;; Projeto.lip 
;;;; Funções que permitem escrever e ler em ficheiros, trata ainda da interação com o utilizador
;;;; Gabriel Pais - 201900301
;;;; Andre Serrado - 201900318


;;; Game Handler

;; jogar 
;; returns a list with 2 elements [play board-state(after the play)]
(defun jogar(pos time)
"
[pos] position 
[time] maximum (1 - 20 milliseconds) time of an computer play
"
)

(defun human-vs-computer())
(defun computer-only())

;;; Menus + Views (and its operations)

;; init-menu 
;;  shows the game's initial menu
(defun init-menu()
    (format t "~%___________________________________________________________")
    (format t "~%\\                      BLOKUS DUO                         /")
    (format t "~%/                                                         \\")
    (format t "~%\\     1 - Humano vs Computador                            /")
    (format t "~%/       2 - Computador vs Computador                      \\")  
    (format t "~%\\     0 - Sair                                            /")
    (format t "~%/_________________________________________________________\\~%~%>")
)

;; start
;; It receives data from the keyboard
;; and executes the correspondent action/operation 
(defun start()
    (init-menu)
    (let ((option (read)))
      (if (and (numberp option) (>= option 0) (<= option 2)) 
        (cond
          ((equal option 1) (get-starter))
          ((equal option 2) (get-time-limit)) 
          ((equal option 0) (format t "~%Adeus!"))
        ) 

        (progn (print "Opção inválida. Tente novamente") (start))
      )
    )
)

;; starter-view
(defun starter-view()
    (format t "~%_________________________________________________________")
    (format t "~%\\                     BLOKUS DUO                        /")
    (format t "~%/                  Quem começa primeiro?                \\")
    (format t "~%\\                   (tipo das peças)                    /")
    (format t "~%/     1 - Humano (1)                                    \\")
    (format t "~%\\     2 - Computador (2)                                /")
    (format t "~%/     0 - Voltar                                        \\")
    (format t "~%\\_______________________________________________________/~%~%> ")
)

;; get-starter
;; 1 - human || -1 - computer
(defun get-starter()
  (starter-view)
  (let ((option (read)))
    (cond
      ((or (< option 0) (> option 2)) (progn (format t "Insira uma opcao valida") (get-starter)))
      ((= option 0) (start))
      (t (get-time-limit option))
    )
  )
)

;; time-limit-view
(defun time-limit-view()
  (format t "~%_________________________________________________________")
  (format t "~%\\                      BLOKUS DUO                       /")
  (format t "~%/          Defina o tempo limite para uma jogada        \\")
  (format t "~%\\            do computador (1 - 20) segundos.           /")
  (format t "~%\\                                                      \\")
  (format t "~%/     0 - Voltar                                        /")
  (format t "~%\\                                                     \\")
  (format t "~%/_______________________________________________________/~%~%> ")
)

;; get-time-limit
(defun get-time-limit(&optional (starter nil))
  (progn (time-limit-view)
    (let ((option (read)))
      (cond 
        ((and (= option 0) (null starter)) (start))
        ((= option 0) (get-starter))
        ((or (not (numberp option)) (< option 1) (> option 20)) (progn (format t "Insira uma opção válida") (get-time-limit)))
        (t (list starter option))
      )
    )
  )
)

;; possible-moves-view
(defun possible-moves-view())

;; get-move
;; piece and position
(defun get-move())

(defun winner-view())

;;; Files Handler (log.dat)

;; get-log-path
;; returns the path to the log file 
(defun get-log-path()
  (make-pathname :host "D" :directory '(:absolute "GitHub\\Blokus2") :name "log" :type "dat")   
)

;; TODO
;; Ficheiro log.dat : 
; - qual a jogada realizada
; - o valor da posicao para onde jogou
; - o numero de nos analisados
; - o numero de cortes efetuados (de cada tipo)
;- tempo gasto
(defun log-header()
 (with-open-file (file (get-log-path) :direction :output :if-exists :append :if-does-not-exist :create)
          (format file "~%----------------- INICIO -----------------~%"))  
)

(defun log-file())
(defun log-content())
(defun log-winner())

;;; Formatters

(defun format-board-line (board)
  (cond
   ((null (first board)) "")
   (t (format nil "~a~%" (first board)))
   )
)

(defun format-board (board)
  (cond
   ((null board) "")
   (t (format nil "~a~a" (format-board-line board) (format-board (cdr board))))
   )
)  

(defun format-solution-path (path)
  (cond
   ((null path) "")
   (t (format nil "~a~%~a" (format-board (first (first path))) (format-solution-path (cdr path))))
   )
)

;; current-time
;; returns a list with a actual time (hours minutes seconds)
(defun current-time()
  (get-internal-real-time)
)