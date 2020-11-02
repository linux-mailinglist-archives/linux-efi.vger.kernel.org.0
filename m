Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD552A2457
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 06:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgKBFax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 00:30:53 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:37822 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgKBFav (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Nov 2020 00:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604295046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XedrgsPWHSVjUUGO8ZU81QjTkXW6pQHWB272YdGVruc=;
        b=DpDVGJyXeDkFG1DumF+WPhH4Cd+xyqxx10lhVMVdl+xwNf6L0JpqcCEhJgKkeudlsPSRJT
        SrQfU8hIB/kQ8jiMvojRKiFTPSTSurEIbaaj0vpI2oIdbg0a97l7XnTQhCF+w7VAascWxD
        NkIz6JWivbvdt45TXA/2iXCyvmOsXCM=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-y9Isd1hJNseHwfZTyl_4QA-1; Mon, 02 Nov 2020 06:30:45 +0100
X-MC-Unique: y9Isd1hJNseHwfZTyl_4QA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmOtjZBVB4yfVADobCb9lx4VDBBlMF+FumbiZG2SMD+e+brZVdyF0soGcDUyJVNFX2G1REPthXCUmhaVvLj58S8Er65LHBpLVxvAiar4sBzBUgoGQO1G+uTjmG94Cxem4QSuXatt+RhgqRUX9wZlA03VEiDVZrAt7DkUrh8nGrZnqwtJXzw+HQFktl2cYdKcc6mlQBmgHDK0rJWyRvCGQ7VN2yQPNdtbU9IDoP7y7ZrnWVb+bSjxP+q9WN4GQeVDsn0YYU3PyWNH5agpXwqlOcMPUIjQE4U9tLaqSpflwJbItOG87Iosm2bFJcgwHkaiVHvTdx0mHIaMbud7OwUfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XedrgsPWHSVjUUGO8ZU81QjTkXW6pQHWB272YdGVruc=;
 b=Z4wroomFwBQ/8kPTzzmSXDspYbiZRJXVI8RTcbjGo4zBIdG8q6XEtcL1DB9efDYhtgKLvoQCFQE1nhoAfGx9Xy9s8PmGS32O+yD5R59mGozn7w1rTrGi9ld7NfMSVmBxV9g02MnPL3VOWXYEFXt1ToWiD8G9BRb/AzjOLrUWadvBNHn4oGURNrWddS+qFoEsZyIJd0urrl+Xy8puvLSd7coiPlCW2N5oSg+pt5xIjH4gJJp1clvNGyJ3QT86jowWwJHjAqdqXNcJfauSahue4Vrb2c2qtLlbowsrUD5KFaafTrqSDMgZyt1mBM+U9tVDEg493FhLmtm2zHIGmnD0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB4286.eurprd04.prod.outlook.com (2603:10a6:803:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 05:30:42 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::255b:d25c:3a2b:1e8f]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::255b:d25c:3a2b:1e8f%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 05:30:42 +0000
Date:   Mon, 2 Nov 2020 13:30:25 +0800
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
Subject: Re: [PATCH v3 1/3] efi: generalize efi_get_secureboot
Message-ID: <20201102052907.GA31148@linux-8mug>
References: <20201030060840.1810-1-clin@suse.com>
 <20201030060840.1810-2-clin@suse.com>
 <CAMj1kXFaARnhvnSKSFvAXXY1TKfv=_hG3z=B2j=G3p7qLeQaYw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFaARnhvnSKSFvAXXY1TKfv=_hG3z=B2j=G3p7qLeQaYw@mail.gmail.com>
X-Originating-IP: [118.166.48.44]
X-ClientProxiedBy: AM4PR0701CA0042.eurprd07.prod.outlook.com
 (2603:10a6:200:42::52) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.48.44) by AM4PR0701CA0042.eurprd07.prod.outlook.com (2603:10a6:200:42::52) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 05:30:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a516c1f8-f034-49f0-7b5f-08d87ef07081
