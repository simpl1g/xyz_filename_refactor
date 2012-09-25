class Target
  attr_accessor :xyz_category_prefix, :kind, :age, :personal, :id, :title, :publish_on
  def initialize(xyz_category_prefix="", kind="", age=0, personal=false, id=0, title="", publish_on=Time.now)
    @xyz_category_prefix=xyz_category_prefix
    @kind=kind
    @age=age
    @personal=personal
    @id=id
    @title=title
    @publish_on=publish_on
  end

  def personal?
    @personal
  end
end