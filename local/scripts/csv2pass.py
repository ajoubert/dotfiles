#! /user/bin/env python2

import getopt, sys, csv
from subprocess import Popen, PIPE

def pass_import_entry(path, data):
    """ Import new password entry to password-store using pass insert command """
    proc = Popen(['pass', 'insert', '--multiline', path], stdin=PIPE, stdout=PIPE)
    proc.communicate(data)
    proc.wait()


class PasswordEntry(object):
    __group__ = "";
    __title__ = "";
    __username__ = "";
    __password__ = "";
    __url__ = "";
    __notes__ = "";

    def __init__(self, record = [] ):
        self.__group__ = record[0] + "/" + record[1] 
        self.__title__ = record[1]
        self.__username__ = record[2] 
        self.__password__ = record[3] 
        self.__url__ = record[4]
        self.__notes__ = record[5] 

    def getPath(self):
        return self.__group__

    def getData(self):
        data = ""
        data += self.__password__ + "\n"
        data += "user: " + self.__username__ + "\n"
        data += "url: " + self.__url__+ "\n"
        data += self.__notes__ + "\n"
        return data
 
def convert_csv(csv_file, root_node):
    """ Converts csv file into a list of password objects"""
    print "[>>>>] Parsing csv file"
    result = []
    reader = csv.reader(open(csv_file), delimiter=',', quoting=csv.QUOTE_MINIMAL)
    for record in reader:
        if reader.line_num == 1:
            header = record
        else:
            if( root_node != None ):
                record[0] = record[0].replace( root_node, "" )
                print "New group name: " +  record[0]
            po = PasswordEntry(record)
            result.append(po)
    return result

def usage():
    """ Print usage """
    print "Usage: %s -i CSV_FILE" % (sys.argv[0])

def main(argv):
    try:
        opts, args = getopt.gnu_getopt(argv, "i:r:")
    except getopt.GetoptError as err:
        print str(err)
        usage()
        sys.exit(2)

    csv_file = None
    root_node = None
    
    for opt, arg in opts:
        if opt in "-i":
            csv_file = arg
        if opt in "-r":
            root_node = arg

    if (csv_file is None):
        usage()
        sys.exit(2)

    passwords = convert_csv(csv_file, root_node)
    print "[INFO] Starting to save passwords"
    for password in passwords:
        print "[>>>>] Saving password %s" % password.__title__
        pass_import_entry( password.getPath(), password.getData() )


if __name__ == '__main__':
    main(sys.argv[1:])


