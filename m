Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA8175DAD
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCBO5J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 09:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbgCBO5J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 09:57:09 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022EslR2050696
        for <linux-efi@vger.kernel.org>; Mon, 2 Mar 2020 09:57:08 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfhs3s1td-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 09:57:07 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Mar 2020 14:57:06 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 14:57:01 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022Ev0Pt23396720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 14:57:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A225AE051;
        Mon,  2 Mar 2020 14:57:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08EFBAE053;
        Mon,  2 Mar 2020 14:56:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.229.179])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 14:56:58 +0000 (GMT)
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Mar 2020 09:56:58 -0500
In-Reply-To: <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com>
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
         <1583160524.8544.91.camel@linux.ibm.com>
         <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030214-0020-0000-0000-000003AF9FA8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030214-0021-0000-0000-00002207CB39
Message-Id: <1583161018.8544.96.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_05:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003020110
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-03-02 at 15:52 +0100, Ard Biesheuvel wrote:
> On Mon, 2 Mar 2020 at 15:48, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Wed, 2020-02-26 at 14:10 -0500, Nayna Jain wrote:
> > > Every time a new architecture defines the IMA architecture specific
> > > functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> > > include file needs to be updated. To avoid this "noise", this patch
> > > defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> > > the different architectures to select it.
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > ---
> > >  arch/powerpc/Kconfig           | 2 +-
> > >  arch/s390/Kconfig              | 1 +
> > >  arch/x86/Kconfig               | 1 +
> > >  include/linux/ima.h            | 3 +--
> > >  security/integrity/ima/Kconfig | 9 +++++++++
> > >  5 files changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index 497b7d0b2d7e..b8ce1b995633 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -246,6 +246,7 @@ config PPC
> > >       select SYSCTL_EXCEPTION_TRACE
> > >       select THREAD_INFO_IN_TASK
> > >       select VIRT_TO_BUS                      if !PPC64
> > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if PPC_SECURE_BOOT
> > >       #
> > >       # Please keep this list sorted alphabetically.
> > >       #
> > > @@ -978,7 +979,6 @@ config PPC_SECURE_BOOT
> > >       prompt "Enable secure boot support"
> > >       bool
> > >       depends on PPC_POWERNV
> > > -     depends on IMA_ARCH_POLICY
> > >       help
> > >         Systems with firmware secure boot enabled need to define security
> > >         policies to extend secure boot to the OS. This config allows a user
> > > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > > index 8abe77536d9d..90ff3633ade6 100644
> > > --- a/arch/s390/Kconfig
> > > +++ b/arch/s390/Kconfig
> > > @@ -195,6 +195,7 @@ config S390
> > >       select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> > >       select SWIOTLB
> > >       select GENERIC_ALLOCATOR
> > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT
> > >
> > >
> > >  config SCHED_OMIT_FRAME_POINTER
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index beea77046f9b..cafa66313fe2 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -230,6 +230,7 @@ config X86
> > >       select VIRT_TO_BUS
> > >       select X86_FEATURE_NAMES                if PROC_FS
> > >       select PROC_PID_ARCH_STATUS             if PROC_FS
> > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI
> >
> > Not everyone is interested in enabling IMA or requiring IMA runtime
> > policies.  With this patch, enabling IMA_ARCH_POLICY is therefore
> > still left up to the person building the kernel.  As a result, I'm
> > seeing the following warning, which is kind of cool.
> >
> > WARNING: unmet direct dependencies detected for
> > IMA_SECURE_AND_OR_TRUSTED_BOOT
> >   Depends on [n]: INTEGRITY [=y] && IMA [=y] && IMA_ARCH_POLICY [=n]
> >   Selected by [y]:
> >   - X86 [=y] && EFI [=y]
> >
> > Ard, Michael, Martin, just making sure this type of warning is
> > acceptable before upstreaming this patch.  I would appreciate your
> > tags.
> >
> 
> Ehm, no, warnings like these are not really acceptable. It means there
> is an inconsistency in the way the Kconfig dependencies are defined.
> 
> Does this help:
> 
>   select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY
> 
> ?

Yes, that's fine for x86.  Michael, Martin, do you want something
similar or would you prefer actually selecting IMA_ARCH_POLICY?

Mimi

