output "conditional_access_policies_id" {
  description = "Map of id values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "conditional_access_policies_conditions" {
  description = "Map of conditions values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => one(v.conditions) if v.conditions != null && length(v.conditions) > 0 }
}
output "conditional_access_policies_display_name" {
  description = "Map of display_name values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => v.display_name if v.display_name != null && length(v.display_name) > 0 }
}
output "conditional_access_policies_grant_controls" {
  description = "Map of grant_controls values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => one(v.grant_controls) if v.grant_controls != null && length(v.grant_controls) > 0 }
}
output "conditional_access_policies_object_id" {
  description = "Map of object_id values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => v.object_id if v.object_id != null && length(v.object_id) > 0 }
}
output "conditional_access_policies_session_controls" {
  description = "Map of session_controls values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => one(v.session_controls) if v.session_controls != null && length(v.session_controls) > 0 }
}
output "conditional_access_policies_state" {
  description = "Map of state values across all conditional_access_policies, keyed the same as var.conditional_access_policies"
  value       = { for k, v in azuread_conditional_access_policy.conditional_access_policies : k => v.state if v.state != null && length(v.state) > 0 }
}

