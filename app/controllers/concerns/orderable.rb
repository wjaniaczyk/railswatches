module Orderable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  # A list of the param names that can be used for ordering the model list
  def ordering_params(params)
    # For example it retrieves a list of watches in descending order of price.
    # Within a specific price, watches are ordered ascending by name
    #
    # GET /watches?sort=-price, name
    # ordering_params(params) # => { price: :desc, name: :asc }
    # Experience.order(price: :desc, name: :asc)
    #
    ordering = {}
    
    if params[:sort]
      sort_order = { '+' => :asc, '-' => :desc }

      sorted_params = params[:sort].split(',')
      sorted_params.each do |attr|
        sort_sign = (attr =~ /\A[+-]/) ? attr.slice!(0) : '+'
        model = controller_name.classify.constantize
        
        if model.attribute_names.include?(attr)
          ordering[attr] = sort_order[sort_sign]
        end
      end
    end
    
    ordering
  end
end