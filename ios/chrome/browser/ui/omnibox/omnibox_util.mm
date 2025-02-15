// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "ios/chrome/browser/ui/omnibox/omnibox_util.h"

#include "base/notreached.h"
#include "base/strings/utf_string_conversions.h"
#include "ios/chrome/browser/ui/ui_feature_flags.h"
#include "ios/chrome/grit/ios_theme_resources.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#pragma mark - Suggestion icons.

OmniboxSuggestionIconType GetOmniboxSuggestionIconTypeForAutocompleteMatchType(
    AutocompleteMatchType::Type type,
    bool is_starred) {
  if (is_starred)
    return BOOKMARK;

  switch (type) {
    case AutocompleteMatchType::BOOKMARK_TITLE:
    case AutocompleteMatchType::CLIPBOARD_URL:
    case AutocompleteMatchType::NAVSUGGEST:
    case AutocompleteMatchType::NAVSUGGEST_PERSONALIZED:
    case AutocompleteMatchType::PHYSICAL_WEB_DEPRECATED:
    case AutocompleteMatchType::PHYSICAL_WEB_OVERFLOW_DEPRECATED:
    case AutocompleteMatchType::URL_WHAT_YOU_TYPED:
    case AutocompleteMatchType::DOCUMENT_SUGGESTION:
    case AutocompleteMatchType::PEDAL:
      return DEFAULT_FAVICON;
    case AutocompleteMatchType::HISTORY_BODY:
    case AutocompleteMatchType::HISTORY_KEYWORD:
    case AutocompleteMatchType::HISTORY_TITLE:
    case AutocompleteMatchType::HISTORY_URL:
    case AutocompleteMatchType::TAB_SEARCH_DEPRECATED:
      return DEFAULT_FAVICON;
    case AutocompleteMatchType::CONTACT_DEPRECATED:
    case AutocompleteMatchType::SEARCH_OTHER_ENGINE:
    case AutocompleteMatchType::SEARCH_SUGGEST:
    case AutocompleteMatchType::SEARCH_SUGGEST_ENTITY:
    case AutocompleteMatchType::SEARCH_SUGGEST_PERSONALIZED:
    case AutocompleteMatchType::SEARCH_SUGGEST_PROFILE:
    case AutocompleteMatchType::SEARCH_SUGGEST_TAIL:
    case AutocompleteMatchType::SEARCH_WHAT_YOU_TYPED:
    case AutocompleteMatchType::VOICE_SUGGEST:
    case AutocompleteMatchType::CLIPBOARD_TEXT:
    case AutocompleteMatchType::CLIPBOARD_IMAGE:
      return SEARCH;
    case AutocompleteMatchType::SEARCH_HISTORY:
      return SEARCH_HISTORY;
    case AutocompleteMatchType::CALCULATOR:
      return CALCULATOR;
    case AutocompleteMatchType::EXTENSION_APP_DEPRECATED:
    case AutocompleteMatchType::TILE_SUGGESTION:
    case AutocompleteMatchType::NUM_TYPES:
      NOTREACHED();
      return DEFAULT_FAVICON;
  }
}

UIImage* GetOmniboxSuggestionIconForAutocompleteMatchType(
    AutocompleteMatchType::Type type,
    bool is_starred) {
  OmniboxSuggestionIconType iconType =
      GetOmniboxSuggestionIconTypeForAutocompleteMatchType(type, is_starred);
  return GetOmniboxSuggestionIcon(iconType);
}

#pragma mark - Security icons.

// Returns the asset with "always template" rendering mode.
UIImage* GetLocationBarSecurityIcon(LocationBarSecurityIconType iconType) {
  NSString* imageName = GetLocationBarSecurityIconTypeAssetName(iconType);
  return [[UIImage imageNamed:imageName]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

// Converts the |security_level| to an appropriate security icon type.
LocationBarSecurityIconType GetLocationBarSecurityIconTypeForSecurityState(
    security_state::SecurityLevel security_level) {
  switch (security_level) {
    case security_state::NONE:
      return INFO;
    case security_state::WARNING:
      if (security_state::ShouldShowDangerTriangleForWarningLevel())
        return NOT_SECURE_WARNING;
      return INFO;
    case security_state::EV_SECURE:
    case security_state::SECURE:
    case security_state::SECURE_WITH_POLICY_INSTALLED_CERT:
      return SECURE;
    case security_state::DANGEROUS:
      return NOT_SECURE_WARNING;
    case security_state::SECURITY_LEVEL_COUNT:
      NOTREACHED();
      return LOCATION_BAR_SECURITY_ICON_TYPE_COUNT;
  }
}

// Converts the |security_level| to an appropriate icon in "always template"
// rendering mode.
UIImage* GetLocationBarSecurityIconForSecurityState(
    security_state::SecurityLevel security_level) {
  LocationBarSecurityIconType iconType =
      GetLocationBarSecurityIconTypeForSecurityState(security_level);
  return GetLocationBarSecurityIcon(iconType);
}
