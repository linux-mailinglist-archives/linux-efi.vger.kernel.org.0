Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9261E14A
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 10:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiKFJcK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 04:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKFJcJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 04:32:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A0B7F5
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 01:32:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D888B80B2A
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 09:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C587DC433D6
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667727125;
        bh=hrKGAFSqjvBzwpFLPAQbNKT50u5nvIj60PchBM9Sffg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mnGOD9RXXx4IEX7xmBluB46dFMeeNxLsl/8LQVnl7db+ymGFCuVN77srko5Rwv9NO
         zEaUi/fWteuPrJy0deoBNIQwV6D/bLkhBYqKz5+Bg4N8x9hbNrDMBti0cv0kIG65fC
         UaqW6/md4CZB6t6FxHq3RQQwSKZvTGgbay9TJ0oMOU1ozNDqaLjZeV1tKO9iNHvATj
         9rRtc/Plus/1/uEw0IsnPtsbKS7R0O9r+MtE5K+rnAnIHxuj6mvl3zFZvPjwIwgchj
         Q0RK1VcupAjGMh0ygngOuwwNyTf8+UdOZDB5He3nByxyVKGZwexSPTSCofWaoimScX
         vmJTVHL65JA9w==
Received: by mail-lj1-f179.google.com with SMTP id s24so12077726ljs.11
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 01:32:05 -0800 (PST)
X-Gm-Message-State: ACrzQf3gszggCwt4xj81tjBAs3BDxcUsSrqJpbqBBlNP+nFN3Fo1dSow
        YmkR5p7LRgzHczpYUFxaeALG+G3JUFvV+fQklUA=
X-Google-Smtp-Source: AMsMyM5gXVmDwAIL5xxarqQPEjC8eq7NB16vx1PVkipdfDNVnlBELGGHxPqbpbjejYb6dpqkHBifu5r+8zM+IszBsIA=
X-Received: by 2002:a05:651c:c6:b0:277:96a:5c32 with SMTP id
 6-20020a05651c00c600b00277096a5c32mr3911578ljr.415.1667727123824; Sun, 06 Nov
 2022 01:32:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
 <CAMj1kXFkp_W4P7twyZhM2mrP0PibOdWAwvKg-rb_jvh08RG_sg@mail.gmail.com>
 <CAHk-=wg2j9Fz-QVjmwqs+Uv9K-+rO9cviAokmvbFhwimtOGJpw@mail.gmail.com>
 <CAMj1kXG5q_UZuPUtifSxwstMBf4QD-Q0=gObk1WzLmMMegduqg@mail.gmail.com>
 <CAMj1kXHau=dVvSCBTDxqPeXiiXEYHTqQ_fBZym3D=4vaB9FMhg@mail.gmail.com> <9c937c47-4d5c-14f9-af6f-e28f6dd1c9dc@canonical.com>
In-Reply-To: <9c937c47-4d5c-14f9-af6f-e28f6dd1c9dc@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Nov 2022 10:31:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFirHeE2yZ2u-Tku_ywsu1xNGU5S7f+4+fQo_WxSuB42w@mail.gmail.com>
Message-ID: <CAMj1kXFirHeE2yZ2u-Tku_ywsu1xNGU5S7f+4+fQo_WxSuB42w@mail.gmail.com>
Subject: Re: Remove WARN_ONCE for unaligned UEFI region?
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 6 Nov 2022 at 03:29, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 11/5/22 23:43, Ard Biesheuvel wrote:
> > On Sat, 5 Nov 2022 at 22:54, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> (cc Heinrich and Ilias)
> >>
> >> On Sat, 5 Nov 2022 at 21:27, Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >>>
> >>> On Sat, Nov 5, 2022 at 1:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>
> >>>> Yeah just rip it out. In the beginning, we tended to make these
> >>>> warnings noisy so people will actually notice.
> >>>
> >>> Rip it out entirely, or replace ith pr_warn_once()?
> >>>
> >>
> >> A warning that can only trigger on 16k or 64k page size kernels
> >> clearly doesn't have a lot of coverage, so either we just drop it, or
> >> we make the warning use SZ_64K and not PAGE_SIZE.
> >>
> >> And if we keep the warning, it should be separate from the if(): when
> >> the regions are misaligned, we have to use RWX mappings because an
> >> adjacent region that gets covered by the same mapping might require
> >> it.
> >>
> >> Maybe I'll just whip up a patch myself.
> >>
> >>>> I'd still like to see a memory map (boot with efi=debug) so we can get
> >>>> this reported and fixed in uboot. We need that so 16k and 64k pages
> >>>> boot doesn't cause surprises with overlapping mappings.
> >>>
> >>> Here's the dmesg attached with efi=debug for your viewing pleasure.
> >>>
> >>
> >> Thanks.
> >>
> >> I've cc'ed the u-boot EFI maintainers, who take EFI spec compliance
> >> very seriously, so I'm sure we'll get this fixed quickly.
> >
> > Grrr looking at the spec, it seems the wording we proposed at the time
> > never made it in, and at the moment, it just reads:
>
> Could you, please, provide a link to the proposal.
>

No, I cannot, unfortunately. This was almost 10 years ago, and I was
at Linaro at the time. In the mean time, they have wiped my account.

But to be honest, I might be misremembering. This was before we had
the memory attributes table, and during the development of that, this
topic also came back.

In any case, let's use today's spec as a starting point for refining this.
