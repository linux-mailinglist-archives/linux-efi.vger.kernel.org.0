Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054E74A968
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 05:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGGDk2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jul 2023 23:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGGDk1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jul 2023 23:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5671FC9
        for <linux-efi@vger.kernel.org>; Thu,  6 Jul 2023 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688701177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbeIWKt/ZhH8gtM0LHJ3D85O5R0ToQZ4nVPoPoLDodA=;
        b=A2B37ZFxvbMXZhdvqsidL5Pnrqqxlaew7hngH6XwrcTlHQzhYxHDz+yicKL2An5Eemo4Sd
        Uy51SdTVs/l+tvTPsvWP35lRRjfDVFcRzEuAkpO3txH41dhTwlTfD4uDqsOlLCgIpnHgCt
        XeERWZNYVnVhTkpi/aJqk7ZlMDgyIr8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-14_81QCKMAis8IFNZ3eP4A-1; Thu, 06 Jul 2023 23:39:36 -0400
X-MC-Unique: 14_81QCKMAis8IFNZ3eP4A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51e2295e74eso974641a12.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Jul 2023 20:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688701175; x=1691293175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbeIWKt/ZhH8gtM0LHJ3D85O5R0ToQZ4nVPoPoLDodA=;
        b=EBO6lqttV4PoZP/DgxobCzF6EbWt5LIEZHK/MsTmWZz8DeV78yZs6pRThccOgspyEV
         6RN3aDVUTtUagu8fU6KiG5jhI+HKNKaYsXMU7yrABoXGZx+HTwmzteY1+1jFAPIXIGwq
         CJQjliRMNLPHWAar73YWqnUnw0RxWGqQJyoi7NK1IxXikgNL2TNPbzzhCs4t7fxOYRAC
         SvC6rMCycL1L5cXkOBU9dTWvtSP3SiuF8b2uGds8tkSvBNiN25sWDBWUIclqMHrixHY1
         s7YJvG2BbpvX719w7gmSCJZ+qwEMzrDqWBaRmKfYjKSYFtdX1vgZ/WrSBxL6EPd5eCn4
         Pu5w==
X-Gm-Message-State: ABy/qLa5wVlTjN8hQYfB0AMttyTaKfTUXLdtQ6c3Ftxq9qVwUaBX0e4c
        4X4N/CYxJGTT94TlxHdOowsIMcIkZglDw50FYZjaFYdfevnDPj07hA0/rp9CKlUIlkY2NUSvajr
        dj+KlncStQREtaimj4l2RxF6yhDztqFU7plwZ
X-Received: by 2002:aa7:cd92:0:b0:51e:164c:b67e with SMTP id x18-20020aa7cd92000000b0051e164cb67emr3108130edv.0.1688701175523;
        Thu, 06 Jul 2023 20:39:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWJlmOujAltt/uzXw3YCGTJt7vhiRKcD5tJ9CGfoQeyq9yhSziGesjZchBVi/vAgucC8Sy47azag+xCNS8lsY=
X-Received: by 2002:aa7:cd92:0:b0:51e:164c:b67e with SMTP id
 x18-20020aa7cd92000000b0051e164cb67emr3108117edv.0.1688701175176; Thu, 06 Jul
 2023 20:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
In-Reply-To: <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
From:   Tao Liu <ltao@redhat.com>
Date:   Fri, 7 Jul 2023 11:38:59 +0800
Message-ID: <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Borislav,

Thanks for the patch review!

On Thu, Jul 6, 2023 at 1:34=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > A kexec kernel bootup hang is observed on Intel Atom cpu due to unmappe=
d
>
> s/cpu/CPU/g
>
> > EFI config table.
> >
> > Currently EFI system table is identity-mapped for the kexec kernel, but=
 EFI
> > config table is not mapped explicitly:
>
> Why does the EFI config table *need* to be mapped explicitly?
>
> >     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
> >                           tables to the ident map")
> >
> > Later in the following 2 commits, EFI config table will be accessed whe=
n
> > enabling sev at kernel startup.
>
> What does SEV have to do with an Intel problem?

For the 2 questions above. The call stack is follows:

head_64.S:.Lon_kernel_cs(which is before extract_kernel) -> sev_enable
-> snp_init -> find_cc_blob -> find_cc_blob_efi. No matter what cpu,
with CONFIG_AMD_MEM_ENCRYPT enabled, all will enter sev_enable() and
go through these functions. I assume it is harmless for Intel cpu,
normally just exit if sev enable conditions not met. However the efi
config table will be iterated in find_cc_blob_efi(), in order to find
if there is EFI_CC_BLOB_GUID(Confidential Computing blob) in the
vendor table.

>
> > This may result in a page fault due to EFI
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
>
> This doesn't answer my question above.

Currently the efi config table is not explicitly ident mapped for 2nd
kernel. In a few "unlucky" cases, 2nd kernel will page fault during
find_cc_blob_efi() and unrecoverable, but for most cases, it is
"lucky" with no problem because PSE and pdpe1gb can make config table
mapped into when ident mapping something else.

>
> > This patch will make sure the EFI config table is always mapped.
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.

Thanks, I will get it improved in v3.

>
>
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
>
> Yeah, about this, did you see efi_reuse_config() and the comment above
> it especially?
>
> Or is it that the EFI in that box wants the config table mapped 1:1 and
> accesses it during boot/kexec?

The call stack shows the page fault issue is before the 2nd kernel
extract, which is earlier than what efi_reuse_config() does for kernel
init.

Thanks,
Tao Liu
>
> In any case, this is all cloudy without a proper root cause.
>
> Also, I'd like for Ard to have a look at this too.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