X-MS-TrafficTypeDiagnostic: VI1PR04MB4286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4286318FC6E9D387C9CD87AEAD100@VI1PR04MB4286.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaalbUSbgYOjpuIQ5wVdgze7usyJu+OSoBZ5vBGDMhgiX749AL3H4QihPWAt4f/M6qFxfBjCICAc7X49EfpHlRnN5GejTZMTGeomn+3uBK8xQh2L+ultOEhQ8uwVZEtuKnNUslk/4oP3ImKOTQUWF+nNpwdUEI2XgyHmNOz0631ipVNI2noIYK+YAX+9zn6WGVglZYr96u+1zYTlu5sp+DmAAIZx92ayjILl4wNAOnMLscejQvUNr8xnvy3Od9wORJBPueXL96tpyCadAkPdkETp92tKAEaXZhKiTHYcNTYNEzKFdQUf0wK0Qfy/DNYoF9SZoUC2TLVaLvfca+5/+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(8936002)(956004)(55016002)(66476007)(16526019)(7416002)(4326008)(83380400001)(66556008)(1076003)(8676002)(6916009)(55236004)(478600001)(45080400002)(5660300002)(6666004)(52116002)(33656002)(26005)(186003)(86362001)(54906003)(9686003)(316002)(2906002)(33716001)(6496006)(66946007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3NzWc5yUPGemi0SFl1yRPSTQbBfzYducL39IfcLmNmPI5kaznMKdTGALKqz4YVUJz6JlYcc83KglhK9cgM3u+yTz1fXbKFtTZC6URjfBVhBcsY1wSon/8JylBd0LYNJ2dOGTo6KI6bOKkQp4kBS8nP7hOLP/oD8CHzLbuokm3s2VE/undNSljJ8ps4Tu6T0s1nI/AoiDoQO8smziU7ollo1xs6SZqLbhtDTIZ6lbMJ0N5JhoRd+5x92d696p+bEKYNFQruVWk5hjVnrOck9M52d6L1Yeq2e6ASlJOwUws+Bp6wnsQ0NaSotFpMhrJMjwz6J1juETtu0GjeKFgCa4R66gWpTvNhuNKYXyJ05XhNCfR0J9eOiIFX2IZi6k12WsPmlfkOPX9cm9DGM8NPfgifbq6WYbQsE0mSTlUtvFKk0pGJGLHjvszG2+1PG2RIiwKTyamnLjThSCpxa00Y588q9+R5tJucLuGSX7Y3qUyVfdJ8n6DWHPjuHS4VLbZuKLEIaUb8OT0e27nPgYD0ijaaQUTssLQdn+d091YiVTjExAqyOEKt7VWvJml/Q852nIjSjoJ9W6FEQ7T0CHAHfR0qXWY0Wz15YnxQTnNE+HDkBAjy1Ocddjvlo0s0+K108M/y99ifKEijoGJ5/9zj5h3Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a516c1f8-f034-49f0-7b5f-08d87ef07081
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 05:30:42.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3VL8/k6SjTkDU2dfTvXnwf67nE2Pvj941YBUtiOidZ15eBCgvnf0/Dpk/tn0LKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4286
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thanks for your time and reviewing.

On Fri, Oct 30, 2020 at 12:51:10PM +0100, Ard Biesheuvel wrote:
> Hello Chester,
> 
> Thanks again for looking into this.
> 
> On Fri, 30 Oct 2020 at 07:09, Chester Lin <clin@suse.com> wrote:
> >
> > Generalize the efi_get_secureboot() function so not only efistub but also
> > other subsystems can use it.
> >
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  drivers/firmware/efi/libstub/Makefile     |  2 +-
> >  drivers/firmware/efi/libstub/efi-stub.c   |  2 +-
> >  drivers/firmware/efi/libstub/efistub.h    | 22 ++++---
> >  drivers/firmware/efi/libstub/secureboot.c | 76 -----------------------
> >  drivers/firmware/efi/libstub/x86-stub.c   |  2 +-
> >  include/linux/efi.h                       | 41 +++++++++++-
> >  6 files changed, 57 insertions(+), 88 deletions(-)
> >  delete mode 100644 drivers/firmware/efi/libstub/secureboot.c
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 8a94388e38b3..88e47b0ca09d 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -49,7 +49,7 @@ OBJECT_FILES_NON_STANDARD     := y
> >  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> >  KCOV_INSTRUMENT                        := n
> >
> > -lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> > +lib-y                          := efi-stub-helper.o gop.o tpm.o \
> >                                    file.o mem.o random.o randomalloc.o pci.o \
> >                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
> >                                    alignedmem.o relocate.o vsprintf.o
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > index 914a343c7785..ad96f1d786a9 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -196,7 +196,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >         /* Ask the firmware to clear memory on unclean shutdown */
> >         efi_enable_reset_attack_mitigation();
> >
> > -       secure_boot = efi_get_secureboot();
> > +       secure_boot = efi_get_secureboot(get_efi_var);
> >
> >         /*
> >          * Unauthenticated device tree data is a security hazard, so ignore
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index 2d7abcd99de9..b1833b51e6d6 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -91,14 +91,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >         fdt_setprop((fdt), (node_offset), (name), &(var), sizeof(var))
> >  #endif
> >
> > -#define get_efi_var(name, vendor, ...)                         \
> > -       efi_rt_call(get_variable, (efi_char16_t *)(name),       \
> > -                   (efi_guid_t *)(vendor), __VA_ARGS__)
> > -
> > -#define set_efi_var(name, vendor, ...)                         \
> > -       efi_rt_call(set_variable, (efi_char16_t *)(name),       \
> > -                   (efi_guid_t *)(vendor), __VA_ARGS__)
> > -
> >  #define efi_get_handle_at(array, idx)                                  \
> >         (efi_is_native() ? (array)[idx]                                 \
> >                 : (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
> > @@ -112,6 +104,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >                 ((handle = efi_get_handle_at((array), i)) || true);     \
> >              i++)
> >
> > +static inline
> > +efi_status_t get_efi_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
> > +                        unsigned long *size, void *data)
> > +{
> > +       return efi_rt_call(get_variable, name, vendor, attr, size, data);
> > +}
> > +
> > +static inline
> > +efi_status_t set_efi_var(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
> > +                        unsigned long size, void *data)
> > +{
> > +       return efi_rt_call(set_variable, name, vendor, attr, size, data);
> > +}
> > +
> >  static inline
> >  void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
> >  {
> > diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
> > deleted file mode 100644
> > index 5efc524b14be..000000000000
> > --- a/drivers/firmware/efi/libstub/secureboot.c
> > +++ /dev/null
> 
> Please keep this file (see below)
> 
> > @@ -1,76 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * Secure boot handling.
> > - *
> > - * Copyright (C) 2013,2014 Linaro Limited
> > - *     Roy Franz <roy.franz@linaro.org
> > - * Copyright (C) 2013 Red Hat, Inc.
> > - *     Mark Salter <msalter@redhat.com>
> > - */
> > -#include <linux/efi.h>
> > -#include <asm/efi.h>
> > -
> > -#include "efistub.h"
> > -
> > -/* BIOS variables */
> > -static const efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> > -static const efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
> > -static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
> > -
> > -/* SHIM variables */
> > -static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> > -static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
> > -
> > -/*
> > - * Determine whether we're in secure boot mode.
> > - *
> > - * Please keep the logic in sync with
> > - * arch/x86/xen/efi.c:xen_efi_get_secureboot().
> > - */
> > -enum efi_secureboot_mode efi_get_secureboot(void)
> > -{
> > -       u32 attr;
> > -       u8 secboot, setupmode, moksbstate;
> > -       unsigned long size;
> > -       efi_status_t status;
> > -
> > -       size = sizeof(secboot);
> > -       status = get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
> > -                            NULL, &size, &secboot);
> > -       if (status == EFI_NOT_FOUND)
> > -               return efi_secureboot_mode_disabled;
> > -       if (status != EFI_SUCCESS)
> > -               goto out_efi_err;
> > -
> > -       size = sizeof(setupmode);
> > -       status = get_efi_var(efi_SetupMode_name, &efi_variable_guid,
> > -                            NULL, &size, &setupmode);
> > -       if (status != EFI_SUCCESS)
> > -               goto out_efi_err;
> > -
> > -       if (secboot == 0 || setupmode == 1)
> > -               return efi_secureboot_mode_disabled;
> > -
> > -       /*
> > -        * See if a user has put the shim into insecure mode. If so, and if the
> > -        * variable doesn't have the runtime attribute set, we might as well
> > -        * honor that.
> > -        */
> > -       size = sizeof(moksbstate);
> > -       status = get_efi_var(shim_MokSBState_name, &shim_guid,
> > -                            &attr, &size, &moksbstate);
> > -
> 
> MokSBState is a boot time variable, so we cannot access it when
> running under the OS. Xen also has a code flow similar to this one,
> but it looks at MokSbStateRt instead (which may be a mistake but let's
> forget about that for now)
> 
> So what we will need to do is factor out only the top part of this
> function (which, incidentally, is the only part that IMA uses in the
i> first place)
> 

Thanks for the reminder. I will take this change into next revision.

> > -       /* If it fails, we don't care why. Default to secure */
> > -       if (status != EFI_SUCCESS)
> > -               goto secure_boot_enabled;
> > -       if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate == 1)
> > -               return efi_secureboot_mode_disabled;
> > -
> > -secure_boot_enabled:
> > -       efi_info("UEFI Secure Boot is enabled.\n");
> > -       return efi_secureboot_mode_enabled;
> > -
> > -out_efi_err:
> > -       efi_err("Could not determine UEFI Secure Boot status.\n");
> > -       return efi_secureboot_mode_unknown;
> > -}
> 
> So let's keep this file, and also, let's put a wrapper function around
> get_efi_var() here, of which you can take the address and pass to the
> static inline function.

