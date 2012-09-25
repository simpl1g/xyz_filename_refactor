require 'test/unit'
require '../app/target'
require '../app/xyzservice'

class TestAdd < Test::Unit::TestCase
  def test
    targ = Array.new
    targ[0] = Target.new(id: 30000000000)
    targ[1] = Target.new(age: 999999999)
    targ[2] = Target.new(title: "32_kj.4h_8sgdf89bucvl", personal: true)
    targ[3] = Target.new(xyz_category_prefix: "___344_")
    targ[4] = Target.new
    targ.each do |target|
      new = escape_random(XYZService.xyz_filename_new(target))
      old = escape_random(XYZService.xyz_filename_old(target))
      puts new
      puts old
      assert_equal new, old
    end
  end

  def escape_random(str)
    ind=str.index(/[a-zA-Z0-9]{8}_[a-zA-Z]*.jpg/)
    str[ind, 8]="*"*8
    str
  end
end
