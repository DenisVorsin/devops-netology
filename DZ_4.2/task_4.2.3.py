#!/usr/bin/env python3

import os
import sys

try:
    sys.argv[1]
except:
    print("Директория не указана. Используем значение по умолчанию.")
    work_dir = "/home/denisvorsin/devops-netology"
else:
    work_dir = sys.argv[1]

os.chdir(work_dir)
bash_command = ["cd " +work_dir, "git status"]

# Проверяем, является ли каталог репозиторем git
res=os.system("git status > /dev/null 2>&1")
if  res > 0 :
    print("Указанный каталог не является репозиторием git")
    sys.exit()

result_os = os.popen(' && '.join(bash_command)).read()
cur_dir=os.getcwd()
is_change = False
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:   ', '')
        print(cur_dir.strip() + "/" + prepare_result.strip())
        # break