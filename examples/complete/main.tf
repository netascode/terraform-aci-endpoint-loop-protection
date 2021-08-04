module "aci_endpoint_loop_protection" {
  source = "netascode/endpoint-loop-protection/aci"

  action               = "bd-learn-disable"
  admin_state          = true
  detection_interval   = 90
  detection_multiplier = 10
}
