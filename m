Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC895F11BE
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiI3SnC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiI3SnB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 14:43:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6956F125186;
        Fri, 30 Sep 2022 11:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ECF6B82963;
        Fri, 30 Sep 2022 18:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FB5C433D7;
        Fri, 30 Sep 2022 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664563374;
        bh=n9d8fxGykif2j8j4F1jsMpGoXvGjd8rFgZONy58Z89w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oImJ3SVrV4qtHCa7McyX2vxcpImY8bcQz2VRQ3WJXyxbZb1c9yHyz6jge1CrH9umm
         l4UObWWzJk/u7yEhGUXV5UFQgGYPPkPbYREs1FGrMd++LZthzRYb/TBaGLBj8+hr2X
         lYYz+94fOyADOZakHkUJvBv17Nc6VvGmiz/34nFpsl2AaGyXd8Xzd0fgOgtDYvzr5h
         iH5gAsZwSlqXj8FP2+bd/1/3Cr7sDiigCJGTMN0wiovWKL7VEDXvXl8Ex3Poooa1NM
         pwGbSgPCKoUQu3xrV2vr8bGm6+SOO/FikzVh3Gg7MHyQAEfE/ZYqwV+8+FQzP+hyBD
         rNt6IO6rvCTzw==
Received: by mail-lf1-f52.google.com with SMTP id 10so8184507lfy.5;
        Fri, 30 Sep 2022 11:42:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf3xm34JMCXSNiyeXWoM/ZoxlU8eBYV14AxduePEwYMvx2Xw8FQC
        QBtKYV4HcO/WyL2cnq+f/WL5AZlrwSJpIJghccY=
X-Google-Smtp-Source: AMsMyM7CHH3GPZ0kxZJ2HbQZGpOplacL0pdSDamKzttlOPDQ9yS7xWVJ1bbSbuTtQSkczRLlrgOWyPTw1L13q1cMFqI=
X-Received: by 2002:a05:6512:3da0:b0:4a1:e17a:2305 with SMTP id
 k32-20020a0565123da000b004a1e17a2305mr3720927lfv.228.1664563372632; Fri, 30
 Sep 2022 11:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXH5tos5XVDUCcuEJG+fSNZBnY-xA1nb+Juu3H7AsM0DiQ@mail.gmail.com> <YzcypiqEzAXvuhKo@itl-email>
