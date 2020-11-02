Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD52A2A77
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 13:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgKBMOO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 07:14:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728423AbgKBMON (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Nov 2020 07:14:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2C1e1Q116735;
        Mon, 2 Nov 2020 07:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rJZq2qAlGGU6LQSZi4sVFIMHSz4uQffedOq+S4xFT1E=;
 b=E9pCxcc/CkyFEQtVpsvqNwfpWnJ+4PHNGaqh2UZBirY9IKjecVs9k/1p2U9bWdRwN3NE
 pT9yaywy/DoihiB7PMdqgJCAGdVoAHmrEmGjEBSycbBHN0arGN2YnFhChreZaVupEBYo
 nNqgxSY9DOKKQkpHMnUw+0dY2ROriQrpUArlbUXWEfP+fiedOT2kxfhlnfeXwPx3SLQY
 j/PHNwgOxeDMA9n9GMrcR4kdclAJbYskigHktA9NnaT17UBknBeQ0fFFY8Fv3go0z0nO
 T8c3zkImKClNW6LNdFxufNzp8zjMQq7W/n2uvNlwOB6xm3rJJIRQcLngP9VDV7ZQ1v9P 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34hn6g4mp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 07:13:37 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A2C1rH2117971;
        Mon, 2 Nov 2020 07:13:37 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34hn6g4mn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 07:13:36 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A2CCLN8018604;
        Mon, 2 Nov 2020 12:13:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 34h01ua24c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 12:13:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A2CDWJq656116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Nov 2020 12:13:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30ECD42052;
        Mon,  2 Nov 2020 12:13:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 300FA42041;
        Mon,  2 Nov 2020 12:13:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.45.94])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Nov 2020 12:13:29 +0000 (GMT)
Message-ID: <f6045fd9844f3b14c20bf86e60aa3a81253230cd.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] arm64/ima: add ima_arch support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chester Lin <clin@suse.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, X86 ML <x86@kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Date:   Mon, 02 Nov 2020 07:13:28 -0500
In-Reply-To: <20201102072005.GB31148@linux-8mug>
References: <20201030060840.1810-1-clin@suse.com>
         <20201030060840.1810-4-clin@suse.com>
         <CAMj1kXFhZEHP37_tkzzHHhkk-Ej+eRcCinMv-tOdp7vvb1d1mQ@mail.gmail.com>
         <20201102072005.GB31148@linux-8mug>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_07:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020093
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-11-02 at 15:20 +0800, Chester Lin wrote:
> On Fri, Oct 30, 2020 at 12:53:25PM +0100, Ard Biesheuvel wrote:
> > On Fri, 30 Oct 2020 at 07:09, Chester Lin <clin@suse.com> wrote:
> > >
> > > Add arm64 IMA arch support. The code and arch policy is mainly inherited
> > > from x86.
> > >
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  arch/arm64/Kconfig           |  1 +
> > >  arch/arm64/kernel/Makefile   |  2 ++
> > >  arch/arm64/kernel/ima_arch.c | 43 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 46 insertions(+)
> > >  create mode 100644 arch/arm64/kernel/ima_arch.c
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index a42e8d13cc88..496a4a26afc6 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -201,6 +201,7 @@ config ARM64
> > >         select SWIOTLB
> > >         select SYSCTL_EXCEPTION_TRACE
> > >         select THREAD_INFO_IN_TASK
> > > +       imply IMA_SECURE_AND_OR_TRUSTED_BOOT if EFI
> > >         help
> > >           ARM 64-bit (AArch64) Linux support.
> > >
> > > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > > index bbaf0bc4ad60..0f6cbb50668c 100644
> > > --- a/arch/arm64/kernel/Makefile
> > > +++ b/arch/arm64/kernel/Makefile
> > > @@ -69,3 +69,5 @@ extra-y                                       += $(head-y) vmlinux.lds
> > >  ifeq ($(CONFIG_DEBUG_EFI),y)
> > >  AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
> > >  endif
> > > +
> > > +obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)   += ima_arch.o
> > > diff --git a/arch/arm64/kernel/ima_arch.c b/arch/arm64/kernel/ima_arch.c
> > > new file mode 100644
> > > index 000000000000..564236d77adc
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/ima_arch.c
> > > @@ -0,0 +1,43 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2018 IBM Corporation
> > > + */
> > > +#include <linux/efi.h>
> > > +#include <linux/module.h>
> > > +#include <linux/ima.h>
> > > +
> > > +bool arch_ima_get_secureboot(void)
> > > +{
> > > +       static bool sb_enabled;
> > > +       static bool initialized;
> > > +
> > > +       if (!initialized & efi_enabled(EFI_BOOT)) {
> > > +               sb_enabled = ima_get_efi_secureboot();
> > > +               initialized = true;
> > > +       }
> > > +
> > > +       return sb_enabled;
> > > +}
> > > +
> > > +/* secure and trusted boot arch rules */
> > > +static const char * const sb_arch_rules[] = {
> > > +#if !IS_ENABLED(CONFIG_KEXEC_SIG)
> > > +       "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> > > +#endif /* CONFIG_KEXEC_SIG */
> > > +       "measure func=KEXEC_KERNEL_CHECK",
> > > +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> > > +       "appraise func=MODULE_CHECK appraise_type=imasig",
> > > +#endif
> > > +       "measure func=MODULE_CHECK",
> > > +       NULL
> > > +};
> > > +
> > > +const char * const *arch_get_ima_policy(void)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> > > +               if (IS_ENABLED(CONFIG_MODULE_SIG))
> > > +                       set_module_sig_enforced();
> > > +               return sb_arch_rules;
> > > +       }
> > > +       return NULL;
> > > +}
> > > --
> > > 2.28.0
> > >
> > 
> > Can we move all this stuff into security/integrity/ima/ima_efi.c instead?
> >
> Actually I hesitated to move all this stuff into ima_efi.c when coding v3
> because I haven't figured out a clear picture to achieve it. Since each
> architecture could still have different details to trigger secure boot detection
> and define their arch-specific rules [e.g. Having boot_params in x86_64 creates
> more conditions that need to be determined before calling get_sb_mode()], moving
> all this stuff seems to decrease the flexibility. Besides, it might also affect
> the consistency of ima_arch as well, for example, ppc and s390 still use these
> function prototypes defined in ima.h. Since these functions are already referred
> by non-EFI architectures, why don't we still reuse these prototypes? For example,
> we could remain a smaller arch_ima_get_secureboot() and the arch-specific rules
> but move the major part of arch_get_ima_policy() into ima_efi.c. For example,
> we could implement an efi_ima_policy() for arch_get_ima_policy() to call so that
> the arch_get_ima_policy() doesn't have to know some details such as checking
> conditions or calling set_module_sig_enforced().
> 
> Please feel free to let me know if any suggestions.

Yes, that is the point and the reason for defining ima_efi.c and
conditionally including it only for EFI systems.  The existing ppc and
s390 code should remain unaffected by this change.

thanks,

Mimi

