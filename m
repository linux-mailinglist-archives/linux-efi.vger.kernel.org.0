Return-Path: <linux-efi+bounces-6048-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D1QHZoyemlo4gEAu9opvQ
	(envelope-from <linux-efi+bounces-6048-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:00:26 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31295A4E85
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 17:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 891343049A5A
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B362F25EF;
	Wed, 28 Jan 2026 15:56:24 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC25301465;
	Wed, 28 Jan 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615784; cv=none; b=fiMmQGpYiCtyrmhdf9kBheaImwrMf2BatsB/IW7sOLx4ZZEzMuTY0x3mDSyh8Vcjw/fJUeWDnBBPXdiyP6M1JgXENdH7X4eD4raqI0X66RuJcQ8dEVyL51/qTUtU98Mc9D8gW+OYaYpsIVDXYz5TZeQ6KUbt/sqt9QA5l/l4AS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615784; c=relaxed/simple;
	bh=WqhnbiU063jiHgDsbB4pAy8Oh04vmWgVP9qS90nduig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3gWAbnwdGirfKRcPYWlzW/jCIDfxPWyakIThfUDD5apQg1vuvpjYSZwtRbuVwLBZHxATa0xv9yUc1CWEqUvyPEbc9yIlXgrotkF6mQC2Rdrpb+kzk2eaWtNAY7B01Mc6riz4ckoSvcxHwoSQPaFjON/TxQe5lvdL5tPkkdrMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 57D162009D01;
	Wed, 28 Jan 2026 16:56:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 43F1435135; Wed, 28 Jan 2026 16:56:21 +0100 (CET)
Date: Wed, 28 Jan 2026 16:56:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Francesco Pompo <francescopompo2@gmail.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Add support for eGPUs on Apple Products
Message-ID: <aXoxpWFE0rByjS-y@wunner.de>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,redhat.com,suse.de,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-6048-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 31295A4E85
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:58:36PM +0000, Atharva Tiwari wrote:
> This series adds support for eGPUs on Apple products, by
> enabling apple-set-os on all apple devices.
> 
> A side effect of this patch is that the iGPU becomes enabled on iMacs.
> However, iMacs can’t use the iGPU to drive the display
> (They can't link-train the internal display),
> so displays must be disabled on iMacs.

Oh there's the explanation that should have been in the commit message
of patch [2/2].

It's possible that the iMac has a multiplexer built-in which can
switch between the iGPU and dGPU at runtime.  Please ensure that
you have set CONFIG_APPLE_GMUX=y in your .config, the gmux driver
should bind to the multiplexer if there is one.

If there is a multiplexer built-in, then disabling the iGPU is the
wrong approach.

Thanks,

Lukas

