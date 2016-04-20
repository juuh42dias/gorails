module ApplicationHelper

  def show_by_file_type(attachment)
    if attachment.present?
      case File.extname(attachment.file.filename)
      when ".doc" 
        link_to attachment.file.filename, attachment.url
      when ".docx"
        link_to attachment.file.filename, attachment.url
      when ".pdf"
        link_to attachment.file.filename, attachment.url
      when ".txt"
        link_to attachment.file.filename, attachment.url
      else
        image_tag attachment.thumb.url
      end
    else
      "Nenhum arquivo cadastrado."
    end
  end
  
   def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
   end

  def flash_error_color(name)
    case name
      when 'success' then '#27ae60'
      when 'error' then '#ae5757'
      when 'alert'  then '#edc613 '
      when 'notice'  then '#27ae60'
      else name
    end
  end


  def flash_message_title(name)
    case name
      when 'success' then 'Sucesso'
      when 'error' then 'Atenção'
      when 'alert'  then 'Atenção '
      when 'notice'  then 'Atenção'
      else name
    end
  end

  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end

  def link_to_image(image_path, target_link,options={})
    link_to(image_tag(image_path, :border => "0",class: "image-size"), target_link, options)
  end

  def date_picker(form, field, label=nil, place_holder=nil, required=false, style=nil, disabled_plugin=false, valor_conteudo=nil, onchange=nil)
    style ||= "width: 120px;"
    valor = valor_conteudo if valor_conteudo
    valor = form.object.attributes[field.to_s].to_date.to_s_br if form.object.attributes[field.to_s] and valor_conteudo == nil
    # valor = form.object.attributes[field.to_s].to_date.to_s_br if form.object.attributes[field.to_s]
    form.text_field field, :label => label, :value => valor, :placeholder => place_holder, :data_required => required, :class => "form-control input-lg datepicker", "data-provide"=>'datepicker', "data-mask" => '99/99/9999', :date_picker => "input-small date date-picker", :html_icon => "<span class=\"input-group-btn\" style=\"vertical-align: top;\"><button class=\"btn btn-info\" type=\"button\"><i class=\"fa fa-calendar\"></i></button></span>", :style => style, :disable_plugin => disabled_plugin, :onchange => onchange

  end


end

