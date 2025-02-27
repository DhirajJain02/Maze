module ApplicationHelper
  def active_class(path)
    current_page?(path) ? "bg-blue-600 text-white hover:bg-blue-700" : "text-[#606165] hover:bg-gray-200"
  end
  def active_image(base_name, path)
    if current_page?(path)
      asset_path("#{base_name}-light.svg") # Active state image
    else
      asset_path("#{base_name}.svg") # Default image
    end
  end
end
