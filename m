Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76F14EBB62
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 09:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiC3HEZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiC3HET (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 03:04:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EEE3898;
        Wed, 30 Mar 2022 00:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15321B81B7F;
        Wed, 30 Mar 2022 07:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB750C34116;
        Wed, 30 Mar 2022 07:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648623750;
        bh=wpVECZ3sXO7GwRz1XNWKB5ozsYjbXV0ijOo0t5EBFf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BvqOQs/jqyJKbjDS+B3LViQLKZj9KlDyTt9BLeCtqzcJHakXaG7RdemePGiezBRyU
         rAQBE4w71PMZhUgSjDygTcZSkGRVHyXWUulVbbjCNo//fojusTiTaQn+bU/68Ij2mz
         qjBwtho7rI+ppRly6VLcL7OlGxbe6DfFGIESISgrckzfnOs1IP8cn0qYXIMVKUf2d5
         asPIkUGPaa2bPRCS1zmufh6CMbGSx9xCEE7jbyNJo34zTwG1SWK07ojB6jihok8pM3
         XIHZQWPG+hcerN1IxpvYKRZfKMPvvnJGaDP8UT877xfcJlumnE3S/EZctoMgXX7CR4
         Rhmwuh/9XKl9A==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-de3ca1efbaso21198273fac.9;
        Wed, 30 Mar 2022 00:02:30 -0700 (PDT)
X-Gm-Message-State: AOAM531EmzXbDXls/st5j3Z1DpUAjTVTqnx2OBbymn5SPtugh7yR9rKm
        gscPQh+emAjcO3aUhPDTBmaxYHispcP/ITxfLdE=
X-Google-Smtp-Source: ABdhPJycQ0z03NeGuyDd4f+VqMbzka78HzPg5y9ZP9zP0S4NCdSssehttV8PYxT/KoPr4OTaVPtS1io+ePzyQJwTXZQ=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr1579995oae.126.1648623749792; Wed, 30
 Mar 2022 00:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org>
In-Reply-To: <20220329174057.GA17778@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 09:02:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
Message-ID: <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Matt,

On Tue, 29 Mar 2022 at 19:41, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> We're still trying to come to a conclusion about the most maintainable
> approach to getting DRTM implementations like Intel TXT working on UEFI
> platforms under Linux. I'm going to try to summarise the situation here
> - I'm not an expert, so details may be inaccurate, but I think this is
> the rough shape of things.
>
> Under normal circumstances on UEFI platforms, the bootloader (or system
> firmware directly) load the kernel and execute code in the boot stub.
> This boot stub code interacts with the firmware in various ways,
> including working around some platform-specific issues and doing things
> like copying the TPM event log into memory that can be used by the
> kernel proper. While it remains technically possible to boot the kernel
> on x86 UEFI platforms by jumping directly to the kernel entry point and
> skipping the boot stub, this risks disabling certain functionality and
> leaving the kernel in a slightly unexpected state. The contract that
> exists between the UEFI stub and the kernel is not meaningfully
> documented - portions are carried out by updating the contents of the
> bootparams struct on x86 or devicetree on ARM, but other information is
> conveyed via UEFI configuration tables, the boot stub may modify the
> contents of certain UEFI variables, and some of this is implicit in
> the form of hardware state.
>
> The Trenchboot project is attempting to implement DRTM under Linux.
> Traditional measured boot takes the form of a static root of trust -
> each component in the boot chain is measured by the previous component
> before being executed, and each measures what it considers to be
> security relevant configuration and behavioural state. Modifying any
> component will change the measurements, even if the end result is
> equivalent. Dynamic Root of Trust Measurement aims to provide more
> useful measurements by performing a measurement at a specific point in
> time - as a result, DRTM cares only about what the state *is*, not what
> happened before then.
>
> There's a bunch of complexity involved in this that's vendor specific,
> but the short version is that a launch environment is set up and a
> specific CPU instruction executed that triggers a secure launch event.
> The Trenchboot code consists of patches to bootloaders to support
> setting up this environment, and patches to the kernel to provide
> support for the "Secure Launch" kernel that handles DRTM before handing
> control off to the kernel proper, skipping the UEFI boot stub.
>
> Since this skips the UEFI boot stub, it's then the responsibility of the
> bootloader to implement the functionality of the boot stub. This is made
> difficult due to the absence of an express contract between the boot
> stub and the rest of the kernel - our assumption has been that the code
> is the contract, and this is free to change arbitrarily since both the
> producer and the consumer of the information can be updated
> simultaneously and can't get out of sync. That seems to leave us with
> two options:
>
> 1) Formalise the contract between the boot stub and the kernel, making
> it easier for other boot loaders to implement the contract. This has the
> downside that even within the scope of the contract we may end up with
> divergent behaviour, and also new functionality in the kernel may not be
> available without the bootloader also being updated.
>
> 2) Modify the boot stub such that it can be provided with a callback,
> and instead of jumping to the kernel it can jump to the callback. The
> boot flow would then involve the boot loader setting up the launch
> environment, calling the boot stub code, and then performing the DRTM
> event. This avoids requiring an explicit contract (the boot stub would
> remain part of the kernel image and would be updated in lockstep).
>
> One complexity for both approaches is that the secure launch environment
> needs to be aware of all security-critical state in the system. The
> firmware nominally exposes that information for everything it's aware
> of that's security-critical, but the boot stub may have performed
> security-critical actions or exposed security-critical state that the
> firmware is unaware of. The secure launch code from Trenchboot has to be
> aware of this in order to ensure it's measured.
>
> If there's a contract, then in theory this would be embodied in the
> contract and when the contract is updated the secure launch code could
> also be updated. If there's no contract, every change to the boot stub
> would need to be examined and the secure launch code updated if
> necessary.
>
> While the secure launch code is currently out of tree, the goal is for
> it to be integrated into the kernel tree. My feeling is that it's
> going to be easier to manage this if everything is in tree - ie, all the
> EFI setup code that does anything security-critical is either in the
> firmware (and so the firmware takes responsibility for exposing it) or
> is in the Linux tree (and so we take responsibility for updating the
> secure launch code whenever something relevant changes in the boot
> stub). But this requires support from the EFI maintainers in terms of
> not merging things until we've established whether updates are required
> to the secure launch code. The alternative is effectively the same,
> except it would require updating the contract instead.
>
> But, as mentioned, that's just my feeling - I know that Daniel feels
> that the contract approach is preferable. So:
>
> 1) From an EFI maintainer perspective, is making the contract between
> the boot stub and the kernel explicit viable?
>

No. The direction of travel has been to define EFI boot only in terms
of the handover from the loader to the stub. What happens next is up
to the architecture, and is deliberately not specified, because it is
considered to be internal Linux ABI. We've deviated from this once for
Xen on ARM, but this means we have already painted ourselves into a
corner when it comes the way we use DT internally at the handover
point between stub and kernel proper, and I am not eager to repeat
that. Locking down the stub-to-kernel protocol for all architectures
is not the way to go.

> 2) If so, is it desirable?
>
> 3) If either (1) or (2) is "no", is it reasonable to ensure that all
> potentially security-critical state or configuration changes to the
> boot stub are reviewed by DRTM people to verify whether the secure
> launch code needs to be updated to match?

Wouldn't it be better for the secure launch kernel to boot the EFI
entrypoint directly? As it happens, I just completed a PoC last week
for a minimal implementation of EFI (in Rust) that only carries the
pieces that the EFI stub needs to boot Linux. It is currently just a
proof of concept that only works on QEMU/arm64, but it should not be
too hard to adapt it for x86 and for booting a kernel that has already
been loaded to memory.

[0] https://github.com/ardbiesheuvel/efilite
