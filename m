Return-Path: <linux-efi+bounces-6084-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHL5D4jXgWlYKgMAu9opvQ
	(envelope-from <linux-efi+bounces-6084-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 12:10:00 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4553D8166
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551C63067044
	for <lists+linux-efi@lfdr.de>; Tue,  3 Feb 2026 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C784328631;
	Tue,  3 Feb 2026 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNrsjF8B"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E8323406;
	Tue,  3 Feb 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116997; cv=none; b=GjA9x/pE8JNPjZA4bqNKnOadHkVNPU/heJ3juUjWw2lG5mQkYIZRF/bzno7fGiRzRvaspwaJeL9mKo9p8/LF/ciZHvyanjseBDXMDPGsylwnmwpWGoyfqJFORo2n8xwQUWgPdqIOZQ9ttAWFG88lBgA5VDZkg6zkqnMa26Fu0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116997; c=relaxed/simple;
	bh=56R1y2uK0WuvOdgZJclIVIEh40jpSjHWy/rEnFSTa0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPp2tiMhs4MtgGYPDLGAQP8cqsc4ceCYgDaOqKKsykFvqygDB194B5FaNM8HstbS2svWWF06MftKCTvKnWT4UKsI7d6FARf1qUAVH+K5vodsWVQowz3FCMjZREnfdjyxCGAUKDWymXXSZJAmhiNskx/m0yhG0ARuOrVGRVyJSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNrsjF8B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770116996; x=1801652996;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=56R1y2uK0WuvOdgZJclIVIEh40jpSjHWy/rEnFSTa0o=;
  b=CNrsjF8B4UfOpmrDYEi83CKK/BpgB5QpKYGUu+brhTQEk0lST82KA5T7
   fKPbBqRTWKfkTuzq6wiyHH240+MhTspUXVptlENmKx0KpjPZE2YvHzJT5
   HL++qgDigcIiRtroDzVpaH09x3xdiBFpgY/x/iNeXXUeDvaOh6f64YgPT
   2MjqrylH7QS1UuQmcAeyln4lO+BzYUGGFQvHEZROD+omwlueM9NhZrAh7
   2gEtR8+z+XP9PucybTTlKTFEGVEC8J+kPN5v8U4GMgBG4qq/f6SvBa/uk
   X88XhzzaX4eq68SGPgUBXXPDrLo0d6hQu0OTO+o5ShONMdh1lk/aFGBX1
   g==;
X-CSE-ConnectionGUID: j4NM1CDCTU6x1RW4+S3cwA==
X-CSE-MsgGUID: lNR+/oxBRz+jNBVdII3TYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71324875"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71324875"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:09:55 -0800
X-CSE-ConnectionGUID: OxGEck8HTBaQAzssDpnRaQ==
X-CSE-MsgGUID: tc1n5BauSTyToFVHotTZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="247426838"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:09:49 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, Ard Biesheuvel
 <ardb@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas
 <javierm@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar
 <mingo@kernel.org>, Francesco Pompo <francescopompo2@gmail.com>, Lenny
 Szubowicz <lszubowi@redhat.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/2] drm/i915/display: Disable display for iMac's
In-Reply-To: <20260203073130.1111-3-atharvatiwarilinuxdev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260203073130.1111-1-atharvatiwarilinuxdev@gmail.com>
 <20260203073130.1111-3-atharvatiwarilinuxdev@gmail.com>
Date: Tue, 03 Feb 2026 13:09:46 +0200
Message-ID: <f24d637ed1a44014a27d420c2a7137ed52e29982@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6084-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,intel.com,linux.intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: B4553D8166
X-Rspamd-Action: no action

On Tue, 03 Feb 2026, Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:
> Disable display on iMacs, as they can't do link training
> on the internal display.
>
> (tested on iMac20,1)

I thought there were open review comments about this. Why are you
resending the same thing?

BR,
Jani.


>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  .../gpu/drm/i915/display/intel_display_device.c    | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/driver=
s/gpu/drm/i915/display/intel_display_device.c
> index 1170afaa8680..b1fec1018d7e 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -3,6 +3,7 @@
>   * Copyright =C2=A9 2023 Intel Corporation
>   */
>=20=20
> +#include <linux/dmi.h>
>  #include <linux/pci.h>
>=20=20
>  #include <drm/drm_color_mgmt.h>
> @@ -1435,7 +1436,18 @@ static bool has_no_display(struct pci_dev *pdev)
>  		{}
>  	};
>=20=20
> -	return pci_match_id(ids, pdev);
> +	static const struct dmi_system_id dmi_ids[] =3D {
> +		{
> +			.ident =3D "Apple Inc. iMac",
> +			.matches =3D {
> +				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "iMac"),
> +			}
> +		},
> +		{}
> +	};
> +
> +	return pci_match_id(ids, pdev) || dmi_check_system(dmi_ids);
>  }
>=20=20
>  #define INTEL_DISPLAY_DEVICE(_id, _desc) { .devid =3D (_id), .desc =3D (=
_desc) }

--=20
Jani Nikula, Intel

