local claims = std.extVar('claims');

local adminGroupId = "6692ebe7-e899-4891-beab-c73f04e86bf7";
local editorGroupId = "29660228-9734-43bd-b302-a1dfead8eb7a";
local viewerGroupId = "dd374070-6b72-43a2-9fd9-63b37bddd2eb";

local groups =
  if std.objectHas(claims, "groups") && std.isArray(claims.groups)
  then claims.groups
  else [];

local mappedGroups = std.filter(function(x) x != "", [
  if std.member(groups, adminGroupId) then "Organization Admins" else "",
  if std.member(groups, editorGroupId) then "Editor" else "",
  if std.member(groups, viewerGroupId) then "Viewer" else "",
]);

{
  identity: {
    traits: {
      email:
        if std.objectHas(claims, "email") && claims.email != "" then claims.email
        else if std.objectHas(claims, "preferred_username") && claims.preferred_username != "" then claims.preferred_username
        else if std.objectHas(claims, "upn") && claims.upn != "" then claims.upn
        else "",

      first_name:
        if std.objectHas(claims, "given_name")
        then claims.given_name
        else "",

      last_name:
        if std.objectHas(claims, "family_name")
        then claims.family_name
        else "",

      idp_groups: mappedGroups,
    },
  },
}