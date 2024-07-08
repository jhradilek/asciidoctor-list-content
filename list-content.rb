#!/usr/bin/env ruby

# list-content.rb - list content included in supplied AsciiDoc files
# Copyright (C) 2022 Jaromir Hradilek

# This program is  free software:  you can redistribute it and/or modify it
# under  the terms  of the  GNU General Public License  as published by the
# Free Software Foundation, version 3 of the License.
#
# This program  is  distributed  in the hope  that it will  be useful,  but
# WITHOUT  ANY WARRANTY;  without  even the implied  warranty of MERCHANTA-
# BILITY  or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the  GNU General Public License  along
# with this program. If not, see <http://www.gnu.org/licenses/>.

require 'asciidoctor'
require 'pathname'
require 'optparse'

# Set the script name and version:
VERSION = '0.1.1'
NAME    = File.basename($0)

# Set the current working directory as the defualt starting point for
# relative paths:
relpath = Pathname.new(Dir.pwd)

# Do not list images by default:
images  = false

# Do not include the main file in the output by default:
with_filename = false

# Do not include the content type determined from the file prefix in the output by default:
with_prefix = false

# Do not include the content type determined from the attribute in the output by default:
with_attribute = false

# Use colon as a field delimiter by default:
delimiter = ': '

# Configure the option parser:
op = OptionParser.new do |opts|
  opts.banner  = "Usage: #{NAME} [OPTION...] FILE...\n"
  opts.banner += "       #{NAME} -h|-v\n\n"

  opts.on('-i', '--images', 'list included images in addition to included files') do
    images = true
  end

  opts.on('-f', '--with-filename', 'include the name of the main file in the output') do
    with_filename = true
  end

  opts.on('-t', '--with-prefix-type', 'include the content type determined from the file prefix in the output') do
    with_prefix = true
  end

  opts.on('-T', '--with-attribute-type', 'include the content type determined from the attribute in the output') do
    with_attribute = true
  end

  opts.on('-d', '--delimiter=STRING', "use STRING instead of '#{delimiter}' for field delimiter") do |value|
    delimiter = value
  end

  opts.on('-r', '--relative-to=DIR', 'print file paths relative to DIR') do |value|
    abort "Directory does not exist: #{dir}" if not File.exist?(value)
    abort "Not a directory: #{dir}" if not File.directory?(value)
    relpath = Pathname.new(File.expand_path(value))
  end

  opts.on('-h', '--help', 'display this help and exit') do
    puts op
    exit
  end

  opts.on('-v', '--version', 'display the version and exit') do
    puts "#{NAME} #{VERSION}"
    exit
  end
end

# Parse command-line options and return the remaining arguments:
args = op.parse!

# Verify the number of supplied command-line arguments:
abort "Invalid number of arguments" if args.length < 1

# Process each supplied file:
args.each do |file|
  # Verify that the supplied file exists and is readable:
  abort "File does not exist: #{file}" if not File.exists?(file)
  abort "Not a file: #{file}" if not File.file?(file)
  abort "File not readable: #{file}" if not File.readable?(file)

  # Get the adjusted relative path to the supplied file:
  path = Pathname.new(File.realpath(file)).relative_path_from(relpath)

  # Parse the supplied file:
  doc = Asciidoctor.load_file(file, doctype: :book, safe: :safe, catalog_assets: true)

  # Print the list of all included files:
  doc.catalog[:includes].each do |item, _|
    # Get the adjusted relative path to the included file:
    include = Pathname.new(File.realpath(File.join(File.dirname(file), "#{item}.adoc"))).relative_path_from(relpath)

    # Print the name of the parent file if requested:
    print "#{path}#{delimiter}" if with_filename

    # Print the content type from the file prefix if requested:
    if with_prefix
      case include.basename.to_s
        when /^con_/
          type = 'CONCEPT'
        when /^proc_/
          type = 'PROCEDURE'
        when /^ref_/
          type = 'REFERENCE'
        when /^assembly_/
          type = 'ASSEMBLY'
        else
          type = 'NONE'
      end
      print "#{type}#{delimiter}"
    end

    # Print the conent type from the related attribute if requested:
    if with_attribute
      type = File.read(include)[/^:_content-type: (.*)$/,1]
      type = 'NONE' if not type
      print "#{type}#{delimiter}"
    end

    # Print the name of the included file:
    puts include
  end

  # Skip listing images if not requested:
  next unless images

  # Print the list of all included images:
  doc.catalog[:images].each do |image|
    print "#{path}#{delimiter}" if with_filename
    print "IMAGE#{delimiter}" if with_prefix
    print "IMAGE#{delimiter}" if with_attribute
    puts Pathname.new(File.realpath(File.join(File.dirname(file), image.imagesdir || '', image.target))).relative_path_from(relpath)
  end
end
