# Nginx service for return a page list json content

## work sequence diagram
sequenceDiagram
    Client->>Backend: request url
    par queryPageRenderConfig
    Backend->>+StaticProxyPod: query http://pagelist/config/page-render.json
    StaticProxyPod-->>-Backend: return page render config
    and queryPageFilePath
    Backend->>+StaticProxyPod: query http://pagelist/config/page-list.json
    StaticProxyPod-->>-Backend: return url page file path
    end
    Backend->>+Cos: read page file
    Cos-->>-Backend: return page file content
    Note left of Backend: render html according to page-render.json and html file content
    Backend-->>Client: return rendered html content

[Edit on mermaid live editor](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG4gICAgQ2xpZW50LT4-QmFja2VuZDogcmVxdWVzdCB1cmxcbiAgICBwYXIgcXVlcnlQYWdlUmVuZGVyQ29uZmlnXG4gICAgQmFja2VuZC0-PitFQ1N0YXRpY1Byb3h5UG9kOiBxdWVyeSBodHRwOi8vcGFnZWxpc3QvcGFnZS1yZW5kZXIuanNvblxuICAgIEVDU3RhdGljUHJveHlQb2QtLT4-LUJhY2tlbmQ6IHJldHVybiBwYWdlIHJlbmRlciBjb25maWdcbiAgICBhbmQgcXVlcnlQYWdlRmlsZVBhdGhcbiAgICBCYWNrZW5kLT4-K0VDU3RhdGljUHJveHlQb2Q6IHF1ZXJ5IGh0dHA6Ly9wYWdlbGlzdC9wYWdlLWxpc3QuanNvblxuICAgIEVDU3RhdGljUHJveHlQb2QtLT4-LUJhY2tlbmQ6IHJldHVybiB1cmwgcGFnZSBmaWxlIHBhdGhcbiAgICBlbmRcbiAgICBCYWNrZW5kLT4-K0NvczogcmVhZCBwYWdlIGZpbGVcbiAgICBDb3MtLT4-LUJhY2tlbmQ6IHJldHVybiBwYWdlIGZpbGUgY29udGVudFxuICAgIE5vdGUgbGVmdCBvZiBCYWNrZW5kOiByZW5kZXIgaHRtbCBhY2NvcmRpbmcgdG8gcGFnZS1yZW5kZXIuanNvbiBhbmQgaHRtbCBmaWxlIGNvbnRlbnRcbiAgICBCYWNrZW5kLS0-PkNsaWVudDogcmV0dXJuIHJlbmRlcmVkIGh0bWwgY29udGVudFxuXG4gICAgICAgICAgICAiLCJtZXJtYWlkIjoie1xuICBcInRoZW1lXCI6IFwiZGVmYXVsdFwiXG59IiwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)

## Test it on minikube
[Install Minikube](https://minikube.sigs.k8s.io/docs/start/)

### Install Minikube
#### for mac intel x86 cpu
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube
```

#### for Windows
```bash
winget install minikube
```

### Start Cluster
```bash
minikube start
```

### Deploy image
```bash
kubectl apply -f ./test/config-map.yml
kubectl apply -f ./test/pagelist-deploy.yml
kubectl expose deployment pagelist --type=NodePort --port=80
kubectl port-forward service/pagelist 7080:80
kubectl get services pagelist
```
