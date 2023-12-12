Return-Path: <linux-efi+bounces-189-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7780E4AD
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 08:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E161F22530
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024091642B;
	Tue, 12 Dec 2023 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rU8XMmSr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1AE3
	for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 23:13:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso6075050e87.0
        for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702365218; x=1702970018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2HvarWiRiZp9CS6HJcLHItesInJpFtP0opjbE7J4kz8=;
        b=rU8XMmSrZl5D+k5uNNCvzCQro6E+ilUc8MMstLQNUobiD5b/oMjd71o0wdWX9HiYx2
         CkDLddEm/rIctpn6zXyUmEDnlJY9ATEL4mY7ZUjeUp+0EYdzlS6yv7ilcHB2mBf48uJ+
         fN/yuzOIMxTlF6khdtNjOatPbeTfouLiXZT+1QW58NEHD7Mv8Cio6Aqm3zKJ273IXyjG
         d2BtPB4DOVCD/koIOpjTFTiIj9HGVeooXi89/E1R/7y4SB50H+QcUetP7jDKD+GpUN4G
         OaDr0uYARmc/ZZkYPa8l6GCGUuw5f0B/mbmQwR/f0NYJG6H+md85js5IGgZCPEBMPIYJ
         o0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702365218; x=1702970018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HvarWiRiZp9CS6HJcLHItesInJpFtP0opjbE7J4kz8=;
        b=QiRIQ2RyrK8nSyTrg67385zBl9tbEDek8K3EcWt9Z2tA1pHRizVN/2qAM/7v2afWfi
         TOHFdRqZmYUJ6c2w/IDwH2bHFjMstAchdpgS4gmsr4z6IYv7TnIUVrrPoTEvN7qrXOWX
         ewgbnzEhLx0ISl5xmpc+26yiCfOPeG43TDQXBhUKr6u25i7TVsCWsyuJVQOX6T20DxmQ
         wQC2yVn/SmbQOpVSXCl5IRZN6CcrpRXTGBDi68JPR44PinkCITZXXYwQcHt+rd1rlhAZ
         5ChgDdeAHuYWoD36oN0yochQfr4UR5FeQ1vbNGhb+ksf/52MOclUbxdv9iyoBIUWJCCE
         Xb+w==
X-Gm-Message-State: AOJu0Yxr/Z/M3Mgt0sHylIVBccWxuGsAFIkVQiK+CdLfKRAX/0uu+KPK
	2TMao1jQz2YAr8hBTVZyLqckSwAAQdTOA+EPbdinoQ==
X-Google-Smtp-Source: AGHT+IFDk55SgY+IlCJn0QNiEn+nXWbyKK7Qxz1/FKHRKczqpugePZ/D1Jdj8q9TgPPxOatu0kP4nx8+E3GHLx5rx50=
X-Received: by 2002:ac2:4201:0:b0:50b:e6e0:cadc with SMTP id
 y1-20020ac24201000000b0050be6e0cadcmr2168637lfh.121.1702365217651; Mon, 11
 Dec 2023 23:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <20231013074540.8980-5-masahisa.kojima@linaro.org> <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
 <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
In-Reply-To: <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Dec 2023 09:13:01 +0200
Message-ID: <CAC_iWjJOJ-x7CUJvN4tYx2UF=yY4gp3QPjt+7uP79tO+2AZ0-w@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] efivarfs: automatically update super block flag
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Sumit Garg <sumit.garg@linaro.org>, 
	linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Johan Hovold <johan+linaro@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ard,

On Tue, 12 Dec 2023 at 07:39, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ard,
>
> On Mon, 11 Dec 2023 at 19:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Oct 2023 at 09:47, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > tee_stmm_efi module supports SetVariable runtime service,
> > > but user needs to manually remount the efivarfs as RW to enable
> > > the write access if the previous efivar operation does not support
> > > SerVariable and efivarfs is mounted as read-only.
> > >
> > > This commit notifies the update of efivar operation to
> > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > operation supports SetVariable.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >
> > Unfortunately, I have identified a problem with this approach.
> >
> > There are cases where there are multiple instances of struct
> > superblock are associated with the efivarfs file system [0].
> >
> > So I reworked the patch a little - please take the time to double
> > check that I did not make any mistakes here.
> >
> > [0] https://lore.kernel.org/linux-efi/20231208163925.3225018-8-ardb@google.com/T/#u
>
> I think you are referring to this patch[1]?
> The modification should be OK, also I have tested it works as expected.
>
> Thank you very much for fixing this.

Same results here (as we discussed yesterday on IRC). Code looks sane
and the automatic remounting correctly sets the mountpoint as RW

