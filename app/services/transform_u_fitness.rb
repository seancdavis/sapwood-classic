class TransformUFitness

  def initialize(site)
    @site = site
  end

  def results(limit = nil)
    if limit.nil?
      @site.page_types.find_by_slug('result').pages
    else
      @site.page_types.find_by_slug('result').pages.limit(limit)
    end
  end

  def reviews
    @site.page_types.find_by_slug('review').pages
  end

  def free_consultation_form
    @site.forms.find_by_slug('free-consultation')
  end

end
