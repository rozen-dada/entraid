local claims = {
  email_verified: false,
} + std.extVar('claims');

local roles =
  if "roles" in claims && std.type(claims.roles) == "array"
  then claims.roles
  else [];

local roles_string = "," + std.join(",", roles) + ",";

{
  identity: {
    traits: {
      [if "email" in claims then "email" else null]: claims.email,
      [if "given_name" in claims then "first_name" else null]: claims.given_name,
      [if "family_name" in claims then "last_name" else null]: claims.family_name,

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