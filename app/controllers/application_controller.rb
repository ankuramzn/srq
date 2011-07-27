class ApplicationController < ActionController::Base
  protect_from_forgery

  def clear_session
    session[:type] = nil
    session[:id] = nil
  end

  def choose_layout
    if [ 'new' ].include? action_name
      'pages'
    else
      'application'
    end
  end

  def validated_all
    if session[:type] != "vendor" and session[:type] != "user"
      redirect_to log_in_path, :notice => "Please Log in to access Compliance details."
    end
  end

  def validated_vendor
    if session[:type] != "vendor" or session[:id].nil?
      redirect_to log_in_path, :notice => "Vendor Please Log in to access Compliance details."
    end
  end

  def validated_user
    if session[:type] != "user" or session[:id].nil?
      redirect_to log_in_path, :notice => "Compliance User Please Log in to access Vendor details."
    end
  end

  def connect_to_aws
    # load params. Cache at class (app) level
    @@s3_config_path ||= RAILS_ROOT + '/config/amazon_s3.yml'
    @@s3_config ||=
         YAML.load_file(@@s3_config_path)[ENV['RAILS_ENV']].symbolize_keys

    AWS::S3::Base.establish_connection!(
      :access_key_id     => @@s3_config[:access_key_id],
      :secret_access_key => @@s3_config[:secret_access_key]
      )
    true
  end


  def upload_to_s3(key, object, bucket)
    connect_to_aws
    AWS::S3::S3Object.store(
        key,
        object,
        bucket,
        :access => :public_read
    )
  end

end
