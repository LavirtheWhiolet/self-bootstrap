

def ctor(name)
  eval %(
    def #{name}(*args)
    end
  end
end