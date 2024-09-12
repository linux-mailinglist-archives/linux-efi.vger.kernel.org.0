Return-Path: <linux-efi+bounces-1717-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D0976E95
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB521C23A9A
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD51448DC;
	Thu, 12 Sep 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JtpFVzTI";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JtpFVzTI"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946E126C0E;
	Thu, 12 Sep 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158126; cv=none; b=qaEKoor4AP/3qqa80Mj4u4z5Y6ocifUMMMB593r8twNcIgerqF1PTWtAxTfI2d+fX28hrawfKryTSRyCvo0FjVTA3P6aMscQ6+vdDlOOvLTZcOxXI1yOU6SG6aejuzDAVDvCJI4u3SBdI+Hu5/gUqiMl23zg5jw65MGIuHi122Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158126; c=relaxed/simple;
	bh=1RRoQ/B4c+/9l2rOSmetknZ/zgMtHUG3tKaFxUMUnaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMradQvEtbMCPYY2a7lZzvMhocEUstcdLPeH7xf/ab0/z+I8aJDiZllLfrr6PC/weQay+2KISne4mlg1HwUXaxHot0YefDK13u+VonTrzMJSJEKD1cI70mKMrj0EvL/glrqG4/fDRvuUyU6Tx2YPVL6hFqSvpPfcPZOnRC3z8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=JtpFVzTI; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=JtpFVzTI; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726158124;
	bh=1RRoQ/B4c+/9l2rOSmetknZ/zgMtHUG3tKaFxUMUnaY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JtpFVzTIHu3vcsWd8FnI4U69MrrUlIzg5yn0PYJIfCV2mTy/nJC87hx4HiuS43Acy
	 DmTv7hmcKZpVcjWZUUx9oD5gZbLVAcRLUX+dLpiEUqThuhVl3TNJYDxzzrzmlCJgAZ
	 6/JNrn5qT7MuDwJCK/KZkKCZeNzteWZszWuC4gks=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6ADBF1287751;
	Thu, 12 Sep 2024 12:22:04 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gI1Frh6cg5OL; Thu, 12 Sep 2024 12:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726158124;
	bh=1RRoQ/B4c+/9l2rOSmetknZ/zgMtHUG3tKaFxUMUnaY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JtpFVzTIHu3vcsWd8FnI4U69MrrUlIzg5yn0PYJIfCV2mTy/nJC87hx4HiuS43Acy
	 DmTv7hmcKZpVcjWZUUx9oD5gZbLVAcRLUX+dLpiEUqThuhVl3TNJYDxzzrzmlCJgAZ
	 6/JNrn5qT7MuDwJCK/KZkKCZeNzteWZszWuC4gks=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1084A128765B;
	Thu, 12 Sep 2024 12:22:02 -0400 (EDT)
Message-ID: <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
 vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 x86@kernel.org,  linux-kernel@vger.kernel.org, rmikey@meta.com,
 gourry@gourry.net
Date: Thu, 12 Sep 2024 12:22:01 -0400
In-Reply-To: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
> Hello Ard,
> 
> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > I don't see how this could be an EFI bug, given that it does not
> > deal with E820 tables at all.
> 
> I want to back up a little bit and make sure I am following the
> discussion.
> 
> From what I understand from previous discussion, we have an EFI bug
> as the root cause of this issue.
> 
> This happens because the EFI does NOT mark the EFI TPM event log
> memory region as reserved (EFI_RESERVED_TYPE). Not having an entry
> for the event table memory in EFI memory mapped, then libstub will
> ignore it completely (the TPM event log memory range) and not
> populate e820 table with it.

Wait, that's not correct.  The TPM log is in memory that doesn't
survive ExitBootServices (by design in case the OS doesn't care about
it).  So the EFI stub actually copies it over to a new configuration
table that is in reserved memory before it calls ExitBootServices. 
This new copy should be in kernel reserved memory regardless of its
e820 map status.

Regards,

James


