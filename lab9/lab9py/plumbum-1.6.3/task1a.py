import sys


file_to_read = open(sys.argv[1],'r')
total_errors_hash = {}
for line in file_to_read:
    line_errors = line.split()
    if len(line_errors) == 2:
        parsed_errors = line_errors[1].split('|')
        for error in parsed_errors:
            error_name = error.split(':')[0]
            counter = 0
            if error_name in total_errors_hash:
                counter = total_errors_hash[error_name]
            total_errors_hash[error_name] = counter + 1

output_file_name = "errorcodes.stats"
output_file = open(output_file_name, "w")

for error_key, total_err_count in total_errors_hash.items():
    output_file.write(str(error_key) + '|'+ str(total_err_count) + '\n')

output_file.close()
