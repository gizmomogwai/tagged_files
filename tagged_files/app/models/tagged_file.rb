class TaggedFile < ActiveRecord::Base
  validates :sha1, :presence => true
  validates :size, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :original_filename, :presence => true
  validates :comment, :presence => true

  acts_as_taggable

  def self.find_for_query(query)
    res = TaggedFile.where('original_filename LIKE ?', query)
    res = Tag.where('name LIKE ?', query).inject(res) do |res, tag|
      res | TaggedFile.tagged_with(tag.name)
    end
    return res
  end

  def save_and_store_file(data)
    return false unless save

    begin
      File.open("store/#{sha1}", "wb") do |io|
        io.write(data)
        return true
      end
    rescue
      destroy
      self.errors[:base] = "Could not write file on server, please contact system administrator"
      return false
    end
  end

end
