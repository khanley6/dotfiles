import sys
import subprocess

get_current_num_cmd = 'i3-msg -t \'get_workspaces\' |'  \
                      'sed -e \'s/{"num/\\n{"num/g\' |' \
                      'grep \\"focused\\":true |'       \
                      'sed -e \'s/,"/\\n/g\' |'         \
                      'grep name |'                     \
                      'cut -d\\" -f 3'

def rename_ws(new_name, reset=False):
    ws_name = subprocess.check_output(get_current_num_cmd, shell=True).decode('ascii')

    try:
        ws_num = int(ws_name)
    except ValueError:
        ws_num = int(ws_name.split(':')[0])

    if reset:
        rename_cmd = f'i3-msg "rename workspace {ws_name} to \"{ws_num}\""'
    else:
        rename_cmd = f'i3-msg "rename workspace {ws_name} to \"{ws_num}:{new_name}\""'

    subprocess.run(rename_cmd, shell=True)

if __name__=='__main__':
    if len(sys.argv) == 1:
        rename_ws('', reset=True)
    else:
        rename_ws(sys.argv[1])
