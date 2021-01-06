import http from 'k6/http';

export default function (data) {
  const response = http.get("http://podinfo.default.svc:9898");
};

