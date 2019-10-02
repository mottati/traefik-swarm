# traefik-swarm
Attempt to configure a route in an adjacent swarm stack.

This project brings up two Docker Swarm stacks
- **traefik**  
contains a traefik, grafana, and influxdb container along with traefik routing labels.
- **portainer**  
contains a portainer and portainer agent container along with routing labels

The routes to the Influxdb and Grafana contaeinrs work as expected, the route to the Portainer container does not. There is a very basic start.sh script that can be used to run the test. 

**Output from ./start.sh**
```
$ ./start.sh

Deploy portainer stack.
Creating network portainer_agent_network
Creating service portainer_agent
Creating service portainer_portainer

Deploy traefik stack
Ignoring unsupported options: restart

Creating service traefik_traefik
Creating service traefik_influxdb
Creating service traefik_grafana

sleep for 10 seconds

Stack info
NAME                SERVICES            ORCHESTRATOR
portainer           2                   Swarm
traefik             3                   Swarm
Docker process info
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS               NAMES
99ab6cdaf3df        grafana/grafana:5.4.3        "/run.sh"                10 seconds ago      Up 8 seconds        3000/tcp            traefik_grafana.1.sarh3wconre4ua64232k8grhs
17463b4bf49b        portainer/portainer:1.22.0   "/portainer -H tcp:/…"   11 seconds ago      Up 5 seconds        9000/tcp            portainer_portainer.1.vv245l0yu2litwqx1o5duskcn
33fe35432499        influxdb:1.5.2               "/entrypoint.sh infl…"   11 seconds ago      Up 9 seconds        8086/tcp            traefik_influxdb.1.q0fugizwnizi1yft6c740x310
174c0bd8e6b7        traefik:2.0.1                "/entrypoint.sh --lo…"   11 seconds ago      Up 9 seconds        80/tcp              traefik_traefik.1.p8vw38svowsuona40t9m8nheg
80b987a00952        portainer/agent:1.4.0        "./agent"                15 seconds ago      Up 14 seconds                           portainer_agent.u1wec6movnxlkaraoryxevfit.imj0ojxfq8c8qk94gwnls4ynu
Test the influxdb path
{"results":[{"statement_id":0,"series":[{"name":"databases","columns":["name"],"values":[["_internal"]]}]}]}

Test the portainer path
Gateway Timeout
cat the access log
10.255.0.2 - - [02/Oct/2019:02:47:34 +0000] "GET /influxdb/query?q=SHOW%20DATABASES HTTP/1.1" 200 109 "-" "-" 1 "influxdb@docker" "http://10.0.10.158:8086" 6ms
10.255.0.2 - - [02/Oct/2019:02:47:34 +0000] "GET /portainer HTTP/1.1" 504 15 "-" "-" 2 "portainer@docker" "http://10.255.0.141:9000" 29970ms
```

The route to http://localhost/portainer fails. The traefik.access.log and traefik.log from this test have been added to the repo.

When I tried to addin the `--providers.docker.swarmMode=true` flag to the traefik startup, pretty much nothing worked.
