Return-Path: <linux-efi+bounces-6206-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJa9L+asnGlyJwQAu9opvQ
	(envelope-from <linux-efi+bounces-6206-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:39:18 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A6D17C779
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1634304E333
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A9371064;
	Mon, 23 Feb 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYk9VjnA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78036C0C2;
	Mon, 23 Feb 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875552; cv=none; b=RZv7amHUW7MgZZDKTzg4PBP8ZV/1qoyfYgIij6HFTLrouzEEbKnS47dFljYNpzbnQ63eZH3cNsuBGMl6onXSMDLSHzS+xTuxxzKy0JzT7B+2jlFnXSgSOkKcgejjlwXvkLrTOtd31IzpoaRPaEAWfz6Vk6kcaHg9YF1rnX3rVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875552; c=relaxed/simple;
	bh=IveoHd9zrLRR33yx6epdsO9eF0MPbX7n9btdHNCQv2o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dc9SHB+U6hJ2SjLLJBRmF/VnaxQJJgovrtn/8c+q0MhKu1sHbw7X3tBUt8ckOHWaBbl0jNGx44FYnZc/Z8Nsv+QjYdVHMca8lkrwYgji7+XnjOo1BNS1HTaUWPvQT/LnCLWmjMQeDdpj0PZnxJpJJwGKA+V5j+utKnQCgAewZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYk9VjnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79705C19423;
	Mon, 23 Feb 2026 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771875552;
	bh=IveoHd9zrLRR33yx6epdsO9eF0MPbX7n9btdHNCQv2o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kYk9VjnA/HYov/kkCKDpWeJ6E9SOQNpGx2QdxK4pbCdkshTk91n7/116gQW6D7RAV
	 fdPjG9EteJGvN/svoEfpKzSnG08xo60tT5uIIrPA5bd2Yl8vLD6AIn6I3MU6VgWTOH
	 eF4r4x0wQ8wCT0n7cpOI1oXZkoZXzb9QMwr+pEZLa8zSIZNwQ0RmmZxqSLT8b70NQg
	 E0Q6u7/A5NQgpkkU4PP76fTmwni3zeUWoFesRyz4owHuHGZc3rqNZIC/8u0Yk1IB09
	 2q8R40V9VDKt5GeXJWze5cCRC1Esw8UyXt6LPrGa4o/DSCNmP2FnBRgoWAhsSWh/2s
	 p7YBrEqRX6kEQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 538B9F40068;
	Mon, 23 Feb 2026 14:39:10 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 14:39:10 -0500
X-ME-Sender: <xms:3qycaddGJqMakJznO8KINaxIcIUhszzQB6a7VPRKpqEBr9Wq2SVbmA>
    <xme:3qycaWAntHYIagFkdClUg8BW0W1z3wtjIFYiCac3xEkBhz5EKsTCNTVzZelSmA7ys
    6L7IN00Pd3__HCp6x1l3AqaBruiXTS4XLMRdI23SP-JvEYZzGe--j8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeejhfetveehvefhteekgeelffdtgffgvddtkeeguddvvdduuddvieetjeff
    veefjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    feekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghp
    thhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnhhitghkrd
    guvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehn
    phhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrd
    guvgdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrghmvghsrd
    gsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhm
X-ME-Proxy: <xmx:3qycaTVDR64kR1jkDUKhlJw7ttsh1mfDYJPnYtybFwWmz_VWFQ9lbQ>
    <xmx:3qycaXSJmLqfdupxfVLz3XiAmF9afvvlTV3fA_mxt1V0uAVBbcEIRw>
    <xmx:3qycaTBcnIfDJonOBxIi3NLUy9hBMhQw1lYTTav-8RplZAABxoW3Cg>
    <xmx:3qycaekuqMGz8NKZr28U5CNsbCrrFj3msxkNFLOxvdt8BpW0DP7QYA>
    <xmx:3qycabmUs8as38t_yBivTwckVLq6-HlT36EIVzSmr1DhxHas2Lam8lk->
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 257E8700065; Mon, 23 Feb 2026 14:39:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AcM5pYIp-jco
Date: Mon, 23 Feb 2026 20:38:47 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Kees Cook" <kees@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <9ba5bb34-2356-4c10-a3d3-f122abe1073b@app.fastmail.com>
In-Reply-To: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
Subject: Re: [PATCH 0/2] kbuild: Switch from '-fms-extensions' to
 '-fms-anonymous-structs' when available
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6206-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 60A6D17C779
X-Rspamd-Action: no action



On Mon, 23 Feb 2026, at 20:10, Nathan Chancellor wrote:
> Hi all,
>
> The kernel enabled '-fms-extensions' in commit c4781dc3d1cf ("Kbuild:
> enable -fms-extensions") in 6.19 to gain access to a Microsoft
> (originally Plan 9) extension around including a tagged structure/union
> anonymously in an other structure/union. Since then, Clang 23.0.0
> (current main) has added a flag to enable only that extension, rather
> than all Microsoft extensions, '-fms-anonymous-structs' [1]. Using this
> narrower compiler option would have avoided the build error fixed by
> commit a6773e6932cb ("jfs: Rename _inline to avoid conflict with clang's
> '-fms-extensions'"). While these errors are not expected to be common,
> using the narrower option when available has no drawbacks because the
> kernel only cares about this extension in '-fms-extensions', no others.
> While this could result in build errors for folks using
> '-fms-anonymous-structs' if a developer uses another extension in
> '-fms-extensions' (either intentionally or unintentionally), flagging
> these uses for further scrutiny seems worthwhile.
>
> This series converts the build system to use that flag when it is
> available. The first patch consolidates all of the C dialect flags into
> a single variable to make future updates to the dialect flags less
> painful, as updating the logic in every place that uses their custom
> built C flags is getting cumbersome (and C23 is looming). The second
> patch makes the actual switch.
>
> I would like Nicolas to carry this in the Kbuild tree for 7.1, please
> provide Acks as necessary.
>
> [1]: 
> https://github.com/llvm/llvm-project/commit/c391efe6fb67329d8e2fd231692cc6b0ea902956
>
> ---
> Nathan Chancellor (2):
>       kbuild: Consolidate C dialect options
>       kbuild: Use '-fms-anonymous-structs' if it is available
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

