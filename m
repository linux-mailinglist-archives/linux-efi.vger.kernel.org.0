Return-Path: <linux-efi+bounces-6014-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6622D39D64
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 05:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45903007639
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 04:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81332F75A;
	Mon, 19 Jan 2026 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgXieibL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="chB39v8t"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803432ED46
	for <linux-efi@vger.kernel.org>; Mon, 19 Jan 2026 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795560; cv=none; b=duWFajV/inHbKn+VdK864DVdeQTAJkR4/GYqquIhXROV149MEqxjlq23TjnQAOjGOt4WepbhQjiBvJBX6s1c2fkvQz8Sf+zDU615dodOE0zuh9095BgrVQrItXTyf/feniQocQsJ/dS38ICeQWMNDqTD2xOX3odlLu5A/JZs9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795560; c=relaxed/simple;
	bh=MlQiZHsczuCG7bk02SmnUlxgCfXMKdwjGin7u8Q6OKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieqcR+WBkYd4dOKZ50XJGsC26w+VipWendcDkRrkmjlCtlTKyQV5PnUXRvcNQPky0i3X+Ym2HrpcK7P2axSfmUs90oejmoF8rZrENiRzCx989Y+BLjnpFa03bsp3c13fXblMJ/B0Yd+OaDMBtIhMMvtPTQSoh/Cetx7tah+pQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgXieibL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=chB39v8t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768795557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQ/pt5veFEgJZqTxKk8ueI9Za/xjDVCyikH3Hycx4Iw=;
	b=DgXieibLcMH4HVZrVIFcKrKvJ0SzuBLDD7IZ2Jfjw2O3J/qsAIZ5DpMBOPUM9Slz+g9rym
	Fmunwn1Zq7DbF0nNd9xJGVSPosBzMAZxWZsemwndLkZvJkGs5Mb3ZBPBRucwT2kTWZHncT
	yAu8eAgVuJLGlUin2mpn/HMQ5Ut5Rzs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-RX4W-tZ6PS2kSDEv_SlZbw-1; Sun, 18 Jan 2026 23:05:56 -0500
X-MC-Unique: RX4W-tZ6PS2kSDEv_SlZbw-1
X-Mimecast-MFC-AGG-ID: RX4W-tZ6PS2kSDEv_SlZbw_1768795555
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso3227034b3a.1
        for <linux-efi@vger.kernel.org>; Sun, 18 Jan 2026 20:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768795555; x=1769400355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQ/pt5veFEgJZqTxKk8ueI9Za/xjDVCyikH3Hycx4Iw=;
        b=chB39v8tobET9/KZ66uFKHE97xMrTZ1ss1TDEDgS64np6sWEoTmBbnIOjSYnVK+8io
         3FRHnRiCAGMfUuzE2yc17BJbbEDZmNqTqPt8a5hcxmiysN83fXVSlmEh1tLvvDEtka94
         owfeu/exuMhFCnuDBF5rpDXBPHh4XiaqTORBFdRuBoRjP1PLDRp+jhM4xaSJbOut+l6O
         u0BgcQQsu4tlCQkKKY+LM/Q3elo5q33UGGVVhoqOX/glbuYwIk+Zt6EA1WJX0pSRwL6p
         JEypxlsmhHeZ5HjzvRhLrl0k8v5vVouj0mXqtZWBCip6CyN6FPtckonvNMEdgMl1xt1a
         3dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768795555; x=1769400355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ/pt5veFEgJZqTxKk8ueI9Za/xjDVCyikH3Hycx4Iw=;
        b=PSo9Ts0BP7jen7g2Kpj8Z4xDzw/AowdGG3SadNmuonnFe5YpZzTFNgqJ4Bz4DplSRM
         CuBEE8JiMtF03Xv+B1177Zsk03MSCfFC/JU9yzeiZJn2gbZMmclRGDpAXoO7qLeVehyZ
         VHG0T/FTZDLCRCGCF3rFGT95S1TdE2vy4r5xp6rUBl9SWVAFXt9F7WRrC2F5+COI04/H
         gVZiHqnbVk+ars+6361ilNN+d0jZZfB5WK7y4Y478jqM5kq7MV+boYLwXhnYeeYZMgz7
         /lr8IOMtaqGKIyU1dlW3VLWoHpIix+CVNN5lhNq/1BMwQBLtep3WUo2sns5WpTl+qrzy
         hOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKR1uKLY9QJ+WuUoDms/Gd7j/Z8WvbZsRGXeucmnQ+qPWJzdMJsHy+wg2yAsSnIw6YPzKrsLBmY3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6x0qm3FX3xA4NEAVUmtaZ0ROfzQs7FHPHewwGmD00lOCLU3jn
	hYkba+7+B5ZLf+cLCWA0jGq8lArjMZ12/hHTc2XxLQpMCem1/0ZmRiHuCHLhi0xxbUQcmnOW395
	SMOfO137ZtezDUQFD+xE1QTCaKQ7H8da8ZMnWLHZcjNCwnecqk+7HFKRdFB+rHQ==