If I understand correctly, that means it's better to define a new wrapper
function around the get_efi_var() rather than changing it from a macro to
an inline function. Please feel free to let me know if I misunderstand it.

> 
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index 3672539cb96e..3f9b492c566b 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -781,7 +781,7 @@ unsigned long efi_main(efi_handle_t handle,
> >          * otherwise we ask the BIOS.
> >          */
> >         if (boot_params->secure_boot == efi_secureboot_mode_unset)
> > -               boot_params->secure_boot = efi_get_secureboot();
> > +               boot_params->secure_boot = efi_get_secureboot(get_efi_var);
> >
> >         /* Ask the firmware to clear memory on unclean shutdown */
> >         efi_enable_reset_attack_mitigation();
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index d7c0e73af2b9..cc2d3de39031 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1089,7 +1089,46 @@ enum efi_secureboot_mode {
> >         efi_secureboot_mode_disabled,
> >         efi_secureboot_mode_enabled,
> >  };
> > -enum efi_secureboot_mode efi_get_secureboot(void);
> > +
> > +static inline enum efi_secureboot_mode efi_get_secureboot(efi_get_variable_t *get_var)
> > +{
> > +       efi_guid_t var_guid = EFI_GLOBAL_VARIABLE_GUID;
> > +       efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> > +       efi_status_t status;
> > +       unsigned long size;
> > +       u8 secboot, setupmode, moksbstate;
> > +       u32 attr;
> > +
> > +       size = sizeof(secboot);
> > +       status = get_var(L"SecureBoot", &var_guid, NULL, &size, &secboot);
> > +
> > +       if (status == EFI_NOT_FOUND)
> > +               return efi_secureboot_mode_disabled;
> > +       if (status != EFI_SUCCESS)
> > +               return efi_secureboot_mode_unknown;
> > +
> > +       size = sizeof(setupmode);
> > +       status = get_var(L"SetupMode", &var_guid, NULL, &size, &setupmode);
> > +
> > +       if (status != EFI_SUCCESS)
> > +               return efi_secureboot_mode_unknown;
> > +       if (secboot == 0 || setupmode == 1)
> > +               return efi_secureboot_mode_disabled;
> > +
> 
> So keep until here and move the rest back into the .c file
> 
> > +       /*
> > +        * See if a user has put the shim into insecure mode. If so, and if the
> > +        * variable doesn't have the runtime attribute set, we might as well
> > +        * honor that.
> > +        */
> > +       size = sizeof(moksbstate);
> > +       status = get_var(L"MokSBState", &shim_guid, &attr, &size, &moksbstate);
> > +       /* If it fails, we don't care why. Default to secure */
> > +       if (status == EFI_SUCCESS && moksbstate == 1
> > +           && !(attr & EFI_VARIABLE_RUNTIME_ACCESS))
> > +               return efi_secureboot_mode_disabled;
> > +
> > +       return efi_secureboot_mode_enabled;
> > +}
> >
> >  #ifdef CONFIG_RESET_ATTACK_MITIGATION
> >  void efi_enable_reset_attack_mitigation(void);
> > --
> > 2.28.0
> >
> 

