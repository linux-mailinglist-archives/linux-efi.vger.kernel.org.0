Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3B71241B
	for <lists+linux-efi@lfdr.de>; Fri, 26 May 2023 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjEZJ4c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 May 2023 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbjEZJ4b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 May 2023 05:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC055A9
        for <linux-efi@vger.kernel.org>; Fri, 26 May 2023 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685094949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYCtA4RZQ08M+9pUkzTh3dY/9or9x6h7PoJOQ6GY4XM=;
        b=c/EUhvycSxwPJgcIXhch9lA1L5fBctpLdnct9wwQlCDiFSzSLjwZZ4ZK9quKBMgMsOhOZO
        gVnzevApMXI6Exee+SCa8pbSfptyg9zbX+Uif/N2ht6+01TqZOkhhLrzknwxUvRa321Avy
        6GFr2WDVrqpwuPmrjIYIDIUhghQ8a0A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-fAc5w0J4OSSZjkWxIQA8vg-1; Fri, 26 May 2023 05:55:47 -0400
X-MC-Unique: fAc5w0J4OSSZjkWxIQA8vg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a341efd9aso69853866b.0
        for <linux-efi@vger.kernel.org>; Fri, 26 May 2023 02:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685094946; x=1687686946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYCtA4RZQ08M+9pUkzTh3dY/9or9x6h7PoJOQ6GY4XM=;
        b=KZN5CLHQ0PxT/z6i8na/JWVh8XN2AcouQ5lyEQDsGOJlI/oUsnKryN7rAVB9ZQ9WRm
         7KFhY1XPkhRGuyj+qpwzd4yjoE203VaObGcgly1VeAUFZjIQw5/q6wYzmfEjuKfiHDLb
         oOb0l6KsNnnjThq5UXVTrJC4pT22KeGIgT1AF60ChzBPm9WWDi9tOevs17FjLIGXmBxG
         SYpC0K/ucE2rFzajphuu0UHsUdQ5vxbqRVpj6rL3Wm0u9oSqMDlch7Cyls6Wy2c8tIe4
         qoejcBQH3nFWrJ07jbDVOeWaxvt7TbxnT0WSLSeutKRQnW3f7D6QDvh9416jN8gIMLhe
         IK1Q==
X-Gm-Message-State: AC+VfDwxh15gSkzdtjpfXtQ7pef+G+5g6hOFOC4J+zIMZqVZ/ZkdssCu
        kQWY+M1K1DCMF+5kwtJw8VfS/7MElwIclhgqaQI6wwxhQ/fR5gdiOpypZiKpDGbAqPqDkFIDAgT
        vDtXqWETZB+gWs31URhCfikrk9fk8qiyca4SK
X-Received: by 2002:a17:906:58d3:b0:973:9522:c678 with SMTP id e19-20020a17090658d300b009739522c678mr1369554ejs.44.1685094946042;
        Fri, 26 May 2023 02:55:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zyHI44awmTn8JJhvOigbX6gmkA/LYXh0At/QzSDwuoAqvtAV8YEuh0jwMPf9fYx86u8OL8wESu6iTQJ2/QyM=
X-Received: by 2002:a17:906:58d3:b0:973:9522:c678 with SMTP id
 e19-20020a17090658d300b009739522c678mr1369536ejs.44.1685094945667; Fri, 26
 May 2023 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230525094914.23420-1-ltao@redhat.com> <ZHAwpL3wbKX9sWep@MiWiFi-R3L-srv>
In-Reply-To: <ZHAwpL3wbKX9sWep@MiWiFi-R3L-srv>
From:   Tao Liu <ltao@redhat.com>
Date:   Fri, 26 May 2023 17:55:09 +0800
Message-ID: <CAO7dBbWhE3yqGk1szKF-7rH1Gk6uAEnLuMVCqqCwwctcrvpiNw@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Baoquan,

On Fri, May 26, 2023 at 12:08=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Tao,
>
> On 05/25/23 at 05:49pm, Tao Liu wrote:
> > A kexec kernel bootup hang is observed on Intel Atom cpu due to unmappe=
d
> > EFI config table.
> >
> > Currently EFI system table is identity-mapped for the kexec kernel, but=
 EFI
