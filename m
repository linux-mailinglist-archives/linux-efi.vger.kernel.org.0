Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF88361E6E1
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKFWee (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 17:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKFWed (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 17:34:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451AA462
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 14:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03CB2B80BFB
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 22:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F8DC433D6
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667774069;
        bh=ArtA4jaDCXt2Ws6xCMc6dHFvmvrIx0ByTr+XvYBppks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c7Au8IO14WeYz6YJD5+/aTJ+qdQAZKPCCjiPDWVckdH61Dv71gEpbnL+GkQqHR1iB
         BBHzW+Zgc/dFUJEU2mq2aQTCaSI1TJIc71BTdKyni8Mw0DU5xNbixCtKQd8n22aKQs
         EShAVxKb1LUNQyUhMd/rwRXQAFAn5gUiiVaarcl5KhoQOztNWnQIVESNRaqOVZf9Tj
         OpXcZIR6xwMypSp0ZpJfPTIEGnUq4zCYlf59uOfYKLDDNBrlaFWWQhr9ZGTI3tKhpv
         lX2SePNqWItECS1VHAKlsqAjbzCBeToXG59Y1O57r02DltOJUgnGyQuTi7dj/xTNSo
         5rzKHiiyWJa8g==
Received: by mail-lf1-f46.google.com with SMTP id p8so14443358lfu.11
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 14:34:29 -0800 (PST)
X-Gm-Message-State: ACrzQf06G78WhBGiE+5vcHMEgZPNdHhqrDP0MRoYlOkryqJivg0kau2S
        Bci01ZUlwq5YmQrNn+jPdCnPqRE0XYAfFp/j/kI=
X-Google-Smtp-Source: AMsMyM7Us/l+O0YBWu3bOgv6qHdAyi4g/wnB70OFNW10dV8Z8I6Izp2JP8/If4Iqyzp1fwQrHbjWlDgbFeyKX43Kuvk=
X-Received: by 2002:a19:4f53:0:b0:4b1:1f35:279b with SMTP id
 a19-20020a194f53000000b004b11f35279bmr10542029lfk.637.1667774067544; Sun, 06
 Nov 2022 14:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20221106145354.3876410-1-ardb@kernel.org> <CAHk-=wgQaL8Xudo-yhr8WTn7KJy=xUBw9+va-6_K=fdOY5xuOw@mail.gmail.com>
In-Reply-To: <CAHk-=wgQaL8Xudo-yhr8WTn7KJy=xUBw9+va-6_K=fdOY5xuOw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Nov 2022 23:34:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHunuPfWj=rCsxR4MzNBLtSyogUY57jqd7DZyZsJmitmw@mail.gmail.com>
Message-ID: <CAMj1kXHunuPfWj=rCsxR4MzNBLtSyogUY57jqd7DZyZsJmitmw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: efi: Fix handling of misaligned runtime regions
 and drop warning
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 6 Nov 2022 at 20:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Note: in quoting the patch below, I removed the '-' lines, so the
> quoted part is really just all that remains after the patch ]
>
> On Sun, Nov 6, 2022 at 6:54 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > +       if (region_is_misaligned(md)) {
> > +               static bool __initdata code_is_misaligned;
> > +
> >                 /*
> > +                * Regions that are not aligned to the OS page size cannot be
> > +                * mapped with strict permissions, as those might interfere
> > +                * with the permissions that are needed by the adjacent
> > +                * region's mapping. However, if we haven't encountered any
> > +                * misaligned runtime code regions so far, we can safely use
> > +                * non-executable permissions for non-code regions.
> >                  */
> > +               code_is_misaligned |= (type == EFI_RUNTIME_SERVICES_CODE);
> > +
> > +               return code_is_misaligned ? pgprot_val(PAGE_KERNEL_EXEC)
> > +                                         : pgprot_val(PAGE_KERNEL);
> > +       }
>
> Ok, this seems like a nice improvement, in how it only does
> PAGE_KERNEL_EXEC if any of the regions end up being code.
>
> At the same time this is a much bigger change than just changing the
> WARN_ONCE() to pr_warn_once(), so rather than me applying it directly
> to my tree, I think I'd prefer it to go through the proper channels
> and the usual way.
>
> I'll still apply it to my private "this is the tree I actually boot on
> my M2" testing tree, since that has all the other Asahi patches too.
> That way I won't see the warning myself on that machine.
>
> So "Acked-by" on the patch, and I hope I'll see it with a future arm64
> or EFI pull request (and I'll holler loudly if it actually causes any
> issues on my M2, but I obviously don't expect it to)
>

Thanks for the ack. I'll drop it in the EFI fixes branch and let it
soak in -next for the week.
