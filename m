Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5205C7CC148
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjJQK6i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 06:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQK6h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 06:58:37 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA4B0
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 03:58:34 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-457c057bdb5so1690447137.0
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697540314; x=1698145114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AvDrSA2O4jubT8nd4WyiQ2wQwwNNb4SRFrLtbdfy5Q=;
        b=MdL7puRn9ROLAwse884LTdVLAL+MjW3yxUImT9KlS3BraLlfEjaBUbPr2jC551IX0F
         lgCIshJq7L4rKXdoCKhrnmyuFi7jlUIIrnsHz71i78iA7X+j+I2Emt6FjLsCMmySM5iD
         zY3GCCMhAkOsGwBdF2tyZYMmT4j7cNdECUeSI49N+UuEy5lQ0tD41DSQIKUc/KjlGJwn
         0eH8neYxZzYywYJpQNBJ+3/1QobgVakiIlQFDQc6qWqz3rDBigRdPKibqJ0rZNb9/cmG
         WfXOjj6ml+tSbOFJjoOPjk9nSDdJWSkFzLLkpQLZWFDwr9gtY5EIsKbqdkDrsvG7uk90
         3wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540314; x=1698145114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AvDrSA2O4jubT8nd4WyiQ2wQwwNNb4SRFrLtbdfy5Q=;
        b=sADhXMU9aAdU8dOIs4S67qhrFuD0KeqffUzQVgADCgus78CuDqiS6ykaz3nWEQgej8
         Sj+4Spd2g9zX39RJdAWCedzVHHy+okJkcTvYGj6/HYGW2L4/kb/HZccLncLO5F2rey8o
         77iG9fzhJ/TqZoy1dkZ6WViQM42Fj2GBx+ALzI58igN5bz+2TIbFqEsYIrFMUMjIMc8h
         Nz84CSoaEfA40Hhq80t5PK6rAj2B3MvzFcRUUbUYBXaC4RYeXL0eqgepUehPv0KiFGr7
         CSC+IP/sWj3tXxNpCTZ9aHMxWyguXXV6mO38b0kwv8EoQS8edJEcjPjqazPYWI9JX3Sq
         lZyA==
X-Gm-Message-State: AOJu0YxDDAgliA2BAf+TdYIRf+Fxahfuw2DrsWafU8Z9Zz0X/Zje6Cz7
        VH6M/YbDL7VVS+W3SWzxXPONn1SkOeO8e6LGMb+zmw==
X-Google-Smtp-Source: AGHT+IFSfbKbPgWID/UTBFfrdLNs7gkV+RQcyowrh78BwTDWbLcKviSNjrW9UlizK7hF3EBURu5B1KLbuh/sOt0h0ts=
X-Received: by 2002:a05:6102:54ac:b0:452:c729:e9df with SMTP id
 bk44-20020a05610254ac00b00452c729e9dfmr2490438vsb.33.1697540313750; Tue, 17
 Oct 2023 03:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <20230807025343.1939-5-masahisa.kojima@linaro.org> <CAC_iWjL3YpZb4ryko1DR9CM1x+VTV8mfnN=AwBR4F09Agc0vRQ@mail.gmail.com>
 <CAFA6WYN_E=4nN1-j2-nQ_pi+b083UmKPNO9Saub7aZLAx4PCww@mail.gmail.com> <CAC_iWj+P110h2cK=4tbCTq2c9aktox-EATOQgH_1wshRMKg4PQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+P110h2cK=4tbCTq2c9aktox-EATOQgH_1wshRMKg4PQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 17 Oct 2023 16:28:22 +0530
Message-ID: <CAFA6WYPc3ZL7C=t_i_VnYmJMHmgEM50aA=v4ZNC=FVAJgSAY=g@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] efivarfs: automatically update super block flag
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, 13 Oct 2023 at 20:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sumit
>
> On Fri, 13 Oct 2023 at 09:53, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 11 Oct 2023 at 22:30, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Kojima-san
> > > Apologies for the late reply, I just found some to test this.
> > >
> > > On Sun, 6 Aug 2023 at 19:55, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> > > >
> > > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > > tee_stmm_efi module supports SetVariable runtime service,
> > > > but user needs to manually remount the efivarfs as RW to enable
> > > > the write access if the previous efivar operation does not support
> > > > SerVariable and efivarfs is mounted as read-only.
> > > >
> > > > This commit notifies the update of efivar operation to
> > > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > > operation supports SetVariable.
> > >
> > > The RO->RW transition works fine and I did manage to test basic stuff
> > > like setting up efibootmgr options.  IIUC the RW->RO should be covered
> > > by this patchset [0] ?
> >
> > Yeah.
> >
> > > Wouldn't it be better to detect that the tee device of the supplicant
> > > closes and use that to switch the permissions?  I get why we need that
> > > for the TPM, the entire subsystem needs to send TPM commands *before*
> > > the supplicant dies.   But this is not needed for the EFI variables
> > > case, we could just remount the FS as RO the moment the supplicant
> > > dies.
> >
> > As we discussed offline, we should have a unified approach to notify
> > kernel TEE client drivers. So the approach implemented as part of [0]
> > should address the needs for fTPM as well as EFI.
>
> Ideally yes, we should have a unified approach.  But this is a bit
> different IMHO. In the majority of the cases, the supplicant goes
> away,  we lose access to storage and that's the only thing we care
> about.

What do you think about in-flight secure storage operations while the
tee-supplicant goes away? They can fail abruptly if the tee-supplicant
goes away without waiting for them to complete. IMO, the graceful
handling should be that the tee-supplicant should be alive when the
dependent devices are being closed.

For an EFI variable store case as well isn't that a possible scenario?

