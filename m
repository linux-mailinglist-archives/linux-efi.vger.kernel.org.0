Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87E2A2518
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 08:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKBHU2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 02:20:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:40722 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728056AbgKBHU0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Nov 2020 02:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604301622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0trEpG2sN257wR2RvkfWGl585lf1+T0Fk27eYcf2jk=;
        b=WmRMFphRqKpHfJL4gRC4dzKx29/pOuBVsO7fgyoXt3dyjTTJev8grhZyLx7LqkABjEut89
        eYjbPrsm+TH1Rm196MceSpmvjOOf7Rjn6N2Nppw6rXfKmxGeBhjLWgbotX0/hISkxuHzwO
        c06ogy0aHqc0Gov2Le8qmi3JqAy3MiQ=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-HythFZkAM7u-5tgq2bSGMA-1; Mon, 02 Nov 2020 08:20:20 +0100
X-MC-Unique: HythFZkAM7u-5tgq2bSGMA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxRGOWdlE7UvyrnKF+Sz4GZvnASYJplpGhFV1/PjuhD7D0yUZDls7Ctpt5bdqMedgfm6BMC2WynypDfQEVpfDPBrj9eaVSwywrlIaQCyLAdqY9V1QBSOid38lAbRTrC6Tiwj78F68GZrM289TGoZ5ytOp51XZfD90KdhelE6p29R6hSWaWHQsPpsoiiohc4X6Ny6lybOs0MozKFqGhKptU6XeXRm7xoezUDJ+mSKsjruN2mda8GMnB62pBU1ZxhdmKEG4ahYeIPHnyg8Z9r+MMOzIfdAUb49TaOKSSxPv7mXNw15uXNWCuHwmwrTDY6YyBgoVMZQ3LIhmDJyTV953g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0trEpG2sN257wR2RvkfWGl585lf1+T0Fk27eYcf2jk=;
 b=OtQWnilw9AzHssgVKTsFQu8E4oAECJmwaUwzhQSHHE7vwXHqtSypqyZOiri5KUn+QpBfrBZsOdirxHo9HelzoGpDjeM046qX07WZ5N+yzugRCTpZp1mJC01YMIDZHYyVzzWBibXpONmTOQ02ZDS7s/jrVDpgVvsuARRRFJCfUZS5xOTjfs1vSqPtSxzi7WS1u/we8XJ12Ycajwcddm1sOaGSHkXJzw2LaA+c1tciIxJmFeivO2C+nKMj6EcpR2ps8rXeCECiI8IHdRWA5/pRYUTjKydRDsYKtWqpfwDSXPhsl+qlFKnDYR53yUjJ2gT6sZaopZIz1/PccMItixZrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB4926.eurprd04.prod.outlook.com (2603:10a6:803:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 07:20:18 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::255b:d25c:3a2b:1e8f]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::255b:d25c:3a2b:1e8f%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 07:20:18 +0000
Date:   Mon, 2 Nov 2020 15:20:05 +0800
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
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
Subject: Re: [PATCH v3 3/3] arm64/ima: add ima_arch support
Message-ID: <20201102072005.GB31148@linux-8mug>
References: <20201030060840.1810-1-clin@suse.com>
 <20201030060840.1810-4-clin@suse.com>
 <CAMj1kXFhZEHP37_tkzzHHhkk-Ej+eRcCinMv-tOdp7vvb1d1mQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFhZEHP37_tkzzHHhkk-Ej+eRcCinMv-tOdp7vvb1d1mQ@mail.gmail.com>
