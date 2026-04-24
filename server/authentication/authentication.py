from rest_framework.authentication import BaseAuthentication
from rest_framework.exceptions import AuthenticationFailed
from firebase_admin import auth
from authentication.models import User

class FirebaseAuthentication(BaseAuthentication):
    def authenticate(self, request):
        auth_header = request.META.get('HTTP_AUTHORIZATION')
        if not auth_header: 
            return None
        try:
            token = auth_header.split(' ').pop()
            decoded_token = auth.verify_id_token(token)
            uid = decoded_token.get('uid')
            phone_number = decoded_token.get('phone_number')
        except Exception as e:
            raise AuthenticationFailed('Invalid token')
        user, created = User.objects.get_or_create(firebase_uid=uid, phone_number=phone_number)
        return (user, None)