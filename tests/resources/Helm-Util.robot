# Copyright Project Harbor Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

*** Settings ***
Documentation  This resource provides helper functions for docker operations
Library  OperatingSystem
Library  Process

*** Keywords ***
Prepare Helm Plugin
    Wait Unitl Command Success  helm init --stable-repo-url https://charts.helm.sh/stable --client-only
    Wait Unitl Command Success  helm plugin install https://github.com/chartmuseum/helm-push
    Wait Unitl Command Success  helm3 plugin install https://github.com/chartmuseum/helm-push

Helm3.7 Registry Login
    [Arguments]  ${ip}  ${user}  ${password}
    Wait Unitl Command Success  helm3.7 registry login ${ip} -u ${user} -p ${password}

Helm3.7 Package
    [Arguments]  ${file_path}
    Wait Unitl Command Success  helm3.7 package ${file_path}

Helm3.7 Push
    [Arguments]  ${file_path}  ${ip}  ${repo_name}
    Wait Unitl Command Success  helm3.7 push ${file_path} oci://${ip}/${repo_name}

Helm3.7 Pull
    [Arguments]  ${ip}  ${repo_name}  ${version}
    Wait Unitl Command Success  helm3.7 pull oci://${ip}/${repo_name}/harbor --version ${version}

Helm3.7 Registry Logout
    [Arguments]  ${ip}
    Wait Unitl Command Success  helm3.7 registry logout ${ip}