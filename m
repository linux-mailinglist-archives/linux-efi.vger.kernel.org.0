Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6D6EFC68
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjDZVYc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZVYb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 17:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189519B9;
        Wed, 26 Apr 2023 14:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0034063225;
        Wed, 26 Apr 2023 21:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BACEC433A1;
        Wed, 26 Apr 2023 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682544269;
        bh=biqI0SeUg9q52FQjztvIn0amAyd7Lxt2JXIvLvrdumI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qEzgqyAvtwDG++3UC2vbPhZFJLt2Sj4C8c8d1wbRHjko8arCya1T9MhgDhQm+j2eM
         OO8vzfjnw6qnlclyI9OP2yryhnieKQXhV8mt8nwH9GHA+fYkyzeThqhZbIGyq1E9C6
         AqInplz279nGGvW8HpaiADkQwIg2ny2S0ZZzp7/z5FnxJrK1WLz0QoAPgelwAt/k3m
         9aPbhKFhEFvS65FKVLTKNI5JnF+HIlHapBO8yC+jjUYtF+lkuBzNxrDfG2MaDnP4sA
         7lZP0l31m6yWoykkakQEVC+Roq7mw1ZeusA02/TipegJy7+/rBIWTNhcNkT4aZqxZ2
         MCmjeYUf0yrPA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so265621e87.2;
        Wed, 26 Apr 2023 14:24:29 -0700 (PDT)
X-Gm-Message-State: AAQBX9c6D1UF8rW7VNjfHqjFBCJrcUAQxR3NOMo3b9UCqBC695gKS6l4
        BaDVmqrdIhV9S+0sPVW7EbW5lMAiqD6UaZit6hI=
X-Google-Smtp-Source: AKy350agTzJPprN9JAo42IO2gKeS1BWWZRQaCVcwjO3IGP+vGNWnInyObvwbW7VySrTdsZTcen+bRMhNRb1n/zJiL74=
X-Received: by 2002:ac2:4e49:0:b0:4ec:9f24:3e5f with SMTP id
 f9-20020ac24e49000000b004ec9f243e5fmr5527381lfr.0.1682544267317; Wed, 26 Apr
 2023 14:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <20230426101754.GBZEj6Un+ahT4iZ9fs@fat_crate.local>
In-Reply-To: <20230426101754.GBZEj6Un+ahT4iZ9fs@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Apr 2023 22:24:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHM2kpk4CvrkJVW3EHDR9NEth_TzvX7+O+9x=Of8cdA6g@mail.gmail.com>
Message-ID: <CAMj1kXHM2kpk4CvrkJVW3EHDR9NEth_TzvX7+O+9x=Of8cdA6g@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Apr 2023 at 11:18, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 24, 2023 at 06:57:20PM +0200, Ard Biesheuvel wrote:
> >  arch/x86/boot/compressed/efi_mixed.S           |  55 ---
> >  arch/x86/boot/compressed/head_32.S             |  24 --
> >  arch/x86/boot/compressed/head_64.S             |  39 +--
> >  arch/x86/boot/compressed/misc.c                |  44 ++-
> >  arch/x86/include/asm/efi.h                     |   2 +
> >  drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
> >  drivers/firmware/efi/libstub/x86-stub.c        | 360 +++++++++++++-------
> >  7 files changed, 279 insertions(+), 249 deletions(-)
>
> Upon a quick scan, I can't argue with that diffstat and would prefer
> a lot more if we did this instead of Evgeny's pile which touches a lot
> of nasty and hard to debug code which gets executed on *everything*.
>
> So if people agree with that approach, I'd gladly give it a more
> detailed look.
>

I think the general approach is better, but to be honest, I may have
missed a thing or two, so it would be good if people more familiar
with the history could chime in.
