Return-Path: <linux-efi+bounces-6008-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CBD31BC6
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 14:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7452431159DA
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83937260A;
	Fri, 16 Jan 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx42etJy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96557250BEC
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569540; cv=none; b=WTN84NxwP02oQLEhpADoMOAZBdGTAqhBuiAUZucBtLV5fx1fptoJQThnqwF6Xo4Mm+vuRJqctzrZM+ymhCLtTs5CRestznvJBjgwtCZRJWwx/GVxvOq1U05v4CV4E50rwNw6bmE6C3544bNDr56zzDwJnkAw5Rf7ynfd5/G0e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569540; c=relaxed/simple;
	bh=paGgdC+WfYWTfp4FQwhsSNV0x9rGHQk4MpKoJN/J6kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul1KMtk9Bmf4zSq8LZC9eKuB/REXlHrhWvO7K7iuZTH7MkIPIAlzaYYH1LhECguTu6w8uWVO8jW8i6CMJdClon4/nERj5Q5Tb9ep/X4xSqji2XuY8661IItkN6MhnNkPAhUI0q/2ld6QnilPlc9pTnV86hXMqgaToBwoVOdKkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx42etJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1BFC19425
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768569540;
	bh=paGgdC+WfYWTfp4FQwhsSNV0x9rGHQk4MpKoJN/J6kM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mx42etJyXvyHu40zb7VhJEa9gBdwKBz3SffMZZHgs6aEMZvLo5cTz87NmUspqu1ui
	 D1Q6Mbpwltz5DWYX1zlMkmGAiZ1/z1DE+wghCaxqJFZDMQH0lGpifb8n+Jg6cEAu9l
	 p7hIaT+50EFL0m6XdcLIQmrkTiOnaFi8KGfVlzR0wnqyesrdVL6QKcVW8GDE6AlC/b
	 k0aV8/X9eC0Y7EnyGGPYqA/hOtlxwZ5kkhrSXTi5ApGh+q+Xac9pqeAzBw4Buu6jQ3
	 70hzYGASgEtiqoiKD6U1NEXpTtTgZzm4qijvIgK1DQrKIs0+ZTLSwg0qazyxHExIXE
	 mVoZfopZUabog==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so1505020a91.2
        for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 05:19:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ5t/Z1TfU8xP4cNv97+r/M0pqau9fGJ63/vcKDHfukyzQZkP5KCdHZTVTeF9s+KBeTL8/ZzkRCt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoBIG8HWdbMGqxH3OTwASs6fWeLUuf4Sj0cRCGanCqvvVXvbJ
	kOD62AqiloNUuhX2M5p0gbdxlkdzsUhAJ+MeEXbBVAEjkpGTyF7EL4Vq20LrojT8cwFNiY6AKZV
	BY9lb9yCDLPm7XpoMjS0y/zotb69cufQ=
X-Received: by 2002:a17:90b:3c49:b0:341:88c1:6a7d with SMTP id
 98e67ed59e1d1-35272f87eb9mr2433924a91.18.1768569539305; Fri, 16 Jan 2026
 05:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115004328.194142-1-coxu@redhat.com> <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com> <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
In-Reply-To: <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Jan 2026 14:18:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
X-Gm-Features: AZwV_QiR8f22XUrZO7Ho9HKYBQjvJoHCgOD5leRDTv3x2USeTKmIDvLwsh7DTh4
Message-ID: <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot integrity-wide
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 14:11, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2026-01-16 at 10:41 +0100, Ard Biesheuvel wrote:
> > On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
> > >
> > > EVM and other LSMs need the ability to query the secure boot status of
> > > the system, without directly calling the IMA arch_ima_get_secureboot
> > > function. Refactor the secure boot status check into a general,
> > > integrity-wide function named arch_integrity_get_secureboot.
> > >
> > > Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which is
> > > automatically configured by the supported architectures. The existing
> > > IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture specific
> > > IMA policy based on the refactored secure boot status code.
> > >
> > > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > ---
> > >  arch/arm64/Kconfig                            |  1 +
> > >  arch/powerpc/Kconfig                          |  1 +
> > >  arch/powerpc/kernel/Makefile                  |  2 +-
> > >  arch/powerpc/kernel/ima_arch.c                |  5 --
> > >  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
> > >  arch/s390/Kconfig                             |  1 +
> > >  arch/s390/kernel/Makefile                     |  1 +
> > >  arch/s390/kernel/ima_arch.c                   |  6 --
> > >  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
> > >  arch/x86/Kconfig                              |  1 +
> > >  arch/x86/include/asm/efi.h                    |  4 +-
> > >  arch/x86/platform/efi/efi.c                   |  2 +-
> > >  include/linux/ima.h                           |  7 +--
> > >  include/linux/integrity.h                     |  8 +++
> > >  security/integrity/Kconfig                    |  6 ++
> > >  security/integrity/Makefile                   |  3 +
> > >  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
> > >  security/integrity/ima/ima_appraise.c         |  2 +-
> > >  security/integrity/ima/ima_efi.c              | 47 +---------------
> > >  security/integrity/ima/ima_main.c             |  4 +-
> > >  security/integrity/platform_certs/load_uefi.c |  2 +-
> > >  21 files changed, 111 insertions(+), 70 deletions(-)
> > >  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
> > >  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
> > >  create mode 100644 security/integrity/efi_secureboot.c
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 93173f0a09c7..4c265b7386bb 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -2427,6 +2427,7 @@ config EFI
> > >         select EFI_STUB
> > >         select EFI_GENERIC_STUB
> > >         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > +       imply INTEGRITY_SECURE_BOOT
> >
> > This allows both to be en/disabled individually, which I don't think
> > is what we want. It also results in more churn across the
> > arch-specific Kconfigs than needed.
> >
> > Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'ed
> > INTEGRITY_SECURE_BOOT in its Kconfig definition?
>
> As much as possible, EVM (and other LSMs) shouldn't be dependent on another LSM,
> in this case IMA, being configured.

Sure, but that is not my point.

This arrangement allows for IMA_SECURE_AND_OR_TRUSTED_BOOT to be
enabled without INTEGRITY_SECURE_BOOT, resulting in the stub
implementation of arch_integrity_get_secureboot() being used, which
always returns false.

