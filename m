Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46064706F30
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEQRRu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 13:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQRRt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 13:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F540E5;
        Wed, 17 May 2023 10:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F55063A19;
        Wed, 17 May 2023 17:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F2C433AA;
        Wed, 17 May 2023 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684343866;
        bh=ErTs2NiRHbpeeRXWKhTdBGrEoF7hZR6iDkEby2P5O1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qXMK9Xn+ujHLceW0GDROzRsCVgW2DTxvHbrNmpQFUkllgvbvJuDSa17AjTbnZE29p
         YpfsrzRqvf2ko/HJjROTE39A9kaz9iVb+s67V3h0clE9+abw9QKNGFw90VwYU+/eN2
         ssxrOsVhDw4rNyzK2Q+E1N4XAN+3urPPtXN/ndvAEZQGKHVaoNlrk4PDQY1c6RzZx3
         mvl/lirs3ZFKGXjoMCiLVtfqI/SyVIVwpTmj5++dBEMmSjCVViMIQ613lHtVVpmgue
         lgpZBPZK5cA2xONumtZ7p3lV6ZyZqyRp9Mb6Tx4CfyzUNUp/gE5RtjgBWJPqVZshlK
         Fo4UfpDW2ty7Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso1342939e87.0;
        Wed, 17 May 2023 10:17:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDzfBBKCJD4lFuoFc8YDbe429hqiyKh7TXZrbXn7VKDqD12Q4ANM
        tBVVbuS1HKWhzxaWQbVbgbXsuNL95zmU8GkESfg=
X-Google-Smtp-Source: ACHHUZ7hjiPlfmJ4fd5LA+ijEeVkQnxqnIy9ecroPhUAbdorcz+8joMwXm5VQFLXLTJQXJfkQO29kZngct25alejZBI=
X-Received: by 2002:ac2:4c02:0:b0:4ed:d216:8217 with SMTP id
 t2-20020ac24c02000000b004edd2168217mr470621lfq.11.1684343864675; Wed, 17 May
 2023 10:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230517153812.2010174-1-anisse@astier.eu>
In-Reply-To: <20230517153812.2010174-1-anisse@astier.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 May 2023 19:17:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgRpEjxXFk5TZSwtCYC1_0Ph+ZrS71=JKbNcvV08xFSA@mail.gmail.com>
Message-ID: <CAMj1kXHgRpEjxXFk5TZSwtCYC1_0Ph+ZrS71=JKbNcvV08xFSA@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: expose used and total size
To:     Anisse Astier <anisse@astier.eu>
Cc:     linux-efi@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anisse Astier <an.astier@criteo.com>, lennart@poettering.net,
        Richard Hughes <hughsient@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 May 2023 at 17:38, Anisse Astier <anisse@astier.eu> wrote:
>
> From: Anisse Astier <an.astier@criteo.com>
>
> When writing EFI variables, one might get errors with no other message
> on why it fails. Being able to see how much is used by EFI variables
> helps analyzing such issues.
>
> Since this is not a conventionnal filesystem, block size is
> intentionnally set to 1 instead of PAGE_SIZE.
>
> x86 quirks of reserved size are taken into account; so that available
> and free size can be different, further helping debugging space issues.
>
> With this patch, one can see the remaining space in EFI variable storage
> via efivarfs, like this:
>
>    $ df -h /sys/firmware/efi/efivars/
>    Filesystem      Size  Used Avail Use% Mounted on
>    efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars
>
> Signed-off-by: Anisse Astier <an.astier@criteo.com>

Thanks - I've queued this up now for v6.5

