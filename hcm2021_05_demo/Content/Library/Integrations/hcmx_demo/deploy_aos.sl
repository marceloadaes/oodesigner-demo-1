namespace: Integrations.hcmx_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: demo.hcmx.local
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 235
        'y': 88
      install_java:
        x: 429
        'y': 84
      install_tomcat:
        x: 630
        'y': 98
      install_aos_application:
        x: 837
        'y': 92
        navigate:
          2f59b90b-af52-a935-036f-52eff3acc96b:
            targetId: 53ccf5bd-0f43-9083-5916-fe801a857a6a
            port: SUCCESS
    results:
      SUCCESS:
        53ccf5bd-0f43-9083-5916-fe801a857a6a:
          x: 1037
          'y': 96
