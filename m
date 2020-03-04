Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF11790AD
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCDMzu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 07:55:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbgCDMzu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 07:55:50 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024CqDUL099896
        for <linux-efi@vger.kernel.org>; Wed, 4 Mar 2020 07:55:49 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmg2g85q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 07:55:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 4 Mar 2020 12:55:46 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 12:55:42 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024CsgYl33948012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 12:54:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F6C64C050;
        Wed,  4 Mar 2020 12:55:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3482B4C046;
        Wed,  4 Mar 2020 12:55:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.200.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 12:55:39 +0000 (GMT)
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific
 policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Date:   Wed, 04 Mar 2020 07:55:38 -0500
In-Reply-To: <CAKv+Gu831SRo+Di6WgKTex40TcOVqNQAdeNLtfQpPdgnvrxucw@mail.gmail.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
         <CAKv+Gu831SRo+Di6WgKTex40TcOVqNQAdeNLtfQpPdgnvrxucw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030412-0012-0000-0000-0000038D17CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030412-0013-0000-0000-000021C9D293
Message-Id: <1583326538.6264.32.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_03:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040098
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Cc'ing Thomas Gleixner and x86 mailing list]

On Wed, 2020-03-04 at 08:14 +0100, Ard Biesheuvel wrote:
> On Wed, 4 Mar 2020 at 03:34, Nayna Jain <nayna@linux.ibm.com> wrote:
> >
> > Every time a new architecture defines the IMA architecture specific
> > functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> > include file needs to be updated. To avoid this "noise", this patch
> > defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> > the different architectures to select it.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks, Ard.
> 
> for the x86 bits, but I'm not an x86 maintainer. Also, you may need to
> split this if you want to permit arch maintainers to pick up their
> parts individually.

Michael, Philipp, Thomas, do you prefer separate patches?

> 
> > ---
> > v2:
> > * Fixed the issue identified by Mimi. Thanks Mimi, Ard, Heiko and Michael for
> > discussing the fix.
> >
> >  arch/powerpc/Kconfig           | 1 +
> >  arch/s390/Kconfig              | 1 +
> >  arch/x86/Kconfig               | 1 +
> >  include/linux/ima.h            | 3 +--
> >  security/integrity/ima/Kconfig | 9 +++++++++
> >  5 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 497b7d0b2d7e..a5cfde432983 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
> >         bool
> >         depends on PPC_POWERNV
> >         depends on IMA_ARCH_POLICY
> > +       select IMA_SECURE_AND_OR_TRUSTED_BOOT
> >         help
> >           Systems with firmware secure boot enabled need to define security
> >           policies to extend secure boot to the OS. This config allows a user
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 8abe77536d9d..4a502fbcb800 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -195,6 +195,7 @@ config S390
> >         select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> >         select SWIOTLB
> >         select GENERIC_ALLOCATOR
> > +       select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY
> >
> >
> >  config SCHED_OMIT_FRAME_POINTER
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index beea77046f9b..7f5bfaf0cbd2 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -230,6 +230,7 @@ config X86
> >         select VIRT_TO_BUS
> >         select X86_FEATURE_NAMES                if PROC_FS
> >         select PROC_PID_ARCH_STATUS             if PROC_FS
> > +       select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY
> >
> >  config INSTRUCTION_DECODER
> >         def_bool y
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 1659217e9b60..aefe758f4466 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
> >  extern void ima_add_kexec_buffer(struct kimage *image);
> >  #endif
> >
> > -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
> > -       || defined(CONFIG_PPC_SECURE_BOOT)
> > +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
> >  extern bool arch_ima_get_secureboot(void);
> >  extern const char * const *arch_get_ima_policy(void);
> >  #else
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> > index 3f3ee4e2eb0d..d17972aa413a 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> >         depends on IMA_MEASURE_ASYMMETRIC_KEYS
> >         depends on SYSTEM_TRUSTED_KEYRING
> >         default y
> > +
> > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > +       bool
> > +       depends on IMA
> > +       depends on IMA_ARCH_POLICY
> 
> Doesn't the latter already depend on the former?

Yes, there's no need for the first.

Mimi
> 
> > +       default n
> > +       help
> > +          This option is selected by architectures to enable secure and/or
> > +          trusted boot based on IMA runtime policies.
> > --
> > 2.13.6
> >

