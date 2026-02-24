Return-Path: <linux-efi+bounces-6220-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEQZJeXynWk2SwQAu9opvQ
	(envelope-from <linux-efi+bounces-6220-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 19:50:13 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79B18B913
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2351300C542
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84282D94B4;
	Tue, 24 Feb 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H91HB49I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952612D9787
	for <linux-efi@vger.kernel.org>; Tue, 24 Feb 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959007; cv=none; b=UDXNfJyOlTHCmRPW2+jkHFHyxZ3OhUdo0zJnNASOEFXurYbm+u8QN4ENaczzO+5BBXjfQ7vAVt1XkNWcQZW3UOPPX3VesASHs6/kwcuwMhWngMG0gN2vym7O4WCgrm+BwijOy17RBV/j58qfsJqLrU5E10jnKlbYwTE6E90vXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959007; c=relaxed/simple;
	bh=egc456JeFzzJ9IHuAVV87rTTgLWYtfbTn8d5ks0MspA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kMOcjyF/lriA6cvP98JGqf4NnfMyIvYzXeHMmzfDH4d20Ccl+rgv/NtIIEHX1hp6MOa0OBvTUtYb1dmS2ESuyFCUmF8dKgwveTnyol9YsIDHMqn+3qDjlRHIvHzWAtZ4K4FLYSS5/D+KrHpzkYUCHoEGPYuu5yKoRR16qlMezQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H91HB49I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AE2C4AF09;
	Tue, 24 Feb 2026 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771959007;
	bh=egc456JeFzzJ9IHuAVV87rTTgLWYtfbTn8d5ks0MspA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=H91HB49IvngxSSpueq+ZdeIUG7YFdA2DKiTA8+7ovXbXElfsGCsgk67nidktfMu9E
	 ehkFOZ72iSGHfkCANR1m0+APrlbbc+RThp6IqHyogpQhwuztNXmxZOJy4+ZECNdkFa
	 ik+e1Yr6kOIcHGHfg58rn+OW1g8XZ6y72hqUSA80BgLvM86a8HYluT1jwKHODcEer3
	 BUV/OjaMdyFS9Xl356ARxvoZxHwk4Wzm03dj41BPP1IFHJ9R7eCo1+xTWPWhpBc68F
	 vrS4A306wPvAkNP9UpHxSGhQSFMXMgkZgH8tM3TyuDuuVDktREL6D1i334+MtcDDsQ
	 e41zxvMPNKbIA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 860C0F40069;
	Tue, 24 Feb 2026 13:50:05 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 13:50:05 -0500
X-ME-Sender: <xms:3fKdadCCYEXrn32B69P_aJ1u7CtyWDC4CiCgaqeWMtrf6N2OANTEmw>
    <xme:3fKdaWVm7RLAvQf-iOG49nF7DsUtYy09ZX61aQP6U44M5wqGNJhZUxAD2lo6MZf2t
    8yLazqBvzT3OV9QWWsi9kuT6XUNXoIXx0WycR8iANB3qWMEWkxPUsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheprghnughrvgifrdgtohhoph
    gvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnth
    gvlhdrtghomhdprhgtphhtthhopehsohhhihhlrdhmvghhthgrsehinhhtvghlrdgtohhm
    pdhrtghpthhtohepthhonhihrdhluhgtkhesihhnthgvlhdrtghomhdprhgtphhtthhope
    hkrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3fKdaRPscNbeyZG3-ynI2I559QuyyI8eXVEy_OFiW8JD6qbReVSVRw>
    <xmx:3fKdaf5U9iZ4w51XupUOY9-luBqDT-8LyZ8iJlrTon7hCHolnKb2EA>
    <xmx:3fKdaWYASEhRyR7Xe-fRiHJXb2ea4ByhnXqRIN0oaUC_fLWoPaCO9w>
    <xmx:3fKdaUGosWv2Ui0e_ERm9yO_jbEo70v5h4s0QLMbMnQnhfvkZ7TC4Q>
    <xmx:3fKdaXm8ev6vF1ARA_8F-TRHG84csDbAVmjua7cfd8fagVHPNy5HJMRz>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0598F700065; Tue, 24 Feb 2026 13:50:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5U4Ut27npfc
Date: Tue, 24 Feb 2026 19:49:44 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Sohil Mehta" <sohil.mehta@intel.com>, x86@kernel.org,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 "Maciej Wieczor-Retman" <m.wieczorretman@pm.me>
Message-Id: <1664bf5d-f1a9-473f-b78d-8d14f0dd7943@app.fastmail.com>
In-Reply-To: <b476c206-08f0-4582-a924-2164ba6ae84b@intel.com>
References: <20260120234730.2215498-1-sohil.mehta@intel.com>
 <b476c206-08f0-4582-a924-2164ba6ae84b@intel.com>
Subject: Re: [PATCH v2 0/3] x86: Extend LASS support to EFI configurations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-6220-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9A79B18B913
X-Rspamd-Action: no action



On Tue, 24 Feb 2026, at 19:45, Sohil Mehta wrote:
> Hello x86 Maintainers, Ard,
>
> On 1/20/2026 3:47 PM, Sohil Mehta wrote:
>> Solution
>> --------
>> These patches take LASS out of the path of all EFI boot and runtime
>> service interactions by:
>> 
>>   Patch 1: Deferring LASS enabling until userspace comes up, which
>>   ensures EFI has completed switching to virtual mode and all boot
>>   services memory has been freed [3]. 
>> 
>>   Patch 2: Temporarily disabling LASS every time a runtime service is
>>   executed after boot. Runtime services execute in a special efi_mm
>>   which doesn't have userspace mapped. So, the security implications of
>>   disabling LASS are fairly limited [4].
>> 
>
> The patches now have tested-by tags from Maciej and Tony. Also, the
> patches apply cleanly on v7.0-rc1. I am hoping to get some review
> feedback on the patches before resending another version.
>
> Ard, are you okay with patch 2 that disables LASS during EFI runtime calls?
>

Yeah I think that's fine.


