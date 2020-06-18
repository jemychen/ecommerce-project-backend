class ApplicationController < ActionController::API
    def encode_token(payloadHash)
        # should store secret in env variable
        JWT.encode(payloadHash, 'secret cheesecake recipe')
    end
    
    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end
    
    def decoded_token
     # header: { 'Authorization': 'Bearer <token>' }
     if auth_header()
      token = auth_header().split(' ')[1]
      begin
        JWT.decode(token, 'secret cheesecake recipe', true, algorithm: 'HS256')
      rescue JWT::DecodeError
          nil
        end
      end
    end
    
    def logged_in_user
      if decoded_token()
        user_id = decoded_token()[0]['user_id']
        @user = User.find_by(id: user_id)
      end
    end
    
    def logged_in?
      !!logged_in_user()
    end
    
    def authorized
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end  
