Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F23635B8F
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiKWLXk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 06:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiKWLXV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 06:23:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67BED5F6;
        Wed, 23 Nov 2022 03:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A48561C21;
        Wed, 23 Nov 2022 11:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D159EC43144;
        Wed, 23 Nov 2022 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669202588;
        bh=XKRzTZEWHP1EN1Nejvn+0OZzGhKx7U4U140sQA04rVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b9F53+1W1kELCSLkWE7UxyjE0kyKvKveLb6yRiwPo0cez4f7CwWFzetXgTgwuwqC7
         2uCkL575Sxo7CtObNKn4o2D7xTzphq90TwT8SiP2//RkxSUMwteTgOxcIazHc7OhpQ
         +1gjR1qz9FJo+ibJ+3o3rlHCDBExYlAKwl9aKe1jMMAoqAC4vm9AIkHoOeWNgbsB57
         WzcGGaVlaIbXhMCZmqcQcUZw93/lD8f14VzRGMb0eWiptrjxQK2ShVP/9h2oNAWqbj
         VM6iIpeAGaiurqzr0uOO2lwlrv4qGAwJoUm6XLIH7QJfjK1ch+t9JmOZTFTzUQ53ij
         rrefrBuSxZhNw==
Received: by mail-lf1-f44.google.com with SMTP id b3so27705394lfv.2;
        Wed, 23 Nov 2022 03:23:08 -0800 (PST)
X-Gm-Message-State: ANoB5pkPu+hP7PQeOeHxdsAS16KXEN3ouhgPakQ/DrVXWzToAXWDDm5y
        fkUMxVk1MNzmifEY85PEtT1BfBcvRn1EzShL7hk=
X-Google-Smtp-Source: AA0mqf7xQPXEKhZUbEG6N9rf61z9C6ox/MXh8L49cyEIG/qq1rOwP2K7b9s22Svaz/OKT6OfyeUtr8LfYTIMYVFKw7w=
X-Received: by 2002:a05:6512:3c89:b0:4a2:bfd2:b218 with SMTP id
 h9-20020a0565123c8900b004a2bfd2b218mr9251006lfv.228.1669202586752; Wed, 23
 Nov 2022 03:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20221122161017.2426828-1-ardb@kernel.org> <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com> <Y336yE4P3NjCGavN@zn.tnic>
 <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com> <Y33/VIsB5HGREY4i@zn.tnic>
In-Reply-To: <Y33/VIsB5HGREY4i@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Nov 2022 12:22:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMc_1ZVeiBJmUwPjPh-_LCU8Jqr_iSOEhVHT=PJFstcQ@mail.gmail.com>
Message-ID: <CAMj1kXFMc_1ZVeiBJmUwPjPh-_LCU8Jqr_iSOEhVHT=PJFstcQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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

On Wed, 23 Nov 2022 at 12:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 23, 2022 at 11:52:32AM +0100, Ard Biesheuvel wrote:
> > The patch moves it from .data to .bss inadvertently, and I am not
> > convinced Tom's analysis is entirely accurate: we may simply have
> > garbage in image_offset if we access it before .bss gets cleared.
>
> That should not be too hard to find out: add an endless loop in asm in
> the guest right after the first image_offset access:
>
> 1:
>         jmp 1b
>
> and then dump its value.
>
> Or Tom might have an even better solution.
>
> But looking at the code, BSS clearing happens later, at .Lrelocated and
> the EFI stub comes before it. AFAICT.
>

Indeed. And moving it back into .data makes the most sense in any case
- the point of the patch is to drop the duplicate definitions from asm
code, not to move it into a different section.

The reason I hadn't spotted this is because my boot chain always sets
the value of image_offset during the boot, and does not rely on the
statically initialized value at all.
