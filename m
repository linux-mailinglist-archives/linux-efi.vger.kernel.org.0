Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CC961DF29
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 23:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKEWnq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEWnp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 18:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084912A84
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 15:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F808B808C7
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 22:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5552C433B5
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667688221;
        bh=V1njG/Wof8OJSEbtdd3htwP2KmAVsFUvXgwPl1FWBb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BlHjifr5Qy9kBQ6aiOXIpO5afrNeIt2QPJbrtHEz/SObUeg+HJv8nGd2G88gqm1zO
         q6qhn2rGRD74TnILc6vSRT3Qn+0c4NSimvC+8jFZUY4owh/N3ZfwfrFMYSCEjHmnU/
         SurCCGPPRucEH2DENGjYDpfnryqe/SyxTIrI5+w8vDcG0TnHEQC4UHg1epdNeWLwcJ
         Anq2ZPFnyDgoqLA3MxsmIkP7d12WR/k0qVWkr5J3vDxvTU+m1siiu9kadm7hXowIGN
         M461iHTG1VbZ/YJoCQ7ciImhX8XdtfFYFvg8eN0KBD7thBSYX2u83Mv5vV0tLq5K8Q
         lQqHI/K6S3VUg==
Received: by mail-lf1-f49.google.com with SMTP id be13so12029290lfb.4
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 15:43:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf16kMjYhAg2kWXm6XuW7y6WuJJTRO3w9mclRbPUg2r4bNfjtvr/
        Ilohqt5rVT7yYWleEIAkoi46Bhy1fmeYVcBm8H0=
X-Google-Smtp-Source: AMsMyM4O13IyOofs8qDD+WEXIRKKBvz9pbtxekEIvmxzddmY+DuHBB1vnfxHKosaDL8lMUrakzCDSa9RyIw6RlomJK0=
X-Received: by 2002:a05:6512:151b:b0:4af:e7d3:4a46 with SMTP id
 bq27-20020a056512151b00b004afe7d34a46mr15011844lfb.583.1667688219955; Sat, 05
 Nov 2022 15:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
 <CAMj1kXFkp_W4P7twyZhM2mrP0PibOdWAwvKg-rb_jvh08RG_sg@mail.gmail.com>
 <CAHk-=wg2j9Fz-QVjmwqs+Uv9K-+rO9cviAokmvbFhwimtOGJpw@mail.gmail.com> <CAMj1kXG5q_UZuPUtifSxwstMBf4QD-Q0=gObk1WzLmMMegduqg@mail.gmail.com>
In-Reply-To: <CAMj1kXG5q_UZuPUtifSxwstMBf4QD-Q0=gObk1WzLmMMegduqg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Nov 2022 23:43:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHau=dVvSCBTDxqPeXiiXEYHTqQ_fBZym3D=4vaB9FMhg@mail.gmail.com>
Message-ID: <CAMj1kXHau=dVvSCBTDxqPeXiiXEYHTqQ_fBZym3D=4vaB9FMhg@mail.gmail.com>
Subject: Re: Remove WARN_ONCE for unaligned UEFI region?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Nov 2022 at 22:54, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Heinrich and Ilias)
>
> On Sat, 5 Nov 2022 at 21:27, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, Nov 5, 2022 at 1:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > Yeah just rip it out. In the beginning, we tended to make these
> > > warnings noisy so people will actually notice.
> >
> > Rip it out entirely, or replace ith pr_warn_once()?
> >
>
> A warning that can only trigger on 16k or 64k page size kernels
> clearly doesn't have a lot of coverage, so either we just drop it, or
> we make the warning use SZ_64K and not PAGE_SIZE.
>
> And if we keep the warning, it should be separate from the if(): when
> the regions are misaligned, we have to use RWX mappings because an
> adjacent region that gets covered by the same mapping might require
> it.
>
> Maybe I'll just whip up a patch myself.
>
> > > I'd still like to see a memory map (boot with efi=3Ddebug) so we can =
get
> > > this reported and fixed in uboot. We need that so 16k and 64k pages
> > > boot doesn't cause surprises with overlapping mappings.
> >
> > Here's the dmesg attached with efi=3Ddebug for your viewing pleasure.
> >
>
> Thanks.
>
> I've cc'ed the u-boot EFI maintainers, who take EFI spec compliance
> very seriously, so I'm sure we'll get this fixed quickly.

Grrr looking at the spec, it seems the wording we proposed at the time
never made it in, and at the moment, it just reads:

"""
If a 64KiB physical page contains any 4KiB page with any of the
following types listed below, then all 4KiB pages in the 64KiB page
must use identical ARM Memory Page Attributes:
=E2=80=94 EfiRuntimeServicesCode
=E2=80=94 EfiRuntimeServicesData
...
"""

The problem here is that it doesn't take permission attributes into
account, allowing the firmware to cram code and data regions into the
same 64k page, and instructing the OS to use R-X for the code and RW-
for the data, which it cannot do if it uses 16k or 64k pages.

So let's drop the warning and add it back later once the spec actually
supports it.

Patch on its way ...