> ---
> Notes:
>
> Patch isn't split per subsystem intentionally, for better understanding
> of intent; I don't think it's necessary, but split could be trivial in
> an another version.
>
> Changes since v1:
>  - update commit message to show how it can be used in userspace
>  - add comments to explain the values put in f_bsize, f_blocks, f_bfree
>    and f_bavail
>  - rebase on top v6.4-rc2
>
> Thanks to Christan Brauner for the review.
>
> Regards,
>
> Anisse
>
> ---
>  arch/x86/platform/efi/quirks.c |  8 ++++++++
>  drivers/firmware/efi/efi.c     |  1 +
>  drivers/firmware/efi/vars.c    | 12 ++++++++++++
>  fs/efivarfs/super.c            | 36 +++++++++++++++++++++++++++++++++-
>  include/linux/efi.h            | 10 ++++++++++
>  5 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index b0b848d6933a..587fa51230e2 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
>                                      EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
>  }
>
> +u64 efi_reserved_space(void)
> +{
> +       if (efi_no_storage_paranoia)
> +               return 0;
> +       return EFI_MIN_RESERVE;
> +}
> +EXPORT_SYMBOL_GPL(efi_reserved_space);
> +
>  /*
>   * In the nonblocking case we do not attempt to perform garbage
>   * collection if we do not have enough free space. Rather, we do the
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index abeff7dc0b58..d0dfa007bffc 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -211,6 +211,7 @@ static int generic_ops_register(void)
>         generic_ops.get_variable = efi.get_variable;
>         generic_ops.get_next_variable = efi.get_next_variable;
>         generic_ops.query_variable_store = efi_query_variable_store;
> +       generic_ops.query_variable_info = efi.query_variable_info;
>
>         if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
>                 generic_ops.set_variable = efi.set_variable;
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index bfc5fa6aa47b..e9dc7116daf1 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -245,3 +245,15 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>         return status;
>  }
>  EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
> +
> +efi_status_t efivar_query_variable_info(u32 attr,
> +                                       u64 *storage_space,
> +                                       u64 *remaining_space,
> +                                       u64 *max_variable_size)
> +{
> +       if (!__efivars->ops->query_variable_info)
> +               return EFI_UNSUPPORTED;
> +       return __efivars->ops->query_variable_info(attr, storage_space,
> +                       remaining_space, max_variable_size);
> +}
> +EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 482d612b716b..c27de959cb5b 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -13,6 +13,7 @@
>  #include <linux/ucs2_string.h>
>  #include <linux/slab.h>
>  #include <linux/magic.h>
> +#include <linux/statfs.h>
>
>  #include "internal.h"
>
> @@ -23,8 +24,41 @@ static void efivarfs_evict_inode(struct inode *inode)
>         clear_inode(inode);
>  }
>
> +static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +       u64 storage_space, remaining_space, max_variable_size;
> +       efi_status_t status;
> +       const u32 attr = (EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +        EFI_VARIABLE_RUNTIME_ACCESS);
> +
> +       buf->f_type = dentry->d_sb->s_magic;
> +       /*
> +        * This is not a normal filesystem, so no point in pretending it has a block
> +        * size; we declare f_bsize to 1, so that we can then report the exact value
> +        * sent by EFI QueryVariableInfo in f_blocks and f_bfree
> +        */
> +       buf->f_bsize = 1;
> +       buf->f_namelen = NAME_MAX;
> +
> +       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
> +                                           &max_variable_size);
> +       if (status != EFI_SUCCESS)
> +               return efi_status_to_err(status);
> +       buf->f_blocks = storage_space;
> +       buf->f_bfree = remaining_space;
> +       /*
> +        * In f_bavail we declare the free space that the kernel will allow writing
> +        * when the storage_paranoia x86 quirk is active. To use more, users
> +        * should boot the kernel with efi_no_storage_paranoia.
> +        */
> +       if (remaining_space > efi_reserved_space())
> +               buf->f_bavail = remaining_space - efi_reserved_space();
> +       else
> +               buf->f_bavail = 0;
> +       return 0;
> +}
>  static const struct super_operations efivarfs_ops = {
> -       .statfs = simple_statfs,
> +       .statfs = efivarfs_statfs,
>         .drop_inode = generic_delete_inode,
>         .evict_inode = efivarfs_evict_inode,
>  };
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7aa62c92185f..d2b686191870 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -703,6 +703,7 @@ static inline void efi_enter_virtual_mode (void) {}
>  extern efi_status_t efi_query_variable_store(u32 attributes,
>                                              unsigned long size,
>                                              bool nonblocking);
> +extern u64 efi_reserved_space(void);
>  #else
>
>  static inline efi_status_t efi_query_variable_store(u32 attributes,
> @@ -711,6 +712,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
>  {
>         return EFI_SUCCESS;
>  }
> +static inline u64 efi_reserved_space(void)
> +{
> +       return 0;
> +}
>  #endif
>  extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
>
> @@ -1042,6 +1047,7 @@ struct efivar_operations {
>         efi_set_variable_t *set_variable;
>         efi_set_variable_t *set_variable_nonblocking;
>         efi_query_variable_store_t *query_variable_store;
> +       efi_query_variable_info_t *query_variable_info;
>  };
>
>  struct efivars {
> @@ -1087,6 +1093,10 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
>  efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>                                  u32 attr, unsigned long data_size, void *data);
>
> +efi_status_t efivar_query_variable_info(u32 attr, u64 *storage_space,
> +                                       u64 *remaining_space,
> +                                       u64 *max_variable_size);
> +
>  #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
>  extern bool efi_capsule_pending(int *reset_type);
>
> --
> 2.34.1
>
