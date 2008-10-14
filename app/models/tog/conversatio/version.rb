module Version
  Major = '0'
  Minor = '2'
  Tiny  = '1'
  Module= 'tog_conversatio'
  class << self
    def to_s
      [Major, Minor, Tiny].join('.')
    end
    def full_version
      "#{Module} #{[Major, Minor, Tiny].join('.')}"
    end
    alias :to_str :to_s
  end
end
