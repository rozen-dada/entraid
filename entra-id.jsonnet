local claims = {
  email_verified: false,
} + std.extVar('claims');

local roles =
  if "roles" in claims && std.type(claims.roles) == "array"
  then claims.roles
  else if "raw_claims" in claims && "roles" in claims.raw_claims && std.type(claims.raw_claims.roles) == "array"
  then claims.raw_claims.roles
  else [];

local roles_string = "," + std.join(",", roles) + ",";

{
  identity: {
    traits: {
      email:
        if "email" in claims then claims.email else "",

      first_name:
        if "given_name" in claims then claims.given_name else "",

      last_name:
        if "family_name" in claims then claims.family_name else "",

      idp_groups:
        (
          if std.length(std.findSubstr(",Admin,", roles_string)) > 0
          then ["Organization Admins"]
          else []
        ) +
        (
          if std.length(std.findSubstr(",Editor,", roles_string)) > 0
          then ["Editor"]
          else []
        ) +
        (
          if std.length(std.findSubstr(",Viewer,", roles_string)) > 0
          then ["Viewer"]
          else []
        ),
    },
  },
}