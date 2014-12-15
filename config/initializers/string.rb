require 'filemagic'

class String

  def text?
    begin
      fm = FileMagic.new(FileMagic::MAGIC_MIME)
      fm.file(self) =~ /^text\//
    ensure
      fm.close
    end
  end

  def binary?
    !text?
  end

end
