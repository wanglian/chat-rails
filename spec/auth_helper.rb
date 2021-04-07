# frozen_string_literal: true

module AuthHelper
  SIGN_IN_URL  = '/api/v1/auth/sign_in'
  SIGN_OUT_URL = '/api/v1/auth/sign_out'
  SIGN_UP_URL  = '/api/v1/auth/'

  def sign_in(user)
    post SIGN_IN_URL, params: { email: user.email, password: user.password }
  end

  def sign_out(headers)
    delete SIGN_OUT_URL, headers: headers
  end

  def sign_up(params)
    post SIGN_UP_URL, params: params
  end

  def get_auth_params(response)
    {
      'access-token' => response.headers['access-token'],
      'client'       => response.headers['client'],
      'uid'          => response.headers['uid'],
      'expiry'       => response.headers['expiry'],
      'token-type'   => response.headers['token-type']
    }
  end
end
