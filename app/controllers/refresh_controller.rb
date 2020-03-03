class RefreshController < ApplocationController
  before_action :authorize_refresh_by_access_request!

  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens = session.refresh_by_access_allowed do
      raise JWTSessions::Error::Unauthorized, "Somethings not right here!"
    end

    response.ser_cookie(JWTSessions.access_cookie,
                        value: tokens[:access],
                        httyonly: true,
                        secure: Rails.env.production?)

    render json: { csrf: tokens[:csrf]}
  end
end