Return-Path: <linux-efi+bounces-6104-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGQAAXgDimluFQAAu9opvQ
	(envelope-from <linux-efi+bounces-6104-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 16:55:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EC11237F
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8D6E3007891
	for <lists+linux-efi@lfdr.de>; Mon,  9 Feb 2026 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379D37FF65;
	Mon,  9 Feb 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GllgBWW3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQ/6mBxy"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B2284898;
	Mon,  9 Feb 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652531; cv=none; b=YPQPuAQ2mzBuZBhd45K8zUz5Qvo3tjpLaK6GNGTUyf3MLrgEqV7gom+uY9QCQbHlaYMLJAT6f6j7fuPjMIwsyM7xHbK0/LF9yxIpZPYEJ+xXk9CJPOgUkETQmE81MQoyYVdd4zPD0mOz3LlCN5SU82yecyRQaCqCsv9wphjKiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652531; c=relaxed/simple;
	bh=x3pzYRgVmGn0TG3kQdTEqDTYlk/gpl2wGw2Z0sQIBys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7esS+fywUtgUzPbJ2w7pK/qTc6epd4kl6/7mjtBsYGUY7fQZhJ0f9bQPlgWle+jPyz2gS4QZp1cRfkhhygemYUw6FJ17frV8Nsj/hMgtVzQ9O90ENrM3vk1N3BIDkHBFTFhTfl7q+w3gQIYsNr8hPEJ9NWuH72pAXAUvKCH0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GllgBWW3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQ/6mBxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 9 Feb 2026 16:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770652529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3pzYRgVmGn0TG3kQdTEqDTYlk/gpl2wGw2Z0sQIBys=;
	b=GllgBWW3S+LRvWHJm+lSxCG/aWVzh5hkzsx6+vhs73xiim/7n1Cw2MpTS8gWS9NCZ50Tnv
	DcGwf+nWGuiS0rkWgymuzpJh4hiNS4Io2QvDeua9I6+NiR0aP6OPwuoJucZa+cYiMwXK7G
	a29bY0kvlr2OiH4PLhyYBZSpEAYMQCg+x+55zuT2ZLt+P5Bjwhqx1ox7Q5x3JD/qaioDaq
	Hv4vlwkY/uf6MsNL4pfFgVFeF/PR2a8MH2WJmdyaTVIqzh0tX36oVeftWAsJnHXEBKlLrF
	I1jGRCCd5RjpYUUvUUA+8RLTjN7Iq14H+zWYFKFsjl0nqc87UwpJYdTZdkGGpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770652529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3pzYRgVmGn0TG3kQdTEqDTYlk/gpl2wGw2Z0sQIBys=;
	b=BQ/6mBxyRFOefziksMaWYPYoriUsksqMaahVkwZpIbvqrZapBfVYiYUJtDBodbjaVPDCaR
	EVIz2HL3uDK8W6Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
Message-ID: <20260209155528.k7RMRPVD@linutronix.de>
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <aYn6j_JLBENcY96V@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYn6j_JLBENcY96V@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-6104-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 9D4EC11237F
X-Rspamd-Action: no action

On 2026-02-09 12:17:35 [-0300], Luis Claudio R. Goncalves wrote:
> Sebastian, as for the TEE feature you mentioned, is there specific test I
> should run? Or is there any test you would like me to run in the context of
> this change?

Puh.
If you have a TEE environment, then the EFI interface should be
"supplied" the TEE instead the runtime-wrappers. My guess is that
tee_get_variable() would be used instead and here the workqueue won't be
used (I think). So that is the easy part.

What I don't know is if this is a problem, i.e. is it possible to
interrupt the secure monitor and continue in Linux before heading back
to the secure environment or not.
If you could check how long you end up in the next variable and RTC call
and if the time is noticeable, do you see it in cyclictest or not.
So if the EFI-TEE-RTC-callback takes always >1ms and you don't see this
in cyclictest as a spike then it should be good.

Sebastian

