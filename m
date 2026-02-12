Return-Path: <linux-efi+bounces-6113-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJUeEfr+jWm0+AAAu9opvQ
	(envelope-from <linux-efi+bounces-6113-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 17:25:30 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A222012F5E8
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 17:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 111103076B7C
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612194A21;
	Thu, 12 Feb 2026 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UHzqdh5q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3vvNLvx"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236372DC35A;
	Thu, 12 Feb 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913248; cv=none; b=GRii5ScsvjptjVxOq5n8rUpbMq/Wz6471+gvxouH6McrsVT9saDGr771cS0vObXnKu542rc5vxyn8ZPVJrw5PQfucDEArXEDPsqD0y1/G4PDZzWDdhlB4HjAjgm4xU9gKfNnnQ/NtoOKmprUSscJ/MWFIYQIFg9RNi4i+rgaxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913248; c=relaxed/simple;
	bh=9BB6hZX1iF6BsiAGlgfEBLQ+iWWBQ3NItsKk/BF1zGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqoBxw+u/FP/4ECweZ5MV2DqPjM5b38+vlgTWFeZrFKJI2Cguq96iBq4roRU8kj0MW0aVR2Yk6fohRBvTHAHMkLqoHscuO4IGKG17qLuZF8sCFM1+M6IqCjhcFa5arBD2gu9DnXQiWHQem3kpFo7fWq/FOSrrTBOIWdPPJTw9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UHzqdh5q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3vvNLvx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Feb 2026 17:20:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770913243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5XlrfEe6vkfD+RQCnpxpWQZ9mV4ZqVYBC7f4C/wFYg=;
	b=UHzqdh5qhHC2FBxvExFSecdAkTjAfd/9PfGLCINtnBtLqIjGHXeCqA9rYF5npW4AZwhQyI
	jOfnwZc4Vg5GrdfJQ21YLB6XSZy6f1dOJTwQEe0AWx7tsiFnDUZ6yTIZS1wGRuPkwicF+n
	7bFwoKvWXX1tAjOmg2aGM2S4fbVWQtKWkdlEcKK5Zre2bdEOpQKpMibD1RNGL4xhvW1btM
	e5r2xUQzJdqXsFzWKYDd/Y9C7BcbOJ6Tq8Fcv8nwpYMc4CD1C4hb10qlmC0nX+uyR8kQZs
	qLSsza+lmOsrS10dcYgMe+jdn87S5z8RA7TMF0jH5DPwAXRiaRD7Nozmquj3hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770913243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5XlrfEe6vkfD+RQCnpxpWQZ9mV4ZqVYBC7f4C/wFYg=;
	b=F3vvNLvxd8frH24xPYi9Pl8wkLfd4zhz+mdl4DqrXg3vT2M8PxQuJOyqovIvZimsRVv/WD
	fHHRuE37+dngQ4DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
Message-ID: <20260212162041.acU_rljT@linutronix.de>
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <aYn6j_JLBENcY96V@redhat.com>
 <20260209155528.k7RMRPVD@linutronix.de>
 <CAC_iWjLt-CzTkmnVMHidnMFWkE9NPzVLo6g8FUgMu0gAUJ0KtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_iWjLt-CzTkmnVMHidnMFWkE9NPzVLo6g8FUgMu0gAUJ0KtQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lists.linux.dev,kernel.org,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-6113-lists,linux-efi=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:url,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: A222012F5E8
X-Rspamd-Action: no action

On 2026-02-12 09:09:51 [+0200], Ilias Apalodimas wrote:
> Hi Sebastian,
Hi Ilias,

> Late to the party but ...

glad to have you.

> On Mon, 9 Feb 2026 at 17:55, Sebastian Andrzej Siewior
> > What I don't know is if this is a problem, i.e. is it possible to
> > interrupt the secure monitor and continue in Linux before heading back
> > to the secure environment or not.
> 
> In theory yes. In practice, at least for arm & OP-TEE, the
> communication between the TEE and the secure-world app doing the
> variable chekcs & authentication is via the MM protocol [0].
> IIRC that requires to run to completion. So what happens is that you
> enter OP-TEE and right before the StMM is invoked (the app that
> handles EFI variables) all exceptions are masked and it must run to
> completion.
> The period of masking does not include writing the variables to
> storage. That's handled differently and is interruptible.

There it RTC and variables which is the most common thing. If you can
somehow outsource variable read/ write then fine but I guess you need to
wait somehow to ensure the data is written. Anyway.

That referenced document describes the protocol but not the
implementation of how communication works. What I found is that most
interfaces in the TEE world end up either in "SMCCC_1_2 hvc" or
"SMCCC_1_2 smc". The smc command in terms of arguments is described in
	https://documentation-service.arm.com/static/5f8ea482f86e16515cdbe3c6

but it does not say if the interrupts are masked. I would assume that it
transfers the execution control to the secure monitor which is then
entered with disabled interrupts similar to an exception on the linux
side. In that case it would mandate a workqueue kind of solution so it
can be pinned to a CPU.

The only exception here seems to be the amdtee driver
(psp_tee_process_cmd()) which sends a command and waits for an answer.

Sebastian