X-Gm-Gg: AY/fxX7HcZELRzjieuR7kVgsz8HNs1HKLWdfezC7JrknLVad7dVbfdSoVnJM7BB32Zq
	BUCLecMYf6BFow2kLcAP0kJoL9gReQCIXxpnf9TAqoeAir/q8JhQBrnhSFdFxLQxxIAbnVq/EMn
	rFPefShtpn14i9RqqA7aeXjHnsAeCD0dv+WS2alHHWK/ANCu2PgZImTlxVx2GkFNQ7v20pvGdE7
	o3ZBJV80V+eM2XuY+7Jq2YAv7dkeEAGRVIifEgi6d2SJ8QTRNUQPWjjXmSCPULnb98C+RXc8LI0
	2ZpT7btLKmfX4LXVlTl8d56D9vPYNBPru1Qt/UBc3/9IehEn6T7egjJH5nMMeJOGUK5LbkUdw9c
	X
X-Received: by 2002:aa7:888b:0:b0:81e:b93a:ab09 with SMTP id d2e1a72fcca58-81f8efbbe1amr10668391b3a.1.1768795554629;
        Sun, 18 Jan 2026 20:05:54 -0800 (PST)
X-Received: by 2002:aa7:888b:0:b0:81e:b93a:ab09 with SMTP id d2e1a72fcca58-81f8efbbe1amr10668347b3a.1.1768795553931;
        Sun, 18 Jan 2026 20:05:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdc65sm7831738b3a.21.2026.01.18.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 20:05:53 -0800 (PST)
Date: Mon, 19 Jan 2026 12:04:04 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aW2i3yacr5TvWU-m@Rk>
References: <20260115004328.194142-1-coxu@redhat.com>
 <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>

On Sun, Jan 18, 2026 at 01:25:52PM -0500, Mimi Zohar wrote:
>On Fri, 2026-01-16 at 18:27 +0100, Ard Biesheuvel wrote:

Hi Ard and Mimi,

Thanks for your discussion on improving the patch!

>> On Fri, 16 Jan 2026 at 17:39, Mimi Zohar <zohar@linux.ibm.com> wrote:
>> >
>> > On Fri, 2026-01-16 at 14:18 +0100, Ard Biesheuvel wrote:
>> > > On Fri, 16 Jan 2026 at 14:11, Mimi Zohar <zohar@linux.ibm.com> wrote:
>> > > >
>> > > > On Fri, 2026-01-16 at 10:41 +0100, Ard Biesheuvel wrote:
>> > > > > On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
>> > > > > >
>> > > > > > EVM and other LSMs need the ability to query the secure boot status of
>> > > > > > the system, without directly calling the IMA arch_ima_get_secureboot
>> > > > > > function. Refactor the secure boot status check into a general,
>> > > > > > integrity-wide function named arch_integrity_get_secureboot.
>> > > > > >
>> > > > > > Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which is
>> > > > > > automatically configured by the supported architectures. The existing
>> > > > > > IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture specific
>> > > > > > IMA policy based on the refactored secure boot status code.
>> > > > > >
>> > > > > > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> > > > > > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
>> > > > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > > > > ---
>> > > > > >  arch/arm64/Kconfig                            |  1 +
>> > > > > >  arch/powerpc/Kconfig                          |  1 +
>> > > > > >  arch/powerpc/kernel/Makefile                  |  2 +-
>> > > > > >  arch/powerpc/kernel/ima_arch.c                |  5 --
>> > > > > >  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
>> > > > > >  arch/s390/Kconfig                             |  1 +
>> > > > > >  arch/s390/kernel/Makefile                     |  1 +
>> > > > > >  arch/s390/kernel/ima_arch.c                   |  6 --
>> > > > > >  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
>> > > > > >  arch/x86/Kconfig                              |  1 +
>> > > > > >  arch/x86/include/asm/efi.h                    |  4 +-
>> > > > > >  arch/x86/platform/efi/efi.c                   |  2 +-
>> > > > > >  include/linux/ima.h                           |  7 +--
>> > > > > >  include/linux/integrity.h                     |  8 +++
>> > > > > >  security/integrity/Kconfig                    |  6 ++
>> > > > > >  security/integrity/Makefile                   |  3 +
>> > > > > >  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
>> > > > > >  security/integrity/ima/ima_appraise.c         |  2 +-
>> > > > > >  security/integrity/ima/ima_efi.c              | 47 +---------------
>> > > > > >  security/integrity/ima/ima_main.c             |  4 +-
>> > > > > >  security/integrity/platform_certs/load_uefi.c |  2 +-
>> > > > > >  21 files changed, 111 insertions(+), 70 deletions(-)
>> > > > > >  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
>> > > > > >  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
>> > > > > >  create mode 100644 security/integrity/efi_secureboot.c
>> > > > > >
>> > > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> > > > > > index 93173f0a09c7..4c265b7386bb 100644
>> > > > > > --- a/arch/arm64/Kconfig
>> > > > > > +++ b/arch/arm64/Kconfig
>> > > > > > @@ -2427,6 +2427,7 @@ config EFI
>> > > > > >         select EFI_STUB
>> > > > > >         select EFI_GENERIC_STUB
>> > > > > >         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
>> > > > > > +       imply INTEGRITY_SECURE_BOOT
>> > > > >
>> > > > > This allows both to be en/disabled individually, which I don't think
>> > > > > is what we want. It also results in more churn across the
>> > > > > arch-specific Kconfigs than needed.
>> > > > >
>> > > > > Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'ed
>> > > > > INTEGRITY_SECURE_BOOT in its Kconfig definition?
>> > > >
>> > > > As much as possible, EVM (and other LSMs) shouldn't be dependent on another LSM,
>> > > > in this case IMA, being configured.
>> > >
>> > > Sure, but that is not my point.
>> > >
>> > > This arrangement allows for IMA_SECURE_AND_OR_TRUSTED_BOOT to be
>> > > enabled without INTEGRITY_SECURE_BOOT, resulting in the stub
>> > > implementation of arch_integrity_get_secureboot() being used, which
>> > > always returns false.

