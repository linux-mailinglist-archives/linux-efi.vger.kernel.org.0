Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE17C59BF
	for <lists+linux-efi@lfdr.de>; Wed, 11 Oct 2023 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjJKRBC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Oct 2023 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJKRBC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Oct 2023 13:01:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29DFAF
        for <linux-efi@vger.kernel.org>; Wed, 11 Oct 2023 10:00:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso408751fa.0
        for <linux-efi@vger.kernel.org>; Wed, 11 Oct 2023 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697043657; x=1697648457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8sHYpk3NLm+iT6M+Vidy6ah4n5Cv4xyN+PvO+EHCwpQ=;
        b=XmXufhLLZenTnmVhn78wi+KcFBUtF3Xt2LEqb2ph36YYMdJWNfbNQyzW1i6/kyu3s9
         Gc9Z78aofuAJ3wVkY+yyRM6jz3kg9IjJrpvB/ieci5wlZClZi92wb5vqND9X0X3tQrIv
         T4hV4Mjepnx0uDQs12RKCXb7sUNqRonmEWwPT3p3xvcHpPGVK7/LLDGTndbNKyAETBtT
         kHnergEsaGH5zb0fVl5HqrN7BlNv5SkAYEsSrzYwe/WzPZf3OXKlRwilywkqvKDiAYNl
         Xi3gc0xRg7vTsESdFZanIhhbqiEUGNG6bRppmpPM0w8Q79sDSQ+1u+M8YLJhxGNrfuGw
         bKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043657; x=1697648457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sHYpk3NLm+iT6M+Vidy6ah4n5Cv4xyN+PvO+EHCwpQ=;
        b=HEmM+/FiOgA3sGLC6X3kgFzAKMP2zuhnG52bWLNV8VNzvUPMT+SelLtTKRDsgLumuh
         ndobtKBQmJgCrJIdtgNVImuM7vLgyCBXdr4qL8IELPnKscAMkJNzMNHGIHX9rGaWeAM/
         aypt+xx+b+M3nQGBWKIAfrrVImPfAAA1pDHJwqYCO6wm1INUqq4FAW5sXppTbzh7kJkI
         jwwajPubAyaZEIfERZCeB37/s2X2t6NJ+/ahN/K3gL2lQ5Hp/D7ABEhavYAEpYf/g/9c
         e4auPd/wQLeNYYu+9QX3acVo6BSlvEXA+cgQ+6+qO6wfypwRl6Mo9kZIGcsmyzPLCzmu
         6S+A==
X-Gm-Message-State: AOJu0Yxwff+xDUpVfoc+jqaJSLvlFrWvqNEuhKdNI3E0RmDsItSON2uC
        v0MPM9Iy9AwCMNO/VZnGhYnoelqWBihY7ygnl4s8O31LEGQ/HfFjowfTdA==
X-Google-Smtp-Source: AGHT+IH8EA3AsbLsUis2v99sJlRWVfe06emr3z13Tmnp6Mrcw/zNjJJ1opldaZVNr2iO+IKLtMEYJfJfWcJe/REws3E=
X-Received: by 2002:a2e:9455:0:b0:2bc:bf29:18d3 with SMTP id
 o21-20020a2e9455000000b002bcbf2918d3mr19654976ljh.31.1697043656907; Wed, 11
 Oct 2023 10:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org> <20230807025343.1939-5-masahisa.kojima@linaro.org>
In-Reply-To: <20230807025343.1939-5-masahisa.kojima@linaro.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 11 Oct 2023 10:00:20 -0700
Message-ID: <CAC_iWjL3YpZb4ryko1DR9CM1x+VTV8mfnN=AwBR4F09Agc0vRQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] efivarfs: automatically update super block flag
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Kojima-san
Apologies for the late reply, I just found some to test this.

