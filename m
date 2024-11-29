Return-Path: <linux-efi+bounces-2237-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F79DEA1B
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00403B212ED
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092613D619;
	Fri, 29 Nov 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kiwMH+vj";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gMBfpksh"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27847168DA;
	Fri, 29 Nov 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896245; cv=none; b=YjSf23F0ujHq0wnEOeriNdY6LaDBVTyfRAiaaoZuXZmske2/XPQxZ5Mh3vYkHvzmIsDJbHvXfnVfbZKFv5oBjPwNEBOsHdXqxVRQ8h6TrW3L9ZY62ucqHN9UOu8xZmOHtoacmQcbmoe7rj54bg21nn3WszIRceintywnw4f2mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896245; c=relaxed/simple;
	bh=eJcwKX6ItFr4x/AT4MvoWM+YZf2mke1byCryuNUysrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8JpmNGF298lD0pGFsgu7EYZL3zT+IAB+I5QV2HzfXKbEGsdFB2MncJEdgNER54Gpm2UZlkD1Zb1li/cKDcSxADY+2q2U56fIOd6tut6jyG4DiW0PjXPKiN46EwRoNUiXgTUghj6EOs8wrraWKXotYslynX7Zt1z2l03QmazOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kiwMH+vj; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gMBfpksh; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732896242;
	bh=eJcwKX6ItFr4x/AT4MvoWM+YZf2mke1byCryuNUysrE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kiwMH+vjBFFwIKiNJlaK8GDSaiK3cokBYEGoKvG5pI++T8kYA7x/tL9zLiFlQIRbj
	 RN79gILbr7U92IkWn2ceI2XTchgE8hOBP80GMUOxj6kbql4n1ejOIrKIBCe+AAWw8U
	 N2oVd/e83WOegR8nCeoYlna/ywWMTiE4HOjY/FNs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F5A0128791E;
	Fri, 29 Nov 2024 11:04:02 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id IFaNvKTXbY5o; Fri, 29 Nov 2024 11:04:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732896241;
	bh=eJcwKX6ItFr4x/AT4MvoWM+YZf2mke1byCryuNUysrE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gMBfpkshrWCnhoUZZh9yt6spyvumqyJ0TuXa/7L/XiT80LNLIqErC67Vwt0iCv1W8
	 vU1jr6icVQSlSCHzymRvFAI2HkAPUWa1qnYBF+Ih/o4hQm3SRJxbg4nDf1RQzWb1Vw
	 PIvw9SIRxv3C5TmHLsDfSzy1ND1JdlV8e5mPZBYs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2B7D81287960;
	Fri, 29 Nov 2024 11:04:01 -0500 (EST)
Message-ID: <02060553aafac7e145e96510a66a6845d389d6ff.camel@HansenPartnership.com>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiri Slaby <jirislaby@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Cc: Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org"
	 <linux-efi@vger.kernel.org>
Date: Fri, 29 Nov 2024 11:03:59 -0500
In-Reply-To: <7773891b-b699-4f1d-b9ba-220c649aee9d@kernel.org>
References: 
	<CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
	 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
	 <ca741d8eade72aa68c389a88d2520f4fe541a1e7.camel@HansenPartnership.com>
	 <2a238b61-fa03-4ae4-9dc4-f73834aa3228@kernel.org>
	 <70bc83bd7cfb236da030e584e93bfc62c1d9eb6a.camel@HansenPartnership.com>
	 <7773891b-b699-4f1d-b9ba-220c649aee9d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-11-29 at 07:36 +0100, Jiri Slaby wrote:
> On 28. 11. 24, 17:13, James Bottomley wrote:
[...]
> > Yes, it tells me the entries in the log for PCR0-7,14 match the log
> > entries (for both sha1 and sha256).  However there are entries for
> > PCR9,12 which don't match.  The log shows shim starting at entry
> > 32, grub starting at entry 37 and the kernel loading at entry 39 
> > the kernel command line logged at 40 to PCR 12, which is
> > mismatching.
> > 
> > The next two entries (41,42) are for the mismatching PCR9 and are
> > of the initrd and the options and come from the libstub code in the
> > kernel early boot (efi-stub-helper.c).
> 
> Note that ovmf logged:
> Called TcgDxeHashLogExtendEvent 0 58683000 1B1E78C 5FE63C00 5E3492AA
> Data 28 B5 2F FD ... E1 29 FE 0
> 
> But initrd on disk is 1B1E78B long, not 1B1E78C. So the excessive 0
> at the end above brews the mismatch. See:
>    https://bugzilla.suse.com/show_bug.cgi?id=1233752#c14
> "By adding the 0 byte I can replicate the measured digest."
> 
> So there is something aligning the initrd. kernel's libstub just uses
> and passes load_file2's size down to TcgDxeHashLogExtendEvent, AIUI.
> So it'd be sdb, ovmf or something. BTW how are sizes stored
> in/fetched from vfat?

Well, I was going to explain what EFI does, but it doesn't look
relevant now I've had a crash course reading the systemd-boot code.  It
looks like run() calls image_start() which loads the initrd itself. 
Then in initrd.c:initrd_prepare() it actually installs its own load
file2 protocol which is the protocol the kernel picks up when it loads
the initrd.  So whatever length the kernel is picking up is, in fact,
provided by systemd-boot.

I'd suspect something in this double indirection of load file protocols
is causing your length mismatch.

>  But well, fs/fat/ received no significant changes either.

We don't use that at all in the EFI stub (and neither does systemd-
boot).  We use the protocols EFI provides to read fat volumes, so any
issue would be in the edk2 (or in your case ovmf) FatPkg.

> > This code was last updated in 6.9, so it seems unlikely to have
> > suddenly caused a problem.  Event 43,44 are exit boot services
> > (logged to PCR 5 which matches). line 40 is anomalous: grub is
> > supposed to measure the options to the string PCR which should be 8
> > not 12 ... did you patch grub to change this?
> 
> All this is with sdb, not grub, actually.

It is?  Grub clearly appears in your log in event 37:

>     SubType 04 File Path
>       Path Name: \EFI\systemd\grub.efi
>     Type 7f End of Hardware Device Path

But I figured it out: shim is hard coded to look for grub.efi  In any
case, the entries match what systemd-boot would write (it seems to
insist that the string PCR is 12 instead of 8, which explains the log
entry).

However, this still doesn't explain the mismatch between the log and
the PCRs (even if you've got the wrong initrd hash, it should be
correctly recorded), but I suspect something updates them later in the
boot sequence without adding a log entry.


> > The log can't be corrupt because PCR8 is zero, so nothing got
> > logged to it.
> > 
> > And do you have the same thing for a working system?
> 
> Let me try.

Thanks, that will at least tell me if something booting via systemd is
supposed to be able to match log entries on these PCRs (I'm suspecting
no is the answer).

I'm also trying to set up my own systemd-boot system.

James


