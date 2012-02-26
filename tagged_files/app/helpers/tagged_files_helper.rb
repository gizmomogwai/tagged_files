module TaggedFilesHelper
  def tag_links(tagged_file)
    tagged_file.tags.map {|tag| link_to(tag.name, Tag.find_by_name(tag.name))}.join(', ')
  end
end
