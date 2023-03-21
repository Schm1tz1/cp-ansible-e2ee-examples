# E2EE-Libraries Deployment with CP-Ansible
This is an deployment example for the CSID E2EE-Accelerator / Libraries to be used with an existing CP-Ansible-Installation. It requires a working Connect node in the cluster.
You should have some basic understanding on the E2EE package before going into the detailed configuration. Please also refer to to official documentation: https://animated-disco-b348e9b1.pages.github.io/ and the samples / training repos: https://github.com/confluentinc/confluent-encryption-samples and https://github.com/confluentinc/confluent-encryption-training
A lot of material can be found via `go/e2e`.

## Steps to install
- Get the e2ee libraries that matches your platform from https://github.com/confluentinc/confluent-encryption/releases
- Unpack all the zip files into a target subdir (e.g. e2ee-2.0.9-cp7.3)
- Adapt you configs according to that subdirectory
- Deploy the libs to your connect host using the `deploy_e2ee.yaml` playbook (e.g. `ansible-playbook -i hosts-connect-replicator-e2ee.yml deploy_e2ee.yml`)
- Create the classpath `create_classpath.sh` anmd add it in in the overrides in you `hosts.yaml` (see create_classpath.sh)
- Re-deploy connect (e.g. `ansible-playbook -i hosts-connect-replicator-e2ee.yml confluent.platform.all --tags kafka_connect --skip-tags package,validate_memory_usage -v`)
- Check startup of connect cluster, remove conflicting jars if needed (e.g. reflections often has conflicts)

## Example: Replicator Setup
Attached is an example configuration for a 2-replicator setup (encrypt/decrypt) with locally (here: as String in prperties) provided wrapping key (KEK) and a dynamically generated AES data key (DEK) that is cached for 120 seconds.
First replicator will replicate an encrypt data from *source_topic* to *destination_topic* and the socond one will replicate and decrypt from *destination_topic* to *decrypted_topic*.
- If you are working with Replicator and CSID E2EE libraries, please make sure you are using the replicator-specific concerters !
- For more information, please refer to to official documentation: https://animated-disco-b348e9b1.pages.github.io/ and the samples / training repos: https://github.com/confluentinc/confluent-encryption-samples and https://github.com/confluentinc/confluent-encryption-training