Return-Path: <linux-efi+bounces-6202-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ELSObtFnGk7CgQAu9opvQ
	(envelope-from <linux-efi+bounces-6202-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 13:19:07 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E4176051
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 13:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E0A6301EF0E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14851364EB9;
	Mon, 23 Feb 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7Lwt3pP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51531DE3DC;
	Mon, 23 Feb 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849144; cv=none; b=okRdOAqJW+f36B885Vo1oAGkpKUwNSTDVtY0bZK22R2ustgw4YNiQZMaq1Q6hL5iR6TECo1RlbujYjBEALXpJ8Wf4FBjpmxzzeUVKcYU8wYOhHPUK/mcBbgN0WVZ3ov6ggB1uLvRx8aKyVf8i6xyIEL85GNa4eyODImJwCYTNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849144; c=relaxed/simple;
	bh=L4x40NTeNfhFz9DzYSHhBr5EkKnCnezdmBS5U2foQr8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d5sRd651zyqH5CaJhVNJmOQxbeXAlB+MR/NoyOhsqGTYrFM+SY65xudmgznC3nhaQPt4hEE49xt+S7qOVGmDVp8wW8a1Jlqm09FnoTTgNQNtOQ45P5iGvEBFvOdEhxVwguj88odEaT7sGvquVPdIdgJbPuQHHKXL5/GtZNVjilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7Lwt3pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9B1C116D0;
	Mon, 23 Feb 2026 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771849143;
	bh=L4x40NTeNfhFz9DzYSHhBr5EkKnCnezdmBS5U2foQr8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=H7Lwt3pPJjskeHHj7y1s81CQC42RHRFMxaaNdWnNjdpesYy/3mkK8bpUdv4JymznU
	 AUFkE55CltUgHIjTnJoEZdsunwj19cT5nlR2XdWSDorj+wF9iJ8LSRyv4DrwrXBFYs
	 m3DTBt5VP7LG1/gTvP7G0swD5K7z2XZz09gheT+/+3wypcgCEG+VlkUM9h/77EEwDf
	 glNBBOnAPdU4L/vH8aR4wnpxsynbkOkXElbf0S7nN2CDOhHrWClGttqJtaGLCKPWAB
	 CDXfBN29Od19fdWhgK2MJIfdHc2Kp/CtMl55HEuT1oS7wWNYeq98OvcNs2D5CEz0TY
	 pTJlgi+OHP9BQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 58BA4F40068;
	Mon, 23 Feb 2026 07:19:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 07:19:02 -0500
X-ME-Sender: <xms:tkWcaXSE1f82Q-t1qd4cdGAieY14BMDjvay_rpnhKBJvqtXTG5H3yg>
    <xme:tkWcaTlxaFEd5VXic_TYXxW-OTIHxdkTBfcdn7krdBpzqIWim-PctdYiicamp7wxS
    tptIyEqCuFKsL5QJhzF7-hijYF5UPuTu8fDQ7uHhA0I5Rc14uLdRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tkWcaQqAeuVtoky9o6-Xnu2J8LHRL6Pq6g5NAO2-wOQpMr3HzyrpPw>
    <xmx:tkWcaWO_hxeo9JKDIMQE6AR9_-zBhjnJYN29J3X_99V4SzfAAYXUcA>
    <xmx:tkWcaZgCfyZa67-lDg7C8hz-eoUrTmGGwwlIWW3W9eZ5GYVr_IhdNA>
    <xmx:tkWcaaYqafVkNhkWWtxZ9hVOMc5oHNMlFwUH7gTk6m2cmykOgzUAPA>
    <xmx:tkWcadjd24EEtUNhXgxtCnev56ZvPCwUpPiOv8RbT4P_UI965pkvP3BL>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F04BD700069; Mon, 23 Feb 2026 07:19:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AF0NZ4OlJH_7
Date: Mon, 23 Feb 2026 13:18:41 +0100
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
Message-Id: <bfe487fe-6868-4215-b5be-99a0360e9bd2@app.fastmail.com>
In-Reply-To: <aZw8xSI-TM-Gz84t@kernel.org>
References: <20260223075219.2348035-1-rppt@kernel.org>
 <b6f4edf5-7587-45d7-b81a-590d4f3d1ddd@app.fastmail.com>
 <aZwyNAbEqb8ZwLUM@kernel.org>
 <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
 <aZw8xSI-TM-Gz84t@kernel.org>
Subject: Re: [PATCH] x86/efi: defer freeing of boot services memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6202-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5D6E4176051
X-Rspamd-Action: no action



On Mon, 23 Feb 2026, at 12:40, Mike Rapoport wrote:
> On Mon, Feb 23, 2026 at 12:17:22PM +0100, Ard Biesheuvel wrote:
>> 
>> On Mon, 23 Feb 2026, at 11:55, Mike Rapoport wrote:
>> > Hi Ard,
>> >
>> > On Mon, Feb 23, 2026 at 09:08:29AM +0100, Ard Biesheuvel wrote:
>> >> Hi Mike,
>> >> 
>> >> On Mon, 23 Feb 2026, at 08:52, Mike Rapoport wrote:
>> >> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >> >
>> >> > efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
>> >> > and EFI_BOOT_SERVICES_DATA using memblock_free_late().
>> >> >
>> >> > There are two issue with that: memblock_free_late() should be used for
>> >> > memory allocated with memblock_alloc() while the memory reserved with
>> >> > memblock_reserve() should be freed with free_reserved_area().
>> >> >
>> >> > More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>> >> > efi_free_boot_services() is called before deferred initialization of the
>> >> > memory map is complete.
>> >> >
>> >> > Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
>> >> > RAM on EC2 t3a.nano instances which only have 512MB or RAM.
>> >> >
>> >> > If the freed memory resides in the areas that memory map for them is
>> >> > still uninitialized, they won't be actually freed because
>> >> > memblock_free_late() calls memblock_free_pages() and the latter skips
>> >> > uninitialized pages.
>> >> >
>> >> > Using free_reserved_area() at this point is also problematic because
>> >> > __free_page() accesses the buddy of the freed page and that again might
>> >> > end up in uninitialized part of the memory map.
>> >> >
>> >> > Delaying the entire efi_free_boot_services() could be problematic
>> >> > because in addition to freeing boot services memory it updates
>> >> > efi.memmap without any synchronization and that's undesirable late in
>> >> > boot when there is concurrency.
>> >> >
>> >> > More robust approach is to only defer freeing of the EFI boot services
>> >> > memory.
>> >> >
>> >> > Make efi_free_boot_services() collect ranges that should be freed into
>> >> > an array and add an initcall efi_free_boot_services_memory() that walks
>> >> > that array and actually frees the memory using free_reserved_area().
>> >> >
>> >> 
>> >> Instead of creating another table, could we just traverse the EFI memory
>> >> map again in the arch_initcall(), and free all boot services code/data
>> >> above 1M with EFI_MEMORY_RUNTIME cleared ?
>> > 
>> > Currently efi_free_boot_services() unmaps all boot services code/data with
>> > EFI_MEMORY_RUNTIME cleared and removes them from the efi.memmap.
>> 
>> Ah yes, I failed to spot that those entries are long gone by initcall
>> time. Other architectures don't touch the EFI memory map at all, but x86
>> mangles it beyond recognition :-)
>
> Heh, EFI on x86 does a lot of, hmm, interesting things with memory, like
> memremaping kmalloced memory and I it really begs for cleanups :)
> 

