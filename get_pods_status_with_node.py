import subprocess
import json
import csv
import argparse
from datetime import datetime, timezone
import sys

def run_kubectl_command(namespace):
    try:
        cmd = ['kubectl', 'get', 'pods', '-n', namespace, '-o', 'json']
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error executing kubectl command: {e.stderr}", file=sys.stderr)
        sys.exit(1)

def parse_pod_info(pods_json):
    pod_data = []
    for pod in pods_json.get('items', []):
        pod_name = pod['metadata']['name']
        pod_status = pod['status']['phase']

        # Node Name
        node_name = pod['spec'].get('nodeName', 'N/A')

        # Calculate 'Ready' containers
        total_containers = len(pod['spec']['containers'])
        ready_containers = 0
        container_statuses = pod['status'].get('containerStatuses', [])
        for c in container_statuses:
            if c.get('ready', False):
                ready_containers += 1
        ready = f"{ready_containers}/{total_containers}"

        # Calculate total restarts
        restarts = sum(c.get('restartCount', 0) for c in container_statuses)

        # Calculate pod age
        creation_timestamp = pod['metadata'].get('creationTimestamp', None)
        age = calculate_age(creation_timestamp)

        pod_data.append({
            'Pod Name': pod_name,
            'Status': pod_status,
            'Ready': ready,
            'Restarts': restarts,
            'Age': age,
            'Node': node_name
        })
    return pod_data

def calculate_age(creation_timestamp):
    if not creation_timestamp:
        return 'N/A'
    try:
        creation_time = datetime.strptime(creation_timestamp, "%Y-%m-%dT%H:%M:%SZ")
        now = datetime.now(timezone.utc)
        age_timedelta = now - creation_time.replace(tzinfo=timezone.utc)
        return format_timedelta(age_timedelta)
    except Exception:
        return 'N/A'

def format_timedelta(td):
    days = td.days
    hours, remainder = divmod(td.seconds, 3600)
    minutes, _ = divmod(remainder, 60)

    parts = []
    if days > 0:
        parts.append(f"{days}d")
    if hours > 0:
        parts.append(f"{hours}h")
    if minutes > 0:
        parts.append(f"{minutes}m")

    return ' '.join(parts) if parts else '0m'

def write_to_csv(pod_data, output_file):
    fieldnames = ['Pod Name', 'Status', 'Ready', 'Restarts', 'Age', 'Node']
    try:
        with open(output_file, mode='w', newline='', encoding='utf-8') as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
            writer.writeheader()
            for row in pod_data:
                writer.writerow(row)
        print(f"Pod statuses have been written to '{output_file}'.")
    except IOError as e:
        print(f"Error writing to CSV file: {e}", file=sys.stderr)
        sys.exit(1)

def main():
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description='Get all pods and their statuses in a namespace.')
    parser.add_argument('namespace', help='The Kubernetes namespace to query.')
    parser.add_argument('--output', default='pods_status.csv', help='Output CSV file name.')
    args = parser.parse_args()

    namespace = args.namespace
    output_file = args.output

    # Get pod information using kubectl
    kubectl_output = run_kubectl_command(namespace)

    # Parse JSON output
    try:
        pods_json = json.loads(kubectl_output)
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON output: {e}", file=sys.stderr)
        sys.exit(1)

    # Extract pod data
    pod_data = parse_pod_info(pods_json)

    # Write data to CSV
    write_to_csv(pod_data, output_file)

if __name__ == "__main__":
    main()
