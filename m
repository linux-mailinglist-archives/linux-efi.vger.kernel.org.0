Return-Path: <linux-efi+bounces-6126-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEumJBA0j2lEMgEAu9opvQ
	(envelope-from <linux-efi+bounces-6126-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:24:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9281370B4
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FC5C3013DD6
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631D35B631;
	Fri, 13 Feb 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gmt6Lrsm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D17361669
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992650; cv=none; b=EwGKj8IbRZ/UaDqLHJe8yjF4xvNPvg1rnnNAVeLyGdxAoAQPlGm9bfWvxPyNNjPbW2nZ5K0vMTJGy405+uFzNncMeL0loa5c4RT1tdrVOgpX2yoEvD/8McX6W2OSzn1xR4hD6Ab5l1qhyzNmjrbzpNKjJJ/6ulJesGZyyLEHe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992650; c=relaxed/simple;
	bh=NyQ/+9Jpp+qd7shQlKvJyvr4xXmgReJwlq27O0lDVK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6rAl2UETf+fZLQr8+mRJLPTnxZzUoBSBa9ZRwjh8oaFBq2RvYg8tDUjY/VGiAj1i9r2YSIApZ9ABv20io2GyDR7UV+CaqYMN2LSJ65rYR4RM0OP4rXTC6pUitBAEsFTvJchpkyr2qHrxOpyuP/rLSxDwhNdnup0ajasYkUR0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gmt6Lrsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0E0C16AAE;
	Fri, 13 Feb 2026 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770992649;
	bh=NyQ/+9Jpp+qd7shQlKvJyvr4xXmgReJwlq27O0lDVK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gmt6Lrsmo0XccZKYm1HlEOkdqjgzgvWKAvCqjmPUetkfPgguzULmVU4TOuku0RjDD
	 iU170gkYDAlsOaNkz81so5hEN5325QRa9lGPi4kIj18R4z30zp4FWy/+nhlrc0b3tL
	 /EOrwPMKO0Bo89nXP2oEtF9n4NAGe1wh2/lBDExjFwqlEoFukkQbolQfT5u7dTsE7b
	 pIZ9irF9Se0AMHNKIItavXRzMmQAoWSbeZhhMWwCcE4gVbdcTUqjRQOmv8TqJ+OdC8
	 rMqrP5U6tAeW791/JZGJV/pTJyehrqlBIzDOp6q38bMmp6j7IS/bodVXb4y8BoLFZL
	 BBickLXnP0AmQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB515F40069;
	Fri, 13 Feb 2026 09:24:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 09:24:08 -0500
X-ME-Sender: <xms:CDSPaaLVPIMWut4vj3e9cD80_j2hglpEBUXFy1ytuoZraZKzRlulPQ>
    <xme:CDSPaQrAtNV0UpExxQ3PdF4VnOTUeQpXEpYnJLfhQgda14jUuS6ZfIX-iQ1_8csFQ
    LyN9We4ePbJfVXqwkkN2PgHuiIUWdNUVEqt6c1BGvuumc3R7B_gHBE>
X-ME-Received: <xmr:CDSPaRjcso3FzhDFFGnJmfN09hS-FmvplZKwagWCbBkid0x2fdlWiPENgppYIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshesvggughgvlhgvshhsrdhshihsthgvmhhspdhrtghpthhtohepuggrvhgvrd
    hhrghnshgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrd
    gtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphht
    thhopehluhhkrghsrdifuhhnnhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CDSPafaRa44pBsAVTH02YRw56HSvSYo46gn8Xzf7pAQH3-NaSyahtg>
    <xmx:CDSPaZlnt_soguspFddS-6VrBC2wzVcajVpyc146FdjdOFdUaU8dmQ>
    <xmx:CDSPaVwQb18F2NXTtnn7jPFWpJjYtHuUGjhp-ADt86T4Geh6CgFsqw>
    <xmx:CDSPaf-keSbdBj8jscHlcFJIZMZ_z53b3lfJ5xwiJhDhpAB2D1UHIw>
    <xmx:CDSPaYAknpY4X2GcaHvRj5yQ7b3XoY--7_ZmjMVokGcQ6iXmC_4ZU7ce>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 09:24:07 -0500 (EST)
Date: Fri, 13 Feb 2026 14:24:03 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Moritz Sanft <ms@edgeless.systems>
Cc: Dave Hansen <dave.hansen@intel.com>, ardb@kernel.org, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Wunner, Lukas" <lukas.wunner@intel.com>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
Message-ID: <aY8y6uCyejTXTejt@thinkstation>
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
 <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
 <aY8Quu2WJG5HB3PP@thinkstation>
 <5a0fa6d2-f138-4360-bf02-5478eda4b495@edgeless.systems>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a0fa6d2-f138-4360-bf02-5478eda4b495@edgeless.systems>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6126-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0C9281370B4
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:33:56PM +0100, Moritz Sanft wrote:
> > Could you check it this patch makes a difference:
> > 
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > index c2c067eff634..f2a00cd429f2 100644
> > --- a/drivers/firmware/efi/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -35,7 +35,7 @@ void accept_memory(phys_addr_t start, unsigned long size)
> >  	struct efi_unaccepted_memory *unaccepted;
> >  	unsigned long range_start, range_end;
> >  	struct accept_range range, *entry;
> > -	phys_addr_t end = start + size;
> > +	phys_addr_t end = start + PAGE_ALIGN(size);
> >  	unsigned long flags;
> >  	u64 unit_size;
> 
> Thanks, I tried this on the `-m 67000M` VM and the crash still occurs. I
> extended the previously-added logging to also log the values for `start +
> size` and `start + PAGE_ALIGN(size)`. Please find the full patch including
> the logging and your change in [1].

What about the patch below. It seems we under-reserve memory for the
table if it is unaligned.

I still think that we need align start/size/end to the PAGE_SIZE in
accept_memory()/range_contains_unaccepted_memory() before doing anything
else. Otherwise (end % unit_size) check is broken. But it seems to be
unrelated to the problem you see.

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 111e87a618e5..56e9d73412fa 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -692,13 +692,13 @@ static __init int match_config_table(const efi_guid_t *guid,
 
 static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
 {
-	phys_addr_t start, size;
+	phys_addr_t start, end;
 
 	start = PAGE_ALIGN_DOWN(efi.unaccepted);
-	size = PAGE_ALIGN(sizeof(*unaccepted) + unaccepted->size);
+	end = PAGE_ALIGN(efi.unaccepted + sizeof(*unaccepted) + unaccepted->size);
 
-	memblock_add(start, size);
-	memblock_reserve(start, size);
+	memblock_add(start, end - start);
+	memblock_reserve(start, end - start);
 }
 
 int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

