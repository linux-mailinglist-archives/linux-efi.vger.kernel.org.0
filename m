Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D366BF980
	for <lists+linux-efi@lfdr.de>; Sat, 18 Mar 2023 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRKgA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Mar 2023 06:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRKf7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Mar 2023 06:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA942820B;
        Sat, 18 Mar 2023 03:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351A360AE4;
        Sat, 18 Mar 2023 10:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D91C433EF;
        Sat, 18 Mar 2023 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679135757;
        bh=QVJsjRJAwNHwH8iVNvT+bQuQJBExNnEPnTB1jL+hRDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MjTUnc2blbPLs85oKFqFh0Wa2zaRs4pTlR9RYcqPn628YlvgK+S3C3pZKFXtgRqDT
         1wxncg7c8wetL76FhjyOXXBrCMTk8XisbgSNpc/2vinVrQTn0Vn2494P5/qFbsbVHK
         6WquODejie+a8uz8aV6yk5k2No6qoqJUbriTO9ef6Wey0PZwJ6iThmvlstI5Y62Dwn
         MwcXUKHg5XnwSiueHiuFUF1txGIkbuw1VpPdEytFxiR3wXq9fZK9b27Sc+nEpkdpMh
         /yeha5xLMs+APYtQlViyr/F40NGsUFSFdX8BZgU1sLcdlCbo6VJm8Vcclkwefjc33A
         kvnIQBKA/+qgQ==
Received: by mail-lj1-f170.google.com with SMTP id 20so334639lju.0;
        Sat, 18 Mar 2023 03:35:57 -0700 (PDT)
X-Gm-Message-State: AO0yUKVa5AGBm+FsOrXEWtaLUs9hT+pe8FR+FoMuMy8MK6yGhiznT7Ce
        1vUPgTZsGLUzAOz/irU92R1CvYTzrG8A2Scn+W4=
X-Google-Smtp-Source: AK7set/LB4GooqDQoabCQNg8ev9Zq3hzP1WJXBZcR30yWNqSFFqQAoyo5HdPAA9ft+oF9o8KSt0NoUcUuDjAHWpbHNk=
X-Received: by 2002:a05:651c:337:b0:295:d460:5a2d with SMTP id
 b23-20020a05651c033700b00295d4605a2dmr4078456ljp.2.1679135755497; Sat, 18 Mar
 2023 03:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
 <ZBMQdgPepwa+VyAH@righiandr-XPS-13-7390> <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
 <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390> <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390> <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390> <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
 <ZBOYBdJR00dOKPSx@fedora>
In-Reply-To: <ZBOYBdJR00dOKPSx@fedora>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 18 Mar 2023 11:35:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
Message-ID: <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 16 Mar 2023 at 23:28, Darren Hart <darren@os.amperecomputing.com> wrote:
>
> On Thu, Mar 16, 2023 at 07:55:36PM +0100, Ard Biesheuvel wrote:
> > On Thu, 16 Mar 2023 at 18:52, Andrea Righi <andrea.righi@canonical.com> wrote:
...
> > >
> > > Yay! Success! I just tested your latest efi/urgent (with the fixup) and
> > > system completed the boot without any soft lockups.
> > >
> >
> > Thanks for confirming. I'll take that as a tested-by
>
> The solution in the current branch looks like the best approach we have to date
> to address the broadest of affected systems. We could switch the eMAG test to an
> MIDR test I believe (but this won't work for Altra as that would capture all the
> Neoverse v1 cores beyond Altra). I can look into the MIDR test if you think it's
> worthwhile - but since I don't think we can eliminate the SMBIOS string test, it
> doesn't buy us much since we don't need a greedier eMAG test (there aren't more
> of them to match).
>
> Given that some OEM Altra platforms change the processor ID, I don't see a
> better solution currently than adding their the "product name" to the smbios
> string tests unfortunately.
>

Indeed. I spotted a Gigabyte system [0] with a different processor ID,
but with a version we can test for.

So for now, I'll go with

        socid = (u32 *)record->processor_id;
        switch (*socid & 0xffff000f) {
                static char const altra[] = "Ampere(TM) Altra(TM) Processor";
                static char const emag[] = "eMAG";
        default:
                version = efi_get_smbios_string(&record->header, 4,
                                                processor_version);
                if (!version || (strncmp(version, altra, sizeof(altra) - 1) &&
                                 strncmp(version, emag, sizeof(emag) - 1)))
                        break;

                fallthrough;

        case 0x0a160001:        // Altra
        case 0x0a160002:        // Altra Max
                efi_warn("Working around broken SetVirtualAddressMap()\n");
...

which should cover all the affected systems we encountered so far.

I'll push this to linux-next to let it soak for a little bit, and then
send it to Linus somewhere during the week

Thanks,
Ard.


[0] https://pastebin.com/HQLE1yYv
