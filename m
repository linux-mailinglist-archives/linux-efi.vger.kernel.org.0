Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA24428F1F5
	for <lists+linux-efi@lfdr.de>; Thu, 15 Oct 2020 14:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJOMVw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Oct 2020 08:21:52 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:20031 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbgJOMVw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Oct 2020 08:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602764508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsLRvxyL5sqqhavRyiuQi88CgHEAIiEAOGXA8OT66gg=;
        b=lA5wQcb6cA2JwFPb6pl2Rv7JdtwnkYq4ECDSUzt1u1hHI6MJbTRNaGFft2grWbEQZjpSoL
        u3KPpmCTCh9cIizn+Tm3EcAQVrE5Qu8psvN5WGy2DhDXCxEtZl6Ni1ROfmIy3VuGuqCsQw
        E05CPE6PqSCx+r5vqyuh9fY2w8TgxpM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-IVGC3LE6ObWWiVec3WGY7Q-1; Thu, 15 Oct 2020 14:21:47 +0200
X-MC-Unique: IVGC3LE6ObWWiVec3WGY7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIw49+KdcZkx34CVvq2UwhKrqwdnjCOaK5s01FRmyNWvaPDeR90KussoSZaJGpMxBvuwTrHrFxTozVnNmF1kGZAboO+1C7l4fgGesmeaEbxzVTQaqrgWUVslOf7nwEEGscgEe/jNlZ+5l2WkuDo+4FYJYAivkEzTQ6V9XDvC5MkuSeIf/U9aJ/tu+qb+aYeM7HaiJLrOBlpZEWuttS6t/UE6mDJ1gMxt9sohTeEDishK6bnMKz31XvZEa2yRAyfp965XEAK/wRTnLR5chEN7q3YMcVNmVt5B7DaQNVfXiiTjO+2N4/tvayznyZBuP9i1qaZSV03MBRufoQzTiqDPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsLRvxyL5sqqhavRyiuQi88CgHEAIiEAOGXA8OT66gg=;
 b=OSyi4NBwgitk18sts21C4POTwUm0y3lTUE9ZQUuNsorcCaDpqqhf471Hq6xpPgq2bHFS6MVEeR8Vl75D3Ke3Bp74lhUrqj4i3wz1qt44WUC2AZCbHfZyjLeJwgz5tXQuvtWaSQuR4oKgdYNRhU5YKYWqpsoAqRZvAuHjPGS9AbSjg5zGgQHkYsDgWpRxOM6P5JletDot2HYVrDsJUj2crII5AKPiwZsTVQm4kRfern6GAj+lOLLnKH8W4TJ1GuSScWsjY58x/d1zKgoJe2umRrbk+yomfr8OmD9dQAnSSVWZKjRtqqBQLGCriYDycX07LHpafwbOPdiu8eOIlPOHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB5966.eurprd04.prod.outlook.com (2603:10a6:803:d7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Thu, 15 Oct
 2020 12:21:44 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 12:21:44 +0000
Date:   Thu, 15 Oct 2020 20:21:22 +0800
From:   Chester Lin <clin@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        "Lee, Chun-Yi" <jlee@suse.com>, clin@suse.com
Subject: Re: [PATCH v2 1/2] efi: add secure boot get helper
Message-ID: <20201015122122.GA4963@linux-8mug>
References: <20201014104032.9776-1-clin@suse.com>
 <20201014104032.9776-2-clin@suse.com>
 <CAMj1kXGacnj=uh9WFh1+YBVXxzZbxeN==Y_f-rhJZ=3385B68g@mail.gmail.com>
 <e436ab32ba30549591753cb3ec43749a6776f43e.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e436ab32ba30549591753cb3ec43749a6776f43e.camel@linux.ibm.com>
X-Originating-IP: [220.141.82.61]
X-ClientProxiedBy: AM0PR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::44) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (220.141.82.61) by AM0PR01CA0175.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 12:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8fb17c-27fe-4d30-c76f-08d87104e0f8
X-MS-TrafficTypeDiagnostic: VI1PR04MB5966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB59662DF5AEE44588D104EB98AD020@VI1PR04MB5966.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkqnkVT2yJpMcrRYNqB7K0Q0d+Wk67uQ9VzQpaIwHZ9Zb7t/y3iP3R8k6RZr42biHEUAdgjE1KWK/OBMPM7T20nwFGAm94JJHTgeKVujSDlw2/UAd1S8IqH0+QErAVxpMHQKTBnJr2pRgHqID6TUxcOh5KcM6Be9ENvR7KLy4ELDTRco0BGfIj9DqahiD8ZGCtQepQ+6gUQN7/63eGLGeqI2JLbPQvyaEBzDbjY3bOYio/uiHhWtxZaJJ7aZbmCWBY4+ZK4bvuXhxU4/BYH+H7OcN1PJhWMR5/5ZtB49zSrEMqGApCK4EBBraxWaXDO61xg6opPgXrfq3zRg79M1hihDk5gXhWLGH80c/1xM0Nw1ksk3Q3y1t/4v6VmWyJdk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(8936002)(316002)(4326008)(26005)(86362001)(6916009)(478600001)(16526019)(107886003)(33716001)(186003)(52116002)(4001150100001)(9686003)(6496006)(55016002)(7416002)(956004)(5660300002)(2906002)(66556008)(66476007)(66946007)(54906003)(1076003)(33656002)(83380400001)(6666004)(8676002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Caql95Vq+UQDqZKr95grGDI6jj5otIOtJflhFA8bAY6NGJgPYc47vkroF1SaXb23tosuiJXwArzwJJDyP66gEwQ5cokJLJqLaxEJuuXMq3CSpHQjnmjttFEkeKjcqa9nJcPdwKau2BV+GAE5DQP/xdlTTxpJbkdJewI3b2e99RWTlO0QtttTJtXDmehpW/Vn4UrBefu7npeBmN4cyQk3ltXfLl0eVjxj0quxgy2w6W3z2CGtafwW5jmPrxlZP+o1vTWI0iwg/VDRUT829dOAlUZNIAReeD8tIVMjadrHQZ2fqMtDOHrynX4EtCJbRkIjlWHtKvpx+XMtPWrnzq6kdm/0Vgg+vGJ4l2hTH6xSZx08+voyll5FIEu70bqq2LjAONABIFKxBGlidX4BWZVdTFcEzsUYXEl4IK0tR2K6m6I5/39dPvKq060zhOU4N/4xYrYNL4rkElBCo6dAtqIXjmuxVpoPWaQQwdIXGLZOrmuG62gBmvMy5/y0vVpSw/ks+MlRYgGrdK0PQrpX+ByDqvm3KG4bBN1N9YvWqPdmy/cwBBf0WQFyYF+A7Bgy3aN90rQljdkkbfECzUXJWw0Q5yeCu1pSxfTSxx2yvbEamuQYGcVxuZAgP7DiruRhprXaNlEg+B8WB+LsO/rwd4Jb0Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8fb17c-27fe-4d30-c76f-08d87104e0f8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 12:21:44.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeWSupbb9fOyCy0L9YdbST8IyD+Q7yVmUN+3BkB740v0Aea6wPhx+WRrr6ZBKkSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5966
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard and Mimi,

On Wed, Oct 14, 2020 at 07:56:17AM -0400, Mimi Zohar wrote:
> On Wed, 2020-10-14 at 13:00 +0200, Ard Biesheuvel wrote:
> > Hello Chester,
> > 
> > Thanks for looking into this.
> > 
> > Some comments below.
> > 
> > On Wed, 14 Oct 2020 at 12:41, Chester Lin <clin@suse.com> wrote:
> > >
> > > Separate the get_sb_mode() from arch/x86 and treat it as a common function
> > > [rename to efi_get_secureboot_mode] so all EFI-based architectures can
> > > reuse the same logic.
> > >
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  arch/x86/kernel/ima_arch.c | 47 ++------------------------------------
> > >  drivers/firmware/efi/efi.c | 43 ++++++++++++++++++++++++++++++++++
> > >  include/linux/efi.h        |  5 ++++
> > >  3 files changed, 50 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> > > index 7dfb1e808928..ed4623ecda6e 100644
> > > --- a/arch/x86/kernel/ima_arch.c
> > > +++ b/arch/x86/kernel/ima_arch.c
> > > @@ -8,49 +8,6 @@
> > >
> > >  extern struct boot_params boot_params;
> > >
> > > -static enum efi_secureboot_mode get_sb_mode(void)
> > > -{
> > > -       efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> > > -       efi_status_t status;
> > > -       unsigned long size;
> > > -       u8 secboot, setupmode;
> > > -
> > > -       size = sizeof(secboot);
> > > -
> > > -       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> > > -               pr_info("ima: secureboot mode unknown, no efi\n");
> > > -               return efi_secureboot_mode_unknown;
> > > -       }
> > > -
> > > -       /* Get variable contents into buffer */
> > > -       status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> > > -                                 NULL, &size, &secboot);
> > > -       if (status == EFI_NOT_FOUND) {
> > > -               pr_info("ima: secureboot mode disabled\n");
> > > -               return efi_secureboot_mode_disabled;
> > > -       }
> > > -
> > > -       if (status != EFI_SUCCESS) {
> > > -               pr_info("ima: secureboot mode unknown\n");
> > > -               return efi_secureboot_mode_unknown;
> > > -       }
> > > -
> > > -       size = sizeof(setupmode);
> > > -       status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> > > -                                 NULL, &size, &setupmode);
> > > -
> > > -       if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> > > -               setupmode = 0;
> > > -
> > > -       if (secboot == 0 || setupmode == 1) {
> > > -               pr_info("ima: secureboot mode disabled\n");
> > > -               return efi_secureboot_mode_disabled;
> > > -       }
> > > -
> > > -       pr_info("ima: secureboot mode enabled\n");
> > > -       return efi_secureboot_mode_enabled;
> > > -}
> > > -
> > >  bool arch_ima_get_secureboot(void)
> > >  {
> > >         static enum efi_secureboot_mode sb_mode;
> > > @@ -60,7 +17,7 @@ bool arch_ima_get_secureboot(void)
> > >                 sb_mode = boot_params.secure_boot;
> > >
> > >                 if (sb_mode == efi_secureboot_mode_unset)
> > > -                       sb_mode = get_sb_mode();
> > > +                       sb_mode = efi_get_secureboot_mode();
> > >                 initialized = true;
> > >         }
> > >
> > > @@ -70,7 +27,7 @@ bool arch_ima_get_secureboot(void)
> > >                 return false;
> > >  }
> > >
> > > -/* secureboot arch rules */
> > > +/* secure and trusted boot arch rules */
> > >  static const char * const sb_arch_rules[] = {
> > >  #if !IS_ENABLED(CONFIG_KEXEC_SIG)
> > >         "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 5e5480a0a32d..68ffa6a069c0 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -1022,3 +1022,46 @@ static int __init register_update_efi_random_seed(void)
> > >  }
> > >  late_initcall(register_update_efi_random_seed);
> > >  #endif
> > > +
> > > +enum efi_secureboot_mode efi_get_secureboot_mode(void)
> > > +{
> > > +       efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> > > +       efi_status_t status;
> > > +       unsigned long size;
> > > +       u8 secboot, setupmode;
> > > +
> > > +       size = sizeof(secboot);
> > > +
> > > +       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> > > +               pr_info("ima: secureboot mode unknown, no efi\n");
> > 
> > These prints don't belong here anymore.
> > 
> > Also, it would be useful if we could reuse this logic in the EFI stub
> > as well, which is built as a separate executable, and does not provide
> > efi.get_variable().
> > 
> > So, you could you please break this up into
> > 
> > static inline
> > enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
> > {
> > }
> > 
> > placed into include/linux/efi.h, which encapsulates the core logic,
> > but using get_var(), and without the prints.
> > 
> > Then, we could put something like
> > 
> > bool efi_ima_get_secureboot(void)
> > {
> > }
> > 
> > in drivers/firmware/efi/efi.c (guarded by #ifdef CONFIG_IMA_xxx),
> > which performs the
> > efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) check, calls
> > efi_get_secureboot_mode(efi.get_variable), and implements the logic.
> > 
> > And actually, if the logic is identical between x86 and arm64, I
> > wonder if it wouldn't be better to put the whole thing into
> > 
> > drivers/firmware/efi/efi-ima.c
> > 
> > or
> > 
> > security/integrity/ima/ima-efi.c
> > 
> > with the only difference being the boot_params->secure_boot access for
> > x86, which we can factor out to a static inline helper.
> > 
> > Mimi, any thoughts here?
> 
> Sounds good.  Keeping as much IMA code in the IMA directory makes
> sense.   The IMA Makefile would then include ima-efi.c based on an EFI
> Kconfig option.
> 
> thanks,
> 
> Mimi

Thanks for your suggestions. I will include them in v3.

Regards,
Chester

> > 
> > 
> > 
> > > +               return efi_secureboot_mode_unknown;
> > > +       }
> > > +
> > > +       /* Get variable contents into buffer */
> > > +       status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> > > +                                 NULL, &size, &secboot);
> > > +       if (status == EFI_NOT_FOUND) {
> > > +               pr_info("ima: secureboot mode disabled\n");
> > > +               return efi_secureboot_mode_disabled;
> > > +       }
> > > +
> > > +       if (status != EFI_SUCCESS) {
> > > +               pr_info("ima: secureboot mode unknown\n");
> > > +               return efi_secureboot_mode_unknown;
> > > +       }
> > > +
> > > +       size = sizeof(setupmode);
> > > +       status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> > > +                                 NULL, &size, &setupmode);
> > > +
> > > +       if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> > > +               setupmode = 0;
> > > +
> > > +       if (secboot == 0 || setupmode == 1) {
> > > +               pr_info("ima: secureboot mode disabled\n");
> > > +               return efi_secureboot_mode_disabled;
> > > +       }
> > > +
> > > +       pr_info("ima: secureboot mode enabled\n");
> > > +       return efi_secureboot_mode_enabled;
> > > +}
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index d7c0e73af2b9..a73e5ae04672 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1076,8 +1076,13 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
> > >
> > >  #ifdef CONFIG_EFI
> > >  extern bool efi_runtime_disabled(void);
> > > +extern enum efi_secureboot_mode efi_get_secureboot_mode(void);
> > >  #else
> > >  static inline bool efi_runtime_disabled(void) { return true; }
> > > +static inline enum efi_secureboot_mode efi_get_secureboot_mode(void)
> > > +{
> > > +       return efi_secureboot_mode_disabled;
> > > +}
> > >  #endif
> > >
> > >  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
> > > --
> > > 2.26.1
> > >
> 
> 

