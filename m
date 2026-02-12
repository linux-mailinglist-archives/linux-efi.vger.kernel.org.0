Return-Path: <linux-efi+bounces-6112-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH2PK4rvjWlw8wAAu9opvQ
	(envelope-from <linux-efi+bounces-6112-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 16:19:38 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F87612ED62
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 16:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A153032642
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E87E110;
	Thu, 12 Feb 2026 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NXAXFZMz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6iTTKLuH"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512C1C3F0C;
	Thu, 12 Feb 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909519; cv=none; b=AqIvXlVAF/U9JeCSTFmDvHMiJC5GnWPwhqC+zWLqARcsGKBOLBmwcNWi3FR1ydGtgbkD9tny+ESGodltEeKdVPuQtGNpSMnDTAmx2VpqYSDDP4OOC2nE4DwGsKOSX6GC4SqVerSk7i0l9AIXwc6UsB7mr75ptaWUJo33Z1/920M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909519; c=relaxed/simple;
	bh=ai5+4phpGGg9Zf2/MzswoaaLkZJhMjczH6MtkTFYiDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2KVRju0eX48Aup5aFHJWJITfdkmEFpXS12yCFfOGjygnhwXqXgKBhn1Jxr3gdHwmoxtt5RSj5c1zgIVpcpZPAYp+ACiWbWTDpTNQYITcZQSSxvqrbIu4fB//0Z8Uqy4gbtNJjf3ILdLkQHkM9tinNRa61ITYqm7mGmELU1UwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NXAXFZMz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6iTTKLuH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Feb 2026 16:18:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770909516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SGzf6YJRP8H9TbMz2kFAMAC0ww4swNjoJ2X6kO51pI4=;
	b=NXAXFZMzFKsu3TQWxkx/BzaMjJ5wh1BhqgUFgpk5LnoCEDxGwPYreHmOifj6nINpSZPnXf
	XbTXy3A2tPNcS0/OqjTijJTyyThlGcRljq9AGipKIJciI03nJ65Ha3iUzEGLctrRGkhgvA
	PcsvuyIUgv1FAOcT3CuzzxvB20IMDDNPfsXKvPlOr/5W4PovrWWcqzKhuLu/ackf4moOdA
	uJCG6TH0rNhiYZQRKn13WnC9Pfiogvd9kxktkL9a7lNuC1Z5sWb2bI+MbmI2jL/vf+XUI1
	opowre9I1KhWyUzUzZGYDq1COdGSIrOY8mbKBoU1UFxZzPt+nbK8Gw1mqohjwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770909516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SGzf6YJRP8H9TbMz2kFAMAC0ww4swNjoJ2X6kO51pI4=;
	b=6iTTKLuHeo8tsKSEw2Tb3IhQl9uQNa4hmagPRfUl9Bj0V11NbFx4BiHkNOf5G0F3mJpVJc
	qVqGeEDXXcQBZpAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
Message-ID: <20260212151835.8On7hOkI@linutronix.de>
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <4c6a5533-6fcd-4237-bb35-0ca74029c7db@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c6a5533-6fcd-4237-bb35-0ca74029c7db@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[linutronix.de:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,linutronix.de,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6112-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F87612ED62
X-Rspamd-Action: no action

On 2026-02-09 18:10:52 [+0100], Ard Biesheuvel wrote:
> Hello Sebastian,
> 
> On Thu, 5 Feb 2026, at 12:55, Sebastian Andrzej Siewior wrote:
> > EFI runtime services are disabled on PREEMPT_RT by default which can be
> > overwritten on the boot command line. For native EFI, an invocation
> > requires to disable preemption while a call is made into EFI.
> 
> This is no longer true on arm64 since
> 
> commit a5baf582f4c026c25a206ac121bceade926aec74
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Wed Oct 15 22:56:42 2025 +0200
> 
>     arm64/efi: Call EFI runtime services without disabling preemption
> 
> except for some corner cases (reboot, pstore crash dump).

Hmm. While this sounds familiar (and I think you told me that FPU usage
no longer disables preemption here, too) there is x86 for instance. Here
arch_efi_call_virt_setup() disables preemption twice (efi_fpu_begin() +
(firmware_restrict_branch_speculation_start()) followed by
efi_call_virt_save_flags() where interrupts are off. 

Also I don't know if the EFI implementation itself is allowed to disable
interrupts.

> > There are two EFI invocations which are not covered by this
> > - mixed EFI
> >   Used on x86 with 64bit kernel but 32bit EFI. Would it work to use here
> >   the same workqueue mechanism?
> >
> 
> That stuff is beyond obsolete, so I don't think it is relevant for RT.

agreed.

> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Oh. Thank you.

Sebastian

