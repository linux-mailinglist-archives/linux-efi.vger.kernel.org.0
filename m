Return-Path: <linux-efi+bounces-6099-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP0eM7eMiGk/rAQAu9opvQ
	(envelope-from <linux-efi+bounces-6099-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 08 Feb 2026 14:16:39 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72806108B9D
	for <lists+linux-efi@lfdr.de>; Sun, 08 Feb 2026 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70D043002338
	for <lists+linux-efi@lfdr.de>; Sun,  8 Feb 2026 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5A25B1DA;
	Sun,  8 Feb 2026 13:16:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187762459EA;
	Sun,  8 Feb 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770556595; cv=none; b=Fn3nQzHV9ZZ/EAUUV7V95+6AhENU7hpLivjkM8bIhCnZbyC1kUptL//cvX27YETl/4xJwgr8XwxKAkTC438hcj8ysfm6/nZmGf2jztY4QHZpioAgXWOB4X7rnZLqXploN4sNTqyLqwkMNne8NCGNLs2AFI9ZCECCaMzUAlMp1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770556595; c=relaxed/simple;
	bh=vZSO0u+h+fAEP3OmnIeujZGeCVVtx0zSVtopGXmExW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5vrTUE0NwORlLeNMSpqBzZi4m6P1e1pGqB7HhX9AikGVDpWqn9rA5hGcm4LanMGACH7/ZJl4WS0DOB8UheI0QM117bDVQyHLLZdF3Eofvrov3lHFdC68loMFUwEoSj99hx8iwV0x2+PgvavatuJyh5bjEgUenoVso/gMk1/Gds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C651C2007F9D;
	Sun,  8 Feb 2026 14:16:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B78E9EA2B; Sun,  8 Feb 2026 14:16:24 +0100 (CET)
Date: Sun, 8 Feb 2026 14:16:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hansg@kernel.org>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] efi: Save Brightness using EFI on Macs
Message-ID: <aYiMqKJgtaah8pLW@wunner.de>
References: <20260206125641.12983-1-atharvatiwarilinuxdev@gmail.com>
 <20260206125641.12983-2-atharvatiwarilinuxdev@gmail.com>
 <c2d14818-1c34-47c7-a210-1f7c737f0bc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d14818-1c34-47c7-a210-1f7c737f0bc9@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6099-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-efi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72806108B9D
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 11:45:55AM +0100, Hans de Goede wrote:
> I was already worried about the shutdown approach on v1,
> but did not say anything since I'm not that familiar
> with apple hw and other apple code is already doing
> something similar.

Yes, macOS saves the brightness so that it's persisted across reboots
and can be set already by the EFI firmware, avoiding a bloom effect
(brightness change) on handover to the OS.  We want to provide the
same seamless user experience on Linux that users have grown accustomed
to on macOS, I think that's a reasonable thing to do.

> But writing a non-volatile EFI variable every 300ms is
> just a very very bad idea.

Agreed.  But what do you think about a delayed write when brightness
is changed, so that brightness is persisted even if the OS crashes?
Users don't change brightness that often, I can't imagine that it
amounts to a significantly higher number of writes than if it's
only done on shutdown.

Thanks,

Lukas

