(deffunction ask_value (?question)
    (print ?question)
    (bind ?answer (read))
    ?answer
)

(deffunction ask-question (?question $?allowed-values)
    (print ?question)
    (bind ?answer (read))
    (if (lexemep ?answer)
        then (bind ?answer (lowcase ?answer))
	    )
    (while (not (member$ ?answer ?allowed-values)) do
        (print ?question)
        (bind ?answer (read))
        (if (lexemep ?answer)
            then (bind ?answer (lowcase ?answer))
		    )
	    )
    ?answer
)

(deffunction yes-or-no (?question)
    (bind ?response (ask-question ?question yes no y n))
    (if (or (eq ?response yes) (eq ?response y))
        then yes
        else no
	    )
)

(defrule determenite_student_sleep
    (not (solution_mark ?))
    (not (student_in_mood ?))
    (not (student_good_sleep ?))
    =>
    (assert (student_good_sleep (yes-or-no "Student have good sleep?: ")))
)

(defrule determenite_student_eat
    (not (solution_mark ?))
    (not (student_in_mood ?))
    (not (student_good_eat ?))
    =>
    (assert (student_good_eat (yes-or-no "Student have good breakfast?: ")))
)

(defrule determenite_student_perfomance
  (not (solution_mark ?))
  (not (student_perfomance ?))
  =>
  (assert (student_perfomance (ask_value "How muck homeworks student reach?: ")))
)

(defrule determenite_lections
  (not (solution_mark ?))
  (not (student_was_on_lections ?))
  =>
  (assert (student_was_on_lections (yes-or-no "Student went on all lections?: ")))
)

(defrule determenite_auditory
  (not (solution_mark ?))
  (not (teacher_in_mood ?))
  (not (auditory_good ?))
  =>
  (assert (auditory_good (yes-or-no "Auditory good?: ")))
)

(defrule determenite_students
  (not (solution_mark ?))
  (not (teacher_in_mood ?))
  (not (students_fast ?))
  =>
  (assert (students_fast (yes-or-no "Students were before begin exam?: ")))
)

(defrule determenite_student_mood_rule1
    (or
      (student_good_sleep yes)
      (student_good_eat yes)
    )
    =>
    (assert (student_in_mood yes))
    (print "Student in mood: Yes" crlf)
)

(defrule determenite_student_mood_rule2
  (and
    (student_good_sleep no)
    (student_good_eat no)
  )
  =>
  (assert (student_in_mood no))
  (print "Student in mood: No" crlf)
)

(defrule determenite_student_end_perfomance_best
  (student_perfomance ?value)
  (not (student_best_perfomance ?))
  (not (student_good_perfomance ?))
  (not (student_bad_perfomance ?))
  (test (eq ?value 7))
  =>
  (assert (student_best_perfomance yes))
  (print "Student have perfoming: Best" crlf)
)

(defrule determenite_student_end_perfomance_good
  (student_perfomance ?value)
  (not (student_best_perfomance ?))
  (not (student_good_perfomance ?))
  (not (student_bad_perfomance ?))
  (test (and (< ?value 7) (>= ?value 5)))
  =>
  (assert (student_good_perfomance yes))
  (print "Student have perfoming: Good" crlf)
)

(defrule determenite_student_end_perfomance_bad
  (student_perfomance ?value)
  (not (student_best_perfomance ?))
  (not (student_good_perfomance ?))
  (not (student_bad_perfomance ?))
  (test (< ?value 5))
  =>
  (assert (student_bad_perfomance yes))
  (print "Student have perfoming: Bad" crlf)
)

(defrule determenite_teacher_mood_rule1
    (or
      (auditory_good no)
      (students_fast no)
    )
    =>
    (assert (teacher_in_mood no))
    (print "Teacher in mood: No" crlf)
)

(defrule determenite_teacher_mood_rule2
    (and
      (auditory_good yes)
      (students_fast yes)
    )
    =>
    (assert (teacher_in_mood yes))
    (print "teacher_in_mood: Yes" crlf)
)

(defrule determenite_student_exam_good
    (or
      (student_in_mood yes)
      (student_best_perfomance yes)
      (student_good_perfomance yes)
    )
    =>
    (assert (student_exam_good yes))
    (print "Student exam is good: Yes" crlf)
)

(defrule determenite_student_exam_bad
    (and
      (student_in_mood no)
      (student_bad_perfomance yes)
    )
    =>
    (assert (student_exam_good no))
    (print "Student exam is good: No" crlf)
)

(defrule determenite_student_add_question_yes
    (and
      (student_exam_good no)
      (teacher_in_mood yes)
    )
    =>
    (assert (student_add_question yes))
    (print "Student have add question: Yes" crlf)
)

(defrule determenite_student_add_question_no
    (and
      (student_exam_good no)
      (teacher_in_mood no)
    )
    =>
    (assert (student_add_question no))
    (print "Student have add question: No" crlf)
)

(defrule determenite_student_add_question_good
    (and
        (student_was_on_lections yes)
        (student_add_question yes)
    )
    =>
    (assert (student_add_question_good yes))
    (print "Student have add question is good: Yes" crlf)
)

(defrule determenite_student_add_question_bad
    (and
        (student_was_on_lections no)
        (student_add_question yes)
    )
    =>
    (assert (student_add_question_good no))
    (print "Student have add question is bad: No" crlf)
)

(defrule determenite_student_mark_2
    (or
      (student_add_question no)
      (student_add_question_good no)
    )
    (not (solution_mark ?))
    =>
    (assert (solution_mark "Mark 2"))
    (print "Mark 2" crlf)
)

(defrule determenite_student_mark_3
    (or
      (and
        (student_bad_perfomance yes)
        (student_add_question_good yes)
      )
      (and
        (student_exam_good yes)
        (student_bad_perfomance yes)
      )
    )
    (not (solution_mark ?))
    =>
    (assert (solution_mark "Mark 3"))
    (print "Mark 3" crlf)
)

(defrule determenite_student_mark_4
    (or
      (and
        (student_good_perfomance yes)
        (student_add_question_good yes)
      )
      (and
        (student_exam_good yes)
        (student_good_perfomance yes)
      )
    )
    (not (solution_mark ?))
    =>
    (assert (solution_mark "Mark 4"))
    (print "Mark 4" crlf)
)

(defrule determenite_student_mark_5
    (or
      (and
        (student_best_perfomance yes)
        (student_add_question_good yes)
      )
      (and
        (student_exam_good yes)
        (student_best_perfomance yes)
      )
    )
    (not (solution_mark ?))
    =>
    (assert (solution_mark "Mark 5"))
    (print "Mark 5" crlf)
)
