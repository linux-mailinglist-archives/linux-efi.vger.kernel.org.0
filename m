Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1A45849F
	for <lists+linux-efi@lfdr.de>; Sun, 21 Nov 2021 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhKUQPR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 21 Nov 2021 11:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237998AbhKUQPQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 21 Nov 2021 11:15:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFB4360E0C
        for <linux-efi@vger.kernel.org>; Sun, 21 Nov 2021 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637511131;
        bh=BEUDQfk/PfDj9ccFHFmOTL6lfF/nIeQba+KHR2LgFZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V6MiR85oN5J901v1Km2G9P1/41KDXey7Yfk5muxYJ7YZfjGr1g/XwmcdoUMZP9c5r
         m10ZsITRYm2sHQzI56But9/JA9eOzXUhZxpnOU1cLQt6mjS3F3muXi1IDm1oQPGcL7
         Hhnga9s4hGyI7OicBzhEGXr4zLMILtQIKzQVuaVSQmgYqlo/HVtxgVUeVmneBrgw1Y
         VBlbBeIllvs1M4a6hDMkBejMW8OHR903flH7VfoYXAD3Pacr9K3xJXzDgYltYII9ke
         bQyPdWxl6wKK5gXHqdYcqdWhpUp4N9P+C+aQ7YjQB7RGxBzjIaXPVzeADoTMOAO79i
         gs79jFjNobpZg==
Received: by mail-oo1-f46.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso5085551oow.10
        for <linux-efi@vger.kernel.org>; Sun, 21 Nov 2021 08:12:11 -0800 (PST)
X-Gm-Message-State: AOAM531nKrW/ohwxhTy81TjjbJztF8lSAiPPxwG5D+n4vy6aZkZ+zyWn
        UuBDztg3wiYR9lY/orbyGK7OfEshixlnCPC98Zk=
X-Google-Smtp-Source: ABdhPJw9mG1G7/6P2GlV4O3VK7Z3hHvMi361OFJWbGUrKpXFfp92n3sAzE5z385kl8tjCaE5/zDf+g5Dctcuw956of8=
X-Received: by 2002:a4a:a641:: with SMTP id j1mr27136495oom.63.1637511131129;
 Sun, 21 Nov 2021 08:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 21 Nov 2021 17:12:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHfFyUePGHbuQx_hVeL7YhRF4jZW0RD2k-zqtfNeDZF3w@mail.gmail.com>
Message-ID: <CAMj1kXHfFyUePGHbuQx_hVeL7YhRF4jZW0RD2k-zqtfNeDZF3w@mail.gmail.com>
Subject: Re: [PATCH 0/4 v3] measure initrd data loaded by the EFI stub
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 19 Nov 2021 at 12:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi!
>
> This is a respin of [1].
> This enables initrd measuring when loaded directly by the kernel EFI stub.
> It ensures that the initrd observed and used by the OS is the same one that
> got measured into the TPM, which is difficult to guarantee in the current
> otherwise.
>
> There's a couple of changes compared to the original RFC:
> - Ard fixed the x86 assembly for providing the extra arguments needed and I
>   rebased it on top of
>   commit 22aa45cb465b ("x86/efi: Restore Firmware IDT before calling ExitBootServices()")
> - Instead of EV_IPL we are now using EV_EVENT_TAG. EV_IPL was marked
>   as deprecated up until the latest PC client spec [2] (and deprecated  in
>   older revisions [3]).  It's current description is:
>   "It may be used by Boot Manager Code to measure events."
>
>   EV_EVENT_TAG on the other hand seems more appropriate as it's defined as:
>   "Used for PCRs defined for OS and application usage.  Defined for use by
>   Host Platform Operating System or Software."
> - We are only measuring the initrd if it was loaded using the LOAD_FILE2
>   protocol.  This is not what we probably want in the long run, but let's
>   only enforce the measurement on the new way of loading an initrd for now.
>
> Questions:
> - Since GRUB seems to be using PCRs 8/9 for it's EV_IPL events, maybe we should
>   use something completely different?
>

Thanks for continuing to work on this.

I think using PCRs 8/9 is fine - if one upgrades to a new version of
the kernel that implements this change, the PCRs will change in any
case.

The only thing that is unclear to me is whether we should measure some
kind of separator event if no initrd is loaded at all - IIRC, this
came up before but I don't remember what the conclusion was in the
end.


> I did test this on arm64 and x86_64 (incl mixed mode). Here's a snip of the
> EventLog
> <snip>
>   - EventNum: 23
>     PCRIndex: 9
>     EventType: EV_EVENT_TAG
>     DigestCount: 4
>     Digests:
>       - AlgorithmId: sha1
>         Digest: "53fe403e0d763f6a4e3384e8112d6463e7ddf12b"
>       - AlgorithmId: sha256
>         Digest: "28f24eab8cb433e4b8cbce0f96b7ad0aa541a4b905f748491139e42f0adc8026"
>       - AlgorithmId: sha384
>         Digest: "848389ab172267dcf9a0b873c7534b3d969e915b525c9fe2b57db47f4ecd8283b18d6e0cff84099893d589447c2bea55"
>       - AlgorithmId: sha512
>         Digest: "438b254c92e6716a5a1ba0338f5e751f3dd27782481e5698911b4cd33a98efdd776459d56781c5ae4a8d0b9945246d04ab243d4dbe03f49542e2455ac66db584"
>     EventSize: 21
>     Event: "ec223b8f0d0000004c696e757820696e6974726400"
> <snip>
>
> [1] https://lore.kernel.org/linux-efi/20201102170634.20575-1-ardb@kernel.org/
> [2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
> [3] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientSpecPlat_TPM_2p0_1p04_pub.pdf
>
> Ard Biesheuvel (3):
>   efi/libstub: add prototype of
>     efi_tcg2_protocol::hash_log_extend_event()
>   efi/libstub: x86/mixed: increase supported argument count
>   efi/libstub: consolidate initrd handling across architectures
>
> Ilias Apalodimas (1):
>   efi/libstub: measure loaded initrd info into the TPM
>
>  arch/x86/boot/compressed/efi_thunk_64.S       | 14 +++-
>  arch/x86/include/asm/efi.h                    | 14 +++-
>  arch/x86/platform/efi/efi_thunk_64.S          | 14 +++-
>  .../firmware/efi/libstub/efi-stub-helper.c    | 73 ++++++++++++++++---
>  drivers/firmware/efi/libstub/efi-stub.c       | 10 +--
>  drivers/firmware/efi/libstub/efistub.h        | 30 +++++++-
>  drivers/firmware/efi/libstub/x86-stub.c       | 26 +++----
>  7 files changed, 134 insertions(+), 47 deletions(-)
>
> --
> 2.33.1
>
