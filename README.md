# E2EE-Libraries Depoyment with CP-Ansible
Works as an add-on on top of CP-Ansible installation, requires existing installation on Connect node.

## Steps to install
- Get the e2ee libraries that matches your platform from https://github.com/confluentinc/confluent-encryption/releases
- Unpack all the zip files into a target subdir (e.g. e2ee-2.0.9-cp7.3)
- Adapt you configs according to that subdirectory
- Deploy the libs to your connect host using the `deploy_e2ee.yaml` playbook (e.g. `ansible-playbook -i hosts-connect-replicator-e2ee.yml deploy_e2ee.yml`)
- Create the classpath `create_classpath.sh` anmd add it in in the overrides in you `hosts.yaml` (see create_classpath.sh)
- Re-deploy connect (e.g. `ansible-playbook -i hosts-connect-replicator-e2ee.yml confluent.platform.all --tags kafka_connect --skip-tags package,validate_memory_usage -v`)
- Check startup of connect cluster, remove conflicting jars if needed (e.g. reflections often has conflicts)
- Attached is an example configuration for a encrypt/decrypt replicator