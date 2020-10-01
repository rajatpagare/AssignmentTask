platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

use_frameworks!

def pods
  pod 'Alamofire', '5.0.0'
end

target 'AssignmentTask' do

  pods

  target 'AssignmentTaskTests' do
    inherit! :search_paths
    pod 'Quick', '~> 2.2.0'
    pod 'Nimble', '~> 8.0.5'
  end
  
end

target 'AssignmentTask-Dev' do
    pods
end

target 'AssignmentTask-Staging' do
    pods
end
