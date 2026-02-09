Return-Path: <linux-efi+bounces-6105-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKCRFEgVimlrGAAAu9opvQ
	(envelope-from <linux-efi+bounces-6105-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 18:11:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0098112E93
	for <lists+linux-efi@lfdr.de>; Mon, 09 Feb 2026 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1957D30254C5
	for <lists+linux-efi@lfdr.de>; Mon,  9 Feb 2026 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC174385ECC;
	Mon,  9 Feb 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltj0hrRz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961C385EC8
	for <linux-efi@vger.kernel.org>; Mon,  9 Feb 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657074; cv=none; b=cIA4Hupihqh1vG/IatwLHeJL5P3dkAQmTImAORMvvMCFkY1L+we140FZg2d3aDlBWbX24NUwaxzhjyJTxt8NYCoGXvndRZvIfWOKtTyeV/67mscYRwVohb0kz/prqZdaFMd/wdXNG0Kw7BBL2eYxZI2liphtDf8VWk2/nLGI/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657074; c=relaxed/simple;
	bh=ZMpJMs0SzYib30S3jyr+Pb8ePdAMp57L4kmJMnMR66E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hF4LW/l6/DI4KjP1t5bT+Tjfp3FQSBfUv27yvV540J9V7fW0GWWxU2HX9b/xbQxxHXx/yJGo7Wy7IAu8ukTB1zKWiGO4BfJQw6g2u+WeoZvZBFQ0QoxBUvokNEoF6VU6FIIdQDbF0zHb8zYXYRBz8iWKTTftBUaKnHGCI1wNeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltj0hrRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CC0C19423;
	Mon,  9 Feb 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770657074;
	bh=ZMpJMs0SzYib30S3jyr+Pb8ePdAMp57L4kmJMnMR66E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ltj0hrRzS+rZzF/mYuWtpJJJDEX0Ka4+zSj6m/diKTv6J2uXbTX0x6X9NolfMjvce
	 7BCd2YXxIcvCjg+wMOYcmK7vlyZwhbuNmeDUh2brP+jP5yOVr1BGacfVRRaD1aOSwf
	 IyJ9UnJJte/jJFn0KfGgIH/dfescUWxgVnFF+Y+IdSyul4sAXhEX4MuMPMcamJBev+
	 i7pgXDb5c+oQ5ISGvvBO0UVtDg/R7ShTHC7kC6/N/3k7obCHlHOdL+5m1lfCsApNoT
	 RuY+KJdD0zah4HGWV/q+80k88xgQKZKy+u/AwETohT1KO7JbkTEFYOlqGan7R0yih/
	 bcC+V/m0+mimA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 149DFF40068;
	Mon,  9 Feb 2026 12:11:13 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 12:11:13 -0500
X-ME-Sender: <xms:MRWKaQ8jUiWje7yXTQD0h4vtrTrYCJ1ScP1E6WiwiZbpDXcx0YoQ5w>
    <xme:MRWKaTg7296dodOjYDUPO67rvoK6mB1evA-u4D4t46KXMOvWLHYfuATDp1Uk0GfyP
    72P1dQ32uN_ey1iusovUBZckVWM7gnZNmJi0VTBBcK8kh4LIGv5qKbh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgtphhtthhopehtjh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehjohhhnhdrohhgnhgvshhssehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtoheplhhinhhugidqrhhtqdguvghvvghlsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheplhhgohhntggrlhhvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MRWKadvLJRwwKnT61HF2r8qwuZ1c1ksWM1fceQbJvlfQKYwvw0c6zg>
    <xmx:MRWKaZBu1vswsXueIPDIfw9LRvkvo41WSQFofzsM_qhCKrM1Mwse2Q>
    <xmx:MRWKaUZIgDUWPjEdopMFEp0OSw0Pk6LuPxtglq0aoGobw61rMuS6HA>
    <xmx:MRWKaUVfomqiEXL2WAh4kizsidGw0exBJ8uhbFnNeCMn5m7ftzKDIQ>
    <xmx:MRWKaTO-1nPt4ucHOaTllcKj87Zj5_QUnuGEyeDmBZjChR_XhtCrndj3>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E7A29700065; Mon,  9 Feb 2026 12:11:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7n9zg-B68tw
Date: Mon, 09 Feb 2026 18:10:52 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 "John Ogness" <john.ogness@linutronix.de>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, "Tejun Heo" <tj@kernel.org>
Message-Id: <4c6a5533-6fcd-4237-bb35-0ca74029c7db@app.fastmail.com>
In-Reply-To: <20260205115559.1625236-1-bigeasy@linutronix.de>
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6105-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linutronix.de,gmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0098112E93
X-Rspamd-Action: no action

Hello Sebastian,

On Thu, 5 Feb 2026, at 12:55, Sebastian Andrzej Siewior wrote:
> EFI runtime services are disabled on PREEMPT_RT by default which can be
> overwritten on the boot command line. For native EFI, an invocation
> requires to disable preemption while a call is made into EFI.

This is no longer true on arm64 since

commit a5baf582f4c026c25a206ac121bceade926aec74
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Wed Oct 15 22:56:42 2025 +0200

    arm64/efi: Call EFI runtime services without disabling preemption

except for some corner cases (reboot, pstore crash dump).

> The time
> spent in EFI is not deterministic and depends on SW and HW of the
> system.
> While accessing the efi-rtc device can be avoided by using a native
> driver, accessing the "variables" is important and there is no second
> path.
>
> The "runtime-wrappers" is wrapping access to the EFI callback via a
> workqueue. On a SMP system one CPU could be declared as housekeeping/
> not-realtime-capable and force all EFI invocation to be performed on
> this CPU. This could be achieved by setting workqueue.unbound_cpus or
> 	/sys/devices/virtual/workqueue/cpumask
>
> at runtime. This however will affect all workqueues and might not be
> desired. With an explicit setting such as
> 	/sys/devices/virtual/workqueue/efi_runtime/cpumask
>
> it looks like an official way to limit the CPUs involved here.
>
> With this in place I was wondering if EFI_DISABLE_RUNTIME could be
> lifted at runtime on SMP systems. But given the unbound_cpus option
> and the auto-config based on NOHZ-full it might not be wise to add yet
> another smart option here. Also it needs to be a subset of root cpumask
> or it won't be effective.
>
> There are two EFI invocations which are not covered by this
> - mixed EFI
>   Used on x86 with 64bit kernel but 32bit EFI. Would it work to use here
>   the same workqueue mechanism?
>

That stuff is beyond obsolete, so I don't think it is relevant for RT.

> - TEE / ARM secure monitor
>   If I understand this right then TEE invokes the secure monitor which
>   is preemptible. So an interrupt will interrupt and enter "normal"
>   world immediately and could wake a user task. The following context
>   switch will not happen because the return from interrupt path goes
>   back to the secure monitor/ TEE.
>   If so, or if TEE may disable interrupts from normal world, would it
>   make sense to use a wrapper here, too?
>
> Any comments or things I have missed?
>
> Sebastian
>
> Sebastian Andrzej Siewior (2):
>   workqueue: Allow to expose ordered workqueues via sysfs
>   efi: Allow to expose the workqueue via sysfs
>
>  drivers/firmware/efi/efi.c |  2 +-
>  kernel/workqueue.c         | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>


