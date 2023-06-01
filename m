Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E552471957F
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jun 2023 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjFAI1G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jun 2023 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjFAI1A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Jun 2023 04:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77463E2
        for <linux-efi@vger.kernel.org>; Thu,  1 Jun 2023 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685607970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzamysyMQrXM2G/k2OexOLkxj2XMsJJyutAVuKEvN7A=;
        b=Gi1cq+f/rKKsrlZpkx7knZADi3K/iFp1GgP+Jev3ibt5AVzxisKEpKtfjbPIQ1wLBC4OiP
        rXr2xfvyJPjsEsuc7WlHvd+GHQgcsQfzrMYo8/Oeiwy761xWjn6T9Ltw5rAVQ1lje/YRa6
        pnO9psdVrExdApjnZRa45tvntBCR6MU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-lO7A0zs8MvW-UbhEMwOBjw-1; Thu, 01 Jun 2023 04:26:08 -0400
X-MC-Unique: lO7A0zs8MvW-UbhEMwOBjw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-96f6944c529so34012966b.2
        for <linux-efi@vger.kernel.org>; Thu, 01 Jun 2023 01:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607967; x=1688199967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzamysyMQrXM2G/k2OexOLkxj2XMsJJyutAVuKEvN7A=;
        b=gZYBgcf5lq0Rg3roZQ15tEK7WuPd2jAhkQ3gOWwj8hL5cf0yQsIzgD3ivuriX4TXL2
         V6fUWGrBXV3D/oLVijziDb+fqQlAE8TsOnetM+xFha8z2hW7ZzoEg5oC8/6zxZAQcbzx
         Kx0PJ7+ySCZqgwgWvEjdRDk+zOEu/PPtDToNesamSv88wT24px0IYNPpnuMJMy+PFmf1
         Iv+YBsvao7CVxW0OZxRLO4m2toWXcA7PrdlVmpydjjbSFtrwMSgdYQVF0/OIwwogAR0+
         zSXmubIPx86LeANCTDhkjfhpb2lO3rZ4vsdmCMoUYKbHscqrFmKOhior8tnY8DEjDLME
         hDRQ==
X-Gm-Message-State: AC+VfDwFkrBqkPGXn1HdTZRsAWLfZUCy14Mra1a8MzWaaqf8/TLaGwOM
        pRgWmG+O7aQKQ6Kf2EbxLVWn3MUP+L5CmWUJkCBSEMtFA7W/WWqy9MeRzko4Jj5IXetD0N+G+h2
        L/L+H4BpKXMLg0qFEYAmO7R6O2mvzL27vLbr2
X-Received: by 2002:a17:907:1ca2:b0:96b:1608:3563 with SMTP id nb34-20020a1709071ca200b0096b16083563mr7253950ejc.58.1685607967665;
        Thu, 01 Jun 2023 01:26:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Z/VwEnPjyGSKqfUflBU9/ovfi6znyKV8z4UMFz8tIFJ3bkPV3n5wUqi3rzVrrhn6dsjIBzc9jOQE560mDKJ8=
X-Received: by 2002:a17:907:1ca2:b0:96b:1608:3563 with SMTP id
 nb34-20020a1709071ca200b0096b16083563mr7253934ejc.58.1685607967405; Thu, 01
 Jun 2023 01:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <ZHhTDXpPqFL+3m5h@MiWiFi-R3L-srv>
In-Reply-To: <ZHhTDXpPqFL+3m5h@MiWiFi-R3L-srv>
From:   Tao Liu <ltao@redhat.com>
Date:   Thu, 1 Jun 2023 16:25:31 +0800
Message-ID: <CAO7dBbVXD+3tq_iQMKtX+Vw7csPfzPJdOWVduMENyO6i7p0b0w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Baoquan,

On Thu, Jun 1, 2023 at 4:13=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 06/01/23 at 03:20pm, Tao Liu wrote:
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
> > This patch will make sure the EFI config table is always mapped.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> > Changes in v2:
> > - Rephrase the change log based on Baoquan's suggestion.
> > - Rename map_efi_sys_cfg_tab() to map_efi_tables().
> > - Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-ltao=
@redhat.com/
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machi=
ne_kexec_64.c
> > index 1a3e2c05a8a5..664aefa6e896 100644
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
> > +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
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
>
> The code comment need be updated too?
>
>          * Prepare EFI tables and ACPI tables for kexec kernel since they=
 are
>          * not covered by pfn_mapped.
>
> Other than this nit, this patch looks good to me, thanks.
>

Thanks for the patch review! I'm OK with the comment update, but I
prefer to leave it as it is. Since the comment provides more details:
there are systab and config tables mapped instead of all efi tables.

Thanks,
Tao Liu

> Acked-by: Baoquan He <bhe@redhat.com>
>
>
> > +      * since they are not covered by pfn_mapped.
> >        */
> > -     result =3D map_efi_systab(&info, level4p);
> > +     result =3D map_efi_tables(&info, level4p);
> >       if (result)
> >               return result;
> >
> > --
> > 2.33.1
> >
>

