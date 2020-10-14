Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED228E018
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgJNL5H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 07:57:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgJNL5H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 07:57:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EBXE5p176539;
        Wed, 14 Oct 2020 07:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BTlOnbpUAUcDb4UPCTOiAatpqX4R9DTQ5GOjIxbyyZ8=;
 b=CVssf4o4/g3EPsUEIGqqW1+77zTEyQi33ds5TyILl2SEJCJ8C6VIT9QPB1cdbkwzkEFI
 RdsQXFYt1Momhx2ki6b6qTnma8cMsY9Rr7XBY4uowJLsGr5XjxgOehnAMUZm50SiWgK1
 valx2TmKOfJMNVJ1DXuzF96/KO73Sya8BSWFocBLGPfWMgHc4+I+C2s0Gqu0qJOtC+nT
 Z5LJ/+i41Oc4lU2PnNaaJGvHyiKipCcMV0YO4HfZyuzDwVE1OPMZSHNwmH0O5xmeL7Pf
 C6NfAeWSydbrdT6LDxQ4PD2a8oi5dWSIXUsf6B1YuuYKYkI2DZCTV9gU2BMIxa2QOq/A zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3460349mkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 07:56:28 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09EBXLrs177077;
        Wed, 14 Oct 2020 07:56:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3460349mgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 07:56:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09EBpmNZ003728;
        Wed, 14 Oct 2020 11:56:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3434k7v3j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 11:56:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09EBuL2T26345738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 11:56:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8082511C054;
        Wed, 14 Oct 2020 11:56:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E3611C04A;
        Wed, 14 Oct 2020 11:56:18 +0000 (GMT)
