Return-Path: <linux-efi+bounces-6264-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE9pOZL7qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6264-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:06:42 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAFF2248CE
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AAE4304289E
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780893E95B5;
	Fri,  6 Mar 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui5M6tep"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547163AE1AC;
	Fri,  6 Mar 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812855; cv=none; b=CZ3X4muJsjhImcZXCmFLxcrydRSclrrQZI95aAp2QCYmp9QyxrJEvhd95fFeYSwk3XS69BoYBIKm6NFMJqSnB9Jd9h/F/wutZoYoE6fAfa8e7CDDQcUY7tXzM5hFvtDu3+PB3QYCs4rzdRhRK7iFBs7M9lMhi3Xh5Y+ZJUuWzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812855; c=relaxed/simple;
	bh=vumTOJ4lX7fBmD/gcjVvysIezY67LkrnMTKk6Uap0cc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uLCvZ2Oy7lPL/oCBCTgqQYcqiZE0690BGS6Eiy4gzmPIrtkhrLWfoX2n0tKvRNOp0MH2HlftaGEwaoVjLIfmncACcFGfyozZgvR9ht4Fpj9JEoRYhLc8v+gW9kRzsZh5UPxW7QwmtKPUP7vEutfF/5hiIExGVYTWxYUEnq6VeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui5M6tep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C8DC4CEF7;
	Fri,  6 Mar 2026 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772812855;
	bh=vumTOJ4lX7fBmD/gcjVvysIezY67LkrnMTKk6Uap0cc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ui5M6tepSPQeamHk5HAnuYqgfEF8uMADPQBaDaP0K6I2Pws9KEz7V7gTOlcCEW/GX
	 4fA/Z7ZE2BRNDX8zPAiN1zwtm7oMPbxwmcUVHotVXzsM0pftPSQWmbYhLJNeh/F1sr
	 QaFp3aqONqqy1n+/hYem4y20bBAn0qWF/oym8mnv8MFsJwObKzqTNeUhAA3EvMx+tW
	 NBbccRKQMPtiJF8n7seqEqO4L04C3aFGKNhX7MMtAnGTgl5lG8JOYXEQ9x2A6BNQA9
	 oo2sTbqLUmhjRAEmHbElJB9FsBZ9r/hj6KvE2IDThGIiG0ZOyNJ/8jvZ2QryVXtkrR
	 5ksCayXbKVkMw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D43BFF4006D;
	Fri,  6 Mar 2026 11:00:53 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 11:00:53 -0500
X-ME-Sender: <xms:NfqqaWKUsk24o0qGIV8YPne-HqIvbmwW8ZIUNaByyUidsxjHGPWZcA>
    <xme:NfqqaY8NQCj0b3ha8Htunf_OZ-PP1AHB1YGDt0IijXISrnhpIKffoS84Gsi2lE32O
    y0wfBvFaq836eOldWQA2gbyeuNPuvVWwLwXilmZcoALBdTW-lQwCw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrrhgusgdoghhithesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhhhse
    hkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NfqqaUtgle9OgKVCQRxbYsv9-LQt86E6TNKnMJpxue2YeKjMVrS3Dg>
    <xmx:NfqqaTtmDwVuGuC5J2j-AxCHf0l3fv4NRVSFj9Z0RyjEblVz_qniiQ>
    <xmx:NfqqaSBlD1FvWGdCWwSIflwhJbuKexreeJLwYh8GuNgtjc9ltt4rUw>
    <xmx:NfqqadM8mOAcHW20CYLC5OhVPC1S3ETblpSVHxa9-YHlLgRhf-ZuqA>
    <xmx:NfqqaTxMsLt52XfyfQ8CBQxHI5e_LIsIxCmw-UTv7iHkUvntNMcL_GSz>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4F37700065; Fri,  6 Mar 2026 11:00:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APqpIWJkOMog
Date: Fri, 06 Mar 2026 17:00:32 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 "Mike Rapoport" <rppt@kernel.org>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Message-Id: <82f3cd1f-620b-48ce-922b-4369d53dd558@app.fastmail.com>
In-Reply-To: <20260306155703.815272-17-ardb+git@google.com>
References: <20260306155703.815272-12-ardb+git@google.com>
 <20260306155703.815272-17-ardb+git@google.com>
Subject: Re: [PATCH 4/4] x86/efi: Omit kernel reservations of boot services memory from
 memmap
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6BAFF2248CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6264-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,git];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Please disregard this 4/4 - it is a stale version from my working dir, apologies.

On Fri, 6 Mar 2026, at 16:57, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Now that efi_mem_reserve() has been updated to rely on RSRV_KERN
> memblock reservations, it is no longer needed to mark memblock reserved
> regions as EFI_MEMORY_RUNTIME. This means that it is no longer needed to
> split existing entries in the EFI memory map, removing the need to
> re-allocate/copy/remap the entire EFI memory map on every call to
> efi_mem_reserve().
>
> So drop this functionality - it is no longer needed.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/efi.h     |   4 -
>  arch/x86/platform/efi/memmap.c | 138 --------------------
>  arch/x86/platform/efi/quirks.c |  54 --------
>  3 files changed, 196 deletions(-)
>

