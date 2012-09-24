require 'test/unit'
require '../app/target'
require '../app/xyzservice'

class TestAdd < Test::Unit::TestCase
  def test_1
    targ = Target.new
    new = escape_random(XYZService.xyz_filename_new(targ))
    old = escape_random(XYZService.xyz_filename_old(targ))
    assert_equal new, old
  end

  def test_2
    targ = Target.new()
    targ.age= 500000
    targ.id= 45454545
    new = escape_random(XYZService.xyz_filename_new(targ))
    old = escape_random(XYZService.xyz_filename_old(targ))
    assert_equal new, old
  end

  def test_3
    targ = Target.new
    targ.personal= false
    targ.title="_________________"
    new = escape_random(XYZService.xyz_filename_new(targ))
    old = escape_random(XYZService.xyz_filename_old(targ))
    assert_equal new, old
  end

  def test_4
    require 'date'
    targ = Target.new
    targ.title="s"
    targ.publish_on=Date.new(2001,2,4)
    new = escape_random(XYZService.xyz_filename_new(targ))
    old = escape_random(XYZService.xyz_filename_old(targ))
    assert_equal new, old
  end

  def test_5
    targ = Target.new
    targ.title="Sm,bv.clkfgjc.vbnmlkdsf"
    new = escape_random(XYZService.xyz_filename_new(targ))
    old = escape_random(XYZService.xyz_filename_old(targ))
    assert_equal new, old
  end
  def escape_random(str)
    ind=str.index(/[a-zA-Z0-9]{8}_[a-zA-Z]*.jpg/)
    str[ind,8]="*"*8
    str
  end
end

#module MyTestHelper
#  def escape_random(str)
#    ind=str.index(/[a-zA-Z0-9]{8}_[a-zA-Z]*.jpg/)
#    str[ind,7]="d"
#  end
#end