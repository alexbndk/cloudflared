module CloudflareDev
  class Image < Object
    def inspect
      "Image id=#{self.id}, filename=#{self.filename}"
    end

    def <=>(other_image)
      self.id <=> other_image.id
    end
  end
end