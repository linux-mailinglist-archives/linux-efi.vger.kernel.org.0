Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5026C587
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIPRDB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgIPRBX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Sep 2020 13:01:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76739C0D9419
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 09:50:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so6493775ljg.9
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ygx/ZkCUBqAbD8KBKsoXijxVT4xms0GMWXWb+N6ApCg=;
        b=orPWngKT+kRO0chLc1iUAEyuBceQn3iiTSJ7zxqLWvHFWjItNgtsENnvgaaNoPFJYY
         4Shl0c6I/WsYpgKGxUD1Ce1gqLO1gxNgVFTSOmNj3Dedeu71Hgxn9hEsX0MGRCdVZz09
         7D6i2QeMTE1InMpoiqW1hTIxt1+UwJp8Y0gtloER4NjPGE68/Z84XJQBSl7xsvv+zBks
         LC7XqY51gANEGqflQeT7WzEJVi8Cw3/PygqY/6A7h41DYTfunBzK6x0azysKMhzcXTgs
         b2S0zx6vrH3w4lCTVi+pk1s6QTb3f7GC4minnNqTKCpgf05A9rvMsUNIQSJHe+94l9tR
         EvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ygx/ZkCUBqAbD8KBKsoXijxVT4xms0GMWXWb+N6ApCg=;
        b=GJuDj4oYAVcFZ+ShlGex0i+9CExPrP6NIhUNcybq5m7GepwatFRTW5crERvi1Uj7qU
         ObfP20HJ4DvjSgySSyQuuj4xhD1aUiD9Fy7Ugmh5dvtCHzFK9j9ckMuDbfwGi0DfPfRt
         gq+zFuQtEpZZ2509eslKtI9ri+k5TA28Tig3rn21nKGgY91cokts6cG15y3ouIVjL3R0
         q/xZ47yQTBB8MGMHEvXNSO3xa8iZsIU4Ea6CcssyUeMGiLoidLaNFeLID9zUo8SfpVH3
         0IbqHw1VGRFR+R4480QH04o2y5CJPYo61+8zdGAbNYgyOfmsdJrS6G8//3i3ex4cvZoi
         bh6Q==
X-Gm-Message-State: AOAM5319Z+XdX8Nt01mIZq8wrBeprVFnTZvCSNzl34XmqYVomJmKSmaH
        37NkEZijia4UJRj0I+5fw+R1KOWJgl1Qjcyh/z8=
X-Google-Smtp-Source: ABdhPJzyVkXNplfq1RAUGRKcnEWvzPjdXX/CbRCozd4j5ihBMwpbgXx8HLZ36t3HFSYBAOF/AzWwU8KAhpURggmBryQ=
X-Received: by 2002:a2e:3210:: with SMTP id y16mr9285315ljy.417.1600275026759;
 Wed, 16 Sep 2020 09:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200914213535.933454-1-nivedita@alum.mit.edu>
 <20200914213535.933454-2-nivedita@alum.mit.edu> <CAMj1kXHy4d6zEJhJtdkHyYx-jnhJJzJ4Xi+qyawhjg6hXhAQgw@mail.gmail.com>
In-Reply-To: <CAMj1kXHy4d6zEJhJtdkHyYx-jnhJJzJ4Xi+qyawhjg6hXhAQgw@mail.gmail.com>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Wed, 16 Sep 2020 18:50:15 +0200
Message-ID: <CAO18KQi9icju0YJ-dGe70NC8oFN0GL0hM1_fn8xE9dEkcrU_8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, I'd like to update my testing and share my thoughts.

Regarding the patches:
1) The patches in email 1/2 (the functions "efi_warn", etc.) are not working
properly. I got some suggestions for testing from Ard in a separate email.
  3a. If, in this 2nd patch, I switch the "efi_warn_once" with an
"efi_printk", the
  messages appear.
  1a. I've set CONFIG_CONSOLE_LOGLEVEL_DEFAULT=5, same result
  2a. I've switched from "efi_warn_once" to "efi_warn", same result.
2) Even if they would be working, since it is not logged anywhere, I
don't really
think these messages make sense. Idk if these can be made available to dmesg.
3) The function "efi_apply_loadoptions_quirk" is called twice, it seems to me
that calling it from the "file.c" is redundant, but probably I'm
missing something.

Regarding the quirk itself, in my opinion we should wait for Mario's
news, since,
again in my opinion, this is something that should be fixed in the
firmware itself.
Being Dell a serious company, I think it is feasible that, at least
for their enterprise
products, they might fix it.

