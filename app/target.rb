class Target
  attr_accessor :xyz_category_prefix, :kind, :age, :personal, :id, :title, :publish_on

  # WTF?
  def initialize(*arg)
    @xyz_category_prefix=""
    @kind=""
    @age=0
    @personal=false
    @id=0
    @title=""
    @publish_on=Time.now
    arg.each do |k|
      k.each { |key, val| instance_variable_set("@#{key}", val) unless val.nil? }
    end
  end

  def personal?
    @personal
  end
end
