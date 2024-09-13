Return-Path: <linux-efi+bounces-1730-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B844977F3D
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F811F229A8
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE171C2DB8;
	Fri, 13 Sep 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Fr3Z+T0S";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Fr3Z+T0S"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC11C175F;
	Fri, 13 Sep 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229244; cv=none; b=B+bjDGBwcQ973RXfZ/J0JNd1wdpUyYrH446l1L28tAZQnbW/tSrNOP7n7SqdjPh5+7VtJcNyxNhmpKN4do6G8D+TlNAHnej9tfZg1Qo0qovMrkHqQJq8dPSK757ovxk4Wq02cZQlbmnoEZbqme0gga6p5LcTr4BPcZoQvnwUQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229244; c=relaxed/simple;
	bh=OGYZmlVkcDrP5LYRua4zarLnQVw/13XyLwQqI9Lg2hE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liXTfD3aVyyBz79mSDnkrVGAYJKXfyQIIkj7AzXc6Wdo7KFyJmRSLqOTErfPWtcRFfYCF538X1BcI/qLIXUUJy246dposcRSKHhPolUqbx2ZExtecpURzBHhwX1p+bQsAo76xa60JsjuQ+eKBh5rmbwBLe3tnW4poAsHI0mJy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Fr3Z+T0S; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Fr3Z+T0S; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726229241;
	bh=OGYZmlVkcDrP5LYRua4zarLnQVw/13XyLwQqI9Lg2hE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Fr3Z+T0SJ/zHOYu780Y2cGaCP2Pd3yxY4nlj1wnXKps/z74wNheT50NRi/dF5moIH
	 MMf+pPFTQVQ6jj9SnEPIOyztnNfByLtn9sZiK2PAe2Hp9UNAYA3+HgDLT1IrXd2PnH
	 Qjx97sRbq0vR/nvQwGCfalI4Kx2D2S0gMsrYqCoE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6E3361287930;
	Fri, 13 Sep 2024 08:07:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NSlQqNqgMfc8; Fri, 13 Sep 2024 08:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726229241;
	bh=OGYZmlVkcDrP5LYRua4zarLnQVw/13XyLwQqI9Lg2hE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Fr3Z+T0SJ/zHOYu780Y2cGaCP2Pd3yxY4nlj1wnXKps/z74wNheT50NRi/dF5moIH
	 MMf+pPFTQVQ6jj9SnEPIOyztnNfByLtn9sZiK2PAe2Hp9UNAYA3+HgDLT1IrXd2PnH
	 Qjx97sRbq0vR/nvQwGCfalI4Kx2D2S0gMsrYqCoE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1F5AC128791E;
	Fri, 13 Sep 2024 08:07:20 -0400 (EDT)
Message-ID: <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
 linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com,  bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com,  x86@kernel.org,
 linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Date: Fri, 13 Sep 2024 08:07:18 -0400
In-Reply-To: <20240913-careful-maroon-crab-8a0541@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
	 <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
	 <20240913-careful-maroon-crab-8a0541@leitao>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-09-13 at 04:57 -0700, Breno Leitao wrote:
> Hello James,
> 
> On Thu, Sep 12, 2024 at 12:22:01PM -0400, James Bottomley wrote:
> > On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
> > > Hello Ard,
> > > 
> > > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > > > I don't see how this could be an EFI bug, given that it does
> > > > not deal with E820 tables at all.
> > > 
> > > I want to back up a little bit and make sure I am following the
> > > discussion.
> > > 
> > > From what I understand from previous discussion, we have an EFI
> > > bug as the root cause of this issue.
> > > 
> > > This happens because the EFI does NOT mark the EFI TPM event log
> > > memory region as reserved (EFI_RESERVED_TYPE). Not having an
> > > entry for the event table memory in EFI memory mapped, then
> > > libstub will ignore it completely (the TPM event log memory
> > > range) and not populate e820 table with it.
> > 
> > Wait, that's not correct.  The TPM log is in memory that doesn't
> > survive ExitBootServices (by design in case the OS doesn't care
> > about it).  So the EFI stub actually copies it over to a new
> > configuration table that is in reserved memory before it calls
> > ExitBootServices.  This new copy should be in kernel reserved
> > memory regardless of its e820 map status.
> 
> First of all, thanks for clarifying some points here.
> 
> How should the TPM log table be passed to the next kernel when
> kexecing() since it didn't surive ExitBootServices?

I've no idea.  I'm assuming you don't elaborately reconstruct the EFI
boot services, so you can't enter the EFI boot stub before
ExitBootServices is called?  So I'd guess you want to preserve the EFI
table that copied the TPM data in to kernel memory.

James



