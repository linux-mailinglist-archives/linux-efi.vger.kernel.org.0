Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECA70F8CE
	for <lists+linux-efi@lfdr.de>; Wed, 24 May 2023 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjEXOdm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 May 2023 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEXOdl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 May 2023 10:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30212E;
        Wed, 24 May 2023 07:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37DD361D20;
        Wed, 24 May 2023 14:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B1C4339B;
        Wed, 24 May 2023 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684938819;
        bh=el9GVKwiEEBQvl/Zcxv1NEN5YF4SLPbIGLfBbaOnmy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LlD2S7BDrKjNEiIiCb1hPAlILLHSZJA+asWXMoFyrQ5fxzEi/Skvq7+N10Vd7n8IO
         6jXzds53NUgBK2J8B9N5CiHQcrasxNa/4VllJndLdf5okhZvJZO81eYdhca2w1RGxS
         mGtxNG6riRrKj9jyzK/A82N5aYdFeH1DSnactrP6Q4bzG8XW864TH+s1AkEEreTmn5
         oVTG3rGoxriXXIngdNkPj/owYiNKo+ZTiZEV3fh5fGhUhIUSYOs5FXSDQ1RFG96Fhw
         7gA9F74gr3kPRYjWXeUylJTufT8qGtoNFSi3gYbY5NYJaFdCZM6EyVQI8855+sbyPU
         pNURMFs75uQuw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4effb818c37so1001306e87.3;
        Wed, 24 May 2023 07:33:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDzWlIAu0BN8b5TBNv8+uVY3KJhceks7969KMkihcgdLHWBUdq2S
        W3ktjOiPZ7+IQTwG9rz5lBeqUYR1lWMfDoMmaFc=
X-Google-Smtp-Source: ACHHUZ5JFRR0fIj/N/Vv7IpEYUT6MLMFuuxe63DL5a/YATPNXfq4LUBdVi5rxccdkQkIA6hk0h3UtkmfQWi/K5AKCrE=
X-Received: by 2002:a05:6512:962:b0:4f1:43ad:7fac with SMTP id
 v2-20020a056512096200b004f143ad7facmr5096662lft.17.1684938817498; Wed, 24 May
 2023 07:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230523190226.3860727-1-arnd@kernel.org> <CAJZ5v0grS85Vk6MM9kgHaSp4ta5osdOLSSgc2OiFG0Gev=CynQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0grS85Vk6MM9kgHaSp4ta5osdOLSSgc2OiFG0Gev=CynQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 May 2023 16:33:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFwK0mSOGZQ8P5+yY4KPA7NGL6M8OJHSDA4rv6tT_BFfA@mail.gmail.com>
Message-ID: <CAMj1kXFwK0mSOGZQ8P5+yY4KPA7NGL6M8OJHSDA4rv6tT_BFfA@mail.gmail.com>
Subject: Re: [PATCH] [v2] efi: fix missing prototype warnings
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 24 May 2023 at 16:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, May 23, 2023 at 9:02=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The cper.c file needs to include an extra header, and efi_zboot_entry
> > needs an extern declaration to avoid these 'make W=3D1' warnings:
> >
> > drivers/firmware/efi/libstub/zboot.c:65:1: error: no previous prototype=
 for 'efi_zboot_entry' [-Werror=3Dmissing-prototypes]
> > drivers/firmware/efi/efi.c:176:16: error: no previous prototype for 'ef=
i_attr_is_visible' [-Werror=3Dmissing-prototypes]
> > drivers/firmware/efi/cper.c:626:6: error: no previous prototype for 'cp=
er_estatus_print' [-Werror=3Dmissing-prototypes]
> > drivers/firmware/efi/cper.c:649:5: error: no previous prototype for 'cp=
er_estatus_check_header' [-Werror=3Dmissing-prototypes]
> > drivers/firmware/efi/cper.c:662:5: error: no previous prototype for 'cp=
er_estatus_check' [-Werror=3Dmissing-prototypes]
> >
> > To make this easier, move the cper specific declarations to
> > include/linux/cper.h.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> For the APEI change:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>

Thanks - I'll queue this up.


> > ---
> > v2: move the prototypes rather than including a file in a different
> > subdir
> > ---
> >  drivers/acpi/apei/apei-internal.h      | 6 ------
> >  drivers/acpi/apei/bert.c               | 1 +
> >  drivers/firmware/efi/libstub/efistub.h | 3 +++
> >  include/linux/cper.h                   | 6 ++++++
> >  include/linux/efi.h                    | 2 ++
> >  5 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei=
-internal.h
> > index 1d6ef9654725..67c2c3b959e1 100644
> > --- a/drivers/acpi/apei/apei-internal.h
> > +++ b/drivers/acpi/apei/apei-internal.h
> > @@ -7,7 +7,6 @@
> >  #ifndef APEI_INTERNAL_H
> >  #define APEI_INTERNAL_H
> >
> > -#include <linux/cper.h>
> >  #include <linux/acpi.h>
> >
> >  struct apei_exec_context;
> > @@ -130,10 +129,5 @@ static inline u32 cper_estatus_len(struct acpi_hes=
t_generic_status *estatus)
> >                 return sizeof(*estatus) + estatus->data_length;
> >  }
> >
> > -void cper_estatus_print(const char *pfx,
> > -                       const struct acpi_hest_generic_status *estatus)=
;
> > -int cper_estatus_check_header(const struct acpi_hest_generic_status *e=
status);
> > -int cper_estatus_check(const struct acpi_hest_generic_status *estatus)=
;
> > -
> >  int apei_osc_setup(void);
> >  #endif
> > diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> > index c23eb75866d0..7514e38d5640 100644
> > --- a/drivers/acpi/apei/bert.c
> > +++ b/drivers/acpi/apei/bert.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/acpi.h>
> > +#include <linux/cper.h>
> >  #include <linux/io.h>
> >
> >  #include "apei-internal.h"
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/=
efi/libstub/efistub.h
> > index 67d5a20802e0..54a2822cae77 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -1133,4 +1133,7 @@ const u8 *__efi_get_smbios_string(const struct ef=
i_smbios_record *record,
> >  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
> >                      unsigned long code_size);
> >
> > +asmlinkage efi_status_t __efiapi
> > +efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
> > +
> >  #endif
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index eacb7dd7b3af..c1a7dc325121 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -572,4 +572,10 @@ void cper_print_proc_ia(const char *pfx,
> >  int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)=
;
> >  int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg=
);
> >
> > +struct acpi_hest_generic_status;
> > +void cper_estatus_print(const char *pfx,
> > +                       const struct acpi_hest_generic_status *estatus)=
;
> > +int cper_estatus_check_header(const struct acpi_hest_generic_status *e=
status);
> > +int cper_estatus_check(const struct acpi_hest_generic_status *estatus)=
;
> > +
> >  #endif
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index bed3c92cbc31..120af31a5136 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1349,4 +1349,6 @@ bool efi_config_table_is_usable(const efi_guid_t =
*guid, unsigned long table)
> >         return xen_efi_config_table_is_usable(guid, table);
> >  }
> >
> > +umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *at=
tr, int n);
> > +
> >  #endif /* _LINUX_EFI_H */
> > --
> > 2.39.2
> >
