# ToDo !!!!!!
#execute 'curl https://sdk.cloud.google.com | bash'

execute '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

homebrew_tap 'aws/tap' do
  homebrew_path '/home/linuxbrew/.linuxbrew/bin/brew'
end
homebrew_package 'aws-sam-cli'

homebrew_package 'k9s'
homebrew_package 'argocd'
homebrew_package 'argoproj/tap/kubectl-argo-rollouts'
homebrew_package 'kayac/tap/ecspresso'
homebrew_package 'dive'
homebrew_package 'gh'
