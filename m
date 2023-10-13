Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3F7C8898
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjJMP0a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 11:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjJMP03 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 11:26:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C7BD
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 08:26:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507973f3b65so1686410e87.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697210784; x=1697815584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=idyP6TZLt0+e2JiohgFKby+oBhBYuginDh4AcfSAIM0=;
        b=jqdbj+ruwiavMHDvvbEnuN9EXQIUjD8l3diLN/d4s/0hmKqt8NhUfHJVbGDyGDlQ08
         eKE8vAF4DGWiJpI3gd6KTqXR/IAhcQKDUTMlXos6DhqPERknbEixAJwMjhc4MM0ElipR
         YQc2wpzB1tJyfDwaXsVbAloyMTuYTJa+/nJlPqp1scJdUDprQKqQ7rob7TJWj86Rdz6B
         C33RdWQa8GWm0MAeTv+U6f3sPK3tCIixwlgNQlhz66SrqRcvrJpYx7KjRj6N8+m4I5ts
         2nlekRcZTDWXlA2O7YNAWF2LyK7MyaLcDV7Qc/MQsfYcuJfpkBR1kCGcHIDHKN+T9x6s
         L0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210784; x=1697815584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idyP6TZLt0+e2JiohgFKby+oBhBYuginDh4AcfSAIM0=;
        b=iMvfDGMDuVy/73gIlnglvgPFgIR/9+e+S+bIZwCXLKUgLS8we+/4HF49PhAzegT59I
         p1jTgd4HsKT95m12ciQHDTdyFRTFnqMb+6X6vM2hINIatORczI+LUP0FhjhTOAIh+4TO
         9M0qNxtpAgaS5wsNwfbWLLmFbJgG/pmMFd5uohdB5rpcRDUbFKdP4fcDg81+3OumgrwM
         EYhBaAopJ4d/NOLLDLz4WgPnUPugOMFJnJcWyUvST6F/wJu5MJQQNXWiLMzkfaYLlF+A
         0WG1GGHHhc/ckrvMrZQJCfGFNHPVjexdajXCTVBRhh4BlWOdSY+xaFcy+O4gW7BbMo4l
         Tgbg==
X-Gm-Message-State: AOJu0Ywk5Mg/XgLHug0fDXJcrqNB5bKGEDhd5T0TqyVfFjcJmdrDnJ/+
        m2H0J2sKBhVnVpp5r8qOJaqhPBJlmjflyk1OZpdoWQ==
X-Google-Smtp-Source: AGHT+IEkj0xvE7pRWlx0hN5jxXkWiivm6HR/PwwHhFypENo7OeXGj3F42BjmRorHeeajvySa/NnlyGCagHU3vsaGE5w=
X-Received: by 2002:a05:6512:3d87:b0:504:7bb0:9d7e with SMTP id
 k7-20020a0565123d8700b005047bb09d7emr28771686lfv.27.1697210784499; Fri, 13
 Oct 2023 08:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <20230807025343.1939-5-masahisa.kojima@linaro.org> <CAC_iWjL3YpZb4ryko1DR9CM1x+VTV8mfnN=AwBR4F09Agc0vRQ@mail.gmail.com>
 <CAFA6WYN_E=4nN1-j2-nQ_pi+b083UmKPNO9Saub7aZLAx4PCww@mail.gmail.com>
In-Reply-To: <CAFA6WYN_E=4nN1-j2-nQ_pi+b083UmKPNO9Saub7aZLAx4PCww@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 13 Oct 2023 17:25:48 +0200
Message-ID: <CAC_iWj+P110h2cK=4tbCTq2c9aktox-EATOQgH_1wshRMKg4PQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] efivarfs: automatically update super block flag
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Sumit

On Fri, 13 Oct 2023 at 09:53, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 11 Oct 2023 at 22:30, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Kojima-san
> > Apologies for the late reply, I just found some to test this.
> >
> > On Sun, 6 Aug 2023 at 19:55, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
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
> >
> > The RO->RW transition works fine and I did manage to test basic stuff
> > like setting up efibootmgr options.  IIUC the RW->RO should be covered
> > by this patchset [0] ?
>
> Yeah.
>
> > Wouldn't it be better to detect that the tee device of the supplicant
> > closes and use that to switch the permissions?  I get why we need that
> > for the TPM, the entire subsystem needs to send TPM commands *before*
> > the supplicant dies.   But this is not needed for the EFI variables
> > case, we could just remount the FS as RO the moment the supplicant
> > dies.
>
> As we discussed offline, we should have a unified approach to notify
> kernel TEE client drivers. So the approach implemented as part of [0]
> should address the needs for fTPM as well as EFI.

Ideally yes, we should have a unified approach.  But this is a bit
different IMHO. In the majority of the cases, the supplicant goes
away,  we lose access to storage and that's the only thing we care
about.  Only the TPM subsystem is 'special' because it has to perform
a shutdown of the device as well.  On top of that, I think we should
try to avoid the kernel depending on userspace apps as much as
possible.  I think it's best if we support both of these and add
documentation on why this is happening. Would it be hard to have a
combination of both of your patches?

Thanks
/Ilias

>
> -Sumit
>
> >
> > [0] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/
> >
> > Regards
> > /Ilias
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
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
> > > index 603bba2d6437..17cd628b5c42 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
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
