Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E2728FFF
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFIGfZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 02:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFIGfY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 02:35:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07A1FE9
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 23:35:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso1697537e87.0
        for <linux-efi@vger.kernel.org>; Thu, 08 Jun 2023 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686292521; x=1688884521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWLk5AcoN1nlHpTB7u7FTqD5LcrlUnshiREnF2lH0hA=;
        b=SiyMbDstSJGUV5wBE0dpYExQgbaOi08fY3+NU4qvjtxBpyiifJ1mvtdFghvFrwEPAe
         7Blad1GIxr5oIeEa6wGg/T+V4udWMlwAV77766KSvC5H1HGYODPSQiv7Pq+uu/Hcmymv
         DUz/OjpR15fmetfDry4q5tdRTQ0Q7C0UCnYDwiPeqrDLyH53Frf0/YhKxROT4dFk3FaD
         6r/ltgKr0U4ZUdbnqOVKMWxxylbKjOBIcv8jrfjpuRn418OfY8XPonxRyKfaG748TaIl
         5YNcEi/4VpJci09XC9e6ZcSYBKNF0ps8LHeRnAT/oX8y6vmUuaVpOuZuFpSBAexLn4A8
         lF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292521; x=1688884521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWLk5AcoN1nlHpTB7u7FTqD5LcrlUnshiREnF2lH0hA=;
        b=QnJEDaGeC/ZF+mLUnFCkieh4xJFeDER1SorQ+8AWDoAFnmFgrYavoYuN0d3wjwU+Br
         GiBOddoqL/6tjIlu1npZw3cq7G73rIHeyaeSdjKUdJgUt/oZQW8CuMVTlLnJ20YJqUqK
         kBSy5tTiuso4nPnsCkJq2wTEXSH3RsVECXsGrlPI1+vGU3R7qrel73tL7ki3fqWCacgv
         S8cIFvLRnFNilxCmXCim+XXTWrD1+k1TsNozwGbDWn7EGaxN9UBwwBgGThHCOOP1fDT9
         nkiEJOQ00w4fQu90rtCIc68P5z0KRLqKGH6qO27219W8WidSJ7D0eTvpEDVSgzKnkPyG
         BWvA==
X-Gm-Message-State: AC+VfDxxtPJpPPq7DibX5EsUDOmshpfOQ7VttMQS2sVjy2vNW9KbWlPG
        VVS3eM1n0is/50AoC5zFaBqiYi3HtxecKmi/Ucv/6Q==
X-Google-Smtp-Source: ACHHUZ4p+rws/CPsQ3jx2AFOjwUCvIpAwSfanS70Dysxx2qLm3VsSeemyMFRzsDJsbFonBrMaSd/94BdvUxefkZW2bg=
X-Received: by 2002:a05:6512:457:b0:4dd:9fd8:3a36 with SMTP id
 y23-20020a056512045700b004dd9fd83a36mr222016lfk.1.1686292521182; Thu, 08 Jun
 2023 23:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com> <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com> <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com> <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
 <CAC_iWjJ0uw_p9=6C+U+q8BNQgnDBgbDpcu8s8c80oB25i9y77w@mail.gmail.com> <3eb9bf84-4cf0-6cfe-9ad3-f7eef7d775fb@siemens.com>
In-Reply-To: <3eb9bf84-4cf0-6cfe-9ad3-f7eef7d775fb@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 9 Jun 2023 09:34:45 +0300
Message-ID: <CAC_iWjLdmmQ4+BVt_mOP5Ht9jDHQqoVV+-ATR-nDrmG37raGjQ@mail.gmail.com>
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

[...]

> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);
> >
> >  bool efivar_supports_writes(void)
> >  {
> > -       return __efivars && __efivars->ops->set_variable;
> > +       return __efivars && __efivars->ops->set_variable != set_variable_int;
> >  }
> >  EXPORT_SYMBOL_GPL(efivar_supports_writes);
> >
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index e028fafa04f3..e40b5c4c5106 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
> > *sb, struct fs_context *fc)
> >         sb->s_d_op              = &efivarfs_d_ops;
> >         sb->s_time_gran         = 1;
> >
> > -       if (!efivar_supports_writes())
> > -               sb->s_flags |= SB_RDONLY;
> > -
> >         inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
> >         if (!inode)
> >                 return -ENOMEM;
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 58d1c271d3b0..ec0ac6ef50a3 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
> >                      const struct efivar_operations *ops);
> >  int efivars_unregister(struct efivars *efivars);
> >
> > +efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
> > +                             u32 attributes, unsigned long data_size,
> > +                             void *data);
> > +
> >  void efivars_generic_ops_register(void);
> >  void efivars_generic_ops_unregister(void);
> >
> > Thanks
> > /Ilias
>
> As just written in my other reply: The root cause is the dependency on
> tee-supplicant daemon. That needs to be resolved, and then also r/w
> mounting will just work.

That's partially true.  If we solve the dependency your problem will
go away only if everything gets compiled as built in.  But if you have
them as modules there's still a chance you mount the efivarfs before
installing all the modules.  In that case, you'll end up with the same
problem no?

That's why I think this patch (or a variation of it) is useful.  It
solves the kernel panic you are seeing if you remount the efivarfs as
RW and It unifies the way the kernel responds to userspace no matter
what the firmware does with its setvariableRT service.

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
