local claims = {
  email_verified: false,
} + std.extVar('claims');

{
  identity: {
    traits: {
      email:
        if "email" in claims then claims.email else "",

      first_name:
        if "given_name" in claims then claims.given_name else "",

      last_name:
        if "family_name" in claims then claims.family_name else "",

      debug_roles:
        if "roles" in claims then claims.roles
        else if "raw_claims" in claims && "roles" in claims.raw_claims then claims.raw_claims.roles
        else ["NO_ROLES_FOUND"],

      debug_groups:
        if "groups" in claims then claims.groups
        else if "raw_claims" in claims && "groups" in claims.raw_claims then claims.raw_claims.groups
        else ["NO_GROUPS_FOUND"],

      idp_groups: ["Viewer"],
    },
  },
}