Since both INTEGRITY_SECURE_BOOT and IMA_SECURE_AND_OR_TRUSTED_BOOT
don't define a prompt, they are not user-configurable and will always be
enable/disabled together with arch-specific secure boot feature. So
despite the "imply" key word, the case where
IMA_SECURE_AND_OR_TRUSTED_BOOT is enabled whereas INTEGRITY_SECURE_BOOT
is disabled won't happen.

But I agree an arch may not care much about INTEGRITY_SECURE_BOOT so it
may be a churn. So limiting it to the scope of the integrity subsystem
can be a better idea.

>> >
>> > I understand your concern, but instead of "select"ing INTEGRITY_SECURE_BOOT from
>> > IMA_SECURE_AND_OR_TRUSTED_BOOT, how making IMA_SECURE_AND_OR_TRUSTED_BOOT
>> > dependent on both IMA_ARCH_POLICY and INTEGRITY_SECURE_BOOT.
>> >
>>
>> Given that INTEGRITY_SECURE_BOOT has no dependencies of its own,
>> afaict, selecting it is the least disruptive option, as otherwise,
>> existing configs will disable IMA_SECURE_AND_OR_TRUSTED_BOOT as the
>> kernel is being upgraded. But conceptually, I agree that they are
>> equivalent.

As already pointed out on by Mimi, INTEGRITY_SECURE_BOOT depend on
arch-specific secure boot feature. So we can't say INTEGRITY_SECURE_BOOT
has no dependencies. 

>>
>> > Including the "imply INTEGRITY_SECURE_BOOT" here in the arch Kconfig allows EVM
>> > to query the secure boot state without relying on IMA_SECURE_AND_OR_TRUSTED_BOOT
>> > being configured.
>>
>> Yes, I understand that this is the whole point of the exercise. But
>> 'imply' should be used with care, and in this case, implying both from
>> CONFIG_EFI really makes little sense. INTEGRITY_SECURE_BOOT should be
>> selected by options that need the functionality, not 'implied' by
>> options that might provide it.

But again I agree INTEGRITY_SECURE_BOOT should "not 'implied' by options
that might provide it".

>
>As not all arch's implement arch_integrity_get_secureboot, the definition in
>include/linux/integrity.h would need to be updated.  Something like:
>
>-#ifdef CONFIG_INTEGRITY_SECURE_BOOT
>+#if (defined(CONFIG_INTEGRITY_SECURE_BOOT) && \
>+       (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
>+        || defined(CONFIG_PPC_SECURE_BOOT))
>
>Then IMA_SECURE_AND_OR_TRUSTED_BOOT and EVM could select INTEGRITY_SECURE_BOOT,
>as suggested.

Since INTEGRITY_SECURE_BOOT has a dependency, select doesn't seem to be
a good choice. If EVM does select INTEGRITY_SECURE_BOOT,
INTEGRITY_SECURE_BOOT will be enabled even if arch-specific secure boot
feature is disabled and this can lead to a building failure. How about
always enabling INTEGRITY_SECURE_BOOT when secure boot feature is
enabled and also making IMA_SECURE_AND_OR_TRUSTED_BOOT depend on
INTEGRITY_SECURE_BOOT?

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 916d4f2bfc44..cd44b46d0325 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -97,6 +97,13 @@ config INTEGRITY_CA_MACHINE_KEYRING_MAX
           will not be loaded. The remaining MOK keys are loaded into the
           .platform keyring.
  
+config INTEGRITY_SECURE_BOOT
+       def_bool y
+       depends on EFI || PPC_SECURE_BOOT || S390
+       help
+         Provide secure boot related helper functions like querying the
+         secure boot status.
+

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 976e75f9b9ba..5dce572192d6 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
  config IMA_SECURE_AND_OR_TRUSTED_BOOT
         bool
         depends on IMA_ARCH_POLICY
+       depends on INTEGRITY_SECURE_BOOT


Another idea is make a tree-wide arch_get_secureboot i.e. to move
current arch_ima_get_secureboot code to arch-specific secure boot
implementation. By this way, there will no need for a new Kconfig option
INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
concern.

-- 
Best regards,
Coiby


