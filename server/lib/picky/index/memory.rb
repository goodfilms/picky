module Index
  
  # TODO Doc.
  #
  class Memory < Base
    
    # Injects the necessary options & configurations for
    # a memory index backend.
    #
    def initialize name, source, options = {}
      options[:indexing_bundle_class] ||= Internals::Indexing::Bundle::Memory
      options[:indexed_bundle_class]  ||= Internals::Indexed::Bundle::Memory
      
      super name, source, options
    end
    
  end
  
end