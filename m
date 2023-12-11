Return-Path: <linux-efi+bounces-162-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1280C577
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCECA28125F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7D1D6A4;
	Mon, 11 Dec 2023 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fICvlCcO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1A1D55C
	for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 10:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74909C433D9;
	Mon, 11 Dec 2023 10:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702288958;
	bh=eAwxe+wbZjnFN8IQhgxn8NYgDvrFF2z1Bra2csTbQ4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fICvlCcOS+b9q410MSV2ASCjV4ED9iDh8/Ge0iqss0UlInytbPmbBLFNAdqLMNuN5
	 bDyVbcKA9p+saXmMvnMHs+/qFE5o73lqjWk7VxUvZdsssu2Kpn4fNW5U2mqFEQ1JZ1
	 XMOlXMGHQYmEwz/YM9q3iq4TuGw1arewsUTGLd/+6JiHK4UlDh8ALaZJtcaMkqk6GG
	 bNZke65K6R6pSVIdp8LgnbKk5sEqHKq8566gGupGXBF00HPa5NylBPCZ6QFXrCylMN
	 OIrdm7S+5MLRdabXlaPO2VBVNYemIOD80E2IIoUDUHChBVxkFO9OywuX3f1PgDRLpX
	 LhB5aHnrfSItg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50c05ea5805so4958400e87.0;
        Mon, 11 Dec 2023 02:02:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yy15zmwBTPRu4qE3zo2Omyjrh7JieNangVGChSSGPUkGx1ozvVs
	OG7o+NFWPciJxXtvpjGBPI4nlRkr1oMhPr30Rfk=
X-Google-Smtp-Source: AGHT+IGnQ16kG944bQzQjF2krGAZzVThyv9bnsdPYoEJI/S2YT8/5eQ3Iub1+9EezCji/mwREiZhDJF7N123bhkP+7c=
X-Received: by 2002:a19:8c4d:0:b0:50b:f803:460b with SMTP id
 i13-20020a198c4d000000b0050bf803460bmr1462938lfj.11.1702288956536; Mon, 11
 Dec 2023 02:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org> <20231013074540.8980-5-masahisa.kojima@linaro.org>
In-Reply-To: <20231013074540.8980-5-masahisa.kojima@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 11 Dec 2023 11:02:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
Message-ID: <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] efivarfs: automatically update super block flag
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Sumit Garg <sumit.garg@linaro.org>, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Oct 2023 at 09:47, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
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
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Unfortunately, I have identified a problem with this approach.

There are cases where there are multiple instances of struct
superblock are associated with the efivarfs file system [0].

So I reworked the patch a little - please take the time to double
check that I did not make any mistakes here.

[0] https://lore.kernel.org/linux-efi/20231208163925.3225018-8-ardb@google.com/T/#u


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
> index 4776a3dd9a72..489707b9b0b0 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1355,6 +1355,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
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