In-Reply-To: <YzcypiqEzAXvuhKo@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Sep 2022 20:42:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHKsO+uUQdK1DCsi=qGEh8CELXUwOQTiXohHVp5py04GQ@mail.gmail.com>
Message-ID: <CAMj1kXHKsO+uUQdK1DCsi=qGEh8CELXUwOQTiXohHVp5py04GQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Sept 2022 at 20:17, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Fri, Sep 30, 2022 at 06:25:53PM +0200, Ard Biesheuvel wrote:
> > On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_D=
ATA,
> > > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered b=
y
> > > Xen before Linux gets to start using it.  Therefore, Linux under Xen
> > > must not use EFI tables from such memory.  Most of the remaining EFI
> > > memory types are not suitable for EFI tables, leaving only
> > > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
> > > use tables that are located in one of these types of memory.
> > >
> > > This patch ensures this, and also adds a function
> > > (xen_config_table_memory_region_max()) that will be used later to
> > > replace the usage of the EFI memory map in esrt.c when running under
> > > Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c=
,
> > > but I have not implemented this.
> > >
> > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > ---
> > >  drivers/firmware/efi/efi.c |  8 +++++---
> > >  drivers/xen/efi.c          | 35 +++++++++++++++++++++++++++++++++++
> > >  include/linux/efi.h        |  9 +++++++++
> > >  3 files changed, 49 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index e4080ad96089abd7f84745dd8461c548bcbb7685..d344f3ff73d1c5ed0c67e=
3251a9502e66719741d 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -574,7 +574,6 @@ int __init efi_config_parse_tables(const efi_conf=
ig_table_t *config_tables,
> > >         unsigned long table;
> > >         int i;
> > >
> > > -       pr_info("");
> >
> > Why are you removing these prints?
>
> If I left them, I would need to include a pr_cont("\n") later.

There should always be one at the end of the loop, no? Or is this
related to the diagnostic that gets printed in your helper?

> Checkpatch recommends against that.  What is the purpose of this print?
> I assumed that since it prints an empty string it is superfluous.
>

It prints the leading [invisible] loglevel marker, and the 'efi: ' prefix.

> > >         for (i =3D 0; i < count; i++) {
> > >                 if (!IS_ENABLED(CONFIG_X86)) {
> > >                         guid =3D &config_tables[i].guid;
> > > @@ -585,7 +584,6 @@ int __init efi_config_parse_tables(const efi_conf=
ig_table_t *config_tables,
> > >
> > >                         if (IS_ENABLED(CONFIG_X86_32) &&
> > >                             tbl64[i].table > U32_MAX) {
> > > -                               pr_cont("\n");
> > >                                 pr_err("Table located above 4GB, disa=
bling EFI.\n");
> > >                                 return -EINVAL;
> > >                         }
> > > @@ -594,10 +592,14 @@ int __init efi_config_parse_tables(const efi_co=
nfig_table_t *config_tables,
> > >                         table =3D tbl32[i].table;
> > >                 }
> > >
> > > +#ifdef CONFIG_XEN_EFI
> >
> > We tend to prefer IS_ENABLED() for cases such as this one. That way,
> > the compiler always gets to see the code inside the conditional block,
> > which gives better build test coverage (even if CONFIG_XEN_EFI is
> > disabled).
>
> Can I count on the compiler eliminating the code as unreachable?  With
> CONFIG_XEN_EFI disabled xen_config_table_memory_region_max() would be an
> undefined symbol.
>

If you drop the #ifdef in the .h file (as I suggested below) the code
will compile fine, and the symbol reference will not be emitted into
the object, so it will link fine even if the Xen objects are not being
built.

We rely on this behavior all over the Linux kernel.

> > > +               if (efi_enabled(EFI_PARAVIRT) && !xen_config_table_me=
mory_region_max(table))
> >
> > So the question here is whether Xen thinks the table should be
> > disregarded or not. So let's define a prototype that reflects that
> > purpose, and let the implementation reason about how this should be
> > achieved.
>
> xen_config_table_memory_region_max() doesn=E2=80=99t just return whether =
the
> table should be disregarded, but also (if the table should not be
> ignored) the end of the memory region containing it.

But the calling code never uses that value, right?

> I will make
> xen_efi_config_table_valid() a wrapper around
> xen_config_table_memory_region_max(), as the former also needs to print
> a warning if the table is in an invalid location.
>
> > So
> >
> > if (IS_ENABLED(CONFIG_XEN_EFI) &&
> >     efi_enabled(EFI_PARAVIRT) &&
> >     xen_efi_config_table_valid(guid, table)
> >         continue
> >
> > I should note here, though, that EFI_PARAViRT is only set on x86 not
> > on other architectures that enable CONFIG_XEN_EFI so this will not
> > work anywhere else.
>
> What should I use instead?
>
> > > +                       continue;
> > > +#endif
> > > +
> > >                 if (!match_config_table(guid, table, common_tables) &=
& arch_tables)
> > >                         match_config_table(guid, table, arch_tables);
> > >         }
> > > -       pr_cont("\n");
> > >         set_bit(EFI_CONFIG_TABLES, &efi.flags);
> > >
> > >         if (efi_rng_seed !=3D EFI_INVALID_TABLE_ADDR) {
> > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > index d1ff2186ebb48a7c0981ecb6d4afcbbb25ffcea0..c2274ddfcc63304008ef0=
fd78fd9fa416f75d073 100644
> > > --- a/drivers/xen/efi.c
> > > +++ b/drivers/xen/efi.c
> > > @@ -28,6 +28,7 @@
> > >  #include <xen/interface/platform.h>
> > >  #include <xen/xen.h>
> > >  #include <xen/xen-ops.h>
> > > +#include <xen/page.h>
> > >
> > >  #include <asm/page.h>
> > >
> > > @@ -271,6 +272,40 @@ static void xen_efi_reset_system(int reset_type,=
 efi_status_t status,
> > >         }
> > >  }
> > >
> > > +__init u64 xen_config_table_memory_region_max(u64 addr)
> >
> > It is more idiomatic for Linux to put __init after the return type.
> > And if we adopt my suggestion above, this becomes
> >
> > bool __init xen_efi_config_table_valid(const efi_guid_t *guid, u64 tabl=
e)
> >
> > Alternatively, you could pass the string identifier of the table
> > instead of the guid (or both) to print in the diagnostic message.
>
> Will fix in v5.
>
> > > +{
> > > +       static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > > +                     "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_S=
HIFT");
> >
> > Is this the only place where this matters? And this never happens on x8=
6, right?
>
> My understanding is that it should never happen on any architecture.

EFI_PAGE_SHIFT is always 12, on any architecture and regardless of the
page size used by the OS itself. AFAICT, the same applies to
XEN_PAGE_SHIFT.

> That=E2=80=99s why I static_assert() it.  I have no idea if this is the o=
nly
> place it matters, though.
>

I don't mind adding this here, but it's kind of orthogonal to the rest
of the patch so please make a mention in the commit log why you are
adding it.

> > > +       struct xen_platform_op op =3D {
> > > +               .cmd =3D XENPF_firmware_info,
> > > +               .u.firmware_info =3D {
> > > +                       .type =3D XEN_FW_EFI_INFO,
> > > +                       .index =3D XEN_FW_EFI_MEM_INFO,
> > > +                       .u.efi_info.mem.addr =3D addr,
> > > +                       .u.efi_info.mem.size =3D U64_MAX - addr,
> > > +               }
> > > +       };
> > > +       union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_info=
;
> > > +       int rc =3D HYPERVISOR_platform_op(&op);
> > > +
> > > +       if (rc) {
> > > +               pr_warn("Failed to lookup header %llu in Xen memory m=
ap: error %d\n",
> > > +                       (unsigned long long)addr, rc);
> > > +               return 0;
> > > +       }
> > > +
> > > +       switch (info->mem.type) {
> > > +       case EFI_RUNTIME_SERVICES_CODE:
> > > +       case EFI_RUNTIME_SERVICES_DATA:
> > > +       case EFI_ACPI_RECLAIM_MEMORY:
> >
> > If we are listing all memory types that Xen preserves, you might add
> > EFI_RESERVED_MEMORY here. Otherwise, please only list the ones that
> > you need to permit explicitly.
>
> My understanding was that EFI_RESERVED_MEMORY should never be touched by
> the OS, so I left it out.  Which types would you permit?
>

Well, given the purpose of the function (i.e, to reject
EfiBootServicesData in spite of the spec), I'd only permit
EFI_ACPI_RECLAIM_MEMORY and EFI_RUNTIME_SERVICES_DATA. However, the
EFI spec does mention that prior versions permitted the reserved
memory type as well for ACPI and SMBIOS tables (although that may be a
very long time ago).

Bottom line is that you want to permit only regions that Xen is
guaranteed not to clobber, right? In any case, I'm not going to obsess
over this so if you prefer to keep it this way, that's also fine.


> > > +               return info->mem.addr + info->mem.size;
> > > +       default:
> > > +               pr_warn("Table %llu is in memory of type %d, ignoring=
 it\n",
> > > +                       (unsigned long long)addr, info->mem.type);
> > > +               return 0;
> > > +       }
> > > +}
> > > +
> > >  /*
> > >   * Set XEN EFI runtime services function pointers. Other fields of s=
truct efi,
> > >   * e.g. efi.systab, will be set like normal EFI.
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index d2b84c2fec39f0268324d1a38a73ed67786973c9..fc81e4b984398cdb399e7=
886b2cae7f33bf91613 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1324,4 +1324,13 @@ struct linux_efi_coco_secret_area {
> > >  /* Header of a populated EFI secret area */
> > >  #define EFI_SECRET_TABLE_HEADER_GUID   EFI_GUID(0x1e74f542, 0x71dd, =
0x4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
> > >
> > > +#ifdef CONFIG_XEN_EFI
> >
> > Please drop this #ifdef
>
> Will fix in v5.
>
> > > +/*
> > > + * Returns the end of the memory region containing the given config =
table,
> > > + * or 0 if the given address does not reside in memory that can vali=
dly
> > > + * contain EFI configuration tables.
> > > + */
> > > +__init u64 xen_config_table_memory_region_max(u64 addr);
> >
> > You can drop the __init here
>
> Will fix in v5.
>
> > > +#endif
> > > +
> > >  #endif /* _LINUX_EFI_H */
> > > --
> > > Sincerely,
> > > Demi Marie Obenour (she/her/hers)
> > > Invisible Things Lab
> > >
>
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
