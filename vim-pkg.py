import json, sys, os, re
from subprocess import call, check_output, CalledProcessError

REQUIREMENTS = ['git']

def get_vimpkg():
    json_file = open('vimpkg.json').read()
    return json.loads(json_file);

def run_post_install(gitUrl, vimpkg):
    commands = vimpkg[gitUrl]['post-install']
    for command in commands:
        try:
            call(command)
        except :
            print 'Failed to complete post-install for `' + gitUrl + '`'
            print 'Command `' + str(' '.join(command)) + '` failed'

def install(gitUrl, vimpkg):
    #TODO: add gitUrl and post-install to vimpkg.json
    if check_requirements(REQUIREMENTS):
        initialDir = os.path.dirname(os.path.realpath(__file__))
        pkgName = get_pkg_name_from_url(gitUrl)
        if vimpkg['config']['install-target']:
            targetDir = vimpkg['config']['install-target']
        else:
            targetDir = '~/.vim/bundle'

        try:
            call(['cd', targetDir])
            call(['git', 'clone', gitUrl])
            call(['cd', pkgName])
            run_post_install(gitUrl, vimpkg)
            call(['cd', initialDir])
        except CalledProcessError:
            print 'Failed to intall ' + pkgName
            print 'Please ensure that the following dependencies are' \
                    + 'installed:' \
                    + ', '.join([com[0] for com in commands])
    else:
        sys.exit()

def add_package(gitUrl, vimpkg):
    pass

def save_vimpkg(vimpkg):
    pass

def get_pkg_name_from_url(gitUrl):
    pkgRegex = r'.*\/([^\/]+).git$'
    match = re.match(pkgRegex, gitUrl)
    return match.group(1)

def check_requirements(requirements=[]):
    for req in requirements:
        try:
            check_output(['which', req])
        except CalledProcessError:
            print 'Missing requirement: ' + req
            return False
    return True

def main():
    check_requirements(REQUIREMENTS)
    run_post_install(get_vimpkg(), 'git-url/blah')


if __name__ == '__main__':
    main()
