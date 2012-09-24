module XYZService

  def self.xyz_filename_new(target)
    require 'securerandom'
    # File format:
    # [day of month zero-padded][three-letter prefix] \
    # _[kind]_[age_if_kind_personal]_[target.id] \
    # _[8 random chars]_[10 first chars of title].jpg
    arr = Array.new
    arr << target.kind.gsub("_", "")
    arr << "%03d" % (target.age || 0) if target.personal?
    arr << target.id
    #arr << SecureRandom.hex(4)
    arr << "#{Digest::SHA1.hexdigest(rand(10000).to_s)[0,8]}"
    arr << target.title.gsub(/[^\[a-z\]]/i, '').downcase[0..9]
    filename = target.publish_on.strftime("%d")
    filename << target.xyz_category_prefix.to_s+arr.join("_")+".jpg"
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
