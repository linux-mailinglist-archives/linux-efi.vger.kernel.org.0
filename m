Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234B70B51B
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjEVGeG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 02:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjEVGeE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 02:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D3C102;
        Sun, 21 May 2023 23:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F268C61CCE;
        Mon, 22 May 2023 06:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE1CC433D2;
        Mon, 22 May 2023 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684737241;
        bh=5QejO/8RzBizb4dikXLmKT91Why1bpOl1mj4A6dWHS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UXzZ7Nq2TrOuSeLncmjsBxOsC9Uj1Boyqh5UDf0lZ2amargXwk8dOQEnxJXpgGSax
         gHTRYjjz3lJ1vWsaU6YX2SFtMl8BX6DycmHlqj6VZCtof3Sk8exGQlgTl9HlwCYGMj
         1zsCN9y5ovw7QG4uzE6/+7j2hP/VZW2fkeu3E6Z8hkFxqpDJuQsiZFH7vIMWvvHAf5
         Xe3/QZKyB/4ALuD9mi5psVTMMDO7vL24smF4PWVz5jgntOha7DwJVxZjjnEmBmnZNx
         lK0EtQJ1+xYjeh/l8wTJWQWrzTnzQy1j6a2g74O7/vCbm7hbQxdqTx9Z9X5Af4D+v3
         JuO8wmZxeyFVw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4eed764a10cso6202408e87.0;
        Sun, 21 May 2023 23:34:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDyYeDV8IU0vGOJBxYB5iEyon0x8E824Tfzb67J5WCiNCf9WFPjj
        oIkuMmraURr0YoKCMWevtz2rzzZYoJny4RxnSwQ=
X-Google-Smtp-Source: ACHHUZ6XN3+gQDN1GWBgXFJoCR3MjEnZ8hjJL7PpAQeD4JQq3JEmZ2u9XtHaZ0eKb8xVC6Bpygj3+aYd9NdI/J9Xblo=
X-Received: by 2002:a19:c202:0:b0:4f3:9001:848c with SMTP id
 l2-20020a19c202000000b004f39001848cmr2878257lfc.33.1684737239417; Sun, 21 May
 2023 23:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <8a79151b-ef75-08ad-ae3d-f6cdabfeaa47@gmail.com> <CAKbZUD3FBiaLGWq=TipfevqXP0SBz8F+=L6JSO+FMZOv0QQ9AQ@mail.gmail.com>
In-Reply-To: <CAKbZUD3FBiaLGWq=TipfevqXP0SBz8F+=L6JSO+FMZOv0QQ9AQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 08:33:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJj4+CFX3YfCZZu7RwxoVf=5PHZcZ8tG7x8xO3x4KPAw@mail.gmail.com>
Message-ID: <CAMj1kXEJj4+CFX3YfCZZu7RwxoVf=5PHZcZ8tG7x8xO3x4KPAw@mail.gmail.com>
Subject: Re: Regression. -6.3.X Good. -6.4-rcY Bad.
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux EFI <linux-efi@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Bartlett <ajb@elrepo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 22 May 2023 at 03:15, Pedro Falcato <pedro.falcato@gmail.com> wrote=
:
>
> On Mon, May 22, 2023 at 1:43=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > I notice a simple build-time regression on Bugzilla [1]. Quoting from i=
t:
> >
> > > This is a very simple to see regression.
> > >
> > > On arm64 hardware, take any one of the -6.4-rcY tarballs created by L=
inus. Extract the contents of the tarball and cd to the linux-6.4-rcY direc=
tory. Issue a "make clean" or a "make mrproper" or a "make distclean" comma=
nd. Look at the output (there should not be any). In every case, the output=
 is --
> > >
> > > nm: 'vmlinux': No such file
> > >
...
> > > # first bad commit: [45dd403da851124412d32e3193c21de4a51d29da] efi/zb=
oot: arm64: Inject kernel code size symbol into the zboot payload
> > >
> > > Reverting the commit 45dd403da851124412d32e3193c21de4a51d29da resolve=
s the problem.
> >
> > The regression looks like arm-specific, but the first bad commit
> > IMO isn't related to kbuild system.
> >
> > Anyway, I'm adding it to regzbot:
> >
> > #regzbot introduced: 45dd403da85112 https://bugzilla.kernel.org/show_bu=
g.cgi?id=3D217468
> > #regzbot title: nm vmlinux ENOENT when "make mrproper" on arm64
>

How on earth is this a regression? It is not even a build error, only
a warning, with no adverse impact whatsoever on the resulting
binaries.

Could we stop being so trigger happy when calling things regressions, pleas=
e?

> I was able to track down the issue.
> In line 47, arch/arm64/boot/Makefile, a variable (that gets expanded
> on use, hence =3D and not :=3D) gets defined, that requires vmlinux to
> exist (see the $(shell) invocation).
> drivers/firmware/efi/libstub/Makefile.zboot then defines a variable
> with :=3D, which expands on site and not when it actually needs to be
> used. This expands EFI_ZBOOT_OBJCOPY_FLAGS without vmlinux existing,
> which ENOENTs.
>
> The below patch should fix it. I'm not submitting an actual patch
> because I simply don't know if there are any possible side effects
> here (although it frankly seems unlikely).
>
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot
> b/drivers/firmware/efi/libstub/Makefile.zboot
> index 89ef820f3b3..3fb39dea114 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -32,7 +32,7 @@ zboot-size-len-$(CONFIG_KERNEL_GZIP)   :=3D 0
>  $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
>         $(call if_changed,$(zboot-method-y))
>
> -OBJCOPYFLAGS_vmlinuz.o :=3D -I binary -O $(EFI_ZBOOT_BFD_TARGET)
> $(EFI_ZBOOT_OBJCOPY_FLAGS) \
> +OBJCOPYFLAGS_vmlinuz.o =3D -I binary -O $(EFI_ZBOOT_BFD_TARGET)
> $(EFI_ZBOOT_OBJCOPY_FLAGS) \
>                           --rename-section
> .data=3D.gzdata,load,alloc,readonly,contents
>  $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
>         $(call if_changed,objcopy)
>

Thanks for the fix. So the reason I used =3D and not :=3D in the first
place in the assignment of EFI_ZBOOT_OBJCOPY_FLAGS was to ensure that
it will not be evaluated eagerly, but obviously, forcing the eager
evaluation further down defeats that.

I've sent this out as a patch and queued it up as a EFI fix. Thanks!
