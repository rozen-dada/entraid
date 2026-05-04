local claims = std.extVar('claims');

{
  identity: {
    traits: {
      email:
        if std.objectHas(claims, "email") && claims.email != "" then claims.email
        else if std.objectHas(claims, "preferred_username") && claims.preferred_username != "" then claims.preferred_username
        else if std.objectHas(claims, "upn") && claims.upn != "" then claims.upn
        else "",

      first_name: if std.objectHas(claims, "given_name") then claims.given_name else "",
      last_name: if std.objectHas(claims, "family_name") then claims.family_name else "",
    },
  },
}
