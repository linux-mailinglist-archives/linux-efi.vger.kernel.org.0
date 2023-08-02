Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283C76C84D
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHBIYW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjHBIYV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 04:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69481704
        for <linux-efi@vger.kernel.org>; Wed,  2 Aug 2023 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690964614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6xA1F/tQvnceD1AFJdAnCO4v6zT18KFQE0US8wehYA=;
        b=OqkPaNTUQG9J8JRZNgOOzP0OCUsPPFYyi6/yIfJXV6+ozvFj6uvneSo+CGDb/wGNnhMhd3
        I9bWb/WkrXvRs6RQjeZ3KAzyceKWlSFPQ5sDf1h7soxaHz/HS3i/3OoRMDD70bCs5BVqC4
        poPjbA+zWtY2S5MG9/vinfxVe+3cDfU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-a-n_X1tPN8OJU3SmPTs1Lw-1; Wed, 02 Aug 2023 04:23:32 -0400
X-MC-Unique: a-n_X1tPN8OJU3SmPTs1Lw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9ba3d6191so61259301fa.2
        for <linux-efi@vger.kernel.org>; Wed, 02 Aug 2023 01:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964611; x=1691569411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6xA1F/tQvnceD1AFJdAnCO4v6zT18KFQE0US8wehYA=;
        b=LnurIabu5S+kvccchHDZaxk4KnRmXrBAFIl6GUFU1rGTC4zbXU8/wj2kTgr/0C6WtM
         wPwXtjK13zwWaYbqZn2CJtBhdgPoEBuGW33H5Jd3M8EJcCB65/uEeayuc6YMGMPm57QJ
         Ha9zzIaJFNN/8rB9YKsWCb4jXaVZOmyC6SD89oXMnOyhD/XzpJEptdnjGUIHRB4E4itl
         Oo1fSrZQZe4lWtWqV2LwZHbxBw+y4IS/uBCLE1WSC7meQ/E0euGCilAvDngsSLqdO3pw
         ixRF7gvw4AxEuEXjsbJGpF4qd2GpVs9ApghR2afDN9Oh0n81RLsO92jt7Jut9Dyn+drX
         SIMA==
X-Gm-Message-State: ABy/qLaXR0LXwfWie89HJsHKpR7v3He4byMlE+UxpJ9kzizuBv/BHlvx
        LP7j2Gwu5MSQZD4/ARSLEAodtSbck9eSTLUeCrxRAHtBo5LTTCZ8HKpSc07mxHSc+khcn/H6956
        MvQf5/s4X2acwl/029BPhCxKKGYEeH7KdmGeD
X-Received: by 2002:a05:6512:3c9d:b0:4fd:d016:c2e8 with SMTP id h29-20020a0565123c9d00b004fdd016c2e8mr5267057lfv.43.1690964611479;
        Wed, 02 Aug 2023 01:23:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJNKHF2p2CytRgIKLCKCUGGjT7LyJXykVvMQOxHkWM+4I6/V0yxuRpiIuVaotJpuNHCW0V42NQ2DovrfXG528=
X-Received: by 2002:a05:6512:3c9d:b0:4fd:d016:c2e8 with SMTP id
 h29-20020a0565123c9d00b004fdd016c2e8mr5267031lfv.43.1690964611133; Wed, 02
 Aug 2023 01:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local> <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
In-Reply-To: <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
From:   Tao Liu <ltao@redhat.com>
Date:   Wed, 2 Aug 2023 16:22:54 +0800
Message-ID: <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Borislav,

On Sat, Jul 29, 2023 at 12:56=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Jul 27, 2023 at 07:03:26PM +0800, Tao Liu wrote:
> > Hi Borislav,
> >
> > Sorry for the late response. I spent some time retesting your patch
> > against 6.5.0-rc1 and 6.5.0-rc3, and it is OK. So
> >
> > Reported-and-tested-by: Tao Liu <ltao@redhat.com>
> >
> > And will we use this patch as a workaround or will we wait for a
> > better solution as proposed by Michael?
>
> First of all, please do not top-post.
>

OK, thanks for the reminder.

> And yes, here's a better one. I'd appreciate it you testing it.
>

Thanks for the patch! I have tested it on the lenovo machine in the
past few days, no issue found, so the patch tests OK.

Thanks,
Tao Liu

> Thx.
>
> ---
>  arch/x86/boot/compressed/idt_64.c |  5 ++++-
>  arch/x86/boot/compressed/sev.c    | 37 +++++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed=
/idt_64.c
> index 6debb816e83d..0f03ac12e2a6 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -63,7 +63,10 @@ void load_stage2_idt(void)
>         set_idt_entry(X86_TRAP_PF, boot_page_fault);
>
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> -       set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
> +       if (sev_status & BIT(1))
> +               set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
> +       else
> +               set_idt_entry(X86_TRAP_VC, NULL);
>  #endif
>
>         load_boot_idt(&boot_idt_desc);
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
> index 09dc8c187b3c..c3e343bd4760 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -404,13 +404,46 @@ void sev_enable(struct boot_params *bp)
>         if (bp)
>                 bp->cc_blob_address =3D 0;
>
> +       /*
> +        * Do an initial SEV capability check before snp_init() which
> +        * loads the CPUID page and the same checks afterwards are done
> +        * without the hypervisor and are trustworthy.
> +        *
> +        * If the HV fakes SEV support, the guest will crash'n'burn
> +        * which is good enough.
> +        */
> +
> +       /* Check for the SME/SEV support leaf */
> +       eax =3D 0x80000000;
> +       ecx =3D 0;
> +       native_cpuid(&eax, &ebx, &ecx, &edx);
> +       if (eax < 0x8000001f)
> +               return;
> +
> +       /*
> +        * Check for the SME/SEV feature:
> +        *   CPUID Fn8000_001F[EAX]
> +        *   - Bit 0 - Secure Memory Encryption support
> +        *   - Bit 1 - Secure Encrypted Virtualization support
> +        *   CPUID Fn8000_001F[EBX]
> +        *   - Bits 5:0 - Pagetable bit position used to indicate encrypt=
ion
> +        */
> +       eax =3D 0x8000001f;
> +       ecx =3D 0;
> +       native_cpuid(&eax, &ebx, &ecx, &edx);
> +       /* Check whether SEV is supported */
> +       if (!(eax & BIT(1)))
> +               return;
> +
>         /*
>          * Setup/preliminary detection of SNP. This will be sanity-checke=
d
>          * against CPUID/MSR values later.
>          */
>         snp =3D snp_init(bp);
>
> -       /* Check for the SME/SEV support leaf */
> +       /* Now repeat the checks with the SNP CPUID table. */
> +
> +       /* Recheck the SME/SEV support leaf */
>         eax =3D 0x80000000;
>         ecx =3D 0;
>         native_cpuid(&eax, &ebx, &ecx, &edx);
> @@ -418,7 +451,7 @@ void sev_enable(struct boot_params *bp)
>                 return;
>
>         /*
> -        * Check for the SME/SEV feature:
> +        * Recheck for the SME/SEV feature:
>          *   CPUID Fn8000_001F[EAX]
>          *   - Bit 0 - Secure Memory Encryption support
>          *   - Bit 1 - Secure Encrypted Virtualization support
> --
> 2.41.0
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

