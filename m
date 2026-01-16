Return-Path: <linux-efi+bounces-6010-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804ED37A01
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84C7304C915
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762733CE80;
	Fri, 16 Jan 2026 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knzP861g"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429DE347FD1
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584440; cv=none; b=cDQqOlPTPg3QXsTIrvb1lteQvHk8Yb2EOP9qyuzc/1h2h89zi3xZfwBU2Cc9MBfgwNIGhT0ghAiHjoYwO9c3bEwPOYb9OFefujjJhgB68oXGail9nBPMu0NWJh/KSP0rtzKploGLO66Tl7gtrhX9JJk7/IC50WTO0XSChpGqJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584440; c=relaxed/simple;
	bh=vXVwCg3KjnOR9p1kVLMGAnoWPMTaqhAgSkTPdcaX44w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYjtIpaARISySA5ich2Da9LX2GUb0+peTLJ8Jrs+eSc+7rZMy/SWFpBF/5osfHmLSjgI77/4KSFs9Is2ro9XNr75WaaH0ocFriHnQ7qD30VQVbn8mkFDY0jRIykpmIhDHqTtnGVnZDD6yGS6zzikqmde7iDsZuZtqR13kG/a1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knzP861g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F03C2BCB0
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768584440;
	bh=vXVwCg3KjnOR9p1kVLMGAnoWPMTaqhAgSkTPdcaX44w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=knzP861gITsD7dSH2OTufz7RuEMShCMheE0tEOLOcr7QNKZqatwxSUytX/MdYcWAw
	 F6smFawSdxuwqrQHm1zLeELFkvRfhcjJXkRgyxrh0syHY/d/FMAoLtDWiRi+kQFJMf
	 oaivFEEYD9DVOeRyeWA8xOJCX8pqi4wRcZ0fjzZr8T7vAfy5Wighog6qrJYuI8EAz3
	 dERnUS9aFFY//41dYgI0PA81xDiLkEzsjh5YuFBMZslnjvKP1+w6I2SOj0OQvuMpNi
	 hTXG/xbjaJUSD0ABvYM5VESZl22prwm59C0e8T28EpQcmopOkZjbfod2slIhX35PLx
	 xHSsuRVwP+2Yw==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34f0bc64a27so1029495a91.1
        for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 09:27:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGRolDkW/+IKiZbSayRtmb9gN5+UNCDvOzenMKhVwK5zBBz/nm+rIktmpSsG598r0pNjRNx/1L/Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZjxcKnCaz0TzMpVeI4HGrcDvGAZ+UfYS5vBD82YEydbxdZmz
	+iMmhnvh3KhRsnSEmSrTg8A1RokTjVozHg8btHAXiCUZ6Wh8FfIq9tVQPyCKtedxiNW+/HuzHxw
	x9eUlwpIjxoVPNmMRdCksoKDVHCAuBZY=
X-Received: by 2002:a17:90b:3d8d:b0:343:e2ba:e8be with SMTP id
 98e67ed59e1d1-3527316560bmr2913371a91.10.1768584439303; Fri, 16 Jan 2026
 09:27:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115004328.194142-1-coxu@redhat.com> <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com> <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
In-Reply-To: <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Jan 2026 18:27:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
X-Gm-Features: AZwV_Qi45ik2p_K9-Rag0B961-yA4Y3UeYMV2L3X0YVNxAN3PGD7hZw7XikMDoE
Message-ID: <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
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

