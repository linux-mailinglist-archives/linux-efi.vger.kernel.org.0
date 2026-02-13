Return-Path: <linux-efi+bounces-6133-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AmmHjpOj2laQAEAu9opvQ
	(envelope-from <linux-efi+bounces-6133-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:15:54 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8490A137DFF
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 492D9302890B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928D3612F4;
	Fri, 13 Feb 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU499Toi"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602430E824
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999286; cv=none; b=eRhGFUTYNjiB/3N+tEEkuOHU/zzBTwyoV3WNJ5nZO9zZovcZADozsLl60f4aXze2/h9ZrZ5BDwRMg/M5f6aN0jm9Q2peFK8FcPXWTvbX2hx9+YGeYjD3z7HvAmvsKhoW3+u5ynffg07tMXhQwgludOx2RgET/GwdRy9BBh+zYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999286; c=relaxed/simple;
	bh=gJZ0H5g6MogpXiUv5VCMxrBmJWtE1/ypyfUmSRv+31M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+JWZahgR7AcUG/f/zJfH/LNHL/FmzqJhL0h2K8fUWd5eDzi4Xs3yXILH0tODfzDVGuHsky30jwf3d8bOI8vsgQmStTYXm+kd/hfx5JTigXiKo4dTxPulg7RHtF67SZYOeHjgsphh9P4bUQw5QOOueljfAbL1pWXu/eynOYwNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU499Toi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E81C19425;
	Fri, 13 Feb 2026 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770999286;
	bh=gJZ0H5g6MogpXiUv5VCMxrBmJWtE1/ypyfUmSRv+31M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU499ToigZuK20hiWZbH7LCORa87aJXQCPe1/z1cQ4iwPfNPc9xs39+iHxiqIPpou
	 F32yb/TlE7gOpcotXGSzt6JIw/t4GtDmewPkiWPFdakP+sRnYX5tEw9xSmMbdVTK0N
	 WDpH0J7hsj5T7ejCY+tGMHwfM5AdVzVOWdgoGepEc9GYF6gEs0YMNPnlk2j6pD1QN/
	 /akVh7b/Y3TgiaaRo5ihIxL5vKsv1ds3u5FLUHnvQnCm+nUBEbrqOmU3hYBdvN/7Sb
	 r0LX1h1GNiSxU7olD7WhETRSpMdn19Nkign3YBE3Tzo7wIQIS2nlqAYOGlo1p43D8C
	 z0bVOkwxuTLog==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 01C01F40068;
	Fri, 13 Feb 2026 11:14:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 13 Feb 2026 11:14:45 -0500
X-ME-Sender: <xms:9E2PaTrENhaqbGlwHu-gUpK5LdGG6TBWH9Fs-AN_8zGb7w_-T8xc0g>
    <xme:9E2PaZG6XtqJC_AC4aaMILMBG1xV_-mzh0xAp9nAVO9TCZCGpNdAkZ0IGQqTGwMXv
    -RXFeLZE5To1r-OKNG2c7tHNW7eKex-ODTeX24b6vnWn5m8HKbTYLA>
X-ME-Received: <xmr:9E2Pae7bkCEUiVoaYkSHVgObc7qBJiyj9InIzlN1COFLvX1yImx5xknsTLXaww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrug
    gssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpse
    grlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomhgrshdrlhgvnhgurggtkhihsegrmh
    gurdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9E2PaUCnT-wGATJhB9o97JOzceYK7wiKm_o_F4L0S2_tiSYpVnsFYQ>
    <xmx:9E2PaZQCeAXsXAH6HA8S9JXf4V6Rxaj6pm1yRK0_dOj9_GKjO3bV4w>
    <xmx:9E2PaUesNnJ8qKjA2_k5Y_Mcuq_xzzc_s7kSU43b9UMx8P-TY37Flg>
    <xmx:9E2PaSTVgSDOMpjnk3ZBfS0S5ER3GE538Y9er1clwcdzh4TiHPOZ-Q>
    <xmx:9E2PaQ0OZYszpOF6ZBWwYabHzAbCw0cUSzJyYrm8unRvaSqLdMLdpFc_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 11:14:43 -0500 (EST)
Date: Fri, 13 Feb 2026 16:14:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Moritz Sanft <ms@edgeless.systems>
Subject: Re: [PATCH 1/2] efi: Fix reservation of unaccepted memory table
Message-ID: <aY9Mf8oZODGiDoXp@thinkstation>
References: <20260213154838.46567-1-kas@kernel.org>
 <20260213154838.46567-2-kas@kernel.org>
 <b3b073e4-d51e-4fd7-ad7c-7465dab412b6@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b073e4-d51e-4fd7-ad7c-7465dab412b6@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6133-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8490A137DFF
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:01:55AM -0800, Dave Hansen wrote:
> On 2/13/26 07:48, Kiryl Shutsemau (Meta) wrote:
> >  static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
> >  {
> > -	phys_addr_t start, size;
> > +	phys_addr_t start, end;
> >  
> >  	start = PAGE_ALIGN_DOWN(efi.unaccepted);
> 
> Why are we even aligning the start? Isn't *that* the bug?

How so? It is up to EFI how the table is allocated. We need to be sure
that this memory is mapped and not overwritten.

> The memblock code seems to be able to handle arbitrary alignment just fine.

Memblock will track it, but, as the comment says, anything smaller than
page size will not be mapped, but we need the table to be accessible by
kernel.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

