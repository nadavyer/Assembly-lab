import sys


def get_most_frequent_error(file__path):
    file_to_read = open(file__path, 'r')
    total_errors_hash = {}
    for line in file_to_read:
        line_errors = line.split()
        if len(line_errors) == 2:
            parsed_errors = line_errors[1].split('|')
            for error in parsed_errors:
                counter = 0
                if error in total_errors_hash:
                    counter = total_errors_hash[error]
                total_errors_hash[error] = counter + 1

    most_frequent_error = {"error_name_key": '', "error_rep_key": 0}
    for error, error_rep in total_errors_hash.items():
        if most_frequent_error["error_rep_key"] < error_rep:
            most_frequent_error["error_name_key"] = error
            most_frequent_error["error_rep_key"] = error_rep
    file_to_read.close()
    return most_frequent_error


def init_code_hash(file_path):
    error_codes_file = open(file_path, 'r')
    error_code_hash = {}
    for line in error_codes_file:
        errors_keys = line.split()
        error_code_hash[errors_keys[0]] = int(errors_keys[1])
    error_codes_file.close()
    return error_code_hash


def calculate_grades(file_students_path, most_freq_err, error_code_hash):
    students_errors_file = open(file_students_path, 'r')

    grades_factored = {}
    grades_without_factor = {}
    for line in students_errors_file:
        students_keys = line.split()
        grades_factored[students_keys[0]] = 100
        grades_without_factor[students_keys[0]] = 100
        if len(students_keys) == 2:
            single_student_errors = students_keys[1].split('|')
            for error in single_student_errors:
                dec_points_by_error = error.split(':')
                points_to_dec = error_code_hash[dec_points_by_error[0]]
                var_percentage = dec_points_by_error[1]
                total_dec = points_to_dec * float(var_percentage)
                grades_without_factor[students_keys[0]] = grades_without_factor[students_keys[0]] - float(total_dec)
                if error != most_freq_err["error_name_key"]:
                    grades_factored[students_keys[0]] = grades_factored[students_keys[0]] - float(total_dec)

    sum_grades = 0
    sum_factored_grades = 0
    total_students = 0
    for student, grade in grades_without_factor.items():
        print(str(student) + ": " + str(grade) + " => " + str(grades_factored[student]))
        sum_grades = sum_grades + grade
        sum_factored_grades = sum_factored_grades + grades_factored[student]
        total_students += 1

    prefactor_avg = (str(sum_grades / total_students))[:4]
    postfactor_avg = (str(sum_factored_grades / total_students))[:4]

    print("prefactored average: " + prefactor_avg + " => postfactored average: " + postfactor_avg)


if __name__ == '__main__':
    file_students_grades = "lab10_grades"
    file_err_codes = "error-codes"

    most_freq_err = get_most_frequent_error(file_students_grades)
    error_code_hash = init_code_hash(file_err_codes)
    calculate_grades(file_students_grades, most_freq_err, error_code_hash)