On Sun, 6 Aug 2023 at 19:55, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> efivar operation is updated when the tee_stmm_efi module is probed.
> tee_stmm_efi module supports SetVariable runtime service,
> but user needs to manually remount the efivarfs as RW to enable
> the write access if the previous efivar operation does not support
> SerVariable and efivarfs is mounted as read-only.
>
> This commit notifies the update of efivar operation to
> efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> operation supports SetVariable.

The RO->RW transition works fine and I did manage to test basic stuff
like setting up efibootmgr options.  IIUC the RW->RO should be covered
by this patchset [0] ?
Wouldn't it be better to detect that the tee device of the supplicant
closes and use that to switch the permissions?  I get why we need that
for the TPM, the entire subsystem needs to send TPM commands *before*
the supplicant dies.   But this is not needed for the EFI variables
case, we could just remount the FS as RO the moment the supplicant
dies.

[0] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/

Regards
/Ilias
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/firmware/efi/efi.c  |  6 ++++++
>  drivers/firmware/efi/vars.c |  8 ++++++++
>  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
>  include/linux/efi.h         |  8 ++++++++
>  4 files changed, 55 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 53ae25bbb6ac..d2eec5ed8e5e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -32,6 +32,7 @@
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
>  #include <linux/security.h>
> +#include <linux/notifier.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
>         .is_visible = efi_attr_is_visible,
>  };
>
> +struct blocking_notifier_head efivar_ops_nh;
> +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> +
>  static struct efivars generic_efivars;
>  static struct efivar_operations generic_ops;
>
> @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
>                 platform_device_register_simple("efivars", 0, NULL, 0);
>         }
>
> +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> +
>         error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
>         if (error) {
>                 pr_err("efi: Sysfs attribute export failed with error %d.\n",
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index e9dc7116daf1..f654e6f6af87 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops)
>  {
>         int rv;
> +       int event;
>
>         if (down_interruptible(&efivars_lock))
>                 return -EINTR;
> @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
>
>         __efivars = efivars;
>
> +       if (efivar_supports_writes())
> +               event = EFIVAR_OPS_RDWR;
> +       else
> +               event = EFIVAR_OPS_RDONLY;
> +
> +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> +
>         pr_info("Registered efivars operations\n");
>         rv = 0;
>  out:
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..0f6e4d223aea 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -14,11 +14,36 @@
>  #include <linux/slab.h>
>  #include <linux/magic.h>
>  #include <linux/statfs.h>
> +#include <linux/notifier.h>
>
>  #include "internal.h"
>
>  LIST_HEAD(efivarfs_list);
>
> +struct efivarfs_info {
> +       struct super_block *sb;
> +       struct notifier_block nb;
> +};
> +
> +static struct efivarfs_info info;
> +
> +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
> +                                void *data)
> +{
> +       switch (event) {
> +       case EFIVAR_OPS_RDONLY:
> +               info.sb->s_flags |= SB_RDONLY;
> +               break;
> +       case EFIVAR_OPS_RDWR:
> +               info.sb->s_flags &= ~SB_RDONLY;
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
>  static void efivarfs_evict_inode(struct inode *inode)
>  {
>         clear_inode(inode);
> @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         if (!root)
>                 return -ENOMEM;
>
> +       info.sb = sb;
> +       info.nb.notifier_call = efivarfs_ops_notifier;
> +       err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
> +       if (err)
> +               return err;
> +
>         INIT_LIST_HEAD(&efivarfs_list);
>
>         err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
> @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
>
>  static void efivarfs_kill_sb(struct super_block *sb)
>  {
> +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> +       info.sb = NULL;
>         kill_litter_super(sb);
>
>         if (!efivar_is_available())
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 603bba2d6437..17cd628b5c42 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
>
>  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
>
> +/*
> + * efivar ops event type
> + */
> +#define EFIVAR_OPS_RDONLY 0
> +#define EFIVAR_OPS_RDWR 1
> +
> +extern struct blocking_notifier_head efivar_ops_nh;
> +
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>
> --
> 2.30.2
>
