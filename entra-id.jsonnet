local claims = std.extVar('claims');

local entra_groups =
  if std.objectHas(claims, "groups") then claims.groups else [];

{
  identity: {
    traits: {
      email:
        if std.objectHas(claims, "email") && claims.email != "" then claims.email
        else if std.objectHas(claims, "preferred_username") && claims.preferred_username != "" then claims.preferred_username
        else if std.objectHas(claims, "upn") && claims.upn != "" then claims.upn
        else "",

      first_name:
        if std.objectHas(claims, "given_name") then claims.given_name else "",

      last_name:
        if std.objectHas(claims, "family_name") then claims.family_name else "",

      idp_groups:
        std.flattenArrays([
          // Entra Admin group → Paralus Organization Admins
          if std.member(entra_groups, "f8e443a8-aadc-4d17-a45e-6a5defe0433a")
          then ["Organization Admins"]
          else [],

          // Entra Editor group → Paralus Editor
          if std.member(entra_groups, "d5055f14-ea82-4ce6-80bc-27059f26eaac")
          then ["Editor"]
          else [],

          // Entra Viewer group → Paralus Viewer
          if std.member(entra_groups, "57852313-6da5-4ccd-8219-14b6886b6aff")
          then ["Viewer"]
          else [],
        ]),
    },
  },
}