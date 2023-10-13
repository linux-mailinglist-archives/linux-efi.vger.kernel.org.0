Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F37C7F01
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJMHxc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 03:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjJMHxb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 03:53:31 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE96B8
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:53:28 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7b07c3eaf9bso745521241.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183608; x=1697788408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXBNB01UeisT6KBlYVbfz6auMQKWtIS6m6y0sOninrM=;
        b=FXGdAvkPCHuS8Ogu0IteEbBYYwn1ye+kGlJz/EeI7+O3M7bIuYTLN2rKcRflvGqBnJ
         CXYSMNQpXdwtdiantgFCq9HDmjBpXhqRwYeAvPt0RB3I0lpVg/CIPJyBGgRCdFYk8WYz
         VO987P6eZ/gbVxQcKRzRkG+iNJ5eIpn2ICK2BwAQNDTgiCfqwqPbFrpLRLiL04B48zR6
         Tb7hgqa83B6ZsqOK7WapNTyGI4yIeAVxC6aq1zmQ+S4vrNVZAGBbm+jLoOHspfDbaLqw
         uhN0HmUMuC8YHaewCROg0S2CVsi4dQlFa/2rf0s9kodo5K0NIY+fVGOqi3yrYWyLNELT
         PndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183608; x=1697788408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXBNB01UeisT6KBlYVbfz6auMQKWtIS6m6y0sOninrM=;
        b=nkS6sj2NT3N0qcHRFgbSXEjLm4vQjCLCLyAmqtovFidxzdTsMd7x39M3ANqSBYPm9o
         2SDuLdSC3I/OtrNhSIIKHnLlPuSXMUuknkFpP0zPa1cRXgp3KeXrloWAiBc613VvNSYw
         EytXWUeVWsjvZ/ODXQh6l5NKoxYdN+C01JRLJUWLkncTZXQDxBYw4MLeAa17GokA/P0a
         f0MM1yMn8kPy5mdCjPT9whiey3ANXKF/AgQJJqzjNVmllyLzm7Oz9vJ1bRuzSRdrcBBF
         wu5TJZY7QEklENNu4QKAxY0NjD1IqMoz1aMDk13+B/SWKYqXK/WsUariJMC0qt3+koFg
         LDQw==
X-Gm-Message-State: AOJu0Yw08udvGrZ2h4d0uezCT2cbicdSiq5OnHdzzzwSBsQqzTrMkyez
        dwPrlh9FPXVnkKgOYALViRlfsE5v0D2jvWgZ0BXQ/w==
X-Google-Smtp-Source: AGHT+IFSsRyvuxZKsbDP3Zwd7BRqoVdHhDIE+9L3uKu6crtpSXyHxt51iEaTNUN4M/U7oCib2S7wRwtGEQ5ae9fLt1M=
X-Received: by 2002:a05:6102:a52:b0:457:adcf:2f9e with SMTP id
 i18-20020a0561020a5200b00457adcf2f9emr5656509vss.24.1697183607881; Fri, 13
 Oct 2023 00:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <20230807025343.1939-5-masahisa.kojima@linaro.org> <CAC_iWjL3YpZb4ryko1DR9CM1x+VTV8mfnN=AwBR4F09Agc0vRQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL3YpZb4ryko1DR9CM1x+VTV8mfnN=AwBR4F09Agc0vRQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 13 Oct 2023 13:23:16 +0530
Message-ID: <CAFA6WYN_E=4nN1-j2-nQ_pi+b083UmKPNO9Saub7aZLAx4PCww@mail.gmail.com>
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

Hi Ilias,

On Wed, 11 Oct 2023 at 22:30, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san
> Apologies for the late reply, I just found some to test this.
>
> On Sun, 6 Aug 2023 at 19:55, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> >
> > efivar operation is updated when the tee_stmm_efi module is probed.
> > tee_stmm_efi module supports SetVariable runtime service,
> > but user needs to manually remount the efivarfs as RW to enable
> > the write access if the previous efivar operation does not support
> > SerVariable and efivarfs is mounted as read-only.
> >
> > This commit notifies the update of efivar operation to
> > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > operation supports SetVariable.
>
> The RO->RW transition works fine and I did manage to test basic stuff
> like setting up efibootmgr options.  IIUC the RW->RO should be covered
> by this patchset [0] ?

