#!/usr/bin/python

import os
import sys
import json
import signal
import subprocess


# create config dir
config_dir = os.path.expanduser('~') + '/.config/sshtc'
if not os.path.isdir(config_dir):
    try:
        os.makedirs(config_dir)
    except OSError:
        raise OSError(2, config_dir + ' not exists')
    # create config file
    f = open(config_dir + '/data.json', 'w')
    f.write("[]")
    f.close()

# traceback Ctrl+C
signal.signal(signal.SIGINT, lambda x,y: sys.exit(0))

def main():
    params = []
    params_file = os.path.expanduser('~') + '/.config/sshtc/data.json'

    if os.path.isfile(params_file) == False and os.access(params_file, os.R_OK) == False:
        print("%s not exists or not readable." % params_file)
        sys.exit(1)
    with open(params_file) as f:
        params = json.load(f)

    subprocess.call('ssh -V', shell=True)
    print('')

    if len(params) == 0:
        print('No connections.')
        sys.exit(1)

    i = 1
    for param in params:
        tpl = "%s %s"
        if i < 10 and len(params) >= 10:
            tpl = " %s %s"
        print(tpl % (i, param['name']))
        i = i + 1

    try:
        val = int(raw_input('>>> '))
        print('')
        if val is None or int(val) <= 0 or int(val) > len(params):
            print('Bad argument!')
            sys.exit(1)
    except ValueError:
        print('Bad argument!')
        sys.exit(1)

    srv = params[int(val)-1]
    print("%s conection..." % srv['name'])
    if srv['public_key'] != "":
        args = "ssh -o {known_host} -o {log_level} -i {public_key} -p {port} {user}@{host}".format(
            known_host='StrictHostKeyChecking=no',
            log_level='LogLevel=ERROR',
            key=srv['public_key'],
            port=srv['port'],
            user=srv['user'],
            host=srv['host']
        )
        subprocess.call(args, shell=True)
    else:
        args = "sshpass -p '{password}' ssh -o {known_host} -o {log_level} -p {port} {user}@{host}".format(
            known_host='StrictHostKeyChecking=no',
            log_level='LogLevel=ERROR',
            password=srv['password'],
            port=srv['port'],
            user=srv['user'],
            host=srv['host']
        )
        subprocess.call(args, shell=True)