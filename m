Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165155F9B87
	for <lists+linux-efi@lfdr.de>; Mon, 10 Oct 2022 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiJJI7n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Oct 2022 04:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiJJI7l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Oct 2022 04:59:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2142708;
        Mon, 10 Oct 2022 01:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C80B80E70;
        Mon, 10 Oct 2022 08:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC634C433C1;
        Mon, 10 Oct 2022 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665392377;
        bh=xUa1B1l792YHt2qun71OdXrrwiiFrDo6W5sNDzWzSno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p01VcfKQt2kuZxS0yXzigTZQhox58Zs89LsJ2yd09W6CWpSaq1bUXWr/3xketYtdW
         slVoL3F6ZQOPPY/K4QLmbjaAdna06blfRUrEhZ2kgJTcV1Wt+pLOaH6kzeTk2bo36n
         9asrtK2hMuLxxzXbIwhhTUH3JVDNv7JajAWdeqwMNuqUyNBSgqolbWumgj3m6IcLnu
         ocM0qVXxiELjGpsmCZeyrPoBjL03P9anOsUc4TwAsQycnsaziCAzbtESdm593Zpz58
         br1TIsvTOEiTKQm3OPnb95l15YgUW7k/XnxxkB0y6E6IQrK9NVE0oH7usbel2udkMT
         knpiB5+2IrhCg==
Received: by mail-lf1-f54.google.com with SMTP id a29so15659251lfo.1;
        Mon, 10 Oct 2022 01:59:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf2b6OE6QLM/KE3wVS5BFVDxeXfkpiPTTcyUp3zZOJgDlsXM0voG
        ND09jPz2nD3ix3Cd+lHw54ed//bGjdSjp2fVz+A=
X-Google-Smtp-Source: AMsMyM5PGuS9COeDEd+Uu2AnKZW6EBRKKeSXg2/jjsRgEQK+G+cVWP3jHpTn82AY6fOvCNIen5qQLBCHcykdBnivA7E=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr6067531lfb.583.1665392375898; Mon, 10
 Oct 2022 01:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221007172918.3131811-1-ardb@kernel.org> <Y0GOKnD89SOjGzCf@nazgul.tnic>
 <CAMj1kXHK_9iDT8CSHnZ15yB+Z=+haZXjbQ99m20jQUr0NScK4Q@mail.gmail.com> <Y0GcZQZTaCgoNFGa@nazgul.tnic>
In-Reply-To: <Y0GcZQZTaCgoNFGa@nazgul.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 10:59:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE6L+aNJCCcq=A3q=oG-e83JA=iA1ujSaat0BRjgyH0XA@mail.gmail.com>
Message-ID: <CAMj1kXE6L+aNJCCcq=A3q=oG-e83JA=iA1ujSaat0BRjgyH0XA@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Make the deprecated EFI handover protocol optional
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 8 Oct 2022 at 17:51, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Oct 08, 2022 at 05:41:40PM +0200, Ard Biesheuvel wrote:
> > Yeah most distros have ~100 ore more patches against GRUB, but this
> > isn't actually their fault. GRUB maintainership was defunct for a
> > number of years, which is why we were stuck on GRUB version 2.02-beta3
> > for such a long time. But in recent years, things have been getting
> > better, and there is an agreement with the current maintainer not to
> > merge the EFI handover protocol, and merge the new EFI protocol based
> > initrd loading method instead, which works on all architectures
> > instead of only on x86.
>
> Aha, ok.
>
> > Never tried that in .S files but I guess it should just work.
>
> If not, at least in the .c files.
>
> > I'd venture a guess that this will break the boot even your own x86
> > boxes, given that almost nobody uses plain upstream GRUB..
> >
> > I can work with the distros directly to start disabling this in their
> > downstream configs once their GRUB builds are up to date with the new
> > changes, so we can phase this out in a controlled manner.
>
> Hm, that might turn out to be a multi-year effort considering how the
> enterprise distros' kernels are moving. Yeah, yeah, they have good
> reasons and so on.
>

Yes, this is going to take time. But we simply cannot get rid of it
today, so the choice we have is between doing nothing at all, or
taking the next step in phasing out this stuff.

-- 
Ard.
