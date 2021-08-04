terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  action               = "bd-learn-disable"
  admin_state          = true
  detection_interval   = 90
  detection_multiplier = 10
}

data "aci_rest" "epLoopProtectP" {
  dn = "uni/infra/epLoopProtectP-default"

  depends_on = [module.main]
}

resource "test_assertions" "epLoopProtectP" {
  component = "epLoopProtectP"

  equal "action" {
    description = "action"
    got         = data.aci_rest.epLoopProtectP.content.action
    want        = "bd-learn-disable"
  }

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.epLoopProtectP.content.adminSt
    want        = "enabled"
  }

  equal "loopDetectIntvl" {
    description = "loopDetectIntvl"
    got         = data.aci_rest.epLoopProtectP.content.loopDetectIntvl
    want        = "90"
  }

  equal "loopDetectMult" {
    description = "loopDetectMult"
    got         = data.aci_rest.epLoopProtectP.content.loopDetectMult
    want        = "10"
  }
}
