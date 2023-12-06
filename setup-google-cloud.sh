# Install gcloud cli dependencies
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl sudo

# Ensure google-cloud-sdk.list exists and contains the required repo line
echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

# Download cloud.google.asc if it does not exist
sudo wget -q -O /usr/share/keyrings/cloud.google.asc https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Update APT cache and install gcloud CLI
sudo apt-get update
sudo apt-get install -y google-cloud-cli