Yeah. Sadly, all this has become ABI for kexec, so the EFI memory map abuse is hard to fix.

>> > I wasn't sure it's Ok to only unmap them, but leave in efi.memmap, that's
>> > why I didn't use the existing EFI memory map.
>> >
>> > Now thinking about it, if the unmapping can happen later, maybe we'll just
>> > move the entire efi_free_boot_services() to an initcall?
>> >
>> 
>> As long as it is pre-SMP, as that code also contains a quirk to allocate
>> the real mode trampoline if all memory below 1 MB is used for boot
>> services.
>
> initcall is long after SMP. It the real mode trampoline allocation is the
> only thing that should happen pre-SMP?
> 

early_initcall() should be early enough, those run before SMP init.

>> But actually, that should be a separate quirk to begin with, rather than
>> being integrated into an unrelated function that happens to iterate over
>> the boot services regions. The only problem, I guess, is that
>> memblock_reserve()'ing that sub-1MB region in the old location in the
>> ordinary way would cause it to be freed again in the initcall?
>
> Right now we anyway don't free anything below 1M, I don't see why it should
> change. 
>
>> But yes, in general I think it is fine to unmap those regions from the
>> EFI page tables during an initcall.
>
> Thanks for confirming. I'll look into extracting the allocation of the real
> mode trampoline to a separate quirk and then making the entire
> efi_free_boot_services() an initcall.
>

Thanks!

