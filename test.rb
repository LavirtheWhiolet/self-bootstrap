

class Value
  
  def initialize(name, *args)
    @name = name
    @args = args
  end
  
end


def ctor(name, *args)
  eval %(
    def #{name}(*args)
    end
  end
end