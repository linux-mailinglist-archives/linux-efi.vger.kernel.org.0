Return-Path: <linux-efi+bounces-6045-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG43Bncvemlq3wEAu9opvQ
	(envelope-from <linux-efi+bounces-6045-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:47:03 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2BA465B
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 455B730639C1
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F92D77FE;
	Wed, 28 Jan 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVnu31vF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5932D7804;
	Wed, 28 Jan 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614647; cv=none; b=O2muV5jeb9zmHT7bVG4uirkLhCPLTctNMCXLjJFH+uY7cmnL2uFUojVvbgN1z0ps6PN559mrBj7vAqGi3qcPYY0U56/TroP78/5MeOGOyaQ9AiRcnaYPaE2UJ1SRTfHyI/9qqnyV15SgEhNwgih1bJlVExRxxD0adu0VZLB2tIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614647; c=relaxed/simple;
	bh=0wyoV90WmYlDsdIojZFY1AdPgbfCyPWW+8y/M6SlHE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDtBXTL+GREu/19NWVDztzh74VnYP1nqg33Kz4Dxxlvfr/PeAagcSchyjwemFpqnN7FDJuB1xvi0w18IY1kcrSsIYx1LDydvFcKZkys7TSmFUKZ7qoMSCTxmCPymVpYdV4yEVTqQfIdxoFyGn0h8X7N8gg6oh1hAxz+dvB3Ors0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVnu31vF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769614646; x=1801150646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0wyoV90WmYlDsdIojZFY1AdPgbfCyPWW+8y/M6SlHE4=;
  b=YVnu31vFQzt7TQVlmmMc4IEbz4CDfPqGipBCN+bomJ0BV4u1Jv9R42fE
   JziIsH33RRFh5ZMWTqVAyK6Q73U0EzkwwhS/UxAkD2qCmvnFsdXP/7Mu8
   /uLhKpaE6GXBGdIpACkZTyFadnV9Kver0yw0j322qZEQxE1XYXHKrh4c2
   kihwx13jShoGLNgk1vB0FskX7QwGhJFJZzj3TkpXOZpdQDLY4Q2e/9EMU
   54pqafakpp46GIr0lraF1fztVmpNUAnoK8+yF9GQbdfWyTIiB9sejaQxL
   yGvDta00JWpsbXznXiKjuBWNHNmL2HV5XA639Em+Wc/3NQrXDVBLliM2Q
   Q==;
X-CSE-ConnectionGUID: 2YX04WKQSdSCONQX7CjEiw==
X-CSE-MsgGUID: NDleZyB2Tj+zv99ddxGl5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73423404"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73423404"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:37:25 -0800
X-CSE-ConnectionGUID: KTQ67kAaSbu8bA5Ll5fKQg==
X-CSE-MsgGUID: QZTVq2c0S8Gv4W9Dfv9tAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208673485"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:37:21 -0800
Date: Wed, 28 Jan 2026 17:37:18 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	Francesco Pompo <francescopompo2@gmail.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/i915/display: Disable display for iMac's
Message-ID: <aXotLnGvZu4Ib0Vx@intel.com>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
 <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
 <26c4e0b7f9c25f405401288d13fc7e5097e9c7f5@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26c4e0b7f9c25f405401288d13fc7e5097e9c7f5@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,intel.com,linux.intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6045-lists,linux-efi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA2BA465B
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:23:51PM +0200, Jani Nikula wrote:
> On Wed, 28 Jan 2026, Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:
> > Disable display on iMacs, as they can't do link training
> > on the internal display.
> 
> I'd expand on that a bit, based on the previous discussion.
> 
> >
> > (tested on iMac20,1)
> >
> > Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> 
> I can't test this, but if nobody chimes in to oppose, I'll take it.

I guess the main problem with a hack like this is that you won't
be able to get deep pkgC states due to the display hardware not
going into DC5/6.

But I can't immediately think of other issues due this being an
iGPU, so eg. runtime PCI D3 doesn't really do anything meaningful
and thus the display hardware remaining powered on shouldn't
matter that much (apart from the increased power usage).

> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> 
> > ---
> >  .../gpu/drm/i915/display/intel_display_device.c    | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> > index 1170afaa8680..b1fec1018d7e 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> > @@ -3,6 +3,7 @@
> >   * Copyright © 2023 Intel Corporation
> >   */
> >  
> > +#include <linux/dmi.h>
> >  #include <linux/pci.h>
> >  
> >  #include <drm/drm_color_mgmt.h>
> > @@ -1435,7 +1436,18 @@ static bool has_no_display(struct pci_dev *pdev)
> >  		{}
> >  	};
> >  
> > -	return pci_match_id(ids, pdev);
> > +	static const struct dmi_system_id dmi_ids[] = {
> > +		{
> > +			.ident = "Apple Inc. iMac",
> > +			.matches = {
> > +				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
> > +				DMI_MATCH(DMI_PRODUCT_NAME, "iMac"),
> > +			}
> > +		},
> > +		{}
> > +	};
> > +
> > +	return pci_match_id(ids, pdev) || dmi_check_system(dmi_ids);
> >  }
> >  
> >  #define INTEL_DISPLAY_DEVICE(_id, _desc) { .devid = (_id), .desc = (_desc) }
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel

