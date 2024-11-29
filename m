Return-Path: <linux-efi+bounces-2239-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214219DECD0
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 22:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41431634F6
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2D19F40B;
	Fri, 29 Nov 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lPx8jFm/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lPx8jFm/"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64E39ACC;
	Fri, 29 Nov 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732914520; cv=none; b=Gtinh69FTfm+gxorb0v4Jhjre3c7MJfRbFsJoVmqhv0sfsU0kzORfea7gMOM5/xgFnqWv2tNFXrd7KkU1GzrFT1TL6gogkSWxIdUyQYOPSGKzI/1VeXYIta117WMpyToKqNcarMTgweB9g7PjTpQRfLHNxGMo0qcUt4ge9BF3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732914520; c=relaxed/simple;
	bh=5vBwaZoG6u9tgHSmIQFWqzq/4I86zBjVABBlEXZzmBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prYbCzPBU7wPCyVz6ETAeb7eXgiiVYxcZ+/7Fo5uuyyentzApmjscjuft2NITLVDvqwPe0K5f3f0qf5fgt9TkbQkF2TqXTLIkde1sc5tksBb2E/vpsawzJzEY2vd4xUOW1ib9XQ0d1AINr/CoK/ucwMIiuFtCP2nCmGCqJyLY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lPx8jFm/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lPx8jFm/; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732914517;
	bh=5vBwaZoG6u9tgHSmIQFWqzq/4I86zBjVABBlEXZzmBs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lPx8jFm/Ep5bbGw8bJBsKWWPaWshosyzX+ltMJP1ixaI8mC5DsKAO2/OMHhOiQvBO
	 x4DHNhdln1+p3WoseVaFAWBlMc1nNigcYNXil2eCYQ3i7WB9/iL2tvBYU46mgfIWDs
	 qJeBnqqybG6MzVbbhPpVEVILGm7eSTMTq6rGAT+A=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B0C6C12879A4;
	Fri, 29 Nov 2024 16:08:37 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PPbvX3RUIpKJ; Fri, 29 Nov 2024 16:08:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732914517;
	bh=5vBwaZoG6u9tgHSmIQFWqzq/4I86zBjVABBlEXZzmBs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lPx8jFm/Ep5bbGw8bJBsKWWPaWshosyzX+ltMJP1ixaI8mC5DsKAO2/OMHhOiQvBO
	 x4DHNhdln1+p3WoseVaFAWBlMc1nNigcYNXil2eCYQ3i7WB9/iL2tvBYU46mgfIWDs
	 qJeBnqqybG6MzVbbhPpVEVILGm7eSTMTq6rGAT+A=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C0A6F1287994;
	Fri, 29 Nov 2024 16:08:36 -0500 (EST)
Message-ID: <5c474ef503f45745d511c5188addd82a6bf25338.camel@HansenPartnership.com>
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
Date: Fri, 29 Nov 2024 16:08:35 -0500
In-Reply-To: <02060553aafac7e145e96510a66a6845d389d6ff.camel@HansenPartnership.com>
References: 
	<CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
	 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
	 <ca741d8eade72aa68c389a88d2520f4fe541a1e7.camel@HansenPartnership.com>
	 <2a238b61-fa03-4ae4-9dc4-f73834aa3228@kernel.org>
	 <70bc83bd7cfb236da030e584e93bfc62c1d9eb6a.camel@HansenPartnership.com>
	 <7773891b-b699-4f1d-b9ba-220c649aee9d@kernel.org>
	 <02060553aafac7e145e96510a66a6845d389d6ff.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-11-29 at 11:03 -0500, James Bottomley wrote:
> On Fri, 2024-11-29 at 07:36 +0100, Jiri Slaby wrote:
> > On 28. 11. 24, 17:13, James Bottomley wrote:
> [...]
> > > Yes, it tells me the entries in the log for PCR0-7,14 match the
> > > log entries (for both sha1 and sha256).  However there are
> > > entries for PCR9,12 which don't match.  The log shows shim
> > > starting at entry 32, grub starting at entry 37 and the kernel
> > > loading at entry 39 the kernel command line logged at 40 to PCR
> > > 12, which is mismatching.
> > > 
> > > The next two entries (41,42) are for the mismatching PCR9 and are
> > > of the initrd and the options and come from the libstub code in
> > > the kernel early boot (efi-stub-helper.c).
> > 
> > Note that ovmf logged:
> > Called TcgDxeHashLogExtendEvent 0 58683000 1B1E78C 5FE63C00
> > 5E3492AA Data 28 B5 2F FD ... E1 29 FE 0
> > 
> > But initrd on disk is 1B1E78B long, not 1B1E78C. So the excessive 0
> > at the end above brews the mismatch. See:
> >    https://bugzilla.suse.com/show_bug.cgi?id=1233752#c14
> > "By adding the 0 byte I can replicate the measured digest."
> > 
> > So there is something aligning the initrd. kernel's libstub just
> > uses and passes load_file2's size down to TcgDxeHashLogExtendEvent,
> > AIUI. So it'd be sdb, ovmf or something. BTW how are sizes stored
> > in/fetched from vfat?
> 
> Well, I was going to explain what EFI does, but it doesn't look
> relevant now I've had a crash course reading the systemd-boot code. 
> It looks like run() calls image_start() which loads the initrd
> itself. Then in initrd.c:initrd_prepare() it actually installs its
> own load file2 protocol which is the protocol the kernel picks up
> when it loads the initrd.  So whatever length the kernel is picking
> up is, in fact, provided by systemd-boot.
> 
> I'd suspect something in this double indirection of load file
> protocols is causing your length mismatch.

OK, confirmed it's the Load File2 protocol installed by systemd-boot
that's doing this.  It seems to be by design: it zero pads and aligns
on 4 bytes:

https://github.com/systemd/systemd/blob/3f3b4959e2cb9bca1e1ed527a0692c9a8b6a18ea/src/boot/boot.c#L2498-L2504

I managed to construct a debian secure boot vm image with the latest
systemd just to check and sure enough the linux boot stub is using the
systemd-boot Load file2 protocol module and so does have this zero
padding issue.

Although it's a problem if you do a flat file hash, and obviously
violates the linux stub assumption that that's how we compute the hash,
I'd have to be reasonably certain that the systemd tools take the zero
padding into account when constructing the pcr lock values.

Regards,

James


