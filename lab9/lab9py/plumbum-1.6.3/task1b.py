import sys


students_errors_file = open(sys.argv[1], 'r')
error_code_file = open(sys.argv[2], 'r')

error_code_hash = {}
for line in error_code_file:
    errors_keys = line.split()
    error_code_hash[errors_keys[0]] = int(errors_keys[1])

grades = {}
for line in students_errors_file:
    students_keys = line.split()
    grades[students_keys[0]] = 100
    if len(students_keys) == 2:
        single_student_errors = students_keys[1].split('|')
        for error in single_student_errors:
            dec_points_by_error = error.split(':')
            points_to_dec = error_code_hash[dec_points_by_error[0]]
            var_percentage = dec_points_by_error[1]
            total_dec = points_to_dec * float(var_percentage)

            grades[students_keys[0]] = grades[students_keys[0]] - float(total_dec)

students_grades_output_file_name = "final_grades"
students_grades_output_file = open(students_grades_output_file_name, "w")

for student, final_grade in grades.items():
    students_grades_output_file.write(str(student) + '|'+ str(final_grade) + '\n')

students_grades_output_file.close()


