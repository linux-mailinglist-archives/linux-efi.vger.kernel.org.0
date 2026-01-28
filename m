Return-Path: <linux-efi+bounces-6047-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGdeAdA1eml+4gEAu9opvQ
	(envelope-from <linux-efi+bounces-6047-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:14:08 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07483A54C0
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DAE1307AC4E
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175DE2FDC5D;
	Wed, 28 Jan 2026 15:49:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411527FD4A;
	Wed, 28 Jan 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615349; cv=none; b=PzUGOU9jO3tpoQ9GWJKYZPj3DE6wQBu/H94wl3sEaSxzkoVGm78EJlvNpw4B7dgMYCX2YGiOA6yh630vREayvHzqsLxHZSA6khrhYN1C8aVT09FKk6CJUkPyvcFClYv8tFvAxPXnhBdGDMG5ktjlST0wcRVhJ45inJSDNua9Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615349; c=relaxed/simple;
	bh=6wFMmklklFAPh50VcRnqjsFDiX8pZAYIm93ZVHrRGaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O302fRq6f5GFyLnIxzQZyQ/0/TJqF/vXmx0xMn0U2Wtl1xC/csj+gTLijiS3g23kyHZMbJR6GVz1XZttjjwENNlDqZEFKfGIqRITioaKYEKf9k4Tc9uKcRjtIyox49MQHZwkJcZqBa4I3O3hHxvBg/8sT9WsbCeZi6JweYOXtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4EE732009D17;
	Wed, 28 Jan 2026 16:49:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3BA7E32CA5; Wed, 28 Jan 2026 16:49:05 +0100 (CET)
Date: Wed, 28 Jan 2026 16:49:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
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
Message-ID: <aXov8c4RSs2f7yAL@wunner.de>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
 <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128145855.1071-3-atharvatiwarilinuxdev@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6047-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07483A54C0
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:58:38PM +0000, Atharva Tiwari wrote:
> Disable display on iMacs, as they can't do link training
> on the internal display.
> 
> (tested on iMac20,1)

So with your patch the screen is black on those iMacs?
I don't quite understand why that would be desirable.

What happens without this patch?  Something worse than a black screen?
This needs to be explained in the commit message so that reviewers
understand why the patch is needed.

I also don't understand why this patch follows the EFI set_os one.
What's the connection between those two patches?  If there is none,
they shouldn't be submitted as a series but as two individual patches.

Thanks,

Lukas

