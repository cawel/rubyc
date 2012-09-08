module MiniTest
  # http://blog.macromates.com/2007/the-textmate-url-scheme/
  module ColorizeStack
    def write(str = "")
      red = "\e[31m"
      clear = "\e[0m"
      green = "\e[32m"
      blue = "\e[34m"
      magenta = "\e[35m"
      clear = "\e[0m"
      # 
      url_regex = %r{(\S*.rb):(\d+)(.*)}
      str.each_line do |line|
        if line =~ url_regex
          file_name = $1
          line_number = $2
          complement = $3
          if File.exist? file_name
            full_path = File.expand_path(file_name)
            app_trace = full_path.match(Dir.pwd) && full_path !~ /vendor/
            new_line = "#{blue}txmt://open?url=file://#{File.dirname(full_path)}/#{clear}#{red if app_trace }#{File.basename(full_path)}#{clear if app_trace}&line=#{line_number
      }#{complement}\n"
          else
            new_line = line
          end
        else
           new_line = line
        end
          super(new_line)
      end
    end
  end
end

if __FILE__ == $0 
  
  ### Test does not pass yet
require 'minitest/unit'
require 'minitest/autorun'
require 'stringio'

class ColorizeStackTest < MiniTest::Unit::TestCase
  def test_colorize_stack
    str = <<EOF
test_0003_should_return_the_value_from_on_key(AProductionBafFileSpec::AStructureSpec):
RuntimeError: THIS IS A STACKTRACE TEST
    ./lib/coco_gem/field.rb:19:in `extract_data_from_raw'
    ./lib/coco_gem/field.rb:9:in `initialize'
    ./lib/coco_gem/field.rb:44:in `new'
    ./lib/coco_gem/field.rb:44:in `parse'
    ./lib/coco_gem/structure.rb:18:in `parse'
    ./lib/coco_gem/structure.rb:17:in `map'
    ./lib/coco_gem/structure.rb:17:in `parse'
    ./lib/coco_gem/record.rb:26:in `parse'
    ./lib/coco_gem/helper.rb:39:in `scanned_string'
    ./lib/coco_gem/record.rb:16:in `parse'
    ./lib/coco_gem/file.rb:27:in `read'
    ./spec/file_spec.rb:8
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/spec.rb:118:in `instance_eval'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/spec.rb:118:in `setup'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:713:in `run'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:675:in `run_test_suites'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:669:in `each'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:669:in `run_test_suites'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:668:in `each'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:668:in `run_test_suites'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:632:in `run'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352/gems/minitest-1.7.2/lib/minitest/unit.rb:524:in `autorun'
    /Users/martinos/.rvm/gems/ruby-1.8.7-p352@global/gems/rake-0.8.7/lib/rake/rake_test_loader.rb:5

5 tests, 0 assertions, 0 failures, 5 errors, 0 skips
EOF
  
    stdout = StringIO.new
    Minitest::ColorizeStack
    stdout.extend Minitest::ColorizeStack
    stdout.write(str)
    stdout.print str
    str = stdout.string
    red = "\e[31m"
    clear = "\e[0m"
    green = "\e[32m"
    blue = "\e[34m"
    magenta = "\e[35m"

    puts "File exist tab"  if File.exist?("./lib/coco_gem/field.rb")
    assert_match %{#{blue}txmt://open?url=file:///.*/lib/coco_gem/#{clear}#{red}field.rb#{clear}:19:in `extract_data_from_raw'}, str
    
  end
end

end



