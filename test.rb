

class Value
  
  def initialize(name, *args)
    @name = name
    @args = args
  end
  
end


def ctor(name)
  eval %(
    def #{name}(*args)
    end
  end
end