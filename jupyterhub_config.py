c.LocalAuthenticator.create_system_users = True
# c.Authenticator.admin_users     = {'soleil'}
# location of server files
c.JupyterHub.cookie_secret_file = '/srv/jupyterhub/cookie_secret'
c.JupyterHub.db_url         = 'sqlite:////srv/jupyterhub/jupyterhub.sqlite'
c.ConfigurableHTTPProxy.pid_file= '/srv/jupyterhub/jupyterhub-proxy.pid'
c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.ip = '0.0.0.0'



#c = get_config()

#import os

#keyfile = '/ssl/ssl.key'
#certfile = '/ssl/ssl.crt'
#if os.path.exists(keyfile) and os.path.exists(certfile):
#    c.JupyterHub.ssl_key = keyfile
#    c.JupyterHub.ssl_cert = certfile
#    c.JupyterHub.port = 443

#c.Spawner.env_keep.extend([name for name in os.environ.get('ENVPASSWHITELIST','').split(',')])

