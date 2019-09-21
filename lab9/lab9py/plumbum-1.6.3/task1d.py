import sys


file_to_read = open(sys.argv[1],'r')
total_errors_hash = {}
for line in file_to_read:
    line_errors = line.split('|')
    total_errors_hash[line_errors[0]] = line_errors[1]
    
    
    
sor = sorted(total_errors_hash.iteritems(), key=lambda (k,v): (v[1]), reverse=True)
   

print("most frequent error is " + (sor[0][0]) + " with " +
      (str)(sor[0][1]) + " repetitions.")

file_to_read.close()
