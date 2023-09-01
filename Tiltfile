local_resource(name="Generate values", cmd="./certs/install.sh")
local_resource('Change context', cmd=["kubectl", "config", "use-context", "k3d-local"],)
docker_build('bar', './services/bar', live_update=[
  sync('./services/bar/index.html', '/usr/share/nginx/html/index.html')
])
docker_build('foo', './services/foo', live_update=[
  sync('./services/foo/index.html', '/usr/share/nginx/html/index.html')
])

k8s_yaml(helm('./infrastructure', "demo", values="local-values.yaml"))
k8s_yaml(helm('./services/bar/helm', 'bar'))
k8s_yaml(helm('./services/foo/helm', 'foo'))
