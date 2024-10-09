import subprocess
import json
import csv
import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py NAMESPACE")
        sys.exit(1)
    namespace = sys.argv[1]

    # Get pods in the namespace
    cmd = ['kubectl', 'get', 'pods', '-n', namespace, '-o', 'json']
    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    if result.returncode != 0:
        print("Error getting pods:", result.stderr)
        sys.exit(1)

    pods = json.loads(result.stdout)
    data = []

    for pod in pods['items']:
        pod_name = pod['metadata']['name']
        volumes = pod['spec'].get('volumes', [])
        volume_dict = {}
        for volume in volumes:
            volume_name = volume['name']
            if 'persistentVolumeClaim' in volume:
                pvc_name = volume['persistentVolumeClaim']['claimName']
                volume_dict[volume_name] = pvc_name
            else:
                volume_dict[volume_name] = None  # Not a PVC

        containers = pod['spec'].get('containers', [])
        for container in containers:
            container_name = container['name']
            volume_mounts = container.get('volumeMounts', [])
            for volume_mount in volume_mounts:
                vol_name = volume_mount['name']
                mount_path = volume_mount['mountPath']
                pvc_name = volume_dict.get(vol_name)
                if pvc_name:
                    # This is a PVC mounted in this container
                    # Exec into the container and get usage
                    # Run 'df -k mount_path' or 'du -sk mount_path'
                    cmd = ['kubectl', 'exec', '-n', namespace, pod_name, '-c', container_name, '--', 'df', '-k', mount_path]
                    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                    if result.returncode != 0:
                        usage = 'Error: ' + result.stderr.strip()
                        capacity = ''
                        usage_percent = ''
                    else:
                        # Parse the output of df
                        lines = result.stdout.strip().split('\n')
                        if len(lines) >= 2:
                            # Assuming the last line has the info
                            # Filesystem     1K-blocks    Used Available Use% Mounted on
                            parts = lines[-1].split()
                            if len(parts) >= 6:
                                filesystem = parts[0]
                                size = parts[1]
                                used = parts[2]
                                available = parts[3]
                                use_percent = parts[4]
                                mounted_on = parts[5]
                                usage = used
                                capacity = size
                                usage_percent = use_percent
                            else:
                                usage = 'Error parsing df output'
                                capacity = ''
                                usage_percent = ''
                        else:
                            usage = 'Error: Unexpected df output'
                            capacity = ''
                            usage_percent = ''
                    data.append({
                        'pod_name': pod_name,
                        'container_name': container_name,
                        'pvc_name': pvc_name,
                        'mount_path': mount_path,
                        'usage': usage,
                        'capacity': capacity,
                        'usage_percent': usage_percent
                    })
    # Write to CSV
    fieldnames = ['pod_name', 'container_name', 'pvc_name', 'mount_path', 'usage', 'capacity', 'usage_percent']
    with open('pvc_usage.csv', 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for row in data:
            writer.writerow(row)

if __name__ == '__main__':
    main()
