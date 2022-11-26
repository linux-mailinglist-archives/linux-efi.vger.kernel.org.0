Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CD863964E
	for <lists+linux-efi@lfdr.de>; Sat, 26 Nov 2022 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiKZOQZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Nov 2022 09:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZOQY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Nov 2022 09:16:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254D1D30B
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 06:16:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C11DB811A3
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 14:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F9CC4347C
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669472180;
        bh=j2dP27BREILsixgq78ObbeEfjycpQjysrlO+l5htKJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VG8vu+rBy2h3qAfYWyvMj+mIcmz7o3wIt8m5UG8xDSsby32wSmKEuJGKSzl0MIvDD
         12Z250j7QVIyl2b79oQlXLYOyf+QR5xbMdVUjX3jkiFYGjapx7pqpbIC/W71IL84Tp
         jw75s6zuTPpken1EP7jaBCuVKBIz/KlmC9VfuEL8JpOo1EAawQlLKBg7VaahSAkX6k
         y8PbpuRISGjlkXvt9tTwzd11kgmTeZXFZmO0A1zbGE1zijYFChLM4YzxDJmM0Pn66G
         RfS40xO5VGPtSFoZam7i2lUDLXRlQ2SXAp8kKHt1viLt+GN5g48lBvcxSQhuDMWs4u
         DH4DQfMnwI6Qg==
Received: by mail-lj1-f173.google.com with SMTP id z4so8149860ljq.6
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 06:16:20 -0800 (PST)
X-Gm-Message-State: ANoB5pkzoU3k3QT/K7sCGpRUXrWvV9WetHpR1PzuwQGh6DSy7MmgG+m2
        1VAXX+4VLyCrKrN00W85RjIBZsUJ2JwtHGWsK58=
X-Google-Smtp-Source: AA0mqf6LqTiH2i4NVZ9BOJAR2/NHYkiSyGNLVlOoiOQJUOuncmt1DTcS3Q5u24keG+r6Q3MmIfn44qEIuz169/wVli4=
X-Received: by 2002:a05:651c:1056:b0:279:96cd:8c66 with SMTP id
 x22-20020a05651c105600b0027996cd8c66mr1733581ljm.352.1669472178782; Sat, 26
 Nov 2022 06:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20221108182204.2447664-1-ardb@kernel.org> <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
 <20221115111658.GA32523@willie-the-truck> <CAMj1kXFGakOpTyUqDrFGDRoRsSzG2bYQ=iZA86DahbjL_zvE7w@mail.gmail.com>
 <20221115113134.GC32523@willie-the-truck>
In-Reply-To: <20221115113134.GC32523@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 26 Nov 2022 15:16:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdJHvT-XKaEC0tXpxM_RMfCic_sS-JkMkVYfKZCYkZuA@mail.gmail.com>
Message-ID: <CAMj1kXFdJHvT-XKaEC0tXpxM_RMfCic_sS-JkMkVYfKZCYkZuA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 15 Nov 2022 at 12:31, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Nov 15, 2022 at 12:21:55PM +0100, Ard Biesheuvel wrote:
> > On Tue, 15 Nov 2022 at 12:17, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, Nov 11, 2022 at 05:36:19PM +0000, Mark Rutland wrote:
> > > > On Tue, Nov 08, 2022 at 07:21:57PM +0100, Ard Biesheuvel wrote:
> > > > > The purpose of this series is to remove any explicit cache maintenance
> > > > > for coherency during early boot that becomes unnecessary if we simply
> > > > > retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> > > > > and use it to populate the ID map page tables. After setting up this
> > > > > preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> > > > > TCR and SCTLR registers as before, and proceed as usual, avoiding the
> > > > > need for any manipulations of memory while the MMU and caches are off.
> > > > >
> > > > > The only properties of the firmware provided 1:1 map we rely on is that
> > > > > it does not require any explicit cache maintenance for coherency, and
> > > > > that it covers the entire memory footprint of the image, including the
> > > > > BSS and padding at the end - all else is under control of the kernel
> > > > > itself, as before.
> > > >
> > > > As a high-level thing, I'm still very much not keen on entering the kernel with
> > > > the MMU on. Given that we have to support booting with the MMU off for !EFI
> > > > boot (including kexec when EFI is in use), I think this makes it harder to
> > > > reason about the boot code overall (e.g. due to the conditional maintenance
> > > > added to head.S), and adds more scope for error, even if it simplifies the EFI
> > > > stub itself.
> > >
> > > As discussed offline, two things that would help the current series are:
> > >
> > >   (1) Some performance numbers comparing MMU off vs MMU on boot
> > >

Finally got around to measuring this - I lost access to my TX2 machine
for a couple of days during the past week,

With the patch below applied to mainline, I measure ~6 ms spent
cleaning the entire image to the PoC (which is the bulk of it) and
subsequently populating the initial ID map and activating it.

This drops to about 0.6 ms with my changes applied. This is unlikely
to ever matter in practice, perhaps, but I will note that booting a VM
in EFI mode using Tianocore/EDK2 from the point where KVM clears the
counter to the point where we start user space can be done (on the
same machine) in 500-700 ms so it is not entirely insignificant
either.

I could try and measure it on bare metal as well, but I suppose that
launch times are even less relevant there so I didn't bother.
