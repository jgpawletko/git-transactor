Given(/^that the remote repository exists$/) do
  @remote_repo_path = 'features/fixtures/remote_repo/blerf'

  @remote_repo = TestRepo.new(@remote_repo_path)
  @remote_repo.nuke
  @remote_repo.init
end

Given(/^that the local repository exists and was cloned from the remote repository$/) do
  @local_repo_parent = 'features/fixtures/local_repo'
  td = TestDir.new(@local_repo_parent)
  td.nuke
  @local_repo_name = 'blerf'
  @local_repo_path = File.join(@local_repo_parent, @local_repo_name)
  Git.clone(@remote_repo.path, @local_repo_name, path: @local_repo_parent)
end

Given(/^the local repository has changes that the remote repository does not$/) do
  rel_path = 'oranges/blueberries.txt'
  subdir = rel_path.split('/')[0]

  @local_repo = TestRepo.new(@local_repo_path)
  @local_repo.open
  @local_repo.create_sub_directory(subdir)
  @local_repo.create_file(rel_path, 'meaningless drivel')
  @local_repo.add(rel_path)
  @local_repo.commit("Updating file #{rel_path}")
  match = @local_repo.status.select {|x| x.path == rel_path }
   expect(match).not_to be_empty
  match = @remote_repo.status.select {|x| x.path == rel_path }
   expect(match).to be_empty
end

When(/^I push the local repository to the remote repository$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the local repository and the remote repository should be in the same state$/) do
  pending # express the regexp above with the code you wish you had
end