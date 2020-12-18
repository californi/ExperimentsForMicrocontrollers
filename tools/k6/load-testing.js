import http from 'k6/http';
import { check, sleep } from 'k6';

const epochSeconds = () => new Date().getTime() / 1000;

export let options = {
  teardownTimeout: '100s',
   stages: [
     {
       duration: '180s',
       target: 400
     },
     {
      duration: '180s',
      target: 0
    }
   ]
};

export function setup() {
  return {
    metrics_exporter: `${__ENV.METRICS_EXPORTER_HOST}/exports/${__ENV.TEST_NAME}`,
    bucket_name: __ENV.BUCKET_NAME,
    start: epochSeconds()
  };
};

export default function() {
  // https://k6.io/blog/how-to-generate-a-constant-request-rate-in-k6
  /**
   * Request Rate = (VU * R) / T
   * Request Rate: measured by the number of requests per second (RPS)
   * VU: the number of virtual users
   * R: the number of requests per VU iteration
   * T: a value larger than the time needed to complete a VU iteration
   */
  const before = new Date().getTime();
  const T = 2;
  
  for (let i = 0; i < 2; i++) {
    const res = http.get('http://nginx-ingress.default.svc/news.php');
    check(res, {
      "is status 200": r => r.status === 200
    });
  }

  const after = new Date().getTime();
  const diff = (after - before) / 1000;
  const remainder = T - diff;
  
  if (remainder > 0) {
    sleep(remainder);
  } else {
    console.warn(
      `Timer exhausted! The execution time of the test took longer than ${T} seconds`
    );
  }
}

export function teardown(data) {
  data.end = epochSeconds();
  const payload = JSON.stringify({
    start: data.start,
    end: data.end,
    bucket_name: data.bucket_name
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  
  const res = http.post(data.metrics_exporter, payload, params);
  console.log(res.status);
}
