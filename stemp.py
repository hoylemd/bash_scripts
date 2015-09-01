import argparse


parser = argparse.ArgumentParser(description='Render a Stemp template.')

help_string = 'Path to the values file. Should be in json dictionary format'
parser.add_argument('values_path', help=help_string)

help_string = 'Path to the input template. Stdin Will be used if omitted.'
parser.add_argument('-i', '-t', '--input-template', dest='template_path',
                    help=help_string)

help_string = 'Path to the output file. Stdout will be used if omitted'
parser.add_argument('-o', '--output-path', dest='output_path',
                    help=help_string)

help_string = 'Print out the Stemp specifiction'
parser.add_argument('-s', '--specification', dest='print_specification',
                    action='store_true', help=help_string)

args = parser.parse_args()

if __name__ == '__main__':
    print 'values at: %s' % args.values_path
    print 'input at: %s' % (args.template_path or 'stdin')
    print 'values at: %s' % (args.output_path or 'stdout')
