Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8CB79A5C4
	for <lists+linux-efi@lfdr.de>; Mon, 11 Sep 2023 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjIKIOw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIKIOv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 04:14:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347897
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:14:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-501bd164fbfso6657586e87.0
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420085; x=1695024885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Db9bU8/uuocihWjg7sGwKKLFZB9mNNDCw6o833i29ZU=;
        b=YbUIB45hc+PnKv3acF1YTSMw7vhYpxb8w4loc/Vx7NZ+PGPT/Da9CSgoySX1Zg+a9U
         5IySAL594o7qEz9qlNMv2oBOHfZOgYaacRijEmZYQaDpOYMXzfpTQFVy423yP5pZUuZe
         BMZKxJhI/ewH6Ftsr06lTVWW1tkNyGvAh7v2IUWSyFZGeUq79YKwYd1mEU6ImPRYZr78
         VMl851pNjcY+qv3RUCn9h+ub4D4WXl29cMbMtivWId46pHqj6GUP8678S6jzUtVvi142
         3Eon2QE1FAtJQgPBcjZt7EMiomAEB+YqEvnkVljyyVnz7CpQrgYMzAogg9aTmGGXcsgM
         dTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420085; x=1695024885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db9bU8/uuocihWjg7sGwKKLFZB9mNNDCw6o833i29ZU=;
        b=E+usiQ+Ns19sXpRmJaJNkFFppNtgZX6vckmige3xUfeh4QBgQgBMrp+dtF8cfcGaSc
         2LoCdsdNTUvo0igNEta0cM8+9wZq/K8kaJ3chL0AkonnJOCzJA039MU6I5jIdgTYc0bA
         KKrcwudX9RKouj1a3oVKUmE9vawXYyZJRC038EKBpJimQ+HaapxoP2GHriRC98ZgYuRv
         SDGoUCLKUxMq5iWdH6ISY7LPiXkYgkwHEFXsrlhjVpT6N9K8cmj/VsNPrNfMI2rNNjlh
         6Ut0BAjp37sN/YGCJxBm4LVfRNyPT6S/Hg/AwViPCflLzek7TiS5gSkQsLbrNDnWp/qR
         DdUg==
X-Gm-Message-State: AOJu0YxEK6GULLfvFx5NktguqD/8dD6w0WzGI1O+7sNi0wMstfGUf421
        +Sk/TM9SuHHOozYSUbHi5cTB755fWxJnUuKFCCTK1Q==
X-Google-Smtp-Source: AGHT+IHhbzjbUWOcSU0Pfb6mIoabKQEQsdwvsBt81bWC5rn1iMb7zHW7wrHZfK5uiaxHoN0oV5qWl64lYeODRzqVstA=
X-Received: by 2002:ac2:4c48:0:b0:500:c765:bbe with SMTP id
 o8-20020ac24c48000000b00500c7650bbemr8772240lfk.0.1694420084938; Mon, 11 Sep
 2023 01:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <ZP4QEvhzO5cOt6lT@gpdmax> <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
 <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
 <CAC_iWjLdA=gFkdB2LhOe9J-d_G=estenCWgYyCenqOYfZSFd+A@mail.gmail.com> <CAMj1kXEdb-76+ywfHK2zvchQqwMFi8HvG0O33A73d6-9AH=wDA@mail.gmail.com>
