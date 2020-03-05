Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31BD179E3F
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 04:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgCED0I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 22:26:08 -0500
Received: from ozlabs.org ([203.11.71.1]:46743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgCED0I (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 22:26:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Xx3c0nB0z9sNg;
        Thu,  5 Mar 2020 14:26:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583378764;
        bh=n7Wk2CTjL+YpeiTvNbjnCG4kwoUD1e2RPLWE3xN1au0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dLaL/OjkNkN9KF1Cjfs20SM3rMJ0QIylnwxzc9IKkkCzwfVo0juguna8o5MOuMges
         EM094nNGS74RYpgeFT+PSub9CqUFJz1tod6CeCU/HDA2wxiQ9nlmU686Pdz2mEriWY
         wWdZfqu7ASGu5/RK9Vzmzm7heTMH8XjxBPHDdxCzfkmBKJSU6p1eanvxEcfOVnsccP
         9M5FZKpbOYTwEAPh53SbO2DshNmlndAMA1Sm6iouDy/Yr0h9EwVevqHma6bCPFcEBK
         EOglgdj+mn00z1YkwFxVsVH4UyRCe0UO5US7zxfD8L/rFvDalTZFbonzT9cCzjj0iI
         iKdmHk2NkHLIg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific policies
In-Reply-To: <1583336133.3284.1.camel@HansenPartnership.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com> <1583307813.3907.4.camel@HansenPartnership.com> <1583325309.6264.23.camel@linux.ibm.com> <1583336133.3284.1.camel@HansenPartnership.com>
Date:   Thu, 05 Mar 2020 14:26:00 +1100
Message-ID: <87a74vqy7r.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> On Wed, 2020-03-04 at 07:35 -0500, Mimi Zohar wrote:
>> On Tue, 2020-03-03 at 23:43 -0800, James Bottomley wrote:
>> > On Tue, 2020-03-03 at 21:33 -0500, Nayna Jain wrote:
>> > > diff --git a/security/integrity/ima/Kconfig
>> > > b/security/integrity/ima/Kconfig
>> > > index 3f3ee4e2eb0d..d17972aa413a 100644
>> > > --- a/security/integrity/ima/Kconfig
>> > > +++ b/security/integrity/ima/Kconfig
>> > > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>> > >  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
>> > >  	depends on SYSTEM_TRUSTED_KEYRING
>> > >  	default y
>> > > +
>> > > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
>> > > +	bool
>> > > +	depends on IMA
>> > > +	depends on IMA_ARCH_POLICY
>> > > +	default n
>> > 
>> > You can't do this: a symbol designed to be selected can't depend on
>> > other symbols because Kconfig doesn't see the dependencies during
>> > select.  We even have a doc for this now:
>> > 
>> > Documentation/kbuild/Kconfig.select-break
>> 
>> The document is discussing a circular dependency, where C selects B.
>>  IMA_SECURE_AND_OR_TRUSTED_BOOT is not selecting anything, but is
>> being selected.  All of the Kconfig's are now dependent on
>> IMA_ARCH_POLICY being enabled before selecting
>> IMA_SECURE_AND_OR_TRUSTED_BOOT.
>> 
>> As Ard pointed out, both IMA and IMA_ARCH_POLICY are not needed, as
>> IMA_ARCH_POLICY is already dependent on IMA.
>
> Then removing them is fine, if they're not necessary ... you just can't
>  select a symbol with dependencies because the two Kconfig mechanisms
> don't mix.

You can safely select something if the selector has the same or stricter
set of dependencies than the selectee. And in this case that's true.

config IMA_SECURE_AND_OR_TRUSTED_BOOT
       bool
       depends on IMA
       depends on IMA_ARCH_POLICY

powerpc:
        depends on IMA_ARCH_POLICY
        select IMA_SECURE_AND_OR_TRUSTED_BOOT

s390: select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY

x86: select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY


But that's not to say it's the best solution, because you have to ensure
the arch code has the right set of dependencies.

I think this is actually a perfect case for using imply. We want the
arch code to indicate it wants IMA_SECURE_..., but only if all the IMA
related dependencies are met.

I think the patch below should work.

For example:

$ grep PPC_SECURE_BOOT .config
CONFIG_PPC_SECURE_BOOT=y
$ ./scripts/config -d CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
$ grep IMA_SECURE .config
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
$ make oldconfig
scripts/kconfig/conf  --oldconfig Kconfig
#
# configuration written to .config
#
$ grep IMA_SECURE .config
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y

$ ./scripts/config -d CONFIG_IMA_ARCH_POLICY
$ grep -e IMA_ARCH_POLICY -e IMA_SECURE .config
# CONFIG_IMA_ARCH_POLICY is not set
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
$ make olddefconfig
scripts/kconfig/conf  --olddefconfig Kconfig
#
# configuration written to .config
#
$ grep -e IMA_ARCH_POLICY -e IMA_SECURE .config
# CONFIG_IMA_ARCH_POLICY is not set
$ 


cheers



diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..5b9f1cba2a44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
        bool
        depends on PPC_POWERNV
        depends on IMA_ARCH_POLICY
+       imply IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
          Systems with firmware secure boot enabled need to define security
          policies to extend secure boot to the OS. This config allows a user
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8abe77536d9d..59c216af6264 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -195,6 +195,7 @@ config S390
        select ARCH_HAS_FORCE_DMA_UNENCRYPTED
        select SWIOTLB
        select GENERIC_ALLOCATOR
+       imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 
 
 config SCHED_OMIT_FRAME_POINTER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..92204a486d97 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,7 @@ config X86
        select VIRT_TO_BUS
        select X86_FEATURE_NAMES                if PROC_FS
        select PROC_PID_ARCH_STATUS             if PROC_FS
+       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
        def_bool y
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 1659217e9b60..aefe758f4466 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
-       || defined(CONFIG_PPC_SECURE_BOOT)
+#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 3f3ee4e2eb0d..5ba4ae040fd8 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -327,3 +327,10 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
        depends on IMA_MEASURE_ASYMMETRIC_KEYS
        depends on SYSTEM_TRUSTED_KEYRING
        default y
+
+config IMA_SECURE_AND_OR_TRUSTED_BOOT
+       bool
+       depends on IMA_ARCH_POLICY
+       help
+          This option is selected by architectures to enable secure and/or
+          trusted boot based on IMA runtime policies.
