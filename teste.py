import os
import subprocess


input_path = '.' 
output_path = './output/'

command = f'java -jar DesigniteJava.jar -i {input_path} -o {output_path}'
result = subprocess.run(command, shell=True, check=True)