Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46DD6349A3
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 22:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiKVVwE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 16:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiKVVwA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 16:52:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D657ECA6;
        Tue, 22 Nov 2022 13:51:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 902FCB81DBB;
        Tue, 22 Nov 2022 21:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D14C4347C;
        Tue, 22 Nov 2022 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669153916;
        bh=q4z6//yfgyOCVuiGPiatlXmj43+ciUUzGeh6wyvrPCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQHLjeXRuI350SbrRwn8EgJ5e+4AxV/Acl1gUF3ntfDYdpl6lYd9abFrNMDFefKad
         EuCjn50xNxGXWsesomzmZOFM/JkeQsPoA7FBYDHQavmrOGben+0Cr8f3Xe6VukXuBX
         BvJkpTwbFSx06hC6qmBQnba7t4hdQYGAgqJmwinRenaYjACTiGRdOy91GqDxvdBFKH
         PV+7mqxOIiAKwrlIbdpdslRFlyvHfKbZUfmRGZfWroTnMiG7Jw8F9Hg9THnqk5EUqu
         eg8o8ady60q27glNE8FLCPjIrkPMJ0F214e8/ZfPZvMyAuV1ZgcW29sHhF5i5ucnXV
         j8j1rD1HPOI3A==
Received: by mail-lf1-f51.google.com with SMTP id j16so25491071lfe.12;
        Tue, 22 Nov 2022 13:51:56 -0800 (PST)
X-Gm-Message-State: ANoB5pkrbOa29N5O37PBbWiwHzkouwV/Y0DzdmzHiAI/teR1CPx+ywit
        OBkifvj24VAJceuLrqy++etDr1SP6sm2Q701OGc=
X-Google-Smtp-Source: AA0mqf5oP1hSlKXcEUZwMDdMSyei7SDiHFzBa8n0Ik4db7PJKpMinSIFW6w99QxjqDdGZvOWAiIkZxH8gFnB5I4h+Q4=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr7964821lfa.122.1669153914124; Tue, 22
 Nov 2022 13:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20221122161017.2426828-1-ardb@kernel.org> <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <CAMj1kXFX3df00cv5hwij396jS2AOgVGavDM-8hRii49Omn5=pw@mail.gmail.com> <62147ae9-eca5-be9f-86a3-72b73eb3d4d4@amd.com>
In-Reply-To: <62147ae9-eca5-be9f-86a3-72b73eb3d4d4@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Nov 2022 22:51:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF7xj4BsB4nvFYGQNxGzSb2v=KGqzbjMc5tzXWy9i1FAQ@mail.gmail.com>
Message-ID: <CAMj1kXF7xj4BsB4nvFYGQNxGzSb2v=KGqzbjMc5tzXWy9i1FAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Nov 2022 at 22:51, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/22/22 15:42, Ard Biesheuvel wrote:
> > On Tue, 22 Nov 2022 at 22:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Tue, 22 Nov 2022 at 21:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>
> >>> On 11/22/22 10:10, Ard Biesheuvel wrote:
> >>>> After doing some cleanup work on the EFI code in head_64.S, the mixed
> >>>> mode code in particular, I noticed that the memory encryption pieces
> >>>> could use some attention as well, so I cleaned that up too.
> >>>>
> >>>> Changes since v2:
> >>>> - add some clarifying comments to the EFI mixed mode changes
> >>>> - include patch to make the EFI handover protocol optional that was sent
> >>>>     out separately before
> >>>> - rebase onto tip/master
> >>>>
> >>>> Changes since v1:
> >>>> - at Boris's request, split the patches into smaller ones that are
> >>>>     easier to review
> >>>>
> >>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>> Cc: Ingo Molnar <mingo@redhat.com>
> >>>> Cc: Borislav Petkov <bp@alien8.de>
> >>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>>> Cc: Michael Roth <michael.roth@amd.com>
> >>>
> >>> This causes an SEV guest to blow up on boot in the early boot code. It
> >>> looks like the stack pointer is not valid and it triple faults on a pushq
> >>> instruction (pushq $__KERNEL_CS in arch/x86/boot/compressed/head_64.S of
> >>> startup_64).
> >>>
> >>
> >> Thanks for the report.
> >>
> >> So the mystery here (at least to me) is that all the changes are to
> >> the 32-bit code, and startup_64 reloads the stack pointer from the
> >> symbol
> >>
> >> Does your config have CONFIG_EFI_MIXED enabled?
> >>
> >> Can I reproduce this fully emulated with QEMU? Or do I need a SEV host?
> >>
> >
> > Also, mind giving this a quick spin?
>
> Just saw this after I sent out my email. Yes, this fixes it.
>

Excellent, thanks for testing.
