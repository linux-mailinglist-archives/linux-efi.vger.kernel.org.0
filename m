Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF361F9B3
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 17:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiKGQ3X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 11:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiKGQ2w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 11:28:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9147A26482
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 08:26:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DDF161196
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 16:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C60C433D7
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667838391;
        bh=7y7VyWtg4M7PIYgvhwlqp8qXJrIhWE2L2TKJY8envvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I9oVwGCAb0M8EPIANCt1dcrYuPfJbM41SvbuHUzljNTsKzxcu35UXgs/YRBvcsHyZ
         KZQSbBdLRmmwPzqZPM8quTB3CvzA5KNttQOfapZx7xCokcfNPk9xrYav0L9U3vG75r
         EMpA6QnqATMuQaqJavCCD9B16ulxLuFlmD6a+6Xv1QRdao9Q9vKxA3TuAYTquQJMbH
         xhuhmrrWsk41XvJ1FKT4gWVUBBAybyBe1RmbZ5Nf/8A9ne5paseOinfLi/4NGtSSAF
         iKtHEVuGWvbRV1VJQDNepfNMt/t5xCNucpOUXKi4L2+Oh6OmXUIGX/HJYhHKQ20qwn
         F4W2D55nQ1Kwg==
Received: by mail-lj1-f180.google.com with SMTP id d20so17066080ljc.12
        for <linux-efi@vger.kernel.org>; Mon, 07 Nov 2022 08:26:31 -0800 (PST)
X-Gm-Message-State: ACrzQf0p2dvvv8u/btlrNc0XBPwNjudyCpo3v8VjVRsnVN4wK3KcS5SX
        svSR8V3VFkano5OKibMCdW2JFZG3c9jGzwhLIhg=
X-Google-Smtp-Source: AMsMyM43WEp7EqE50MuUDOLJA00VTvmSlEJWGoU2AZIHmmCn9McZGidPoGJEUc3o+8maQjJrFRgMjQl3GjNAm5G72o0=
X-Received: by 2002:a2e:87cd:0:b0:277:3662:3be4 with SMTP id
 v13-20020a2e87cd000000b0027736623be4mr17245522ljj.415.1667838389591; Mon, 07
 Nov 2022 08:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20221018110441.3855148-1-ardb@kernel.org> <20221107161222.GE21157@willie-the-truck>
In-Reply-To: <20221107161222.GE21157@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Nov 2022 17:26:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFf4CqRBgSXFcuHF2op+-oDg-DcYvfSMJw7rN-Y7VDU9w@mail.gmail.com>
Message-ID: <CAMj1kXFf4CqRBgSXFcuHF2op+-oDg-DcYvfSMJw7rN-Y7VDU9w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] arm64: efi: leave MMU and caches on at boot
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 7 Nov 2022 at 17:12, Will Deacon <will@kernel.org> wrote:
>
> Hi Ard,
>
> On Tue, Oct 18, 2022 at 01:04:35PM +0200, Ard Biesheuvel wrote:
> > The purpose of this series is to remove any explicit cache maintenance
> > for coherency during early boot that becomes unnecessary if we simply
> > retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> > and use it to populate the ID map page tables. After setting up this
> > preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> > TCR and SCTLR registers as before, and proceed as usual, avoiding the
> > need for any manipulations of memory while the MMU and caches are off.
> >
> > The only properties of the firmware provided 1:1 map we rely on is that
> > it does not require any explicit cache maintenance for coherency, and
> > that it covers the entire memory footprint of the image, including the
> > BSS and padding at the end - all else is under control of the kernel
> > itself, as before.
> >
> > Changes since v3:
> > - drop EFI_LOADER_CODE memory type patch that has been queued in the
> >   mean time
> > - rebased onto [partial] series that moves efi-entry.S into the libstub/
> >   source directory [0]
> > - fixed a correctness issue in patch #2
>
> I really like this series, but I'm also very nervous about supporting
> booting the kernel with the MMU enabled outside of EFI. The booting
> documentation prohibits this, but we don't appear to take any steps to
> prevent this case with your series. Perhaps we shouldn't, but I do think
> it would be worth trying to warn+taint if we detect it so that we don't
> spend too much time debugging strange memory issues on platforms that
> try to use such a configuration.
>
> What do you think?
>

I share your concern, and capturing the value of SCTLR at boot and
warning about it later should be trivial to do. In fact, we already do
something similar for the alignment, where only EFI is permitted to
deviate from the 2 MiB alignment requirement of the image's placement
in memory. I'll add something in the same spot.

Note that I need to respin this in any case - the EL2 startup code
needs to be cleaned to the PoC as well, given that it will also
execute with MMU and caches off at EL2 when finalise_el2() is called.

I was about to get back to this so I should have a v5 tomorrow.
