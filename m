Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521E94F53F1
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiDFEEX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573148AbiDESCz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 14:02:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB58EBB9D;
        Tue,  5 Apr 2022 11:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05824B81F46;
        Tue,  5 Apr 2022 18:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E3CC385A9;
        Tue,  5 Apr 2022 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649181653;
        bh=DEsPoEU/5E2aHVZgQZCveB9mC/4vVgGzX7eDnKQsH1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WMBUPiXVn4jIQOTsqBIO5vrfkhbqjHt/h5chaD/wedjcngfWcwTLh8h2oi1DE6HDX
         dzaPOcbmTH8LZnQcfebDxTtYx2gqmevPCKAk4URCFU4AdFBqSRdcVso5GsMpG3wunl
         eorVXyUYwCq8OJ4dXIzo1OANkewLZNXlZf4ySbWxfEjAqfqp5e85PEiEXkY4fDWO3E
         wg3Z2xs3ne4ObjHj1ZPtBzQzLqeHHfDB0IuGDztVbIfZY8VOlMi6EXW4Uty471eAkH
         58TvAlMhDwmLmpkSKu51sdGtU49ep+8xapGkk7+J9U82gXjbzphShbQR5EV0Xooq83
         VWMHsLVvxbkyQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-de48295467so224592fac.2;
        Tue, 05 Apr 2022 11:00:53 -0700 (PDT)
X-Gm-Message-State: AOAM5322x8xzMvuoZsOtOxes/AEuidd6XLZhgwhKZZWjyrrfvxnKdGWt
        3bwn0vFzeWhdA19MJywcTKqvTSAOV4FkrWWlMX0=
X-Google-Smtp-Source: ABdhPJyVj5hV5enQfSRyb6Ywt5+n+is6l9llY4/UZnczlt0FqbI9Kjr5WpW5ZDCur6hEypd5gKBpIfcsLtQ1wmevZ7g=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr2221796oap.228.1649181652698; Tue, 05
 Apr 2022 11:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220321045853.3324-1-akihiko.odaki@gmail.com> <87bkxfebsu.fsf@meer.lwn.net>
In-Reply-To: <87bkxfebsu.fsf@meer.lwn.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 5 Apr 2022 20:00:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGHQm7yy2QPCEVRiXBzb8HWOHzKMCuoS+mbnBKujEXQnA@mail.gmail.com>
Message-ID: <CAMj1kXGHQm7yy2QPCEVRiXBzb8HWOHzKMCuoS+mbnBKujEXQnA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Remove references of EFI earlyprintk from documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akihiko Odaki <akihiko.odaki@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 5 Apr 2022 at 18:26, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Akihiko Odaki <akihiko.odaki@gmail.com> writes:
>
> > x86 EFI earlyprink was removed with commit 69c1f396f25b ("efi/x86:
> > Convert x86 EFI earlyprintk into generic earlycon implementation").
>
> So I will confess that I don't know this area well enough to know
> whether this patch makes sense or not.  To help with that, it would have
> been good to CC Ard, who is the author of the patch you cite above.
> Adding him now.
>
> Ard, do you agree with this change (preserved below)?
>

Yes, it looks fine to me.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f5a27f067db9..fb39337f4123 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1252,7 +1252,7 @@
> >                       Append ",keep" to not disable it when the real console
> >                       takes over.
> >
> > -                     Only one of vga, efi, serial, or usb debug port can
> > +                     Only one of vga, serial, or usb debug port can
> >                       be used at a time.
> >
> >                       Currently only ttyS0 and ttyS1 may be specified by
> > @@ -1267,7 +1267,7 @@
> >                       Interaction with the standard serial driver is not
> >                       very good.
> >
> > -                     The VGA and EFI output is eventually overwritten by
> > +                     The VGA output is eventually overwritten by
> >                       the real console.
> >
> >                       The xen option can only be used in Xen domains.
> > --
> > 2.35.1
