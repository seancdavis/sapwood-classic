class TransformUFitness

  def initialize(site)
    @site = site
  end

  def results
    @site.page_types.find_by_slug('result').pages
  end

  def free_consultation_form
    @site.forms.find_by_slug('free-consultation')
  end

end