On Tue, 15 Sep 2020 at 17:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 15 Sep 2020 at 00:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > At least some versions of Dell EFI firmware pass the entire
> > EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
> > the loaded image. This was verified with firmware revision 2.15.0 on a
> > Dell Precision T3620 by Jacobo Pontaja.

Please be so kind to correct my name, if it's being included in the commit msg.

> >
> > To handle this, add a quirk to check if the options look like a valid
> > EFI_LOAD_OPTION descriptor, and if so, use the OptionalData part as the
> > command line.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Reported-by: Jacobo Pantoja <jacobopantoja@gmail.com>
> > Link: https://lore.kernel.org/linux-efi/20200907170021.GA2284449@rani.riverdale.lan/
>
> I'll queue these up for v5.10
>
> Thanks all
>
> > ---
> >  .../firmware/efi/libstub/efi-stub-helper.c    | 101 +++++++++++++++++-
> >  drivers/firmware/efi/libstub/efistub.h        |  31 ++++++
> >  drivers/firmware/efi/libstub/file.c           |   5 +-
> >  3 files changed, 135 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index f735db55adc0..aa8da0a49829 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -238,6 +238,102 @@ efi_status_t efi_parse_options(char const *cmdline)
> >         return EFI_SUCCESS;
> >  }
> >
> > +/*
> > + * The EFI_LOAD_OPTION descriptor has the following layout:
> > + *     u32 Attributes;
> > + *     u16 FilePathListLength;
> > + *     u16 Description[];
> > + *     efi_device_path_protocol_t FilePathList[];
> > + *     u8 OptionalData[];
> > + *
> > + * This function validates and unpacks the variable-size data fields.
> > + */
> > +static
> > +bool efi_load_option_unpack(efi_load_option_unpacked_t *dest,
> > +                           const efi_load_option_t *src, size_t size)
> > +{
> > +       const void *pos;
> > +       u16 c;
> > +       efi_device_path_protocol_t header;
> > +       const efi_char16_t *description;
> > +       const efi_device_path_protocol_t *file_path_list;
> > +
> > +       if (size < offsetof(efi_load_option_t, variable_data))
> > +               return false;
> > +       pos = src->variable_data;
> > +       size -= offsetof(efi_load_option_t, variable_data);
> > +
> > +       if ((src->attributes & ~EFI_LOAD_OPTION_MASK) != 0)
> > +               return false;
> > +
> > +       /* Scan description. */
> > +       description = pos;
> > +       do {
> > +               if (size < sizeof(c))
> > +                       return false;
> > +               c = *(const u16 *)pos;
> > +               pos += sizeof(c);
> > +               size -= sizeof(c);
> > +       } while (c != L'\0');
> > +
> > +       /* Scan file_path_list. */
> > +       file_path_list = pos;
> > +       do {
> > +               if (size < sizeof(header))
> > +                       return false;
> > +               header = *(const efi_device_path_protocol_t *)pos;
> > +               if (header.length < sizeof(header))
> > +                       return false;
> > +               if (size < header.length)
> > +                       return false;
> > +               pos += header.length;
> > +               size -= header.length;
> > +       } while ((header.type != EFI_DEV_END_PATH && header.type != EFI_DEV_END_PATH2) ||
> > +                (header.sub_type != EFI_DEV_END_ENTIRE));
> > +       if (pos != (const void *)file_path_list + src->file_path_list_length)
> > +               return false;
> > +
> > +       dest->attributes = src->attributes;
> > +       dest->file_path_list_length = src->file_path_list_length;
> > +       dest->description = description;
> > +       dest->file_path_list = file_path_list;
> > +       dest->optional_data_size = size;
> > +       dest->optional_data = size ? pos : NULL;
> > +
> > +       return true;
> > +}
> > +
> > +/*
> > + * At least some versions of Dell firmware pass the entire contents of the
> > + * Boot#### variable, i.e. the EFI_LOAD_OPTION descriptor, rather than just the
> > + * OptionalData field.
> > + *
> > + * Detect this case and extract OptionalData.
> > + */
> > +void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size)
> > +{
> > +       const efi_load_option_t *load_option = *load_options;
> > +       efi_load_option_unpacked_t load_option_unpacked;
> > +
> > +       if (!IS_ENABLED(CONFIG_X86))
> > +               return;
> > +       if (!load_option)
> > +               return;
> > +       if (*load_options_size < sizeof(*load_option))
> > +               return;
> > +       if ((load_option->attributes & ~EFI_LOAD_OPTION_BOOT_MASK) != 0)
> > +               return;
> > +
> > +       if (!efi_load_option_unpack(&load_option_unpacked, load_option, *load_options_size))
> > +               return;
> > +
> > +       efi_warn_once(FW_BUG "LoadOptions is an EFI_LOAD_OPTION descriptor\n");
> > +       efi_warn_once(FW_BUG "Using OptionalData as a workaround\n");
> > +
> > +       *load_options = load_option_unpacked.optional_data;
> > +       *load_options_size = load_option_unpacked.optional_data_size;
> > +}
> > +
> >  /*
> >   * Convert the unicode UEFI command line to ASCII to pass to kernel.
> >   * Size of memory allocated return in *cmd_line_len.
> > @@ -247,12 +343,15 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
> >  {
> >         const u16 *s2;
> >         unsigned long cmdline_addr = 0;
> > -       int options_chars = efi_table_attr(image, load_options_size) / 2;
> > +       int options_chars = efi_table_attr(image, load_options_size);
> >         const u16 *options = efi_table_attr(image, load_options);
> >         int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
> >         bool in_quote = false;
> >         efi_status_t status;
> >
> > +       efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
> > +       options_chars /= sizeof(*options);
> > +
> >         if (options) {
> >                 s2 = options;
> >                 while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index e33b9395bc23..7997890c756d 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -711,6 +711,35 @@ union efi_load_file_protocol {
> >         } mixed_mode;
> >  };
> >
> > +typedef struct {
> > +       u32 attributes;
> > +       u16 file_path_list_length;
> > +       u8 variable_data[];
> > +       // efi_char16_t description[];
> > +       // efi_device_path_protocol_t file_path_list[];
> > +       // u8 optional_data[];
> > +} __packed efi_load_option_t;
> > +
> > +#define EFI_LOAD_OPTION_ACTIVE         0x0001U
> > +#define EFI_LOAD_OPTION_FORCE_RECONNECT        0x0002U
> > +#define EFI_LOAD_OPTION_HIDDEN         0x0008U
> > +#define EFI_LOAD_OPTION_CATEGORY       0x1f00U
> > +#define   EFI_LOAD_OPTION_CATEGORY_BOOT        0x0000U
> > +#define   EFI_LOAD_OPTION_CATEGORY_APP 0x0100U
> > +
> > +#define EFI_LOAD_OPTION_BOOT_MASK \
> > +       (EFI_LOAD_OPTION_ACTIVE|EFI_LOAD_OPTION_HIDDEN|EFI_LOAD_OPTION_CATEGORY)
> > +#define EFI_LOAD_OPTION_MASK (EFI_LOAD_OPTION_FORCE_RECONNECT|EFI_LOAD_OPTION_BOOT_MASK)
> > +
> > +typedef struct {
> > +       u32 attributes;
> > +       u16 file_path_list_length;
> > +       const efi_char16_t *description;
> > +       const efi_device_path_protocol_t *file_path_list;
> > +       size_t optional_data_size;
> > +       const void *optional_data;
> > +} efi_load_option_unpacked_t;
> > +
> >  void efi_pci_disable_bridge_busmaster(void);
> >
> >  typedef efi_status_t (*efi_exit_boot_map_processing)(
> > @@ -753,6 +782,8 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
> >
> >  void efi_free(unsigned long size, unsigned long addr);
> >
> > +void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size);
> > +
> >  char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
> >
> >  efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
> > diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> > index 630caa6b1f4c..4e81c6077188 100644
> > --- a/drivers/firmware/efi/libstub/file.c
> > +++ b/drivers/firmware/efi/libstub/file.c
> > @@ -136,7 +136,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
> >                                   unsigned long *load_size)
> >  {
> >         const efi_char16_t *cmdline = image->load_options;
> > -       int cmdline_len = image->load_options_size / 2;
> > +       int cmdline_len = image->load_options_size;
> >         unsigned long efi_chunk_size = ULONG_MAX;
> >         efi_file_protocol_t *volume = NULL;
> >         efi_file_protocol_t *file;
> > @@ -148,6 +148,9 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
> >         if (!load_addr || !load_size)
> >                 return EFI_INVALID_PARAMETER;
> >
> > +       efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
> > +       cmdline_len /= sizeof(*cmdline);
> > +
> >         if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
> >                 efi_chunk_size = EFI_READ_CHUNK_SIZE;
> >
> > --
> > 2.26.2
> >