On Fri, 16 Jan 2026 at 17:39, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2026-01-16 at 14:18 +0100, Ard Biesheuvel wrote:
> > On Fri, 16 Jan 2026 at 14:11, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Fri, 2026-01-16 at 10:41 +0100, Ard Biesheuvel wrote:
> > > > On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
> > > > >
> > > > > EVM and other LSMs need the ability to query the secure boot status of
> > > > > the system, without directly calling the IMA arch_ima_get_secureboot
> > > > > function. Refactor the secure boot status check into a general,
> > > > > integrity-wide function named arch_integrity_get_secureboot.
> > > > >
> > > > > Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which is
> > > > > automatically configured by the supported architectures. The existing
> > > > > IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture specific
> > > > > IMA policy based on the refactored secure boot status code.
> > > > >
> > > > > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> > > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > > > ---
> > > > >  arch/arm64/Kconfig                            |  1 +
> > > > >  arch/powerpc/Kconfig                          |  1 +
> > > > >  arch/powerpc/kernel/Makefile                  |  2 +-
> > > > >  arch/powerpc/kernel/ima_arch.c                |  5 --
> > > > >  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
> > > > >  arch/s390/Kconfig                             |  1 +
> > > > >  arch/s390/kernel/Makefile                     |  1 +
> > > > >  arch/s390/kernel/ima_arch.c                   |  6 --
> > > > >  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
> > > > >  arch/x86/Kconfig                              |  1 +
> > > > >  arch/x86/include/asm/efi.h                    |  4 +-
> > > > >  arch/x86/platform/efi/efi.c                   |  2 +-
> > > > >  include/linux/ima.h                           |  7 +--
> > > > >  include/linux/integrity.h                     |  8 +++
> > > > >  security/integrity/Kconfig                    |  6 ++
> > > > >  security/integrity/Makefile                   |  3 +
> > > > >  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
> > > > >  security/integrity/ima/ima_appraise.c         |  2 +-
> > > > >  security/integrity/ima/ima_efi.c              | 47 +---------------
> > > > >  security/integrity/ima/ima_main.c             |  4 +-
> > > > >  security/integrity/platform_certs/load_uefi.c |  2 +-
> > > > >  21 files changed, 111 insertions(+), 70 deletions(-)
> > > > >  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
> > > > >  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
> > > > >  create mode 100644 security/integrity/efi_secureboot.c
> > > > >
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index 93173f0a09c7..4c265b7386bb 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -2427,6 +2427,7 @@ config EFI
> > > > >         select EFI_STUB
> > > > >         select EFI_GENERIC_STUB
> > > > >         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > > > +       imply INTEGRITY_SECURE_BOOT
> > > >
> > > > This allows both to be en/disabled individually, which I don't think
> > > > is what we want. It also results in more churn across the
> > > > arch-specific Kconfigs than needed.
> > > >
> > > > Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'ed
> > > > INTEGRITY_SECURE_BOOT in its Kconfig definition?
> > >
> > > As much as possible, EVM (and other LSMs) shouldn't be dependent on another LSM,
> > > in this case IMA, being configured.
> >
> > Sure, but that is not my point.
> >
> > This arrangement allows for IMA_SECURE_AND_OR_TRUSTED_BOOT to be
> > enabled without INTEGRITY_SECURE_BOOT, resulting in the stub
> > implementation of arch_integrity_get_secureboot() being used, which
> > always returns false.
>
> I understand your concern, but instead of "select"ing INTEGRITY_SECURE_BOOT from
> IMA_SECURE_AND_OR_TRUSTED_BOOT, how making IMA_SECURE_AND_OR_TRUSTED_BOOT
> dependent on both IMA_ARCH_POLICY and INTEGRITY_SECURE_BOOT.
>

Given that INTEGRITY_SECURE_BOOT has no dependencies of its own,
afaict, selecting it is the least disruptive option, as otherwise,
existing configs will disable IMA_SECURE_AND_OR_TRUSTED_BOOT as the
kernel is being upgraded. But conceptually, I agree that they are
equivalent.

> Including the "imply INTEGRITY_SECURE_BOOT" here in the arch Kconfig allows EVM
> to query the secure boot state without relying on IMA_SECURE_AND_OR_TRUSTED_BOOT
> being configured.

Yes, I understand that this is the whole point of the exercise. But
'imply' should be used with care, and in this case, implying both from
CONFIG_EFI really makes little sense. INTEGRITY_SECURE_BOOT should be
selected by options that need the functionality, not 'implied' by
options that might provide it.

