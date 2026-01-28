Return-Path: <linux-efi+bounces-6046-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OmGFA8wemkc4gEAu9opvQ
	(envelope-from <linux-efi+bounces-6046-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:49:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A8A47CC
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891143067B2B
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719C32939F;
	Wed, 28 Jan 2026 15:45:37 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6632779D;
	Wed, 28 Jan 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615137; cv=none; b=Te19Kz8zMdpmagfe5D67nZT3teGKxSz69hyXONs1mq4Xx93EbC89ucGxR9Ln+oeYWp1QxsPjTyIOU/aU2UU1WIcmKhjePRty0OhDsZH/st0MjQVB8tn+3YdMAjJGWtel/Jx9AQfmLj9n0pT5qQFZfMnMOcqXAuWZs1EJfihchVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615137; c=relaxed/simple;
	bh=vaLeiY/w3EowkKOAXKVRcAEtHcJbAWa0f9J/atN+Ex4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlFIJmG/YaYk5k/aM6x79hlfHCV5go1nFPgSn39NQCTmRk5t4hNqZn3B0CIqX8WUmb/I2P8NYYGu8TjVL2mRU+eHBFpxXUM3Rzqejdy/VYCuKxfju8jsXKzjc0SKPhd4V1Ea1rx8ZNXcpXB9lnFXOTFNbvH9HJOmDszXXeVgFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B820B20091A5;
	Wed, 28 Jan 2026 16:45:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A8116351C5; Wed, 28 Jan 2026 16:45:25 +0100 (CET)
Date: Wed, 28 Jan 2026 16:45:25 +0100
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
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Francesco Pompo <francescopompo2@gmail.com>,
	Lenny Szubowicz <lszubowi@redhat.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] efi/libstub: enable apple-set-os for all apple
 devices
Message-ID: <aXovFQsk-w90wZi1@wunner.de>
References: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
 <20260128145855.1071-2-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128145855.1071-2-atharvatiwarilinuxdev@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6046-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,redhat.com,suse.de,alien8.de,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-efi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: BB5A8A47CC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:58:37PM +0000, Atharva Tiwari wrote:
> Make apple-set-os run on all macs, as
> apple-set-os is needed to use eGPUs and iGPU.

As discussed previously, your patch will regress older MacBook Airs
which use SPI to access keyboard + trackpad if the set_os protocol
is invoked:

https://lore.kernel.org/all/ZoJPgSlZJ3ZlU2zL@wunner.de/

The last time this topic came up, I suggested counting the number of
GPUs instead of using the DMI quirk.  I even provided a patch but
nobody with an eGPU bothered to test it, so the thread fizzled out:

https://lore.kernel.org/all/Z6paeFrjdv7L3mtv@wunner.de/

Maybe you could give it a spin and verify if it fixes the issue for you?

Thanks,

Lukas

