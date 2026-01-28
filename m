Return-Path: <linux-efi+bounces-6049-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDaMM2c8emlB4wEAu9opvQ
	(envelope-from <linux-efi+bounces-6049-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:42:15 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57672A603F
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B1DE32544CC
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A54286D4B;
	Wed, 28 Jan 2026 16:03:13 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3326ED40;
	Wed, 28 Jan 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616193; cv=none; b=f7hVmbg8GC9UR8mSx6fVCjrDnrwXTF6NHlroeZQMiQ1d0G+EO1XNBI7AETDgBCZxgW0RRQZt63ruWSl60Lvq4Fx5NJgBP1VYLfjT8X2h50wREgyLsD7WA6WcU/Aa9dZTszlHQBdOnqjWrVWbfK92k+pyjyTEMlMxQcmCXVWsE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616193; c=relaxed/simple;
	bh=uMLqevFIr/ee44GujvNqkd8JnuJ2AMLcErLeJSBRGhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHfTKeszyI2c6GGKtHuGAIf4xaB/6VXtd2wkv6oKUKCOFkzBaQ1c6joQMXvmG8lxAeJfKmeeyA7f3XjsJC3KTz9t4gj+uIVI9n8t+qie0beNpzgWAZLeY3uyTnT+mTWp3gb4jc4mNHrt6XAgjdM3Rn/mbg7hpMQZcFrveTXK2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0299E2C0781D;
	Wed, 28 Jan 2026 17:03:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ED2A733097; Wed, 28 Jan 2026 17:03:03 +0100 (CET)
Date: Wed, 28 Jan 2026 17:03:03 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
Message-ID: <aXozN_-GCw4bLjmE@wunner.de>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
 <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
 <26c4e0b7f9c25f405401288d13fc7e5097e9c7f5@intel.com>
 <aXotLnGvZu4Ib0Vx@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXotLnGvZu4Ib0Vx@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,kernel.org,intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-6049-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57672A603F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:37:18PM +0200, Ville Syrjälä wrote:
> On Wed, Jan 28, 2026 at 05:23:51PM +0200, Jani Nikula wrote:
> > On Wed, 28 Jan 2026, Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:
> > > Disable display on iMacs, as they can't do link training
> > > on the internal display.
> > >
> > > (tested on iMac20,1)
> 
> I guess the main problem with a hack like this is that you won't
> be able to get deep pkgC states due to the display hardware not
> going into DC5/6.

If patch [1/2] in this series results in a power regression,
I'd say it needs to be reworked.  Either exclude iMacs from
the set_os protocol or find a way to power down the iGPU again
once the kernel has assumed control.

I wonder what macOS does.  If the iGPU is exposed by set_os,
surely macOS must be able to power down the iGPU again,
so we should be doing the same.

Thanks,

Lukas

