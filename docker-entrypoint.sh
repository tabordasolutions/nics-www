#!/bin/bash

if [ ! -d /opt/forgerock/openam-web-policy-agent-3.3.4/apache24_agent/Agent_001 ]; then
  /opt/forgerock/openam-web-policy-agent-3.3.4/apache24_agent/bin/agentadmin \
    --install \
    --useResponse /root/responses.txt \
    --acceptLicense
fi

apache2ctl -DFOREGROUND