Yeah.

> Wouldn't it be better to detect that the tee device of the supplicant
> closes and use that to switch the permissions?  I get why we need that
> for the TPM, the entire subsystem needs to send TPM commands *before*
> the supplicant dies.   But this is not needed for the EFI variables
> case, we could just remount the FS as RO the moment the supplicant
> dies.

As we discussed offline, we should have a unified approach to notify
kernel TEE client drivers. So the approach implemented as part of [0]
should address the needs for fTPM as well as EFI.

-Sumit

>
> [0] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/
>
> Regards
> /Ilias
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  drivers/firmware/efi/efi.c  |  6 ++++++
> >  drivers/firmware/efi/vars.c |  8 ++++++++
> >  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
> >  include/linux/efi.h         |  8 ++++++++
> >  4 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 53ae25bbb6ac..d2eec5ed8e5e 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/ucs2_string.h>
> >  #include <linux/memblock.h>
> >  #include <linux/security.h>
> > +#include <linux/notifier.h>
> >
> >  #include <asm/early_ioremap.h>
> >
> > @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
> >         .is_visible = efi_attr_is_visible,
> >  };
> >
> > +struct blocking_notifier_head efivar_ops_nh;
> > +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> > +
> >  static struct efivars generic_efivars;
> >  static struct efivar_operations generic_ops;
> >
> > @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
> >                 platform_device_register_simple("efivars", 0, NULL, 0);
> >         }
> >
> > +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> > +
> >         error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
> >         if (error) {
> >                 pr_err("efi: Sysfs attribute export failed with error %d.\n",
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index e9dc7116daf1..f654e6f6af87 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
> >                      const struct efivar_operations *ops)
> >  {
> >         int rv;
> > +       int event;
> >
> >         if (down_interruptible(&efivars_lock))
> >                 return -EINTR;
> > @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
> >
> >         __efivars = efivars;
> >
> > +       if (efivar_supports_writes())
> > +               event = EFIVAR_OPS_RDWR;
> > +       else
> > +               event = EFIVAR_OPS_RDONLY;
> > +
> > +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> > +
> >         pr_info("Registered efivars operations\n");
> >         rv = 0;
> >  out:
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index e028fafa04f3..0f6e4d223aea 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -14,11 +14,36 @@
> >  #include <linux/slab.h>
> >  #include <linux/magic.h>
> >  #include <linux/statfs.h>
> > +#include <linux/notifier.h>
> >
> >  #include "internal.h"
> >
> >  LIST_HEAD(efivarfs_list);
> >
> > +struct efivarfs_info {
> > +       struct super_block *sb;
> > +       struct notifier_block nb;
> > +};
> > +
> > +static struct efivarfs_info info;
> > +
> > +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
> > +                                void *data)
> > +{
> > +       switch (event) {
> > +       case EFIVAR_OPS_RDONLY:
> > +               info.sb->s_flags |= SB_RDONLY;
> > +               break;
> > +       case EFIVAR_OPS_RDWR:
> > +               info.sb->s_flags &= ~SB_RDONLY;
> > +               break;
> > +       default:
> > +               return NOTIFY_DONE;
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> >  static void efivarfs_evict_inode(struct inode *inode)
> >  {
> >         clear_inode(inode);
> > @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >         if (!root)
> >                 return -ENOMEM;
> >
> > +       info.sb = sb;
> > +       info.nb.notifier_call = efivarfs_ops_notifier;
> > +       err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
> > +       if (err)
> > +               return err;
> > +
> >         INIT_LIST_HEAD(&efivarfs_list);
> >
> >         err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
> > @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
> >
> >  static void efivarfs_kill_sb(struct super_block *sb)
> >  {
> > +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> > +       info.sb = NULL;
> >         kill_litter_super(sb);
> >
> >         if (!efivar_is_available())
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 603bba2d6437..17cd628b5c42 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
> >
> >  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
> >
> > +/*
> > + * efivar ops event type
> > + */
> > +#define EFIVAR_OPS_RDONLY 0
> > +#define EFIVAR_OPS_RDWR 1
> > +
> > +extern struct blocking_notifier_head efivar_ops_nh;
> > +
> >  void efivars_generic_ops_register(void);
> >  void efivars_generic_ops_unregister(void);
> >
> > --
> > 2.30.2
> >
