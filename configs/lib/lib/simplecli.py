import re
import json
import shutil
import glob
import subprocess as sp
import sys
import os


def require(*libs, venv=None, clean_venv=False, pip_install=False):
    '''
    venv: path to your env.
          If None uses {script_dir}/.env-{script_name}
          If not absolute uses {script_dir}/{venv}
    clean_env: True of False. Remove venv if True
    SIMPLECLI_CLEAN_VENV: set clean_venv as True if 1, yes or y
    pip_install: call pip install if True. If new env force set to True
    '''
    if not libs:
        return

    clean_venv = clean_venv or os.environ.get('SIMPLECLI_CLEAN_VENV', '0').lower() in ['1', 'yes', 'y']

    script_path = sys.argv[0]
    if venv is None:
        script_name = os.path.basename(script_path)
        venv = f'.env-{script_name}'
    if os.path.abspath(venv) != venv:
        script_dir = os.path.dirname(script_path)
        venv = os.path.join(script_dir, venv)

    env_interpreter = os.path.join(venv, 'bin/python')
    if env_interpreter == sys.executable:
        return

    if os.path.exists(venv) and clean_venv:
        shutil.rmtree(venv)

    if not os.path.exists(venv):
        sp.check_call(['python', '-m', 'venv', venv])
        pip_install = True

    missing = []
    if pip_install:
        missing = libs
    # else:
    #     installed_info = json.loads(sp.check_output([env_interpreter, '-m', 'pip', 'list', '--format', 'json'], stderr=sp.DEVNULL))
    #     installed = {x['name'] for x in installed_info}
    #     missing = [x for x in libs if re.split(r'[=><@ ]', x, 1)[0] not in installed]

    if missing:
        sp.check_call([env_interpreter, '-m', 'pip', 'install', *missing])

    os.execlp(env_interpreter, env_interpreter, *sys.argv)
