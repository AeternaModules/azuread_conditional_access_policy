variable "conditional_access_policies" {
  description = <<EOT
Map of conditional_access_policies, attributes below
Required:
    - display_name
    - state
    - conditions (block):
        - applications (required, block):
            - excluded_applications (optional)
            - filter (optional, block):
                - mode (required)
                - rule (required)
            - included_applications (optional)
            - included_user_actions (optional)
        - authentication_flow_transfer_methods (optional)
        - client_app_types (required)
        - client_applications (optional, block):
            - excluded_service_principals (optional)
            - filter (optional, block):
                - mode (required)
                - rule (required)
            - included_service_principals (optional)
        - devices (optional, block):
            - filter (optional, block):
                - mode (required)
                - rule (required)
        - insider_risk_levels (optional)
        - locations (optional, block):
            - excluded_locations (optional)
            - included_locations (required)
        - platforms (optional, block):
            - excluded_platforms (optional)
            - included_platforms (required)
        - service_principal_risk_levels (optional)
        - sign_in_risk_levels (optional)
        - user_risk_levels (optional)
        - users (required, block):
            - excluded_groups (optional)
            - excluded_guests_or_external_users (optional, block):
                - external_tenants (optional, block):
                    - members (optional)
                    - membership_kind (required)
                - guest_or_external_user_types (required)
            - excluded_roles (optional)
            - excluded_users (optional)
            - included_groups (optional)
            - included_guests_or_external_users (optional, block):
                - external_tenants (optional, block):
                    - members (optional)
                    - membership_kind (required)
                - guest_or_external_user_types (required)
            - included_roles (optional)
            - included_users (optional)
Optional:
    - grant_controls (block):
        - authentication_strength_policy_id (optional)
        - built_in_controls (optional)
        - custom_authentication_factors (optional)
        - operator (required)
        - terms_of_use (optional)
    - session_controls (block):
        - application_enforced_restrictions_enabled (optional)
        - cloud_app_security_policy (optional)
        - disable_resilience_defaults (optional)
        - persistent_browser_mode (optional)
        - sign_in_frequency (optional)
        - sign_in_frequency_authentication_type (optional)
        - sign_in_frequency_interval (optional)
        - sign_in_frequency_period (optional)
EOT

  type = map(object({
    display_name = string
    state        = string
    conditions = object({
      applications = object({
        excluded_applications = optional(list(string))
        filter = optional(object({
          mode = string
          rule = string
        }))
        included_applications = optional(list(string))
        included_user_actions = optional(list(string))
      })
      authentication_flow_transfer_methods = optional(set(string))
      client_app_types                     = list(string)
      client_applications = optional(object({
        excluded_service_principals = optional(list(string))
        filter = optional(object({
          mode = string
          rule = string
        }))
        included_service_principals = optional(list(string))
      }))
      devices = optional(object({
        filter = optional(object({
          mode = string
          rule = string
        }))
      }))
      insider_risk_levels = optional(string)
      locations = optional(object({
        excluded_locations = optional(list(string))
        included_locations = list(string)
      }))
      platforms = optional(object({
        excluded_platforms = optional(list(string))
        included_platforms = list(string)
      }))
      service_principal_risk_levels = optional(list(string))
      sign_in_risk_levels           = optional(list(string))
      user_risk_levels              = optional(list(string))
      users = object({
        excluded_groups = optional(list(string))
        excluded_guests_or_external_users = optional(list(object({
          external_tenants = optional(list(object({
            members         = optional(list(string))
            membership_kind = string
          })))
          guest_or_external_user_types = list(string)
        })))
        excluded_roles  = optional(list(string))
        excluded_users  = optional(list(string))
        included_groups = optional(list(string))
        included_guests_or_external_users = optional(list(object({
          external_tenants = optional(list(object({
            members         = optional(list(string))
            membership_kind = string
          })))
          guest_or_external_user_types = list(string)
        })))
        included_roles = optional(list(string))
        included_users = optional(list(string))
      })
    })
    grant_controls = optional(object({
      authentication_strength_policy_id = optional(string)
      built_in_controls                 = optional(list(string))
      custom_authentication_factors     = optional(list(string))
      operator                          = string
      terms_of_use                      = optional(list(string))
    }))
    session_controls = optional(object({
      application_enforced_restrictions_enabled = optional(bool)
      cloud_app_security_policy                 = optional(string)
      disable_resilience_defaults               = optional(bool)
      persistent_browser_mode                   = optional(string)
      sign_in_frequency                         = optional(number)
      sign_in_frequency_authentication_type     = optional(string)
      sign_in_frequency_interval                = optional(string)
      sign_in_frequency_period                  = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        length(v.display_name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.applications.included_applications == null || (alltrue([for x in v.conditions.applications.included_applications : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.applications.excluded_applications == null || (alltrue([for x in v.conditions.applications.excluded_applications : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.applications.included_user_actions == null || (alltrue([for x in v.conditions.applications.included_user_actions : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.applications.filter == null || (length(v.conditions.applications.filter.rule) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.client_applications == null || (v.conditions.client_applications.included_service_principals == null || (alltrue([for x in v.conditions.client_applications.included_service_principals : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.client_applications == null || (v.conditions.client_applications.excluded_service_principals == null || (alltrue([for x in v.conditions.client_applications.excluded_service_principals : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.client_applications == null || (v.conditions.client_applications.filter == null || (length(v.conditions.client_applications.filter.rule) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.included_users == null || (alltrue([for x in v.conditions.users.included_users : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.excluded_users == null || (alltrue([for x in v.conditions.users.excluded_users : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.included_groups == null || (alltrue([for x in v.conditions.users.included_groups : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.excluded_groups == null || (alltrue([for x in v.conditions.users.excluded_groups : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.included_roles == null || (alltrue([for x in v.conditions.users.included_roles : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.excluded_roles == null || (alltrue([for x in v.conditions.users.excluded_roles : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.included_guests_or_external_users == null || alltrue([for item in v.conditions.users.included_guests_or_external_users : (item.external_tenants == null || alltrue([for item in item.external_tenants : (item.members == null || (alltrue([for x in item.members : length(x) > 0])))]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.users.excluded_guests_or_external_users == null || alltrue([for item in v.conditions.users.excluded_guests_or_external_users : (item.external_tenants == null || alltrue([for item in item.external_tenants : (item.members == null || (alltrue([for x in item.members : length(x) > 0])))]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.devices == null || (v.conditions.devices.filter == null || (length(v.conditions.devices.filter.rule) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.locations == null || (alltrue([for x in v.conditions.locations.included_locations : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.conditions.locations == null || (v.conditions.locations.excluded_locations == null || (alltrue([for x in v.conditions.locations.excluded_locations : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.grant_controls == null || (contains(["AND", "OR"], v.grant_controls.operator))
      )
    ])
    error_message = "must be one of: AND, OR"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.grant_controls == null || (v.grant_controls.custom_authentication_factors == null || (alltrue([for x in v.grant_controls.custom_authentication_factors : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.grant_controls == null || (v.grant_controls.terms_of_use == null || (alltrue([for x in v.grant_controls.terms_of_use : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.conditional_access_policies : (
        v.session_controls == null || (v.session_controls.sign_in_frequency == null || (v.session_controls.sign_in_frequency >= 0))
      )
    ])
    error_message = "must be at least 0"
  }
  # Note: 24 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