> > config table is not mapped explicitly:
> >
> >     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
> >                           tables to the ident map")
> >
> > Later in the following 2 commits, EFI config table will be accessed whe=
n
> > enabling sev at kernel startup. This may result in a page fault due to =
EFI
> > config table's unmapped address. Since the page fault occurs at an earl=
y
> > stage, it is unrecoverable and kernel hangs.
> >
> >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME featu=
res
> >                           earlier during boot")
> >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> >                           detection/setup")
> >
> > In addition, the issue doesn't appear on all systems, because the kexec
> > kernel uses Page Size Extension (PSE) for identity mapping. In most cas=
es,
> > EFI config table can end up to be mapped into due to 1 GB page size.
> > However if nogbpages is set, or cpu doesn't support pdpe1gb feature
> > (e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
> > due to 2 MB page size, thus a page fault hang is more likely to happen.
> >
> > In this patch, we will make sure the EFI config table is always mapped.
>
> Nice work. While you may need to rephrase above sentence, x86
> maintainers don't like log with the 'this patch,' or 'we'. Please refer
> to 'Changelog' part of Documentation/process/maintainer-tip.rst and
> improve it.

OK, Thanks for the suggestion! I will get the sentence rephrased in v2.

>
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machi=
ne_kexec_64.c
> > index 1a3e2c05a8a5..755aa12f583f 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -28,6 +28,7 @@
> >  #include <asm/setup.h>
> >  #include <asm/set_memory.h>
> >  #include <asm/cpu.h>
> > +#include <asm/efi.h>
> >
> >  #ifdef CONFIG_ACPI
> >  /*
> > @@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_load=
ers[] =3D {
> >  #endif
> >
> >  static int
> > -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> > +map_efi_sys_cfg_tab(struct x86_mapping_info *info, pgd_t *level4p)
>
> Can we call the function map_efi_tables() since we will map efi system
> table, system config table. If you need add another table mapping here,
> what would you call it, map_efi_sys_cfg_xxx_tab()?
>

Yeah, map_efi_sys_cfg_xxx_tab() is surely a bad name. I agree with the
map_efi_tables() name.

Thanks,
Tao Liu

> Anyway, not very strong opinion as long as x86 maintainer likes it.
>
> >  {
> >  #ifdef CONFIG_EFI
> >       unsigned long mstart, mend;
> > +     void *kaddr;
> > +     int ret;
> >
> >       if (!efi_enabled(EFI_BOOT))
> >               return 0;
> > @@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_=
t *level4p)
> >       if (!mstart)
> >               return 0;
> >
> > +     ret =3D kernel_ident_mapping_init(info, level4p, mstart, mend);
> > +     if (ret)
> > +             return ret;
> > +
> > +     kaddr =3D memremap(mstart, mend - mstart, MEMREMAP_WB);
> > +     if (!kaddr) {
> > +             pr_err("Could not map UEFI system table\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     mstart =3D efi_config_table;
> > +
> > +     if (efi_enabled(EFI_64BIT)) {
> > +             efi_system_table_64_t *stbl =3D (efi_system_table_64_t *)=
kaddr;
> > +
> > +             mend =3D mstart + sizeof(efi_config_table_64_t) * stbl->n=
r_tables;
> > +     } else {
> > +             efi_system_table_32_t *stbl =3D (efi_system_table_32_t *)=
kaddr;
> > +
> > +             mend =3D mstart + sizeof(efi_config_table_32_t) * stbl->n=
r_tables;
> > +     }
> > +
> > +     memunmap(kaddr);
> > +
> >       return kernel_ident_mapping_init(info, level4p, mstart, mend);
> >  #endif
> >       return 0;
> > @@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, uns=
igned long start_pgtable)
> >       }
> >
> >       /*
> > -      * Prepare EFI systab and ACPI tables for kexec kernel since they=
 are
> > -      * not covered by pfn_mapped.
> > +      * Prepare EFI systab, config table and ACPI tables for kexec ker=
nel
> > +      * since they are not covered by pfn_mapped.
> >        */
> > -     result =3D map_efi_systab(&info, level4p);
> > +     result =3D map_efi_sys_cfg_tab(&info, level4p);
> >       if (result)
> >               return result;
> >
> > --
> > 2.33.1
> >
>