X-Originating-IP: [118.166.48.44]
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.48.44) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 2 Nov 2020 07:20:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d31d46-2327-44c5-4f8b-08d87effc033
X-MS-TrafficTypeDiagnostic: VI1PR04MB4926:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4926ECF61AE1CFA8D9094AB7AD100@VI1PR04MB4926.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsnBgRZ/wlPG3uyWFhjx8lFvxfmm62rTgmwzeA9VDcojR5/o166y0SAbxe3TI8MMvtVjj6kIBN1ruf77jD/wKeljEQ+1zXC+O6eMoUcePQMJRFox2K67VsTb3xuHdA3LXwuylxAlqK7YXAwEUa3bSbT3Shw653gfDuJxfm/R73Vyd9ZDOJn5zAiVHk2O8L/y+KhBsGw3D+FchJkFrblZW+fkLXENtJMaRR0E/Xpn9Y4svU62PmunhW4hiPSPE/sANncE44v7Lieky+LyGU+zWDBMfaGEjDAzcumSshiWD/q3uhYgDZRkrnBC6wDQZQQSUoZKCRcKhEchoKzTRp5p8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(366004)(316002)(66476007)(66556008)(55236004)(66946007)(52116002)(8936002)(33656002)(1076003)(956004)(8676002)(478600001)(6496006)(33716001)(54906003)(5660300002)(4326008)(107886003)(83380400001)(6666004)(2906002)(55016002)(7416002)(6916009)(86362001)(26005)(186003)(16526019)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qusgbbVtyPHVuQferDuJwtJHYweURFxUegCpxtZuvAu+OEUecf9kBygDwCXn/CQa0gP6RVfVj0pBjBZI4VrHbzmorrpDQqMgqs9701NGUOreAGwYbz4RuENIK2XuNmoEfQzCLqtPXjfu/GObi4H97ZDNw8HuOf1pZeWWbAD7qfpn2nDS0e7lcVQtTTATAQBehkW+ucCVLy9DaqNmcDXZ+uuk0+Yr7haISIAlChlBKaF+g+KidclI3h1rqBo5swwH7H+uE+HQeZyF3ik2XPTTBgnL1OcQtdgAVgeeZ+OkWnR670+UwnC/jL+SS6Un/xPK+T1UaMg4ldd8G+vjeMKGewqVR4ktoLPh94uqIGrafKUjAUVAmvDVPYnzSjT7ytudvcH4OyF0M4106J3FfgfIgshX0wZd3hhmTFgRAXjQZPtmWy+USLSwQ0efUd7FbPS8CLHyp0IRcVfX+mKVn5HHeJB2O8VJIg5avMSPid5clM4yNBMRsKZPU4hqYlTMhlfxWG776/E9F8hdp015Y5bFoLJOoHN+PvyEkHrYY1a+WHuN3m5c62XoF5KmSfsIGz+sCJ40QzHcq9oSAmio1y2s8kGR71ZVXw7UPQd7TnbQ5QIsaV2ET57/MLs1sthRFdh4V8NLeCtds30rmhbQYIorfg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d31d46-2327-44c5-4f8b-08d87effc033
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 07:20:18.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uEaRmGkssMRqWFY09/qPMctr9YjN9oJSDGEaE0Mp9ndTECKgXmAeBZMx74rKq0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4926
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 30, 2020 at 12:53:25PM +0100, Ard Biesheuvel wrote:
> On Fri, 30 Oct 2020 at 07:09, Chester Lin <clin@suse.com> wrote:
> >
> > Add arm64 IMA arch support. The code and arch policy is mainly inherited
> > from x86.
> >
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm64/Kconfig           |  1 +
> >  arch/arm64/kernel/Makefile   |  2 ++
> >  arch/arm64/kernel/ima_arch.c | 43 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+)
> >  create mode 100644 arch/arm64/kernel/ima_arch.c
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index a42e8d13cc88..496a4a26afc6 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -201,6 +201,7 @@ config ARM64
> >         select SWIOTLB
> >         select SYSCTL_EXCEPTION_TRACE
> >         select THREAD_INFO_IN_TASK
> > +       imply IMA_SECURE_AND_OR_TRUSTED_BOOT if EFI
> >         help
> >           ARM 64-bit (AArch64) Linux support.
> >
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index bbaf0bc4ad60..0f6cbb50668c 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -69,3 +69,5 @@ extra-y                                       += $(head-y) vmlinux.lds
> >  ifeq ($(CONFIG_DEBUG_EFI),y)
> >  AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
> >  endif
> > +
> > +obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)   += ima_arch.o
> > diff --git a/arch/arm64/kernel/ima_arch.c b/arch/arm64/kernel/ima_arch.c
> > new file mode 100644
> > index 000000000000..564236d77adc
> > --- /dev/null
> > +++ b/arch/arm64/kernel/ima_arch.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018 IBM Corporation
> > + */
> > +#include <linux/efi.h>
> > +#include <linux/module.h>
> > +#include <linux/ima.h>
> > +
> > +bool arch_ima_get_secureboot(void)
> > +{
> > +       static bool sb_enabled;
> > +       static bool initialized;
> > +
> > +       if (!initialized & efi_enabled(EFI_BOOT)) {
> > +               sb_enabled = ima_get_efi_secureboot();
> > +               initialized = true;
> > +       }
> > +
> > +       return sb_enabled;
> > +}
> > +
> > +/* secure and trusted boot arch rules */
> > +static const char * const sb_arch_rules[] = {
> > +#if !IS_ENABLED(CONFIG_KEXEC_SIG)
> > +       "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> > +#endif /* CONFIG_KEXEC_SIG */
> > +       "measure func=KEXEC_KERNEL_CHECK",
> > +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> > +       "appraise func=MODULE_CHECK appraise_type=imasig",
> > +#endif
> > +       "measure func=MODULE_CHECK",
> > +       NULL
> > +};
> > +
> > +const char * const *arch_get_ima_policy(void)
> > +{
> > +       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> > +               if (IS_ENABLED(CONFIG_MODULE_SIG))
> > +                       set_module_sig_enforced();
> > +               return sb_arch_rules;
> > +       }
> > +       return NULL;
> > +}
> > --
> > 2.28.0
> >
> 
> Can we move all this stuff into security/integrity/ima/ima_efi.c instead?
>
Actually I hesitated to move all this stuff into ima_efi.c when coding v3
because I haven't figured out a clear picture to achieve it. Since each
architecture could still have different details to trigger secure boot detection
and define their arch-specific rules [e.g. Having boot_params in x86_64 creates
more conditions that need to be determined before calling get_sb_mode()], moving
all this stuff seems to decrease the flexibility. Besides, it might also affect
the consistency of ima_arch as well, for example, ppc and s390 still use these
function prototypes defined in ima.h. Since these functions are already referred
by non-EFI architectures, why don't we still reuse these prototypes? For example,
we could remain a smaller arch_ima_get_secureboot() and the arch-specific rules
but move the major part of arch_get_ima_policy() into ima_efi.c. For example,
we could implement an efi_ima_policy() for arch_get_ima_policy() to call so that
the arch_get_ima_policy() doesn't have to know some details such as checking
conditions or calling set_module_sig_enforced().

Please feel free to let me know if any suggestions.

