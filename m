Return-Path: <linux-efi+bounces-6044-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPNLFWQqeml/3gEAu9opvQ
	(envelope-from <linux-efi+bounces-6044-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:25:24 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855CA3BEB
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2D5303AA84
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856C36BCCF;
	Wed, 28 Jan 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y41BOaKW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE75280CF6;
	Wed, 28 Jan 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613843; cv=none; b=acsS0KLJqcsgmsOOZmNumVBv6Wv/vbunR6/s2cHwTpRkYj9JA8c0AKxNS46kSkoS6q7FUVW/AudekLhE0mAmkEcQVFbMpBBJL0Hfeccse7XLcPO/Z8YjFdUnDyz5M6uaCjPreb+1wYfrmDtp/ghtEigoYDHvT2cNF6pSM3vAgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613843; c=relaxed/simple;
	bh=xA/cLH3p3j7UsPePj5u+LBkikGeRVEePxWLy+SJODAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MIOIks/QMQ8YW7oAao93pZ9TlqLzcRKxHGdwD9AEKyhN9KJ6yYjyJkCc76soPsDr9yx21F1/ZXlMvl/PowgIqdv1eBa6X9MYac2qRgqrzN87ThxheZZ64r4PS6L67t8ly5V/tidQq7DceIcEN4wH4DxAPJHp7+UyFhTqQpgyBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y41BOaKW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769613840; x=1801149840;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xA/cLH3p3j7UsPePj5u+LBkikGeRVEePxWLy+SJODAk=;
  b=Y41BOaKWmU4BIUpi5icRnKLFLptBL9OVf19EQfRcYLpBqtyQ6dPk9Bj9
   foN4axb86lqUfING3+VyEMs8IlQt3HKLvJosZ9nIGSS+EsKC5vqeUROR9
   PODMLtVFaP2eN5rZ500cXNiKAS+LWEU4j8+qPKXjsFHy5FkDeXyHikF8k
   6Vfqv0Pod103RH2UYXfHc49s5X+2SgUJXlb80dYPsSCCUrXw2XrWZ0vgD
   9omHmbSZoHovu3c86TAkEcXePDRPMcZeJIg2Wj7pE9VV0IdWtfNyqmuHM
   V5fg2az6zm+5qYTCNYAAKRZos0VPOy6tX/yWG4iJTdo2zyMCPDDFyH9ST
   g==;
X-CSE-ConnectionGUID: 6CZVHe4WT5aI7eqMX6dQWw==
X-CSE-MsgGUID: Xl5ns56bTXWVHKnKyctYXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70546749"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70546749"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:24:00 -0800
X-CSE-ConnectionGUID: ujyiKXTLQoWwg/FzKCQVMA==
X-CSE-MsgGUID: a4l5P1gKQ8yqjSCXIm0q0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212780268"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.207])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:23:54 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, Ard Biesheuvel
 <ardb@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas
 <javierm@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Lenny
 Szubowicz <lszubowi@redhat.com>, Francesco Pompo
 <francescopompo2@gmail.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/i915/display: Disable display for iMac's
In-Reply-To: <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
 <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
Date: Wed, 28 Jan 2026 17:23:51 +0200
Message-ID: <26c4e0b7f9c25f405401288d13fc7e5097e9c7f5@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6044-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,intel.com,linux.intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 6855CA3BEB
X-Rspamd-Action: no action

On Wed, 28 Jan 2026, Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:
> Disable display on iMacs, as they can't do link training
> on the internal display.

I'd expand on that a bit, based on the previous discussion.

>
> (tested on iMac20,1)
>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

I can't test this, but if nobody chimes in to oppose, I'll take it.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


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