> Only the TPM subsystem is 'special' because it has to perform
> a shutdown of the device as well.  On top of that, I think we should
> try to avoid the kernel depending on userspace apps as much as
> possible.

There is only tee-supplicant user-space dependency which has to be
handled carefully. I am very much up for RPMB fastpath via kernel and
get rid of this dependency as well.

>  I think it's best if we support both of these and add
> documentation on why this is happening. Would it be hard to have a
> combination of both of your patches?
>

It won't be hard but there can be corner cases as mentioned above.

-Sumit

> Thanks
> /Ilias
>
> >
> > -Sumit
> >
> > >
> > > [0] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/
> > >
> > > Regards
> > > /Ilias
> > > >
> > > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > > ---
> > > >  drivers/firmware/efi/efi.c  |  6 ++++++
> > > >  drivers/firmware/efi/vars.c |  8 ++++++++
> > > >  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
> > > >  include/linux/efi.h         |  8 ++++++++
> > > >  4 files changed, 55 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > index 53ae25bbb6ac..d2eec5ed8e5e 100644
> > > > --- a/drivers/firmware/efi/efi.c
> > > > +++ b/drivers/firmware/efi/efi.c
> > > > @@ -32,6 +32,7 @@
> > > >  #include <linux/ucs2_string.h>
> > > >  #include <linux/memblock.h>
> > > >  #include <linux/security.h>
> > > > +#include <linux/notifier.h>
> > > >
> > > >  #include <asm/early_ioremap.h>
> > > >
> > > > @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
> > > >         .is_visible = efi_attr_is_visible,
> > > >  };
> > > >
> > > > +struct blocking_notifier_head efivar_ops_nh;
> > > > +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> > > > +
> > > >  static struct efivars generic_efivars;
> > > >  static struct efivar_operations generic_ops;
> > > >
> > > > @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
> > > >                 platform_device_register_simple("efivars", 0, NULL, 0);
> > > >         }
> > > >
> > > > +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> > > > +
> > > >         error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
> > > >         if (error) {
> > > >                 pr_err("efi: Sysfs attribute export failed with error %d.\n",
> > > > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > > > index e9dc7116daf1..f654e6f6af87 100644
> > > > --- a/drivers/firmware/efi/vars.c
> > > > +++ b/drivers/firmware/efi/vars.c
> > > > @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
> > > >                      const struct efivar_operations *ops)
> > > >  {
> > > >         int rv;
> > > > +       int event;
> > > >
> > > >         if (down_interruptible(&efivars_lock))
> > > >                 return -EINTR;
> > > > @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
> > > >
> > > >         __efivars = efivars;
> > > >
> > > > +       if (efivar_supports_writes())
> > > > +               event = EFIVAR_OPS_RDWR;
> > > > +       else
> > > > +               event = EFIVAR_OPS_RDONLY;
> > > > +
> > > > +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> > > > +
> > > >         pr_info("Registered efivars operations\n");
> > > >         rv = 0;
> > > >  out:
> > > > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > > > index e028fafa04f3..0f6e4d223aea 100644
> > > > --- a/fs/efivarfs/super.c
> > > > +++ b/fs/efivarfs/super.c
> > > > @@ -14,11 +14,36 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/magic.h>
> > > >  #include <linux/statfs.h>
> > > > +#include <linux/notifier.h>
> > > >
> > > >  #include "internal.h"
> > > >
> > > >  LIST_HEAD(efivarfs_list);
> > > >
> > > > +struct efivarfs_info {
> > > > +       struct super_block *sb;
> > > > +       struct notifier_block nb;
> > > > +};
> > > > +
> > > > +static struct efivarfs_info info;
> > > > +
> > > > +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
> > > > +                                void *data)
> > > > +{
> > > > +       switch (event) {
> > > > +       case EFIVAR_OPS_RDONLY:
> > > > +               info.sb->s_flags |= SB_RDONLY;
> > > > +               break;
> > > > +       case EFIVAR_OPS_RDWR:
> > > > +               info.sb->s_flags &= ~SB_RDONLY;
> > > > +               break;
> > > > +       default:
> > > > +               return NOTIFY_DONE;
> > > > +       }
> > > > +
> > > > +       return NOTIFY_OK;
> > > > +}
> > > > +
> > > >  static void efivarfs_evict_inode(struct inode *inode)
> > > >  {
> > > >         clear_inode(inode);
> > > > @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > > >         if (!root)
> > > >                 return -ENOMEM;
> > > >
> > > > +       info.sb = sb;
> > > > +       info.nb.notifier_call = efivarfs_ops_notifier;
> > > > +       err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > >         INIT_LIST_HEAD(&efivarfs_list);
> > > >
> > > >         err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
> > > > @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
> > > >
> > > >  static void efivarfs_kill_sb(struct super_block *sb)
> > > >  {
> > > > +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> > > > +       info.sb = NULL;
> > > >         kill_litter_super(sb);
> > > >
> > > >         if (!efivar_is_available())
> > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > index 603bba2d6437..17cd628b5c42 100644
> > > > --- a/include/linux/efi.h
> > > > +++ b/include/linux/efi.h
> > > > @@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
> > > >
> > > >  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
> > > >
> > > > +/*
> > > > + * efivar ops event type
> > > > + */
> > > > +#define EFIVAR_OPS_RDONLY 0
> > > > +#define EFIVAR_OPS_RDWR 1
> > > > +
> > > > +extern struct blocking_notifier_head efivar_ops_nh;
> > > > +
> > > >  void efivars_generic_ops_register(void);
> > > >  void efivars_generic_ops_unregister(void);
> > > >
> > > > --
> > > > 2.30.2
> > > >
