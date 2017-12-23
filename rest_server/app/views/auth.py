# -*- coding: UTF-8 -*-
from flask import Blueprint, request, jsonify, make_response, g
from flask.views import MethodView
from flask_httpauth import HTTPTokenAuth
from random import randint
from .. import db, SECRET_KEY
from ..models import User, VERIFY_EXPIRED, TOKEN_EXPIRED
from itsdangerous import SignatureExpired, BadSignature, \
    TimedJSONWebSignatureSerializer as Serializer
import time
import uuid

auth = HTTPTokenAuth()
auth_blueprint = Blueprint('auth', __name__)

business_id = uuid.uuid4()


@auth.verify_token
def verify_token(token):
    g.user_id = None
    try:
        print SECRET_KEY
        serializer = Serializer(SECRET_KEY, expires_in=TOKEN_EXPIRED)
        print 'token is %s' % token
        data = serializer.loads(token)
    except SignatureExpired:
        print 'Signature Expired'
        return False
    except BadSignature:
        print 'Bad Signature '
        return False
    user = User.query.filter_by(id=data['user_id']).first()
    if not user:
        return False
    g.user_id = data['user_id']
    return True


def generate_rand_digits(n):
    digits = ''
    for i in range(n):
        digits += str(randint(0, 9))
    return digits


class GetVerifyCode(MethodView):
    """
    get verify code from client to phone
    """
    def get(self):
        phone = request.args['phone']
        user = User.query.filter_by(phone=phone).first()
        digits = generate_rand_digits(6)
        if not user:
            u = User(phone=phone, verify_code=digits)
            db.session.add(u)
        elif time.time() - user.launch_timestamp > VERIFY_EXPIRED:
            user.launch_timestamp = time.time()
            user.verify_code = digits
            db.session.add(user)
        else:
            return make_response('<h1>User exists with repeated verify code submited</h1>', 400)
        from send_sms import send_sms, SIGN_NAME, TEMPLATE_CODE
        params = {'code': digits, 'product': 'aida'}
        send_state = send_sms(business_id, phone, SIGN_NAME, TEMPLATE_CODE, params)
        print 'the send state', send_state
        db.session.commit()
        return make_response(jsonify({'phone': phone, 'verify_code': digits})), 200


class UserGetAPI(MethodView):
    """
    User Registeration Resource
    """
    decorators = [auth.login_required]

    def get(self, user_id):
        user = User.query.filter_by(id=g.user_id).first()
        print 'before user get with user id ', g.user_id
        if user:
            res = {'id': user.id, 'name': user.name,
                   'point': user.point, 'avatar': user.avatar,
                   'phone': user.phone}
            return make_response(jsonify(res)), 200
        return '<h1>the user id %s not found!</h1>' % user_id, 400


class GetAndSetToken(MethodView):
    """
    User get or set the token
    """
    def post(self):
        phone = request.values['phone']
        password = request.values['password']
        user = User.query.filter_by(phone=phone).first()
        if not user:
            return make_response('<h1>The user not exists</h1>', 400)
        if 'verification_code' in request.values:
            verified_code = request.values['verification_code']
            if verified_code != user.verify_code:
                return make_response('<h1>verify code not right resubmit</h1>', 401)
            else:
                user.password = password
                user.verified = True
                res = dict()
                res['user_id'] = user.id
                res['phone'] = user.phone
                res['access_token'] = user.generate_token()
                res['user_name'] = user.name
                res['expires_in'] = TOKEN_EXPIRED
                return make_response(jsonify(res)), 200
        else:
            if user.check_password(password):
                res = dict()
                res['user_id'] = user.id
                res['phone'] = user.phone
                res['access_token'] = user.generate_token()
                res['user_name'] = user.name
                res['expires_in'] = TOKEN_EXPIRED
                return make_response(jsonify(res)), 200
            else:
                return make_response('password not right', 402)


user_get_view = UserGetAPI.as_view('user_get_api')
get_verify_code = GetVerifyCode.as_view('get_verify_code')
get_and_set_token = GetAndSetToken.as_view('get_and_set_token')


auth_blueprint.add_url_rule('/aida/user/<user_id>', view_func=user_get_view,
                            methods=['GET'])
auth_blueprint.add_url_rule('/aida/get_verify_code',
                            view_func=get_verify_code, methods=['GET'])
auth_blueprint.add_url_rule('/aida/auth2/token', view_func=get_and_set_token,
                            methods=['POST'])