# ToDo !!!!!!
#execute 'curl https://sdk.cloud.google.com | bash'

execute '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

homebrew_tap 'aws/tap' do
  homebrew_path '/home/linuxbrew/.linuxbrew/bin/brew'
end
homebrew_package 'aws-sam-cli'

homebrew_package 'k9s'
homebrew_package 'argoproj/tap/kubectl-argo-rollouts'

apt_repository 'terraform' do
  arch 'amd64'
  components ['main']
  uri 'https://apt.releases.hashicorp.com'
  key 'https://apt.releases.hashicorp.com/gpg'
end
package 'terraform'
