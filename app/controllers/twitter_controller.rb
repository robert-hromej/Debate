# This class aggregate all functionality for working with Twitter API. Twitter login and tweeting are implemented here.
# all methods requires authorization, except ones for for authorization
class TwitterController < ApplicationController

  TWITTER_API_URL = "https://api.twitter.com"

  # perform first step in oauth authenticating
  def login
    # get request token
    request_token = twitter_oauth.get_request_token(:oauth_callback => oauth_callback)

    session['rtoken'] = request_token.token
    session['rsecret'] = request_token.secret

    # redirect to Twitter's authenticating page
    redirect_to twitter_authenticate(request_token.token)
  rescue OAuth::Error => e
    logger.error("OAuth error: #{e} \n #{e.backtrace.join("\n")}")
    push_error_message t(:oauth_error)
    redirect_to root_url
  end

  # perform logout
  def logout
    # simply clean current user value in session
    set_current_user(nil)
    redirect_to root_url
  end

  # is redirected by Twitter after authenticating.
  def after_login
    # user doen't allowed
    raise t(:twitter_denided) if params[:denied]

    # get OAuth access token
    result = OAuth::RequestToken.new(twitter_oauth, session['rtoken'], session['rsecret']).
        get_access_token(:oauth_verifier => params[:oauth_verifier])

    options = {:consumer_key => APP_CONFIG[:twitter][:consumer_token],
               :consumer_secret => APP_CONFIG[:twitter][:consumer_secret],
               :oauth_token => result.token,
               :oauth_token_secret => result.secret}

    # get twitter screen name using got access token
    client = Twitter::Client.new(options)
    credentials = client.verify_credentials

    # search user using screen name
    user = User.login(credentials, result)

    #Updates user profile image
    user.update_avatar
    # cleans cache fragments
    expire_fragment(%r{link_id_\d*_author_id_#{user.id}_voted_\d*})
    expire_fragment(%r{comment_id_\d*_author_id_#{user.id}})

    # Sets current user variable
    set_current_user user

    redirect_to root_url

  rescue OAuth::Error => e
    logger.error("OAuth error: #{e} \n #{e.backtrace.join("\n")}")
    push_error_message t(:oauth_error)
    redirect_to root_url
  rescue Twitter::Error => e
    logger.error("Twitter error: #{e} \n #{e.backtrace.join("\n")}")
    push_error_message t(:twitter_error)
    redirect_to root_url
  rescue StandardError => e
    push_error_message e.to_s
    redirect_to root_url
  end

  private

  # return OAuth::Consumer object
  def twitter_oauth
    OAuth::Consumer.new(APP_CONFIG[:twitter][:consumer_token], APP_CONFIG[:twitter][:consumer_secret],
                        {:site => TWITTER_API_URL, :request_endpoint => TWITTER_API_URL})
  end

  # generate callback url for twitter login
  def oauth_callback
    @callback_url ||= "http://#{request.host_with_port}/twitter/after_login"
    return @callback_url
  end

  def twitter_authenticate oauth_token
    return "https://api.twitter.com/oauth/authenticate?oauth_token=#{oauth_token}"
  end

end
