resource "azuread_conditional_access_policy" "conditional_access_policies" {
  for_each = var.conditional_access_policies

  display_name = each.value.display_name
  state        = each.value.state

  conditions {
    applications {
      excluded_applications = each.value.conditions.applications.excluded_applications
      dynamic "filter" {
        for_each = each.value.conditions.applications.filter != null ? [each.value.conditions.applications.filter] : []
        content {
          mode = filter.value.mode
          rule = filter.value.rule
        }
      }
      included_applications = each.value.conditions.applications.included_applications
      included_user_actions = each.value.conditions.applications.included_user_actions
    }
    authentication_flow_transfer_methods = each.value.conditions.authentication_flow_transfer_methods
    client_app_types                     = each.value.conditions.client_app_types
    dynamic "client_applications" {
      for_each = each.value.conditions.client_applications != null ? [each.value.conditions.client_applications] : []
      content {
        excluded_service_principals = client_applications.value.excluded_service_principals
        dynamic "filter" {
          for_each = client_applications.value.filter != null ? [client_applications.value.filter] : []
          content {
            mode = filter.value.mode
            rule = filter.value.rule
          }
        }
        included_service_principals = client_applications.value.included_service_principals
      }
    }
    dynamic "devices" {
      for_each = each.value.conditions.devices != null ? [each.value.conditions.devices] : []
      content {
        dynamic "filter" {
          for_each = devices.value.filter != null ? [devices.value.filter] : []
          content {
            mode = filter.value.mode
            rule = filter.value.rule
          }
        }
      }
    }
    insider_risk_levels = each.value.conditions.insider_risk_levels
    dynamic "locations" {
      for_each = each.value.conditions.locations != null ? [each.value.conditions.locations] : []
      content {
        excluded_locations = locations.value.excluded_locations
        included_locations = locations.value.included_locations
      }
    }
    dynamic "platforms" {
      for_each = each.value.conditions.platforms != null ? [each.value.conditions.platforms] : []
      content {
        excluded_platforms = platforms.value.excluded_platforms
        included_platforms = platforms.value.included_platforms
      }
    }
    service_principal_risk_levels = each.value.conditions.service_principal_risk_levels
    sign_in_risk_levels           = each.value.conditions.sign_in_risk_levels
    user_risk_levels              = each.value.conditions.user_risk_levels
    users {
      excluded_groups = each.value.conditions.users.excluded_groups
      dynamic "excluded_guests_or_external_users" {
        for_each = each.value.conditions.users.excluded_guests_or_external_users != null ? each.value.conditions.users.excluded_guests_or_external_users : []
        content {
          dynamic "external_tenants" {
            for_each = excluded_guests_or_external_users.value.external_tenants != null ? excluded_guests_or_external_users.value.external_tenants : []
            content {
              members         = external_tenants.value.members
              membership_kind = external_tenants.value.membership_kind
            }
          }
          guest_or_external_user_types = excluded_guests_or_external_users.value.guest_or_external_user_types
        }
      }
      excluded_roles  = each.value.conditions.users.excluded_roles
      excluded_users  = each.value.conditions.users.excluded_users
      included_groups = each.value.conditions.users.included_groups
      dynamic "included_guests_or_external_users" {
        for_each = each.value.conditions.users.included_guests_or_external_users != null ? each.value.conditions.users.included_guests_or_external_users : []
        content {
          dynamic "external_tenants" {
            for_each = included_guests_or_external_users.value.external_tenants != null ? included_guests_or_external_users.value.external_tenants : []
            content {
              members         = external_tenants.value.members
              membership_kind = external_tenants.value.membership_kind
            }
          }
          guest_or_external_user_types = included_guests_or_external_users.value.guest_or_external_user_types
        }
      }
      included_roles = each.value.conditions.users.included_roles
      included_users = each.value.conditions.users.included_users
    }
  }

  dynamic "grant_controls" {
    for_each = each.value.grant_controls != null ? [each.value.grant_controls] : []
    content {
      authentication_strength_policy_id = grant_controls.value.authentication_strength_policy_id
      built_in_controls                 = grant_controls.value.built_in_controls
      custom_authentication_factors     = grant_controls.value.custom_authentication_factors
      operator                          = grant_controls.value.operator
      terms_of_use                      = grant_controls.value.terms_of_use
    }
  }

  dynamic "session_controls" {
    for_each = each.value.session_controls != null ? [each.value.session_controls] : []
    content {
      application_enforced_restrictions_enabled = session_controls.value.application_enforced_restrictions_enabled
      cloud_app_security_policy                 = session_controls.value.cloud_app_security_policy
      disable_resilience_defaults               = session_controls.value.disable_resilience_defaults
      persistent_browser_mode                   = session_controls.value.persistent_browser_mode
      sign_in_frequency                         = session_controls.value.sign_in_frequency
      sign_in_frequency_authentication_type     = session_controls.value.sign_in_frequency_authentication_type
      sign_in_frequency_interval                = session_controls.value.sign_in_frequency_interval
      sign_in_frequency_period                  = session_controls.value.sign_in_frequency_period
    }
  }
}

