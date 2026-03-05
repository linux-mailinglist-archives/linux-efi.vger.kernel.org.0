Return-Path: <linux-efi+bounces-6244-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHcjOzpmqWmc6wAAu9opvQ
	(envelope-from <linux-efi+bounces-6244-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Mar 2026 12:17:14 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680C821074D
	for <lists+linux-efi@lfdr.de>; Thu, 05 Mar 2026 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1B6315F66C
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2026 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC33806B0;
	Thu,  5 Mar 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvAgJJnr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41268379991
	for <linux-efi@vger.kernel.org>; Thu,  5 Mar 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709094; cv=none; b=rP3SodBxKcQlkD8EVQGqFDXGmeGDTT/Pbdv3KUSW2KQo46C1NGxYQ5xA0qmlcajPxLYKnAr3jUfMX8/mUC1Pf0/XsXkqC6TTsq5Y/3iZm8bMQ/wHyX8YCfdInPGCsZ3Q3M8shi8pEy4EIWFOc6jJMfasj1tH5VRrJEP5LYMP9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709094; c=relaxed/simple;
	bh=NICvv8J3MIUF9ByAPF1vMZRw9pZ9D4dvv1VCtt3dYU4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=luIUydJLswP+qdoio19cgUuW6ta6S8z7Nk8+gtiAtqj9ij0g+mJnV4qTiojWMllTnWtTqFd2P2zDWRpZexQ2SQRJeTiEN47zE/WhmsvUeEXpG+LH3xxVYdGyZPuyfFCuJ9F0eD/OSs4YQpCA9cN8Ks2m8MBwveLsMJJiS74c+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvAgJJnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A221CC19423;
	Thu,  5 Mar 2026 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709093;
	bh=NICvv8J3MIUF9ByAPF1vMZRw9pZ9D4dvv1VCtt3dYU4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EvAgJJnryaqujXE2dARD97LtcPKl7wltiLzQZqUQrrRC6hc34BjcLsUhSnKdoya5h
	 z/c2Gd4E3Y1SWD5KR56lb4xkuXWZzyAdxbihaebpLg+ueePuXDl3Y5v3ftVHw/TTyT
	 Dig5xVIU6X/L9x12WJRHV4/JNQkUFdbF3KN9DITZ9mp/HRBAcLGAbEgJzZa4OsFlnZ
	 FGyz/oeLkdD6cvQNTMGXHMIItKPEKBTM1dfnhpsbU2sNj8a5cQGGJ/W8sF4wjsG6Q2
	 EwlA2uiTrykPkZk+o/z4U+AYzXn7jzf0BlEIC4iG4rFCJOcjJTDLpPhQN6dC0WCC07
	 BugRcJ85j8++Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D7F2F40068;
	Thu,  5 Mar 2026 06:11:32 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 06:11:32 -0500
X-ME-Sender: <xms:5GSpaSk5SyAKmyIflqUXYy9VMs699eQjD-Z-eC2fmpBlMXy7su9T6g>
    <xme:5GSpaUoAvXC_OHFMrlo57ko8vFr2y3wZqm4mIokfdltCnsowdSEmrfFx6ADhbCZEl
    cr3yEFsa_33kV10cqXgSEhfj151Ts978iTg1FPax8Pup8TmRCvk2mk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeivdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:5GSpaSfxGytkM113DN7Mwym-LRxF2ufvjMsVoSKkjCAXKaZI4gbUHQ>
    <xmx:5GSpabz2oDU9ZdPs8giRBhgh44XriiI_Yc0fFfDT1ZeIwhpHCuc6VA>
    <xmx:5GSpaX2JAdOBMS_5wFuMYuM5_WtTbstyxDcl6obfNmF3MV6hALwATg>
    <xmx:5GSpaSdYSp__UK0sQAJCt3_zJwpnhZwff_t24xTQZD3fI_aXLyEFcA>
    <xmx:5GSpacUjivZtZ3ABUWxmfwUB-Y0cfnK8BHxZJYQt1ORxQxg_8z9jOSGu>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F204700065; Thu,  5 Mar 2026 06:11:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AusYBuezkfp3
Date: Thu, 05 Mar 2026 12:11:12 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mike Rapoport" <rppt@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Ingo Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 "Thomas Gleixner" <tglx@kernel.org>, linux-efi@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Message-Id: <7e4f6a4b-fe41-482d-a4cd-5a059e1626e6@app.fastmail.com>
In-Reply-To: <20260225065555.2471844-1-rppt@kernel.org>
References: <20260225065555.2471844-1-rppt@kernel.org>
Subject: Re: [PATCH v2] x86/efi: defer freeing of boot services memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 680C821074D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6244-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Wed, 25 Feb 2026, at 07:55, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
> and EFI_BOOT_SERVICES_DATA using memblock_free_late().
>
> There are two issue with that: memblock_free_late() should be used for
> memory allocated with memblock_alloc() while the memory reserved with
> memblock_reserve() should be freed with free_reserved_area().
>
> More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> efi_free_boot_services() is called before deferred initialization of the
> memory map is complete.
>
> Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
> RAM on EC2 t3a.nano instances which only have 512MB or RAM.
>

Putting a fixes tag referencing a patch that dates back to 2011 doesn't seem that useful here. Is this really an issue that goes all the way back? Or did a later change trigger the actual leak?

