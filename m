Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4893664C6E4
	for <lists+linux-efi@lfdr.de>; Wed, 14 Dec 2022 11:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiLNKM2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Dec 2022 05:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiLNKMD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Dec 2022 05:12:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E8233A4;
        Wed, 14 Dec 2022 02:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4FBF618BB;
        Wed, 14 Dec 2022 10:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4041FC433D2;
        Wed, 14 Dec 2022 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671012585;
        bh=9Fl50pE2AYKpTZsVNJkvTqaiaCa/zyH+CxC4HbLrEc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=us6Gg4Fst8ebLkXk4Lwbh7ogPG0TKCnlNHahABCkMmP9P6gNNcVwn1ULzek49Iswv
         yPhQ5njxsxzRcWf/iDEIkJq8Bm++1YJHpRFqteYft0ufTlBqKKv7Xk+5t6HBi1HPJI
         8nzn/19o5ImHLoYuVLict5Gmq+XOtvXoTU4SR17lgQdokLYoiZIwTvgNuyXTX7lISF
         tu7L5Wd9g3bjqm+PbBJewJ2Wpxq7L8B2Hw9FwCWUjV2FrgA+MtMJkEJwh2hKGUunr6
         p9fDZ6GwEgD6wAZMEJ5KhUhTNpDCjDcVidboIwP/NZwLqXhzGNqj/RiHySh/CChTmt
         UI/bqSa5rjRGQ==
Received: by mail-lf1-f46.google.com with SMTP id bp15so9544956lfb.13;
        Wed, 14 Dec 2022 02:09:45 -0800 (PST)
X-Gm-Message-State: ANoB5pllTxM5x5rSyqBNFIvqiVUmKkbcnGN/6wl0zmLPu1VDp3hvutLC
        rJGoyJbstMUKHS/t+Dt75n7sIK41F7IfrYadNwg=
X-Google-Smtp-Source: AA0mqf5Of7N6hHY8RP8I50a7Mr21vrO18YBYb3mx7EtfLdkRfhqqXCYXcn+71eEb7rI9gdmT5LtYqUu+n5AYVnSNU50=
X-Received: by 2002:a05:6512:3082:b0:4b5:964d:49a4 with SMTP id
 z2-20020a056512308200b004b5964d49a4mr3831362lfd.637.1671012583304; Wed, 14
 Dec 2022 02:09:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668958803.git.baskov@ispras.ru> <20221213180317.qoy2l3mcpjparocq@redhat.com>
 <20221213181336.fjyxagxkjtq3jchl@redhat.com> <e28ce5943937225517d460dabda6f8e5@ispras.ru>
In-Reply-To: <e28ce5943937225517d460dabda6f8e5@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 14 Dec 2022 11:09:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVffE8nm5qP_tGzQ9zGaXP11RtdFQhhwQc_DDyAk6qOw@mail.gmail.com>
Message-ID: <CAMj1kXEVffE8nm5qP_tGzQ9zGaXP11RtdFQhhwQc_DDyAk6qOw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] x86_64: Improvements at compressed kernel stage
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Peter Jones <pjones@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 13 Dec 2022 at 23:16, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2022-12-13 21:13, Peter Jones wrote:
> > On Tue, Dec 13, 2022 at 01:03:17PM -0500, Peter Jones wrote:
> >> On Tue, Nov 22, 2022 at 02:12:09PM +0300, Evgeniy Baskov wrote:
> >> > This patchset is aimed
> >> > * to improve UEFI compatibility of compressed kernel code for x86_64
> >> > * to setup proper memory access attributes for code and rodata sections
> >> > * to implement W^X protection policy throughout the whole execution
> >> >   of compressed kernel for EFISTUB code path.
> >>
> >> Hi Evgeniy,
> >>
> >> I've tested this patch set on hardware and QEMU+MU firmware, and it
> >> works for me with a couple of minor issues:
> >>
> >> - on one machine that has the DXE protocol but not the EFI one, we get
> >>   an error because the firmware doesn't support EFI_MEMORY_RP
> >> - on QEMU I'm seeing the size of "(unsigned long)_head - image_base"
> >>   wind up as 0, which leads to an EFI_INVALID_PARAMETER on the
> >>   clear_memory_attributes() call.
> >>
> >> In both cases the system winds up working, but with unnecessary
> >> console
> >> output.
> >
> > I just realized I've overstated here - I haven't actually hit the first
> > problem on x86, only on ARM, where we don't currently use this code.  I
> > discovered it in grub, and checked your patch set to see if you had the
> > same issue I did.  That said, "in both cases the system winds up
> > working" is probably still true - in that the edk2 code supports
> > EFI_MEMORY_RP on x86 but not ARM, so x86 won't hit the issue when using
> > DXE unless someone cooks up another implementation.  Nevertheless I
> > believe the patch to fix it is correct and should be applied.
> >
> > Thanks!
>
> Hi,
>
> Thank you for testing and fixes!
>
> I have also discovered one issue with v3, that can only be hit when
> booting with grub -- there's one kernel_add_identity_map() missing in
> the get_acpi_srat_table() function, before header->length is read.
> So I'll prepare the v4 soon and include your new patches there.
>

Happy to see this is converging. Please rebase onto latest mainline as
well - some cleanups to the early boot code have landed there
yesterday.
