#!/usr/bin/env python3

import os
os.chdir("/home/denisvorsin/devops-netology")
bash_command = ["cd ~/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
cur_dir=os.getcwd()
is_change = False
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:   ', '')
        print(cur_dir.strip() + "/" + prepare_result.strip())
        # break