In-Reply-To: <CAMj1kXEdb-76+ywfHK2zvchQqwMFi8HvG0O33A73d6-9AH=wDA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 11 Sep 2023 11:14:09 +0300
Message-ID: <CAC_iWjL0ishwsLw+uqwLTMy3eNbaR6Tr5LZ9xUwqWG66amNOvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anisse Astier <anisse@astier.eu>, Jeremy Kerr <jk@ozlabs.org>,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 11 Sept 2023 at 11:06, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 11 Sept 2023 at 10:04, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Ard,
> >
> > On Mon, 11 Sept 2023 at 09:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Sun, 10 Sept 2023 at 22:42, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > On 9/10/23 20:53, Anisse Astier wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Sun, Sep 10, 2023 at 06:54:45AM +0200, Heinrich Schuchardt wrote:
> > > > >> Some firmware (notably U-Boot) provides GetVariable() and
> > > > >> GetNextVariableName() but not QueryVariableInfo().
> > > > >
> > > > >  From a quick search, it seems u-boot, does support QueryVariableInfo, is
> > > > > it on a given version ?
> > > > >
> > > > > https://elixir.bootlin.com/u-boot/v2023.07.02/source/lib/efi_loader/efi_variable.c#L391
> > > >
> > > > QueryVariableInfo() and SetVariable() are available before
> > > > ExitBootServices(), i.e. in Linux' EFI stub.
> > > >
> > > > ExitBootServices() results in calling efi_variables_boot_exit_notify()
> > > > which disables these services during the UEFI runtime.
> > > >
> > > > >
> > > > >>
> > > > >> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> > > > >> statfs syscall was broken for such firmware.
> > > > >
> > > > > Could you be more specific ? What breaks, and what regressed ? I imagine
> > > > > it could be some scripts running df, but maybe you had something else in
> > > > > mind ?
> > > >
> > > > Some more details can be found in
> > > > https://bugs.launchpad.net/ubuntu/+source/linux-meta-riscv/+bug/2034705.
> > > >
> > > > Though EFI variables are exposed via GetVariable() and
> > > > GetNextVariableName() the efivar command refuses to display variables
> > > > when statfs() reports an error.
> > > >
> > > > >
> > > > >>
> > > > >> If QueryVariableInfo() does not exist or returns an error, just report the
> > > > >> file-system size as 0 as statfs_simple() previously did.
> > > > >
> > > > > I considered doing this [2] , but we settled on returning an error
> > > > > instead for clarity:
> > > > > https://lore.kernel.org/linux-efi/20230515-vorgaben-portrait-bb1b4255d31a@brauner/
> > > > >
> > > > > I still think it would be a good idea if necessary.
> > > >
> > > > We should never break user APIs.
> > > >
> > >
> > > Indeed.
> > >
> > > > >
> > > > > On the approach, I prefer what Ard proposed, to fall back to the old
> > > > > approach. I think the difference in block size could also be a good
> > > > > marker that something wrong is happening:
> > > > > https://lore.kernel.org/linux-efi/CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com/
> > > >
> > > > This will allow user code making assumptions based on block size:
> > > > If block size > 1, assume setting variables is possible.
> > > >
> > > > We should really avoid this.
> > > >
> > >
> > > I agree that having different block sizes depending on which code path
> > > is taken is not great. But that is the situation we are already in,
> > > given that older kernels will always report PAGE_SIZE. And actually,
> > > PAGE_SIZE does not make sense either - PAGE_SIZE could be larger than
> > > 4k on ARM for instance, so the efivarfs block size will be dependent
> > > on the page size of the kernel you happened to boot.
> > >
> > > So I think we should go with the below:
> > >
> > > --- a/fs/efivarfs/super.c
> > > +++ b/fs/efivarfs/super.c
> > > @@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry,
> > > struct kstatfs *buf)
> > >         u64 storage_space, remaining_space, max_variable_size;
> > >         efi_status_t status;
> > >
> > > -       status = efivar_query_variable_info(attr, &storage_space,
> > > &remaining_space,
> > > -                                           &max_variable_size);
> > > -       if (status != EFI_SUCCESS)
> > > -               return efi_status_to_err(status);
> > > +       /* Some UEFI firmware does not implement QueryVariableInfo() */
> > > +       storage_space = remaining_space = 0;
> > > +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> > > +               status = efivar_query_variable_info(attr, &storage_space,
> > > +                                                   &remaining_space,
> > > +                                                   &max_variable_size);
> > > +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> > > +                       pr_warn_ratelimited("query_variable_info()
> > > failed: 0x%lx\n",
> > > +                                           status);
> > > +       }
> >
> > I think this is better, but shouldn't we initialize the status
> > variable now? Or is there more code following that I am missing?
> >
>
> status is not referenced again after this.

Ah fair enough. I'd still initialize it for sanity, but with or without
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
