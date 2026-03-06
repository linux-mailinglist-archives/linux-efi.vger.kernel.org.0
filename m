Return-Path: <linux-efi+bounces-6252-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLsWBvn7qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6252-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:08:25 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3E2248FF
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E44E306AFF9
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64313EB80D;
	Fri,  6 Mar 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyGMNP/h"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D053921F3
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812554; cv=none; b=QFf8sPAEzIm8G3FIZcNlovpjIr7JBVKv/Bkj0OYnRCillczfUJpa4n+HvdZ4sZVGoLHcsQPuHwf/ZDD28Qf7DMdFSigr8YFgPmwd2oHLdA6No1vODAtUApZcxHkglkITmJEX3h6QFAJXQRZakYLQA64lgTD3WHB2JNDOxcJjbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812554; c=relaxed/simple;
	bh=ZQ76liIW6E6i1/b3A1a2pPbDIjkLjWQN5mm1jo1jI5I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UiftI+Ym2OwFU+vvyr1X5OsCh9gtMPFGbNdE/jdIEo3E3fjXD395g1kr9efUG56zDXmxs+onHTW39DIK3yCZBxxrL9DC4piNQMN27YwPXcMrqBAxfoaD3IDJ6gJBiHzl3cK1F9ghqlwW1WGWEaLD7UqEpHT4H6tHd+qRjce0wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyGMNP/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D845C4AF0B;
	Fri,  6 Mar 2026 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772812554;
	bh=ZQ76liIW6E6i1/b3A1a2pPbDIjkLjWQN5mm1jo1jI5I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RyGMNP/hk1TAg8aHgD4A+bD+/1kbYrNphSFQIsoLmsaxxOS1suF3QL6RzP7cKP5FT
	 mrb7Aqt5OCAUcQ+NY4Pr1GF3SWjBQkJ/yiIsDKNkTTSTFAoJ5q16aUHEjgFh6d3ZXi
	 ZLMi4jidLzMEj+R65YO4MdsXjUUwU/LlYv6Z5eQoBOFXYDLtEOpkKt/O48h1Bz0JzY
	 LUjXJft3011mUscCtiejCwH2c61BBUFf5y/PXTt+gPCVKM0DGRtK27+hwp1T1vpK1J
	 Jq/fU3uJoI6RlfhuTitw8djWNvyz2ZoNLoYY7T2fKvqdmD/h9wvcAS8wjIjEIylBrT
	 n+0mXm/OvTJPQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 10D63F4006A;
	Fri,  6 Mar 2026 10:55:53 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 10:55:53 -0500
X-ME-Sender: <xms:CPmqaevDFTTP5tP-wAr6rloDUR4mtfLUIgNoAesRCcQWo328495YkQ>
    <xme:CPmqaeRgfP1dvMyKfmfUaMpRNipHYWRMMyw8NI7edldaxtQpi9Zxv66kG7rWUJMLp
    ilhbcUsrnQSYiygYZ3NKGi7HbW_Le5cWSDvjbr1kAJUqKniOf2U8wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepsggvnhhhsehkvghrnhgvlh
    drtghrrghshhhinhhgrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdho
    rhhgpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghssehlihhnrghrohdroh
    hrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:CfmqaXmJAOECBW03bGl-aJclbL81Cjd1WknFsjv9UiWUoF1rOrkfnw>
    <xmx:CfmqaaZ9Z5C9Iy8DDgF-BoKLc2AL3866rZ7jbX77zXjX3DPk_-jVqg>
    <xmx:CfmqaR83dyL7YMWqho8yGfa46BcO_JPgLKX9xWA3bbQmU7eqGIgZgA>
    <xmx:CfmqaSHSvLtI6xfbVh_u5N_XjrMRIsuo-yIAnjHS5OwtYANGP6tLNQ>
    <xmx:CfmqaTevVisFxupb-2nmu75yBQXy_NbcfHBnC1mb2nAvTiVxHv_Pap6D>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DBBEE700065; Fri,  6 Mar 2026 10:55:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AusYBuezkfp3
Date: Fri, 06 Mar 2026 16:55:32 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Ingo Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 "Thomas Gleixner" <tglx@kernel.org>, linux-efi@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Message-Id: <132771ba-c5e4-4fc0-82a8-0d681fb6eae9@app.fastmail.com>
In-Reply-To: <aar4wRh3TRm1m0HJ@kernel.org>
References: <20260225065555.2471844-1-rppt@kernel.org>
 <7e4f6a4b-fe41-482d-a4cd-5a059e1626e6@app.fastmail.com>
 <aar4wRh3TRm1m0HJ@kernel.org>
Subject: Re: [PATCH v2] x86/efi: defer freeing of boot services memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1AD3E2248FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6252-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On Fri, 6 Mar 2026, at 16:54, Mike Rapoport wrote:
> On Thu, Mar 05, 2026 at 12:11:12PM +0100, Ard Biesheuvel wrote:
>> 
>> On Wed, 25 Feb 2026, at 07:55, Mike Rapoport wrote:
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
>> > and EFI_BOOT_SERVICES_DATA using memblock_free_late().
>> >
>> > There are two issue with that: memblock_free_late() should be used for
>> > memory allocated with memblock_alloc() while the memory reserved with
>> > memblock_reserve() should be freed with free_reserved_area().
>> >
>> > More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>> > efi_free_boot_services() is called before deferred initialization of the
>> > memory map is complete.
>> >
>> > Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
>> > RAM on EC2 t3a.nano instances which only have 512MB or RAM.
>> >
>> 
>> Putting a fixes tag referencing a patch that dates back to 2011 doesn't
>> seem that useful here. Is this really an issue that goes all the way
>> back? Or did a later change trigger the actual leak?
>
> You are right, the leak was triggered later by addition of deferred
> initialization of struct pages which is about 4.2 time.
>
> So fixes tag is wrong indeed, but all the currently maintained stable
> versions are affected.
>

Fair enough. It's already in -next so I will just leave it as is.


