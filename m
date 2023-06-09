Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732572921E
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjFIIDA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjFIICq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 04:02:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65349DC
        for <linux-efi@vger.kernel.org>; Fri,  9 Jun 2023 01:01:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1adf27823so16009191fa.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Jun 2023 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686297642; x=1688889642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06aLnWhJdy0R77EsY3W61qYT6aLBj8zgctJ+CoIkn7k=;
        b=dROKAMlm60dMt/sFOkYwFrndwAc6rtu/0Fsi8H2vVIhFFlPPnHLqTyV6+5WR4qRGCs
         MZIxKJdOeDfJJbhVmU1yfSJqZ93i+//1HfRt78TXb5NsuXDnYerwmGazjylxknO4ngV3
         YQJrrK17lzV2vSArB10Qpm7bFBSuZPemXs0f9v7Eg/wfYNvy/JfHNHGhIwgCYEdTVMMy
         cHOiELFspxfchQ8ZGuO0JXiQSaHgFFCuV4PE9nQthctMS5/O6HrIwQ9zVe4QlNOqvEG5
         Nh74xoUGA+nt7G4PaZr++YqJQ9EJkYcy5fghSF3w7TLwttexeZ/JYzBBA8Z+PrQ/daNC
         +CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686297642; x=1688889642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06aLnWhJdy0R77EsY3W61qYT6aLBj8zgctJ+CoIkn7k=;
        b=V70udohg1bf0Tav9CXOqY5wzuIVm6bsAQaq9gtuVkCIbUTzFoVPLNKUWb1B7/Brqpq
         Hxg6NyCSWnaBgrRTzndzvT9VOW2rve0gY9GiEuWddZw/J+VattxCWDEY9ejW+v9WwVsp
         x1oFhk36552h3+prsNwnapPmy4SEE1HmS8MSJD0JC+WFkl8vAOb1dSRmtofLLmIEjyAq
         q40SVm86/n4chB1TEZf/0vS8pMS+9jEm63ZJMlWwCehlAOIOZSAcfDalY0fM1Hi+GsAp
         s2wUuzvkvNdUNZVjifhJ674mZn697g8MvQxBh+h1/HKIHjpLvThi95pSfDkGYgpvZd8E
         tnzA==
X-Gm-Message-State: AC+VfDz32skPY6RQem0FqRe1LZRiKEBDbn6L55STiNyl7n0cyx9c7yDs
        AhTRtDk8N7tk8ceD09nWH5Wemt9Uu1V5EraEVHkVRw==
X-Google-Smtp-Source: ACHHUZ6sDFOrDw132Cxb7TJmxDK1wGBHWBj8Fj1F3tNZ4ozNN7LXTygGpdV6UGgjan6VSVHykaR+fa1+M66McOZDoJE=
X-Received: by 2002:a2e:98ca:0:b0:2b1:d4fc:75ff with SMTP id
 s10-20020a2e98ca000000b002b1d4fc75ffmr525291ljj.31.1686297642304; Fri, 09 Jun
 2023 01:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com> <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com> <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com> <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
 <CAC_iWjJ0uw_p9=6C+U+q8BNQgnDBgbDpcu8s8c80oB25i9y77w@mail.gmail.com>
 <3eb9bf84-4cf0-6cfe-9ad3-f7eef7d775fb@siemens.com> <CAC_iWjLdmmQ4+BVt_mOP5Ht9jDHQqoVV+-ATR-nDrmG37raGjQ@mail.gmail.com>
 <da7d3871-3b2f-1172-62a8-70f6856e4968@siemens.com>
In-Reply-To: <da7d3871-3b2f-1172-62a8-70f6856e4968@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 9 Jun 2023 11:00:06 +0300
Message-ID: <CAC_iWj+67o2LF5ULffaDPUQ9FXZYpqK96Sb1_EhY40ppgk=X2A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jan,

On Fri, 9 Jun 2023 at 09:40, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 09.06.23 08:34, Ilias Apalodimas wrote:
> > Hi Jan,
> >
> > [...]
> >
> >>> --- a/drivers/firmware/efi/vars.c
> >>> +++ b/drivers/firmware/efi/vars.c
> >>> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
> >>>
> >>>  bool efivar_supports_writes(void)
> >>>  {
> >>> -       return __efivars && __efivars->ops->set_variable;
> >>> +       return __efivars && __efivars->ops->set_variable != set_variable_int;
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(efivar_supports_writes);
> >>>
> >>> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> >>> index e028fafa04f3..e40b5c4c5106 100644
> >>> --- a/fs/efivarfs/super.c
> >>> +++ b/fs/efivarfs/super.c
> >>> @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
> >>> *sb, struct fs_context *fc)
> >>>         sb->s_d_op              = &efivarfs_d_ops;
> >>>         sb->s_time_gran         = 1;
> >>>
> >>> -       if (!efivar_supports_writes())
> >>> -               sb->s_flags |= SB_RDONLY;
> >>> -
> >>>         inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
> >>>         if (!inode)
> >>>                 return -ENOMEM;
> >>> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >>> index 58d1c271d3b0..ec0ac6ef50a3 100644
> >>> --- a/include/linux/efi.h
> >>> +++ b/include/linux/efi.h
> >>> @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
> >>>                      const struct efivar_operations *ops);
> >>>  int efivars_unregister(struct efivars *efivars);
> >>>
> >>> +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> >>> +                             u32 attributes, unsigned long data_size,
> >>> +                             void *data);
> >>> +
> >>>  void efivars_generic_ops_register(void);
> >>>  void efivars_generic_ops_unregister(void);
> >>>
> >>> Thanks
> >>> /Ilias
> >>
> >> As just written in my other reply: The root cause is the dependency on
> >> tee-supplicant daemon. That needs to be resolved, and then also r/w
> >> mounting will just work.
> >
> > That's partially true.  If we solve the dependency your problem will
> > go away only if everything gets compiled as built in.  But if you have
> > them as modules there's still a chance you mount the efivarfs before
> > installing all the modules.  In that case, you'll end up with the same
> > problem no?
>
> Obviously, this will need proper probing of the TA services in the
> proper order so that the STMM driver is pulled in before efivarfs gets used.
>
> >
> > That's why I think this patch (or a variation of it) is useful.  It
> > solves the kernel panic you are seeing if you remount the efivarfs as
> > RW and It unifies the way the kernel responds to userspace no matter
> > what the firmware does with its setvariableRT service.
>
> I'm not against fixes crashes, but the r/w issue is a different thing IMHO.

Fair enough, but if we want to fix the crash only I think there's a
better way to do it.
I'll cook some patches and send  them over

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
