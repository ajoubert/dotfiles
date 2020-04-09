echo "Did you remember to run that script as with an extra . to keep the current context ?"
minikube_ip=$(
	kubectl get node -o json |
		jq --raw-output \
			'.items[0].status.addresses[]
				| select(.type == "InternalIP")
					.address
			'
);

export MINIKUBE_IP=$minikube_ip

echo "Ip found to be $minikube_ip, I added it as \$MINIKUBE_IP if you ran me correctly :)";
