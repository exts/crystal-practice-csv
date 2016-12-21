
module Csv

    alias SArray = Array(String)

    class Reader

        @data = [] of SArray

        # construct which initializes the filename & delimiter
        # allowing us to parse the csv file accordingly
        def initialize(@filename = "", @delimiter : (String|Char) = ',')
        end

        # get parsed csv data
        def parsed_data
            @data
        end

        # read file data if file exists & split it into string array
        protected def read_file_lines() : Array(String)
            contents = [] of String
            if File.exists?(@filename)
                contents = File.read_lines(@filename)
            end

            contents
        end

        # parse csv data into array and return any matched parts
        protected def parse_line(line : String) : Array(String)
            line = line.strip

            # split line into parts based on our delimiter
            line_parts = [] of String
            if !line.empty?
                line_parts = line.split(@delimiter)
            end

            tmp_parts = [] of String
            if line_parts.size > 0
                line_parts.each do |l|
                    tmp_parts << l.strip
                end
            end

            tmp_parts
        end

        # read and parse csv file data
        # (optional: skip the first line of te csv data)
        def read_and_parse(skip_first_line = false)
            count = 0
            contents = read_file_lines()
            if contents.size > 0
                contents.each do |line|
                    if count == 0 && skip_first_line
                        count = 1
                        next
                    end

                    @data << parse_line(line)
                end
            end
        end

    end
end