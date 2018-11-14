from jinja2 import Template
import sys

def missingvar():
  print """
    run haproxygen.py:
    python ./haproxygen.py SERVERNAME FQDN BACKENDPORT HAPROXYADMINPASS
    example:
    python ./haproxygen.py myserver myserver.com 80 adminpass
    """
def buildfile():
  with open('/haproxy.cfg.j2') as file_:
    template = Template(file_.read())
    config = template.render(server=sys.argv[1], fqdn=sys.argv[2], port=sys.argv[3], haproxyadmin=sys.argv[4])
  print(config)

if len(sys.argv) > 5:
    print len(sys.argv)
    missingvar() 
else:
    buildfile()
