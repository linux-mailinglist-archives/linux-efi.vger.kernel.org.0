Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D788C2694DF
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 20:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgINSa4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 14:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgINSav (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 14:30:51 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8838F2193E
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600108248;
        bh=hp2wD32HuoavSR68s651qlveHIifz3unzD/J/Ufs13I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9Op10LcLMZJ8Jtzex8xHX/N9ja1G4ATvDHYFAehtF101W2dF34eEotGRDq6HxUV8
         M9hbAs9vpXq2xZUZsWTgxZlJDvb25S1JEIF8pccw2r3mR6m4m6k67l9ksbp8UvMsez
         0VsszgoXHVHjlB4y8mrWn51owly0SB7GTSkWXx0Q=
Received: by mail-ot1-f49.google.com with SMTP id u25so814020otq.6
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 11:30:48 -0700 (PDT)
X-Gm-Message-State: AOAM530jq150vS2ARQO+KeZ0tOfcjkG+TCBOMPJeytVIbyIq6EbBVH0N
        EnA97XaHUrxGOPdUzxVAQHtI49H1DT6AFjaKuDI=
X-Google-Smtp-Source: ABdhPJw18FfkFXn0BsixUj1FdQ6AWgDIdh8Fe2Nb0T8kIRiGzC+50xX035MXAIxmhZ5Vf3rpHNXDSGRfc+fqmq5aTXM=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr9546580oto.90.1600108247771;
 Mon, 14 Sep 2020 11:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200912175105.2085299-1-nivedita@alum.mit.edu> <20200912175105.2085299-2-nivedita@alum.mit.edu>
 <DM6PR19MB26366FAF28A730412DC505EDFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB26366FAF28A730412DC505EDFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Sep 2020 21:30:36 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFueikQBrv1xS-Csz+kHfjA+diaZ4ut2FZSO9JXxBPPhA@mail.gmail.com>
Message-ID: <CAMj1kXFueikQBrv1xS-Csz+kHfjA+diaZ4ut2FZSO9JXxBPPhA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Sep 2020 at 19:57, Limonciello, Mario
<Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Arvind Sankar <nivedita@alum.mit.edu>
> > Sent: Saturday, September 12, 2020 12:51
> > To: Jacobo Pantoja
> > Cc: Limonciello, Mario; Ard Biesheuvel; Peter Jones; linux-efi
> > Subject: [RFC PATCH 1/2] efi/x86: Add a quirk to support command line
> > arguments on Dell EFI firmware
> >
> >
> > [EXTERNAL EMAIL]
> >
> > At least some versions of Dell EFI firmware pass the entire
> > EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
> > the loaded image.
> >
> > To handle this, add a quirk to check if the options look like a valid
> > EFI_LOAD_OPTION descriptor, and if so, use the OptionalData part as the
> > command line.
>
> I think it would be useful to document in the commit message the specifics
> of at least the failure reported by Jacobo (Precision T3620 FW 2.15.0).
>

Agreed.

> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Reported-by: Jacobo Pantoja <jacobopantoja@gmail.com>
> > Link: https://lore.kernel.org/linux-
> > efi/20200907170021.GA2284449@rani.riverdale.lan/
> > ---
> >  .../firmware/efi/libstub/efi-stub-helper.c    | 99 ++++++++++++++++++-
> >  drivers/firmware/efi/libstub/efistub.h        | 31 ++++++
> >  drivers/firmware/efi/libstub/file.c           |  5 +-
> >  3 files changed, 133 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index f735db55adc0..294958ff1ee6 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -238,6 +238,100 @@ efi_status_t efi_parse_options(char const *cmdline)
> >       return EFI_SUCCESS;
> >  }
> >
> > +/*
> > + * The EFI_LOAD_OPTION descriptor has the following layout:
> > + *   u32 Attributes;
> > + *   u16 FilePathListLength;
> > + *   u16 Description[];
> > + *   efi_device_path_protocol_t FilePathList[];
> > + *   u8 OptionalData[];
> > + *
> > + * This function validates and unpacks the variable-size data fields.
> > + */
> > +static
> > +bool efi_load_option_unpack(efi_load_option_unpacked_t *dest,
> > +                         const efi_load_option_t *src, size_t size)
> > +{
> > +
> > +     const void *pos;
> > +     u16 c;
> > +     efi_device_path_protocol_t header;
> > +     const efi_char16_t *description;
> > +     const efi_device_path_protocol_t *file_path_list;
>
> Should re-order to reverse xmas tree order.
>

We have no such requirement in the EFI subsystem.

> > +
> > +     if (size < offsetof(efi_load_option_t, variable_data))
> > +             return false;
> > +     pos = src->variable_data;
> > +     size -= offsetof(efi_load_option_t, variable_data);
> > +
> > +     if ((src->attributes & ~EFI_LOAD_OPTION_MASK) != 0)
> > +             return false;
> > +
> > +     /* Scan description. */
> > +     description = pos;
> > +     do {
> > +             if (size < sizeof(c))
> > +                     return false;
> > +             c = *(const u16 *)pos;
> > +             pos += sizeof(c);
> > +             size -= sizeof(c);
> > +     } while (c != L'\0');
> > +
> > +     /* Scan file_path_list. */
> > +     file_path_list = pos;
> > +     do {
> > +             if (size < sizeof(header))
> > +                     return false;
> > +             header = *(const efi_device_path_protocol_t *)pos;
> > +             if (header.length < sizeof(header))
> > +                     return false;
> > +             if (size < header.length)
> > +                     return false;
> > +             pos += header.length;
> > +             size -= header.length;
> > +     } while ((header.type != EFI_DEV_END_PATH && header.type !=
> > EFI_DEV_END_PATH2) ||
> > +              (header.sub_type != EFI_DEV_END_ENTIRE));
> > +     if (pos != (const void *)file_path_list + src->file_path_list_length)
> > +             return false;
> > +
> > +     dest->attributes = src->attributes;
> > +     dest->file_path_list_length = src->file_path_list_length;
> > +     dest->description = description;
> > +     dest->file_path_list = file_path_list;
> > +     dest->optional_data_size = size;
> > +     dest->optional_data = size ? pos : NULL;
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * At least some versions of Dell firmware pass the entire contents of the
> > + * Boot#### variable, i.e. the EFI_LOAD_OPTION descriptor, rather than just
> > the
> > + * OptionalData field.
> > + *
> > + * Detect this case and extract OptionalData.
> > + */
> > +void efi_apply_loadoptions_quirk(const void **load_options, int
> > *load_options_size)
> > +{
> > +     const efi_load_option_t *load_option = *load_options;
> > +     efi_load_option_unpacked_t load_option_unpacked;
> > +
> > +     if (!IS_ENABLED(CONFIG_X86))
> > +             return;
> > +     if (!load_option)
> > +             return;
> > +     if (*load_options_size < sizeof(*load_option))
> > +             return;
> > +     if ((load_option->attributes & ~EFI_LOAD_OPTION_BOOT_MASK) != 0)
> > +             return;
> > +
> > +     if (!efi_load_option_unpack(&load_option_unpacked, load_option,
> > *load_options_size))
> > +             return;
> > +
>
> In case this was ever to be attributed to a cause for someone to fail to
> boot, it may be useful to drop a pr_debug here that could be easily turned
> on.
>

Agree that adding a efi_info() here makes sense, not only for
potential failures, but also simply to have some confirmation that the
quirk is taking effect.

Note that I am not 100% convinced yet that we need this change to
begin with. How large is the intersection of the set of affected
systems and the set of systems that are likely to run future kernels
that carry this quirk?


> > +     *load_options = load_option_unpacked.optional_data;
> > +     *load_options_size = load_option_unpacked.optional_data_size;
> > +}
> > +
> >  /*
> >   * Convert the unicode UEFI command line to ASCII to pass to kernel.
> >   * Size of memory allocated return in *cmd_line_len.
> > @@ -247,12 +341,15 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int
> > *cmd_line_len)
> >  {
> >       const u16 *s2;
> >       unsigned long cmdline_addr = 0;
> > -     int options_chars = efi_table_attr(image, load_options_size) / 2;
> > +     int options_chars = efi_table_attr(image, load_options_size);
> >       const u16 *options = efi_table_attr(image, load_options);
> >       int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
> >       bool in_quote = false;
> >       efi_status_t status;
> >
> > +     efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
> > +     options_chars /= sizeof(*options);
> > +
> >       if (options) {
> >               s2 = options;
> >               while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
> > diff --git a/drivers/firmware/efi/libstub/efistub.h
> > b/drivers/firmware/efi/libstub/efistub.h
> > index 85050f5a1b28..589d07acb22d 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -688,6 +688,35 @@ union efi_load_file_protocol {
> >       } mixed_mode;
> >  };
> >
> > +typedef struct {
> > +     u32 attributes;
> > +     u16 file_path_list_length;
> > +     u8 variable_data[];
> > +     // efi_char16_t description[];
> > +     // efi_device_path_protocol_t file_path_list[];
> > +     // u8 optional_data[];
> > +} __packed efi_load_option_t;
> > +
> > +#define EFI_LOAD_OPTION_ACTIVE               0x0001U
> > +#define EFI_LOAD_OPTION_FORCE_RECONNECT      0x0002U
> > +#define EFI_LOAD_OPTION_HIDDEN               0x0008U
> > +#define EFI_LOAD_OPTION_CATEGORY     0x1f00U
> > +#define   EFI_LOAD_OPTION_CATEGORY_BOOT      0x0000U
> > +#define   EFI_LOAD_OPTION_CATEGORY_APP       0x0100U
> > +
> > +#define EFI_LOAD_OPTION_BOOT_MASK \
> > +     (EFI_LOAD_OPTION_ACTIVE|EFI_LOAD_OPTION_HIDDEN|EFI_LOAD_OPTION_CATEGORY)
> > +#define EFI_LOAD_OPTION_MASK
> > (EFI_LOAD_OPTION_FORCE_RECONNECT|EFI_LOAD_OPTION_BOOT_MASK)
> > +
> > +typedef struct {
> > +     u32 attributes;
> > +     u16 file_path_list_length;
> > +     const efi_char16_t *description;
> > +     const efi_device_path_protocol_t *file_path_list;
> > +     size_t optional_data_size;
> > +     const void *optional_data;
> > +} efi_load_option_unpacked_t;
> > +
> >  void efi_pci_disable_bridge_busmaster(void);
> >
> >  typedef efi_status_t (*efi_exit_boot_map_processing)(
> > @@ -730,6 +759,8 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
> >
> >  void efi_free(unsigned long size, unsigned long addr);
> >
> > +void efi_apply_loadoptions_quirk(const void **load_options, int
> > *load_options_size);
> > +
> >  char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
> >
> >  efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
> > diff --git a/drivers/firmware/efi/libstub/file.c
> > b/drivers/firmware/efi/libstub/file.c
> > index 630caa6b1f4c..4e81c6077188 100644
> > --- a/drivers/firmware/efi/libstub/file.c
> > +++ b/drivers/firmware/efi/libstub/file.c
> > @@ -136,7 +136,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t
> > *image,
> >                                 unsigned long *load_size)
> >  {
> >       const efi_char16_t *cmdline = image->load_options;
> > -     int cmdline_len = image->load_options_size / 2;
> > +     int cmdline_len = image->load_options_size;
> >       unsigned long efi_chunk_size = ULONG_MAX;
> >       efi_file_protocol_t *volume = NULL;
> >       efi_file_protocol_t *file;
> > @@ -148,6 +148,9 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t
> > *image,
> >       if (!load_addr || !load_size)
> >               return EFI_INVALID_PARAMETER;
> >
> > +     efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
> > +     cmdline_len /= sizeof(*cmdline);
> > +
> >       if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
> >               efi_chunk_size = EFI_READ_CHUNK_SIZE;
> >
> > --
> > 2.26.2
>
