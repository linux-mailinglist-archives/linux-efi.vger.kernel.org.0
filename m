Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C275EC80
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jul 2023 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGXH2U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jul 2023 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGXH2T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jul 2023 03:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BD187;
        Mon, 24 Jul 2023 00:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0B2D60F6B;
        Mon, 24 Jul 2023 07:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49180C43397;
        Mon, 24 Jul 2023 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690183695;
        bh=GLnsrmTJQyipNzjtP9w/tp3G33tGRxpIkFbIQBxhhLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEVOH7rrKbxlAafi3pd9P3vo8/q1NGdit3Lna7XuwUK1VR7QNt2JWvuSMBvEgdA8s
         QaNSmwnSl6WHkFUNA+Aadm+NDb2O/6B3s5Eegy42ubRT5+8tSrhk5VNdu99NWeWbg5
         77twwwJi4V0vMhqblG6Zf5GniOCfEeV8oKv5w9IHGcEV5lmp094sRu1+E0T5Kr3FTn
         RgJlWIVKYRd2q34jfAuANnyyij9vY6Xc0IKtGK5QrTcMPiN53nAvZW/aE57c3ysjxC
         ZJW8uMP9A7UheDcsBTT6ZQFy2iq0q2IJtdkPv96uAGeiaJQOVCpsZtEXKwhkicefVN
         pP605K9c/OUZQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso5854022e87.1;
        Mon, 24 Jul 2023 00:28:15 -0700 (PDT)
X-Gm-Message-State: ABy/qLaUCY3uN94QF1hy95cjQv3Av2we3m8PkymXrHyv+WCF19RLU//e
        jyKI98dGfi3s03kgewZBBcwFI/mN4tHbHPGfgH8=
X-Google-Smtp-Source: APBJJlEGz6OG1NKpKFLNSBRyJpiL9bNI8DJD1V12HIzUf22/vJ+2NpSgMhYn9F/mdFWW0vVlEB/ydlNYKQIKPVgn+wk=
X-Received: by 2002:a19:7508:0:b0:4ed:cc6d:61fe with SMTP id
 y8-20020a197508000000b004edcc6d61femr4848902lfe.24.1690183693160; Mon, 24 Jul
 2023 00:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230724013111.2327251-1-sashal@kernel.org>
In-Reply-To: <20230724013111.2327251-1-sashal@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 Jul 2023 09:28:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFxPFbihEMN-vPLzw6mDtrO56pTfA48kKwxWmRczxrTXg@mail.gmail.com>
Message-ID: <CAMj1kXFxPFbihEMN-vPLzw6mDtrO56pTfA48kKwxWmRczxrTXg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.4 1/4] efivarfs: expose used and total size
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Anisse Astier <an.astier@criteo.com>, matt@codeblueprint.co.uk,
        ard.biesheuvel@linaro.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, matthew.garrett@nebula.com,
        jk@ozlabs.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 24 Jul 2023 at 03:31, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Anisse Astier <an.astier@criteo.com>
>
> [ Upstream commit d86ff3333cb1d5f42d8898fb5fdb304e143c0237 ]
>

NAK

Please don't backport this - this is obviously new functionality.

> When writing EFI variables, one might get errors with no other message
> on why it fails. Being able to see how much is used by EFI variables
> helps analyzing such issues.
>
> Since this is not a conventional filesystem, block size is intentionally
> set to 1 instead of PAGE_SIZE.
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
> [ardb: - rename efi_reserved_space() to efivar_reserved_space()
>        - whitespace/coding style tweaks]
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/platform/efi/quirks.c |  8 +++++++
>  drivers/firmware/efi/efi.c     |  1 +
>  drivers/firmware/efi/vars.c    | 12 +++++++++++
>  fs/efivarfs/super.c            | 39 +++++++++++++++++++++++++++++++++-
>  include/linux/efi.h            | 11 ++++++++++
>  5 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index b0b848d6933af..f0cc00032751d 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
>                                      EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
>  }
>
> +u64 efivar_reserved_space(void)
> +{
> +       if (efi_no_storage_paranoia)
> +               return 0;
> +       return EFI_MIN_RESERVE;
> +}
> +EXPORT_SYMBOL_GPL(efivar_reserved_space);
> +
>  /*
>   * In the nonblocking case we do not attempt to perform garbage
>   * collection if we do not have enough free space. Rather, we do the
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 34b9e78765386..91d986a741dad 100644
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
> index bfc5fa6aa47b6..e9dc7116daf13 100644
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
> index 482d612b716bb..e028fafa04f38 100644
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
> @@ -23,8 +24,44 @@ static void efivarfs_evict_inode(struct inode *inode)
>         clear_inode(inode);
>  }
>
> +static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +       const u32 attr = EFI_VARIABLE_NON_VOLATILE |
> +                        EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                        EFI_VARIABLE_RUNTIME_ACCESS;
> +       u64 storage_space, remaining_space, max_variable_size;
> +       efi_status_t status;
> +
> +       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
> +                                           &max_variable_size);
> +       if (status != EFI_SUCCESS)
> +               return efi_status_to_err(status);
> +
> +       /*
> +        * This is not a normal filesystem, so no point in pretending it has a block
> +        * size; we declare f_bsize to 1, so that we can then report the exact value
> +        * sent by EFI QueryVariableInfo in f_blocks and f_bfree
> +        */
> +       buf->f_bsize    = 1;
> +       buf->f_namelen  = NAME_MAX;
> +       buf->f_blocks   = storage_space;
> +       buf->f_bfree    = remaining_space;
> +       buf->f_type     = dentry->d_sb->s_magic;
> +
> +       /*
> +        * In f_bavail we declare the free space that the kernel will allow writing
> +        * when the storage_paranoia x86 quirk is active. To use more, users
> +        * should boot the kernel with efi_no_storage_paranoia.
> +        */
> +       if (remaining_space > efivar_reserved_space())
> +               buf->f_bavail = remaining_space - efivar_reserved_space();
> +       else
> +               buf->f_bavail = 0;
> +
> +       return 0;
> +}
>  static const struct super_operations efivarfs_ops = {
> -       .statfs = simple_statfs,
> +       .statfs = efivarfs_statfs,
>         .drop_inode = generic_delete_inode,
>         .evict_inode = efivarfs_evict_inode,
>  };
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 571d1a6e1b744..120af31a5136f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1042,6 +1042,7 @@ struct efivar_operations {
>         efi_set_variable_t *set_variable;
>         efi_set_variable_t *set_variable_nonblocking;
>         efi_query_variable_store_t *query_variable_store;
> +       efi_query_variable_info_t *query_variable_info;
>  };
>
>  struct efivars {
> @@ -1049,6 +1050,12 @@ struct efivars {
>         const struct efivar_operations *ops;
>  };
>
> +#ifdef CONFIG_X86
> +u64 __attribute_const__ efivar_reserved_space(void);
> +#else
> +static inline u64 efivar_reserved_space(void) { return 0; }
> +#endif
> +
>  /*
>   * The maximum size of VariableName + Data = 1024
>   * Therefore, it's reasonable to save that much
> @@ -1087,6 +1094,10 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
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
> 2.39.2
>
