module XYZService

  def self.xyz_filename_new(target)
    require 'securerandom'
    # File format:
    # [day of month zero-padded][three-letter prefix] \
    # _[kind]_[age_if_kind_personal]_[target.id] \
    # _[8 random chars]_[10 first chars of title].jpg
    delim = "_"
    day_of_month = target.publish_on.strftime("%d")
    prefix = target.xyz_category_prefix
    kind = target.kind.gsub("_", "")
    age = "_%03d" % (target.age || 0) if target.personal?
    id = delim + target.id.to_s
    rand = delim + SecureRandom.hex(4)
    first_ten_letters = delim+target.title.gsub(/[^\[a-z\]]/i, '').downcase[0..9]
    filename = day_of_month + prefix + kind + age.to_s + id + rand + first_ten_letters + ".jpg"
  end
  def self.xyz_filename_old(target)
    require "digest"
    # File format:
    # [day of month zero-padded][three-letter prefix] \
    # _[kind]_[age_if_kind_personal]_[target.id] \
    # _[8 random chars]_[10 first chars of title].jpg
    filename = "#{target.publish_on.strftime("%d")}"
    filename << "#{target.xyz_category_prefix}"
    filename << "#{target.kind.gsub("_", "")}"
    filename << "_%03d" % (target.age || 0) if target.personal?
    filename << "_#{target.id.to_s}"
    filename << "_#{Digest::SHA1.hexdigest(rand(10000).to_s)[0,8]}"
    truncated_title = target.title.gsub(/[^\[a-z\]]/i, '').downcase
    truncate_to = truncated_title.length > 9 ? 9 : truncated_title.length
    filename << "_#{truncated_title[0..(truncate_to)]}"
    filename << ".jpg"
    return filename
  end
end