Thanks!
/Ilias
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/efivarfs?id=94f7f6182c72ba642c1f20111681f9cc8621c95f
>
> Thanks,
> Masahisa Kojima
>
> >
> >
> > > ---
> > >  drivers/firmware/efi/efi.c  |  6 ++++++
> > >  drivers/firmware/efi/vars.c |  8 ++++++++
> > >  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
> > >  include/linux/efi.h         |  8 ++++++++
> > >  4 files changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 53ae25bbb6ac..d2eec5ed8e5e 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/ucs2_string.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/security.h>
> > > +#include <linux/notifier.h>
> > >
> > >  #include <asm/early_ioremap.h>
> > >
> > > @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
> > >         .is_visible = efi_attr_is_visible,
> > >  };
> > >
> > > +struct blocking_notifier_head efivar_ops_nh;
> > > +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> > > +
> > >  static struct efivars generic_efivars;
> > >  static struct efivar_operations generic_ops;
> > >
> > > @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
> > >                 platform_device_register_simple("efivars", 0, NULL, 0);
> > >         }
> > >
> > > +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> > > +
> > >         error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
> > >         if (error) {
> > >                 pr_err("efi: Sysfs attribute export failed with error %d.\n",
> > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > > index e9dc7116daf1..f654e6f6af87 100644
> > > --- a/drivers/firmware/efi/vars.c
> > > +++ b/drivers/firmware/efi/vars.c
> > > @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
> > >                      const struct efivar_operations *ops)
> > >  {
> > >         int rv;
> > > +       int event;
> > >
> > >         if (down_interruptible(&efivars_lock))
> > >                 return -EINTR;
> > > @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
> > >
> > >         __efivars = efivars;
> > >
> > > +       if (efivar_supports_writes())
> > > +               event = EFIVAR_OPS_RDWR;
> > > +       else
> > > +               event = EFIVAR_OPS_RDONLY;
> > > +
> > > +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> > > +
> > >         pr_info("Registered efivars operations\n");
> > >         rv = 0;
> > >  out:
> > > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > > index e028fafa04f3..0f6e4d223aea 100644
> > > --- a/fs/efivarfs/super.c
> > > +++ b/fs/efivarfs/super.c
> > > @@ -14,11 +14,36 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/magic.h>
> > >  #include <linux/statfs.h>
> > > +#include <linux/notifier.h>
> > >
> > >  #include "internal.h"
> > >
> > >  LIST_HEAD(efivarfs_list);
> > >
> > > +struct efivarfs_info {
> > > +       struct super_block *sb;
> > > +       struct notifier_block nb;
> > > +};
> > > +
> > > +static struct efivarfs_info info;
> > > +
> > > +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
> > > +                                void *data)
> > > +{
> > > +       switch (event) {
> > > +       case EFIVAR_OPS_RDONLY:
> > > +               info.sb->s_flags |= SB_RDONLY;
> > > +               break;
> > > +       case EFIVAR_OPS_RDWR:
> > > +               info.sb->s_flags &= ~SB_RDONLY;
> > > +               break;
> > > +       default:
> > > +               return NOTIFY_DONE;
> > > +       }
> > > +
> > > +       return NOTIFY_OK;
> > > +}
> > > +
> > >  static void efivarfs_evict_inode(struct inode *inode)
> > >  {
> > >         clear_inode(inode);
> > > @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >         if (!root)
> > >                 return -ENOMEM;
> > >
> > > +       info.sb = sb;
> > > +       info.nb.notifier_call = efivarfs_ops_notifier;
> > > +       err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
> > > +       if (err)
> > > +               return err;
> > > +
> > >         INIT_LIST_HEAD(&efivarfs_list);
> > >
> > >         err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
> > > @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
> > >
> > >  static void efivarfs_kill_sb(struct super_block *sb)
> > >  {
> > > +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> > > +       info.sb = NULL;
> > >         kill_litter_super(sb);
> > >
> > >         if (!efivar_is_available())
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index 4776a3dd9a72..489707b9b0b0 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1355,6 +1355,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
> > >
> > >  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
> > >
> > > +/*
> > > + * efivar ops event type
> > > + */
> > > +#define EFIVAR_OPS_RDONLY 0
> > > +#define EFIVAR_OPS_RDWR 1
> > > +
> > > +extern struct blocking_notifier_head efivar_ops_nh;
> > > +
> > >  void efivars_generic_ops_register(void);
> > >  void efivars_generic_ops_unregister(void);
> > >
> > > --
> > > 2.30.2
> > >

