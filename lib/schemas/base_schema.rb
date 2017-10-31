class BaseSchema
  def is_valid_file?(filename)
    filename.include?('.')
  end  

  def load_file_from(schema, sub_folders, filename)
    return nil unless schema && sub_folders && filename
    return nil unless sub_folders.is_a?(Array)
    return nil unless is_valid_file?(filename)

    path_to_file  = schema
    sub_folders.each {|folder| path_to_file += "/#{folder}/"}
    path_to_file += '/' if sub_folders.blank?
    path_to_file += filename
    file          = Rails.root.join("lib/schemas/#{path_to_file}")
    contents      = File.read(file)

    # special YAML file handling (for now)
    case true
    when filename.include?('.yml') then return YAML.load(contents)
    else return contents
    end
  end
end
