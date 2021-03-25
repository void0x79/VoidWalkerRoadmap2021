#!/bin/bash

KEYS="$(kubectl exec --stdin vault-server-0 -n spotify -- vault operator init -recovery-shares=3 -recovery-shares=2 -format=json)"
echo $KEYS | jq