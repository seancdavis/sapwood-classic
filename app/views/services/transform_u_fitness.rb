class TransformUFitness

  def initialize(site)
    @site = site
  end

  def results
    @site.page_types.find_by_slug('result').pages
  end

end
