Return-Path: <linux-efi+bounces-1928-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE9996489
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71569B22BB2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723818A6A3;
	Wed,  9 Oct 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="NsMO4m1B"
X-Original-To: linux-efi@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB918A6CD;
	Wed,  9 Oct 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465104; cv=none; b=uqlM5dqown/qnANUV44/WSmR9A6qXFbJS15EGuCKR5VbowQGXoyJGXiDe1lPiEEjnJuCkUc9N6fx6cLsV982jt39fWx0slwxwK4MU7H4MkSAZZVnU+bN5IzzX3tZQmsHm/0MOwAqTmJ0xJxWQMVp6Dmfpy92PsusHkDeDXoZfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465104; c=relaxed/simple;
	bh=IVUQL/RYP1pypt4l4/4VPtvvoPQ0+Vk50Ex1eOQ6mhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvO/aUwylxRLl9tVbcJnk2Y/EpGjW9EM7PgUrXXB/xcVylmF1U5s5HTkLFX7Sw6AQvB+ZSV4k8R16pkKbP6cV2tjMiM9q+82eqsBlzuypuStES75rPUjAKWnZ3ib2UUveqdNWembqpvdFwwxS+5GeHPc66vjZaI5l9ZOesIAI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=NsMO4m1B; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=41lRgjq+jYVfy53InEiK/LxoafTTsLIwL+NynDjl2xU=; b=NsMO4m1B4aGFYZt9fC4X1CKAiW
	MIzvs2ZjbL6wZcQDQAOEs1GaikWr5p2AMSFZJxsBGsVRSjp96nvv3M5MX2hIaU5JWNtoh8I75TKyU
	Z9nj0Wls79/pybLaeBOEJzIGNMB762OnaquwigElHpZech5HnZZMoyAjviXzqId1ygTG7QYOYIS0p
	lgI+TDFByXZFiYyPWiVlYNV1kURd7gMYyXUCwMGQr3xFJHzRpMNse+ocTUx8qmwtaMWhbWZMPITXX
	1aKA62WK/9jKLMx8JtQYtdQaPs5lCdUC748kGa+S1dijJB65QTQmjxAbsHvHqLi4aAGjB4yMH31zW
	1zMVnTUw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sySif-0032Cb-0j;
	Wed, 09 Oct 2024 10:10:57 +0100
Date: Wed, 9 Oct 2024 10:10:57 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Breno Leitao <leitao@debian.org>,
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <ZwZIoQobJrltBpTX@earth.li>
References: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao>
 <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>

On Wed, Sep 18, 2024 at 09:36:06AM +0200, Ard Biesheuvel wrote:
> On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Ard Biesheuvel <ardb@kernel.org> writes:
> > > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >> Ard Biesheuvel <ardb@kernel.org> writes:

> > >> This should not be the kexec-on-panic kernel as that runs in memory
> > >> that is reserved solely for it's own use.  So we are talking something
> > >> like using kexec as a bootloader.
> > >
> > > kexec as a bootloader under TPM based measured boot will need to do a
> > > lot more than pass the firmware's event log to the next kernel. I'd
> > > expect a properly engineered kexec to replace this table entirely, and
> > > include the hashes of the assets it has loaded and measured into the
> > > respective PCRs.
> > >
> > > But let's stick to solving the actual issue here, rather than
> > > philosophize on how kexec might work in this context.
> >
> > I am fine with that.  The complaint I had seen was that the table was
> > being corrupted and asking how to solve that.  It seems I haven't read
> > the part of the conversation where it was made clear that no one wants
> > the tpm_log after kexec.
> >
> It was not made clear, that is why I raised the question. I argued
> that the TPM log has limited utility after a kexec, given that we will
> be in one of two situations:
> - the kexec boot chain cares about the TPM and measured boot, and will
> therefore have extended the TPM's PCRs and the TPM log will be out of
> sync;
> - the kexec boot chain does not care, and so there is no point in
> forwarding the TPM log.
> 
> Perhaps there is a third case where kdump wants to inspect the TPM log
> that the crashed kernel accessed? But this is rather speculative.

Generally the kernel/host OS and the firmware are touching different
PCRs in the TPM.

The firmware eventlog covers what the firmware/bootloader measured;
itself, option ROMs, secure boot details, bootloader, initial
kernel/initrd (if we're talking grub as the initial bootloader). These
details are not changed by a kexec, and provide the anchor of the
software trust chain.

A kexec'd kernel will generally not touch the same PCRs. The primary way
I know to carry kexec measurements / logs over to new kernels is using
IMA, which will be configured to use one of the later PCRs (default of
10).

That means that the firmware event log is still completely valid to
subsequent kernels, and is still required to validate the
firmware/bootloader trust chain. You then probably _also_ want to make
use of the IMA log to validate the kexec'd kernel chain, but that's
separate.

> > If someone wants the tpm_log then we need to solve this problem.
> Agreed.

There's a real requirement and use for kexec'd kernels to be able to
continue to access the firmware TPM event log; to the extent that there
are also patches floating around to have this carried over via device
tree on non-UEFI platforms.

J.

-- 
Avoid temporary variables and strange women.
This .sig brought to you by the letter U and the number 37
Product of the Republic of HuggieTag

