Return-Path: <linux-efi+bounces-1786-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAE97AB9F
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2024 08:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E16D1C23457
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2024 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F756B8C;
	Tue, 17 Sep 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmDUlcLa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC918B1A;
	Tue, 17 Sep 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555557; cv=none; b=EMsdPEWukT2UP1nqGUMJHcx90h/b/OGVixVHYfut7RMdt+NChKEaUlRfJZQ7+QwBZIzJgOF4pAgNACqlnweYmHxtTDYSdGAkwWl7oS8BjtLjjJQfZi+RVoebWDHB7t1WuB97XhXJQxC8/wL2C6zr3gS8MUKGcLVnXTr5VNk5DLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555557; c=relaxed/simple;
	bh=J43I05Zcs7kcFspFnWbTBMBwpCTbgNcmNj+jUQJ9eCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIbe8wyYi85qTIHoJn/sTbIfsxIL33hMjQsB41EPwNiGL3G12z52vmI/2nqLYYp51NJg0lYYwN9vNPsWSPK5YEyBmm3EwcrsZeu2mwgvXm3XKbzixJRqKnIygfYeWdXGiUsx9KmoMonPtklLx7U9I23P1jyyN7fQUlBU/+RvS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmDUlcLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022E7C4CED0;
	Tue, 17 Sep 2024 06:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726555557;
	bh=J43I05Zcs7kcFspFnWbTBMBwpCTbgNcmNj+jUQJ9eCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fmDUlcLaKMhp66QFx4wHtpClgn1gLI1IdLAIg11AO3X0de90cMXayleJERfZPACw/
	 3XHd799ANAOH5h/Ljoq2P9m7POZst+XKVtSjNXCeHoP+JnryUmZvPLPkXVItPglVNX
	 Y3JfDFYaMMYRSZYpy6nRGhLokLI0h0S1R0n+kVV+1LJkzEjlmLihbV2Gf8riPRePbZ
	 5h+spASbvwPuPRnBNyx0d4mteSaSPcO5XxwraYcRmFR7bTxdIiX7cPtF1UpHn9kp1U
	 hbcuVB7lrcNH4RDXALMAi5T2htdOcDA51DkjVrDOei22cUUr8LiSda+TMoc+tkt4BS
	 Et/woAq9Og2NA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53659c8d688so4136439e87.1;
        Mon, 16 Sep 2024 23:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzB2K4E4kkowmAqEz6R2lJa8//sqEK8/Ju7VusrIPV9/BXXxdtwCBQb8URJp1JrAzchIeZ/dEheM8=@vger.kernel.org, AJvYcCXhHbLzW6DV1XbIT1xU8mRed6N+al+SmZqgVjsa0qvweElkKUqOu71TwUnADAr4ccV3bOaHpXkIU1OinwAO@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJ7mANLT/XJEyptNAbp+34OIq7/lXhhlKO0JCqCcgx7JPCQgF
	ergTh+An2v2ve2S4wnqP4gfoVxi+r+ygcMNO7UP3Ypa0N3FnR9fhtnx/VcDAXb9XRir1GLKlU/f
	2s2DtYvxkLJqsBHSo1XGkSITrjkU=
X-Google-Smtp-Source: AGHT+IHn0yi/KPP4BE3OaV8sNgbLs1sC926jgjdW27Dc37QkocyI/d6HQzyaLm+1w24sdhCtt0W8vaoNjEGG8kMsXNA=
X-Received: by 2002:a05:6512:230d:b0:533:426a:d52f with SMTP id
 2adb3069b0e04-5366b91a435mr8325705e87.11.1726555555275; Mon, 16 Sep 2024
 23:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao> <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87o74n5p05.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Sep 2024 08:45:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
Message-ID: <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Breno Leitao <leitao@debian.org>, 
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, 
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

Thanks for chiming in.

On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>
> > On Fri, 2024-09-13 at 04:57 -0700, Breno Leitao wrote:
> >> Hello James,
> >>
> >> On Thu, Sep 12, 2024 at 12:22:01PM -0400, James Bottomley wrote:
> >> > On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
> >> > > Hello Ard,
> >> > >
> >> > > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> >> > > > I don't see how this could be an EFI bug, given that it does
> >> > > > not deal with E820 tables at all.
> >> > >
> >> > > I want to back up a little bit and make sure I am following the
> >> > > discussion.
> >> > >
> >> > > From what I understand from previous discussion, we have an EFI
> >> > > bug as the root cause of this issue.
> >> > >
> >> > > This happens because the EFI does NOT mark the EFI TPM event log
> >> > > memory region as reserved (EFI_RESERVED_TYPE). Not having an
> >> > > entry for the event table memory in EFI memory mapped, then
> >> > > libstub will ignore it completely (the TPM event log memory
> >> > > range) and not populate e820 table with it.
> >> >
> >> > Wait, that's not correct.  The TPM log is in memory that doesn't
> >> > survive ExitBootServices (by design in case the OS doesn't care
> >> > about it).  So the EFI stub actually copies it over to a new
> >> > configuration table that is in reserved memory before it calls
> >> > ExitBootServices.  This new copy should be in kernel reserved
> >> > memory regardless of its e820 map status.
> >>
> >> First of all, thanks for clarifying some points here.
> >>
> >> How should the TPM log table be passed to the next kernel when
> >> kexecing() since it didn't surive ExitBootServices?
> >
> > I've no idea.  I'm assuming you don't elaborately reconstruct the EFI
> > boot services, so you can't enter the EFI boot stub before
> > ExitBootServices is called?  So I'd guess you want to preserve the EFI
> > table that copied the TPM data in to kernel memory.
>
> This leaves two practical questions if I have been following everything
> correctly.
>
> 1) How to get kexec to avoid picking that memory for the new kernel to
>    run in before it initializes itself. (AKA the getting stomped by
>    relocate kernel problem).
>
> 2) How to point the new kernel to preserved tpm_log.
>
>
> This recommendation is from memory so it may be a bit off but
> the general structure should work.  The idea is as follows.
>
> - Pass the information between kernels.
>
>   It is probably simplest for the kernel to have a command line option
>   that tells the kernel the address and size of the tpm_log.
>
>   We have a couple of mechanisms here.  Assuming you are loading a
>   bzImage with kexec_file_load you should be able to have the in kernel
>   loader to add those arguments to the kernel command line.
>

This shouldn't be necessary, and I think it is actively harmful to
keep inventing special ways for the kexec kernel to learn about these
things that deviate from the methods used by the first kernel. This is
how we ended up with 5 sources of truth for the physical memory map
(EFI memory map, memblock and 3 different versions of the e820 memory
map).

We should try very hard to make kexec idempotent, and reuse the
existing methods where possible. In this case, the EFI configuration
table is already being exposed to the kexec kernel, which describes
the base of the allocation. The size of the allocation can be derived
from the table header.

> - Ensure that when the loader is finding an address to load the new
>   kernel it treats the address of the tpm_log as unavailable.
>

The TPM log is a table created by the EFI stub loader, which is part
of the kernel. So if we need to tweak this for kexec's benefit, I'd
prefer changing it in a way that can accommodate the first kernel too.
However, I think the current method already has that property so I
don't think we need to do anything (modulo fixing the bug)

That said, I am doubtful that the kexec kernel can make meaningful use
of the TPM log to begin with, given that the TPM will be out of sync
at this point. But it is still better to keep it for symmetry, letting
the higher level kexec/kdump logic running in user space reason about
whether the TPM log has any value to it.

-- 
Ard.

