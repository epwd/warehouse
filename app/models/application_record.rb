class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include ActionView::Helpers::TranslationHelper
  
  def created_at_original
    created_at(true)
  end

  def created_at(original=false)
    if original == true
      attributes['created_at']
    else
      l(attributes['created_at'],  :format => "%d %B %Y - %H:%M")
    end
  end

  def updated_at_original
    updated_at(true)
  end
  def updated_at(original=false)
    if original == true
      attributes['updated_at']
    else
      l(attributes['updated_at'],  :format => "%d %B %Y - %H:%M")
    end
  end
end
