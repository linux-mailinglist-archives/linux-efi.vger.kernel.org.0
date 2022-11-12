Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34AC626A7A
	for <lists+linux-efi@lfdr.de>; Sat, 12 Nov 2022 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiKLQOI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 11:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLQOH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 11:14:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD1B7EE
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 08:14:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F2A360C84
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 16:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C3AC433D6
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668269645;
        bh=jdBf9UdNQeTbRmO9rXER392vr/lzKpn0OPHSokRj32c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K1Msty77iBkqRRBBAtJauFgk1P18Q+CD/y0ZPcotXolFH7a6HHWwJGhRtxT7WzSdc
         BqdikkDCmyfpav9dBdnvyJfTsQdGCfxDbVjmzbIFiySYypuQ85KK4AyLCULMaSRrBW
         oUcqRelbZqlQwrx7mm/vFvHB1zJCkIZFFsksdZwQbbNMPb6nQSIauu5bruGrlZn5Vw
         WkfEucusAa3ryN2kf/L6Fo5mPrn5msekaaBI7vUmcytj0NeeRvb8Mzj3gNoPa6t8bP
         soMrtd2ArTNZweXYNEDKAQA6mkMT1a1n+9SqiSQufjJkL4Nl4zS8W4RtcWcHmLSb+i
         XJhHjRwT4OxIw==
Received: by mail-lf1-f46.google.com with SMTP id r12so12684291lfp.1
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 08:14:05 -0800 (PST)
X-Gm-Message-State: ANoB5pndYcmT1y9AE6w0FpPHBeMFUeRQcU6IyQHAfDlJRhMRvwMlzhG9
        D//xgl14kEgk6CgkadC7a8qXVBqA0NPLfwtEQQM=
X-Google-Smtp-Source: AA0mqf6vgbX/EmnhN3n/6K4uoFvdrVAIZtxX+arx3hIVF2Pkf5Lb2hPhwhQBO4vVvlcbpSTnXiDaqnLwNT33balOqVM=
X-Received: by 2002:a05:6512:e9a:b0:4b4:11c0:f572 with SMTP id
 bi26-20020a0565120e9a00b004b411c0f572mr2117986lfb.583.1668269643556; Sat, 12
 Nov 2022 08:14:03 -0800 (PST)
MIME-Version: 1.0
References: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de>
 <CAMj1kXEgzN2WdnYdNvywG1XMT4uhhn5RU_64-JyVBiMASox5rg@mail.gmail.com> <202211121626.12652.ulrich.gemkow@ikr.uni-stuttgart.de>
In-Reply-To: <202211121626.12652.ulrich.gemkow@ikr.uni-stuttgart.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 12 Nov 2022 17:13:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXENHPP4DjT+37HHo9=UYpi5HKEw-+hLmJHRKD+JzdQEmg@mail.gmail.com>
Message-ID: <CAMj1kXENHPP4DjT+37HHo9=UYpi5HKEw-+hLmJHRKD+JzdQEmg@mail.gmail.com>
Subject: Re: Regression in Linux 6.0.8 in Lenovo T14 Gen 3 when adding EFI
 boot entries
To:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 12 Nov 2022 at 16:26, Ulrich Gemkow
<ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
>
> Hello Ard,
>
> thanks for looking into this!
>
> On Saturday 12 November 2022, you wrote:
> > On Sat, 12 Nov 2022 at 14:42, Ulrich Gemkow
> > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > >
> > > Hello,
> > >
> > > calling efibootmgr for adding EFI boot entries with Linux 6.0.8 does
> > > not work on our Lenovo T14 Gen 3 (intel). The error is "EFI variables
> > > are not supported on this system". The directory /sys/firmware/efi/efivars/
> > > exists but is empty.
> > >
> > > This worked fine with the latest 5.19 kernel. The config was transferred
> > > from 5.19 to 6.0 with "make oldconfig". All kernels are self-compiled
> > > and without changes from the kernel.org downloads.
> > >
> > > I saw earlier messages about bugs in this area, the fixes applied
> > > seem to be not complete.
> > >
> > > Please let me know when additional information would help to debug.
> > >
> >
> > Hello Ulrich,
> >
> > Can you please share the complete kernel boot log when booting with
> > efi=debug, and the .config used to build the kernel? Thanks.
> >
>
> please find attached the two files. Please do not get confused about
> the kernel uname, the used kernel is 6.0.8. I use my own automated
> setup and build environment which requires a different naming.
>

Does it work if you enable CONFIG_EFI_STUB?
