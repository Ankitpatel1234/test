from google.cloud import compute_v1

instance_client = compute_v1.InstancesClient()
project_id = "ankit-sbx-sbx-6650"
zone = "us-east4-b"

instance_list = instance_client.list(project=project_id, zone=zone)

# Get the list of virtual machine instances in your project


# Iterate through the list of instances and print the information
for instance in instance_list:
    print("Instance Name: ", instance.name)
    print("Instance Zone: ", instance.zone)
    print("Instance Machine Type: ", instance.machine_type)
    print("Instance Status: ", instance.status)
    print("\n")
