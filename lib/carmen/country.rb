require 'forwardable'

require 'carmen/world'
require 'carmen/region'
require 'carmen/querying'

module Carmen
  class Country < Region
    extend Querying
    extend SingleForwardable

    attr_reader :alpha_2_code
    attr_reader :alpha_3_code

    def initialize(data={}, parent)
      super
      @alpha_2_code = data['alpha_2_code']
      @alpha_3_code = data['alpha_3_code']
    end

    def self.all
      World.instance.subregions
    end

    def self.query_collection
      all
    end

    def inspect
      "<##{self.class} name=\"#{name}\">"
    end

  private

    def self.attribute_to_search_for_code(code)
      code.to_s.size == 2 ? :alpha_2_code : :alpha_3_code
    end

    def subregion_directory
      alpha_2_code.downcase
    end

  end
end
