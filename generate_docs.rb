#!/usr/bin/ruby
#
#  The contents of this file are dedicated to the public domain.
#
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
#

require 'FileUtils'
require 'yaml'

class Doxyclean_Doc_Creator
 
  attr_accessor :proj_dir, :project_name, :docs_dir, :doxygen_output, :doxyclean_input, :doxyclean_html_output, :doxyclean_xml_output, :doxyclean_exec_dir, :doxygen_exec_dir, :doxygen_config
	
  CONFIG = YAML::load_file('config.yml')		
  
  def initialize 
		@proj_dir = ENV['PROJECT_DIR']
		@project_name =  CONFIG["project_name"] 
		@docs_dir = "#{proj_dir}/#{CONFIG["documnetation_dir"]}"
		@doxygen_output = "#{proj_dir}#{CONFIG["doxygen_output_dir"]}"
		@doxyclean_input = "#{proj_dir}#{CONFIG["doxyclean_input_dir"]}"
		@doxyclean_html_output = "#{proj_dir}#{CONFIG["doxyclean_html_output_dir"]}"
		@doxyclean_xml_output = "#{proj_dir}#{CONFIG["doxyclean_xml_output_dir"]}"
		@doxyclean_exec_dir = "#{CONFIG["doxyclean_exec_dir"]}"
		@doxygen_exec_dir = "#{CONFIG["doxygen_exec_dir"]}"
		@doxygen_config = "#{proj_dir}/#{CONFIG["doxygen_config"]}"
		
		puts project_name
  end
  
	
  def clear_doxyclean_output_folder
    puts "The Project dir = #{proj_dir}"
    if File.exist?(doxyclean_html_output)
	    puts "Clearing old doxyclean html files"
      FileUtils::Verbose.remove_dir(doxyclean_html_output)
    end
   if File.exist?(doxyclean_xml_output)
	    puts "Clearing old doxyclean xml files"
      FileUtils::Verbose.remove_dir(doxyclean_xml_output)
    end
    
  end
  
  def clear_doxygen_output_folder
    if File.exist?(doxygen_output)
      puts "Cleaning up old doxygen xml output"
      FileUtils::Verbose.remove_dir(doxygen_output)
    end
  end

  def run_doxygen
    puts "doxygen creating XML from project"

    system "#{doxygen_exec_dir}"
  end
  
  def run_doxyclean
	puts docs_dir
    if File.exist?(docs_dir)
      puts "doxyclean creating html from xml"
      do_doxyclean = "#{doxyclean_exec_dir} -n #{project_name} -i #{doxygen_output} -o #{docs_dir}"
  		puts do_doxyclean
      system "#{do_doxyclean}"
		puts "Done creating documentation"
    end
  end
	
end

if __FILE__ == $0
  puts "Generating Documentation with Doxygen and Doxyclean"
  dox = Doxyclean_Doc_Creator.new
  
  dox.clear_doxyclean_output_folder
  dox.clear_doxygen_output_folder
  
  dox.run_doxygen
  dox.run_doxyclean
end
  
#${PROJECT_DIR}/docscript.rb
#echo "Done with scrip"
