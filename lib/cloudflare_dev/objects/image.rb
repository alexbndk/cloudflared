module CloudflareDev
  class Image < Object
    def inspect
      "Image id=#{self.id}, filename=#{self.filename}"
    end
  end
end