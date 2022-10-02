Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C285F256B
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJBVPw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJBVPv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 17:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D01303F1
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 14:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63F18B80DCC
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 21:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284A5C433D7
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664745342;
        bh=fif8ds8n4eDUkiz/aYPaXcQDSWmGy5qhYTQd0ohG7/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IE4ckpJUYxErJbu05GIhrnKhMGpcdkANYbIU9Hd2mBIUJHS+m1DEPSh2JGuyanUmm
         5uMG8rkr2dzw7r4yvC1ROCpAzFgpwKOKN+2T7l/UOCJCSENTM8fn6maxTb7Xad8OdB
         kZznsBB92z9zg72Yv33xTbWj6CvNks+S5N0HqWoC/CKTO/lewETuZ96+izdfcIcXuP
         /MYILCvoWdlOYKsi0TN/UP6CcFwcwxHTJf6dvN2NPBBK9YAmht+xKAGUHnTZcSaqsK
         /NLRdOANKC/f8MMLXf4z62XdI3n+INnV/MSSJucjBBt3+W7r4PdJvkyWf6/R3neovh
         nSfWpQh3FiaEg==
Received: by mail-lf1-f44.google.com with SMTP id z4so14094748lft.2
        for <linux-efi@vger.kernel.org>; Sun, 02 Oct 2022 14:15:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf1S+qSPRgvSTInToNMyNfu/DH/ycW9YltrXr1eMFUiCwJ+n+LGh
        NurjmHX6DmUx6H3DmptIplRkJRkc+OeVhUme0xs=
X-Google-Smtp-Source: AMsMyM6tYPVzwKKftmZbnrndz5JpXCbaHaK+dvF6XEkhG5mdsYQkpUqxFADg6glx7cAHziDS519snNk2E8JvT/gqOek=
X-Received: by 2002:ac2:5cb7:0:b0:4a2:2ac4:cff1 with SMTP id
 e23-20020ac25cb7000000b004a22ac4cff1mr2396963lfq.110.1664745340138; Sun, 02
 Oct 2022 14:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221002150037.ad3tgbllhvt6zwwy@tartarus.xdbob.net>
 <CAMj1kXGqtoX7yVgCu+5mmFUiRCytyxrgJnRjD6LwnA4C-L6=2w@mail.gmail.com> <20221002170624.sp2zyeoowqv4fjnu@tartarus.xdbob.net>
In-Reply-To: <20221002170624.sp2zyeoowqv4fjnu@tartarus.xdbob.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 2 Oct 2022 23:15:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjMH7eC2FMAa_knYt7+V1976r0RGLcdcS5o1v-PdhCYQ@mail.gmail.com>
Message-ID: <CAMj1kXHjMH7eC2FMAa_knYt7+V1976r0RGLcdcS5o1v-PdhCYQ@mail.gmail.com>
Subject: Re: Disable lockdown while keeping SecureBoot enabled
To:     Antoine Damhet <antoine@damhet.fr>
Cc:     Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2 Oct 2022 at 19:06, Antoine Damhet <antoine@damhet.fr> wrote:
>
> On Sun, Oct 02, 2022 at 05:28:16PM +0200, Ard Biesheuvel wrote:
> > On Sun, 2 Oct 2022 at 17:00, Antoine Damhet <antoine@damhet.fr> wrote:
> > >
> > > Hello,
> > >
> > > Since `5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1`[1] I can't have both
> > > SecureBoot enabled and lockdown disabled (I need to do that to allow
> > > undervolting on my intel laptop).
> > >
> > > My current bootchain is:
> > >
> > > systemd-boot -> kernel+initrd+cmdline as a unified kernel image and
> > > signed using a personal custom key. I don't use the shim loader.
> > >
> > > Until now I disabled the lockdown by setting the `MokSBState` +
> > > `MokSBStateRT` UEFI variables to 1. Now they need to be volatile.
> > >
> >
> > OK, so this means the patch works as intended: MokSBState is owned by
> > shim, and you are not booting via shim, and so honouring those
> > variables was a bug.
> >
> > > Would you be open to either add a variable or a command-line argument to
> > > disable the kernel lockdown while keeping SecureBoot enabled ?
> >
> > Can't you just omit the lockdown LSM from your kernel build?
>
> It would probably work but I'm using a downstream Fedora build, I
> would rather find a solution that would work in a default configure
> state (eg: that distributions would be willing to use) if it's possible.
>

The distro kernels enable lockdown by default if secure boot is
enabled, and the way to override that is to use shim and put it into
insecure mode. So you have plenty of options here:
- build your kernel without the lockdown LSM
- use the distro kernel with shim
- create a [signed] driver or uefi app that sets the volatile
variable, and install it as a Driver### or SysPrep#### boot option

Adding command line options or any other setting that is not signed
and is persistent kind of defeats the purpose, so I don't see a point
in adding support for that.