Received: from sig-9-65-216-73.ibm.com (unknown [9.65.216.73])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Oct 2020 11:56:17 +0000 (GMT)
Message-ID: <e436ab32ba30549591753cb3ec43749a6776f43e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] efi: add secure boot get helper
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Chester Lin <clin@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Date:   Wed, 14 Oct 2020 07:56:17 -0400
In-Reply-To: <CAMj1kXGacnj=uh9WFh1+YBVXxzZbxeN==Y_f-rhJZ=3385B68g@mail.gmail.com>
References: <20201014104032.9776-1-clin@suse.com>
         <20201014104032.9776-2-clin@suse.com>
         <CAMj1kXGacnj=uh9WFh1+YBVXxzZbxeN==Y_f-rhJZ=3385B68g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_07:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 suspectscore=3 mlxlogscore=999 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140085
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-10-14 at 13:00 +0200, Ard Biesheuvel wrote:
> Hello Chester,
> 
> Thanks for looking into this.
> 
> Some comments below.
> 
> On Wed, 14 Oct 2020 at 12:41, Chester Lin <clin@suse.com> wrote:
> >
> > Separate the get_sb_mode() from arch/x86 and treat it as a common function
> > [rename to efi_get_secureboot_mode] so all EFI-based architectures can
> > reuse the same logic.
> >
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/x86/kernel/ima_arch.c | 47 ++------------------------------------
> >  drivers/firmware/efi/efi.c | 43 ++++++++++++++++++++++++++++++++++
> >  include/linux/efi.h        |  5 ++++
> >  3 files changed, 50 insertions(+), 45 deletions(-)
> >
> > diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> > index 7dfb1e808928..ed4623ecda6e 100644
> > --- a/arch/x86/kernel/ima_arch.c
> > +++ b/arch/x86/kernel/ima_arch.c
> > @@ -8,49 +8,6 @@
> >
> >  extern struct boot_params boot_params;
> >
> > -static enum efi_secureboot_mode get_sb_mode(void)
> > -{
> > -       efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> > -       efi_status_t status;
> > -       unsigned long size;
> > -       u8 secboot, setupmode;
> > -
> > -       size = sizeof(secboot);
> > -
> > -       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> > -               pr_info("ima: secureboot mode unknown, no efi\n");
> > -               return efi_secureboot_mode_unknown;
> > -       }
> > -
> > -       /* Get variable contents into buffer */
> > -       status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> > -                                 NULL, &size, &secboot);
> > -       if (status == EFI_NOT_FOUND) {
> > -               pr_info("ima: secureboot mode disabled\n");
> > -               return efi_secureboot_mode_disabled;
> > -       }
> > -
> > -       if (status != EFI_SUCCESS) {
> > -               pr_info("ima: secureboot mode unknown\n");
> > -               return efi_secureboot_mode_unknown;
> > -       }
> > -
> > -       size = sizeof(setupmode);
> > -       status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> > -                                 NULL, &size, &setupmode);
> > -
> > -       if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> > -               setupmode = 0;
> > -
> > -       if (secboot == 0 || setupmode == 1) {
> > -               pr_info("ima: secureboot mode disabled\n");
> > -               return efi_secureboot_mode_disabled;
> > -       }
> > -
> > -       pr_info("ima: secureboot mode enabled\n");
> > -       return efi_secureboot_mode_enabled;
> > -}
> > -
> >  bool arch_ima_get_secureboot(void)
> >  {
> >         static enum efi_secureboot_mode sb_mode;
> > @@ -60,7 +17,7 @@ bool arch_ima_get_secureboot(void)
> >                 sb_mode = boot_params.secure_boot;
> >
> >                 if (sb_mode == efi_secureboot_mode_unset)
> > -                       sb_mode = get_sb_mode();
> > +                       sb_mode = efi_get_secureboot_mode();
> >                 initialized = true;
> >         }
> >
> > @@ -70,7 +27,7 @@ bool arch_ima_get_secureboot(void)
> >                 return false;
> >  }
> >
> > -/* secureboot arch rules */
> > +/* secure and trusted boot arch rules */
> >  static const char * const sb_arch_rules[] = {
> >  #if !IS_ENABLED(CONFIG_KEXEC_SIG)
> >         "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 5e5480a0a32d..68ffa6a069c0 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -1022,3 +1022,46 @@ static int __init register_update_efi_random_seed(void)
> >  }
> >  late_initcall(register_update_efi_random_seed);
> >  #endif
> > +
> > +enum efi_secureboot_mode efi_get_secureboot_mode(void)
> > +{
> > +       efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> > +       efi_status_t status;
> > +       unsigned long size;
> > +       u8 secboot, setupmode;
> > +
> > +       size = sizeof(secboot);
> > +
> > +       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> > +               pr_info("ima: secureboot mode unknown, no efi\n");
> 
> These prints don't belong here anymore.
> 
> Also, it would be useful if we could reuse this logic in the EFI stub
> as well, which is built as a separate executable, and does not provide
> efi.get_variable().
> 
> So, you could you please break this up into
> 
> static inline
> enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
> {
> }
> 
> placed into include/linux/efi.h, which encapsulates the core logic,
> but using get_var(), and without the prints.
> 
> Then, we could put something like
> 
> bool efi_ima_get_secureboot(void)
> {
> }
> 
> in drivers/firmware/efi/efi.c (guarded by #ifdef CONFIG_IMA_xxx),
> which performs the
> efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) check, calls
> efi_get_secureboot_mode(efi.get_variable), and implements the logic.
> 
> And actually, if the logic is identical between x86 and arm64, I
> wonder if it wouldn't be better to put the whole thing into
> 
> drivers/firmware/efi/efi-ima.c
> 
> or
> 
> security/integrity/ima/ima-efi.c
> 
> with the only difference being the boot_params->secure_boot access for
> x86, which we can factor out to a static inline helper.
> 
> Mimi, any thoughts here?

Sounds good.  Keeping as much IMA code in the IMA directory makes
sense.   The IMA Makefile would then include ima-efi.c based on an EFI
Kconfig option.

thanks,

Mimi
> 
> 
> 
> > +               return efi_secureboot_mode_unknown;
> > +       }
> > +
> > +       /* Get variable contents into buffer */
> > +       status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> > +                                 NULL, &size, &secboot);
> > +       if (status == EFI_NOT_FOUND) {
> > +               pr_info("ima: secureboot mode disabled\n");
> > +               return efi_secureboot_mode_disabled;
> > +       }
> > +
> > +       if (status != EFI_SUCCESS) {
> > +               pr_info("ima: secureboot mode unknown\n");
> > +               return efi_secureboot_mode_unknown;
> > +       }
> > +
> > +       size = sizeof(setupmode);
> > +       status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> > +                                 NULL, &size, &setupmode);
> > +
> > +       if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> > +               setupmode = 0;
> > +
> > +       if (secboot == 0 || setupmode == 1) {
> > +               pr_info("ima: secureboot mode disabled\n");
> > +               return efi_secureboot_mode_disabled;
> > +       }
> > +
> > +       pr_info("ima: secureboot mode enabled\n");
> > +       return efi_secureboot_mode_enabled;
> > +}
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index d7c0e73af2b9..a73e5ae04672 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1076,8 +1076,13 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
> >
> >  #ifdef CONFIG_EFI
> >  extern bool efi_runtime_disabled(void);
> > +extern enum efi_secureboot_mode efi_get_secureboot_mode(void);
> >  #else
> >  static inline bool efi_runtime_disabled(void) { return true; }
> > +static inline enum efi_secureboot_mode efi_get_secureboot_mode(void)
> > +{
> > +       return efi_secureboot_mode_disabled;
> > +}
> >  #endif
> >
> >  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
> > --
> > 2.26.1
> >


