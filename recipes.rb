execute 'apt-get update'

include_recipe './recipes/kvm.rb'
include_recipe './recipes/openjdk.rb'
include_recipe './recipes/android-sdk.rb'
include_recipe './recipes/x11.rb'
