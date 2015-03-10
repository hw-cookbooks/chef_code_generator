
context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)

# cookbook root dir
directory cookbook_dir

# metadata.rb
template "#{cookbook_dir}/metadata.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# README
template "#{cookbook_dir}/README.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# CONTRIBUTING
cookbook_file "#{cookbook_dir}/CONTRIBUTING.md"

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

# Bundler
cookbook_file "#{cookbook_dir}/Gemfile"

# Guard
cookbook_file "#{cookbook_dir}/Guardfile"

# Rubocop
cookbook_file "#{cookbook_dir}/.rubocop.yml" do
  source 'rubocop.yml'
end

# Librarian
template "#{cookbook_dir}/Cheffile" do
  source "Cheffile.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# TK
template "#{cookbook_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

directory "#{cookbook_dir}/test/integration/default/serverspec" do
  recursive true
end

template "#{cookbook_dir}/test/integration/default/serverspec/default_spec.rb" do
  source 'serverspec_default_spec.rb.erb'
end

directory "#{cookbook_dir}/test/integration/helpers/serverspec" do
  recursive true
end

template "#{cookbook_dir}/test/integration/helpers/serverspec/spec_helper.rb" do
  source "serverspec_spec_helper.rb.erb"
end

# ChefSpec
directory "#{cookbook_dir}/test/unit"

%w( default_spec spec_helper ).each do |specfile|
  template "#{cookbook_dir}/test/unit/#{specfile}.rb" do
    source "chefspec_#{specfile}.rb.erb"
    helpers(ChefDK::Generator::TemplateHelper)
    action :create_if_missing
  end
end

# Recipes

directory "#{cookbook_dir}/recipes"

template "#{cookbook_dir}/recipes/default.rb" do
  source "default_recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# git
if context.have_git
  if !context.skip_git_init

    execute("initialize-git") do
      command("git init .")
      cwd cookbook_dir
    end
  end

  cookbook_file "#{cookbook_dir}/.gitignore" do
    source "gitignore"
  end
end
