# optimize
current_state = 0
def get_path(json_string):
#    print(json_string)
    str = json_string.decode("utf-8")
    print(str)
    current_state += 1
    str = str + str(current_state)
    return json_string
def change_path():
    str = "changed path"
    print(str)
    current_state += 1
    str = str + str(current_state)
    return str
