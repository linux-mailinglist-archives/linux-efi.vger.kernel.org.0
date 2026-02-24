Return-Path: <linux-efi+bounces-6215-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F1WBOtwnWk9QAQAu9opvQ
	(envelope-from <linux-efi+bounces-6215-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 10:35:39 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 379E7184B0E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C99A30585B7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B12BEC30;
	Tue, 24 Feb 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knq0yBl/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2E3EBF33
	for <linux-efi@vger.kernel.org>; Tue, 24 Feb 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925422; cv=none; b=oFuCw0DOJmdmFHTNFHjRa6d9W1iUCajyt7nPjMwbDDApZJs6kt5z+BvSNH4lGSLvNIHB4r5n/DFsgRFTXCAjZD7qf+e1A137AlZacm8W/iAvRrC2O4BW9bPUPLgfIfCX5dWFAOr4ohgo7pCIy0rXlqQBnZG5jCTNhbsQSZ+FMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925422; c=relaxed/simple;
	bh=jbUHpcYlvb7oVyQJFkV28djZCHiGr4saQLNVfd4W5R4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tkPXjFvldvi3Jic8ycJ+U5uMwMh7IO5+U7mOYLuzxNqOm25Gukm84LTfr1y32fZP/CN+1NGZWGwSghR3CHJ9tjK1j+xqNqPEQ9XKTSvJ13G3yCrbOS7o3WQqSHOhLEkxK//AyKZZ+kzorZmc+v4LABgEgyJrMCaBn5jIcs1Fa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knq0yBl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF52AC19423;
	Tue, 24 Feb 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925422;
	bh=jbUHpcYlvb7oVyQJFkV28djZCHiGr4saQLNVfd4W5R4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=knq0yBl/b9+RxkrojcdaA400AQwDSi0RQp8m5WGlP44MhqbXdgnq5RV3Nd2eIbHQW
	 rEQzqLCM0VPOIvbi6Xhr2tufGlvFZ4G8PEXiOa3TkW+gvG03Rc7nnoqKoasYz7uI7n
	 YrqgxN4M5a691hH87KsXMvtmVQGgYr93i2wQfC/0lVxM+Fb/lvNGo96reCTrlloPIQ
	 7L41Yj/Ji08V9vEcl7uIxBaZiTlJkPWprFudC+MOXErGreyIej5GqcEpKr8UeitJdl
	 qUTtnuX38jOXmeTCTZT9Tsbas/wW50e0FnijMfB1cdwNOp8sCzP0+TBivDjJj4h1WY
	 1abvZ9nYLO3rA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C6939F4006B;
	Tue, 24 Feb 2026 04:30:20 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 04:30:20 -0500
X-ME-Sender: <xms:rG-dac5Eldop4hd5g1rcFphVyAwAIuwE_Nt6AohZkkYhGCz3pw8ppg>
    <xme:rG-daYsz1hog2P-R8OAx-d1AmpL1wdDZBWAy04ov663SMDYfytyzwb1iHS7pTVWhu
    e_IA1HhlKpt-ol2mp9Vz9Os1D3dnEK_JnzX88cowDVQWXfGXimdLwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rG-dabR0f8a3bHnCzMDUtGobFjlTOLKiX67HAt5j3GLFERUelBzv_A>
    <xmx:rG-dacWnLFN1wrnpaEXZ2hPKAPWX-V7nl8t1-OeUPvse692Cqi4geA>
    <xmx:rG-daVIA1upta-g1_ksje9mFW6cZChSXuJ_E3O3ilJAXiJq_uPfgXA>
    <xmx:rG-dadhO4OkjdezzAe3izOmbzXMjDXfWTqn_MpQrG46sxbwTTeshwg>
    <xmx:rG-daSIzM11vfacGtEVN3K-V5PqLX7fKIi7uQvQAXwoiaYUdW35z26-k>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A1156700065; Tue, 24 Feb 2026 04:30:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AF0NZ4OlJH_7
Date: Tue, 24 Feb 2026 10:29:59 +0100
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
Message-Id: <3a01d817-e08c-45ec-b5a7-4a8d9ecd0fc6@app.fastmail.com>
In-Reply-To: <aZ1vWEgJNwc2nrrA@kernel.org>
References: <20260223075219.2348035-1-rppt@kernel.org>
 <b6f4edf5-7587-45d7-b81a-590d4f3d1ddd@app.fastmail.com>
 <aZwyNAbEqb8ZwLUM@kernel.org>
 <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
 <aZw8xSI-TM-Gz84t@kernel.org>
 <bfe487fe-6868-4215-b5be-99a0360e9bd2@app.fastmail.com>
 <aZ1vWEgJNwc2nrrA@kernel.org>
Subject: Re: [PATCH] x86/efi: defer freeing of boot services memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6215-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 379E7184B0E
X-Rspamd-Action: no action



On Tue, 24 Feb 2026, at 10:28, Mike Rapoport wrote:
> On Mon, Feb 23, 2026 at 01:18:41PM +0100, Ard Biesheuvel wrote:
>> On Mon, 23 Feb 2026, at 12:40, Mike Rapoport wrote:
>> > On Mon, Feb 23, 2026 at 12:17:22PM +0100, Ard Biesheuvel wrote:
>> >>
>> >> > I wasn't sure it's Ok to only unmap them, but leave in efi.memmap, that's
>> >> > why I didn't use the existing EFI memory map.
>> >> >
>> >> > Now thinking about it, if the unmapping can happen later, maybe we'll just
>> >> > move the entire efi_free_boot_services() to an initcall?
>> >> 
>> >> As long as it is pre-SMP, as that code also contains a quirk to allocate
>> >> the real mode trampoline if all memory below 1 MB is used for boot
>> >> services.
>> >
>> > initcall is long after SMP. It the real mode trampoline allocation is the
>> > only thing that should happen pre-SMP?
>> 
>> early_initcall() should be early enough, those run before SMP init.
>
> I don't think so. All initcalls run quite late in boot, early ones just run
> before the others.
> 

It is documented as running before SMP. If that is no longer true, we should fix the documentation.


