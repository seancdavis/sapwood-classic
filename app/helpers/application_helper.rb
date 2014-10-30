module ApplicationHelper

  def data
    @data ||= {}
  end

  def route(items)
    i = ""; s = ""; pop = false
    if items.last.is_a?(Array)
      items[-1] = items.last.flatten.first
      pop = true
    end
    items.each do |item|
      klass = item.class.method_defined?(:model) ? item.model : item.class
      t = klass.table_name.gsub(/heartwood\_/, '')
      ts = t.singularize; s += "#{ts}_"
      item == items.last ? i += "#{t}_" : i += "#{ts}_"
    end
    objs = items.reverse.drop(1).reverse
    objs = objs.collect(&:to_param).join(',')
    if objs.empty?
      routes = {
        :index => send("#{i}path"),
        :new => send("new_#{s}path"),
        :edit => send("edit_#{s}path", items.last.to_param),
        :show => send("#{s}path", items.last.to_param)
      }
    else
      routes = {
        :index => send("#{i}path", objs),
        :new => send("new_#{s}path", objs),
        :edit => send("edit_#{s}path", objs, items.last.to_param),
        :show => send("#{s}path", objs, items.last.to_param)
      }
    end
  end

  def authenticate_admin!
    authenticate_user!
    redirect_to current_user.last_site unless current_user.is_admin?
  end

end
