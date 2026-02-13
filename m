Return-Path: <linux-efi+bounces-6124-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lxmeKYQRj2ngHgEAu9opvQ
	(envelope-from <linux-efi+bounces-6124-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 12:56:52 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF81135E5C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 12:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 835A8300C00B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057B35B64E;
	Fri, 13 Feb 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCYr5ux3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D439358D2C
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983807; cv=none; b=otS2GMTdsPTDQKEZaQIBBSWzgq7hkxqpbxg9/ykMILSZQCgsv0n/t4txeLpI2IpK20tCrrfeQRM7iXmb0JvEcN5brF2tovg0aCSSm+WlkzRwiHmhfsRBl6tOEQ4z949YhJ37v0Enfum9laIJ2eFA6xzTh8GRiaBwFv2MAQIdngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983807; c=relaxed/simple;
	bh=/tzuy95dr7y5V1xfTpUXokAN62TL8ReXjo5KHj11448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnxCn+gDB0t1SVFMnaUwvPQxZsBOUo9WZ1AFF0npmb1u2c1UBWbc2YIcxlaHf/K2KA8tS/qaMuEQx5PL5JN7fnm1fVoqJMZWxNgOhwB8Zg5K99C6gHsoDPoYIgoRjgepnma3mhaWH+WSiknbOWwk1BHRqpmurokVW8umZkeUNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCYr5ux3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986AFC116C6;
	Fri, 13 Feb 2026 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770983806;
	bh=/tzuy95dr7y5V1xfTpUXokAN62TL8ReXjo5KHj11448=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCYr5ux3t/lpkP2ZV4s+Fe7LoaA5qLMjQr524Lipt/Bp/ATzyHs8xNBfiRW7LKmDQ
	 TlW4vvaje27pbwyN52XPoQih1JABTMCmdI2p2rBhcVqCoXO49dxVP35DPG+yZcN7Di
	 VdIYj7V9tWeEymwAVXl5FZFoZD4xD7oFO05LvXokyl1bvs4/Apb6WPRx+4rdSfnN2c
	 lM86MOAVWCdKys/GABcd4OtRmACFSvqYy9hcU1LxhZkwq6nrYbIFdkzfA+l48vDEKj
	 FTgmZPyG2xjEu1cFirI3+ipg1yNxkKLmlS6x4tpJeMDNFL2cGMrjNKn0gwiWcp38wd
	 q7lNiMJMI3siw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id ACFCDF40068;
	Fri, 13 Feb 2026 06:56:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Feb 2026 06:56:45 -0500
X-ME-Sender: <xms:fRGPaT42FBvJ-mvG5XQic5O_yn-kmtKWzBfB7uQgbmURXonUAFjy7w>
    <xme:fRGPaXYKBVUDF5AkacvqHIIaKHt7zdQOUel7lsleFTWZeT0A6WzcvrYCLPsNc262D
    XgioELRW9WdHTL1iOo7btaptMhP_VMjf_RypCpjq_Kvp_n2OyvM-Bc>
X-ME-Received: <xmr:fRGPaRSUTyl9z5lEtUNaJfNnNyf26MH46N5nlHPoUrb7_gKHLoigBwYZWNagPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekudekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fRGPaUJQwsGnz9lKMw_AJyUJcYj95bj7VmhJh-Gze1bzWM7slaRPGw>
    <xmx:fRGPafW1rhxBW_X6Qm3R21Fwx7jWifYG72kcPNDgpPCxb7YW0dqb_Q>
    <xmx:fRGPaYgV8p0HKoQzC7FEzpPDmriDlTKRbz8gaMTk14xpbb4mmO3SWQ>
    <xmx:fRGPabtgeGfwGAZNmj6VPiu3UD392yUEcpV83WHU1ERls_AzuAAqTQ>
    <xmx:fRGPaYz7DjnS8IUwhGsUM8GB2WBS-TbsSWMI4Tc4-GwTK0Og8BQibEeA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 06:56:45 -0500 (EST)
Date: Fri, 13 Feb 2026 11:56:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Moritz Sanft <ms@edgeless.systems>
Cc: Dave Hansen <dave.hansen@intel.com>, ardb@kernel.org, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Wunner, Lukas" <lukas.wunner@intel.com>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
Message-ID: <aY8Quu2WJG5HB3PP@thinkstation>
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
 <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6124-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1AF81135E5C
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 09:34:46AM +0100, Moritz Sanft wrote:
> > Any chance you can throw
> > a bunch of printk()'s in the kernel and see what all the fields in here are:
> > 
> > struct efi_unaccepted_memory {
> >         u32 version;
> >         u32 unit_size;
> >         u64 phys_base;
> >         u64 size;
> >         unsigned long bitmap[];
> > };
> > 
> > Along with the address of bitmap[] and all the calls to: bitmap_clear()?
> 
> Thanks for the guidance. I've added this logging via the patch in [1], which
> produced the following output:
> 
> ```
> [    0.033292] accept_memory(start=0x0000000000099000 size=0x6000)
> [    0.037860]   unaccepted: version=1 unit_size=2097152
> phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
> [    0.041469] Using GB pages for direct mapping
> [    0.043090] accept_memory(start=0x00000010db600000 size=0x200000)
> [    0.045311]   unaccepted: version=1 unit_size=2097152
> phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
> [    0.058123]   bitmap_clear(bitmap=ff1100007d624030, start=32475, len=1)
> [    0.060921] accept_memory(start=0x00000010db7ff000 size=0x1000)
> [    0.063142]   unaccepted: version=1 unit_size=2097152
> phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
> [    0.066865] accept_memory(start=0x00000010db7fe000 size=0x1000)
> [    0.069096]   unaccepted: version=1 unit_size=2097152
> phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
> [    0.073705] accept_memory(start=0x00000010db7fd000 size=0x1000)
> [    0.075908]   unaccepted: version=1 unit_size=2097152
> phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
> // unrelated logs omitted here
> [    0.134988] accept_memory(start=0x00000010db7fcf40 size=0x83)
> [    0.137152]   unaccepted: version=1 unit_size=2097152
> phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
> [    0.140828] BUG: unable to handle page fault for address:
> ff1100007d625008
> ```
> 
> Find a full log attached in [2].
> 
> Please let me know if we need to gather any further logs - we're happy to do
> so.

Could you check it this patch makes a difference:

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index c2c067eff634..f2a00cd429f2 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -35,7 +35,7 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	struct efi_unaccepted_memory *unaccepted;
 	unsigned long range_start, range_end;
 	struct accept_range range, *entry;
-	phys_addr_t end = start + size;
+	phys_addr_t end = start + PAGE_ALIGN(size);
 	unsigned long flags;
 	u64 unit_size;
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

