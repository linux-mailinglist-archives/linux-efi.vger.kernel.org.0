Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A226540730F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Sep 2021 23:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhIJVp5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Sep 2021 17:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233480AbhIJVp4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Sep 2021 17:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D16661211;
        Fri, 10 Sep 2021 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631310284;
        bh=/Oq6QaIgV+Ix7/mPJ0fNxuXGWyRdrpmf8tttDsijvVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y8Q+LXVHLbtdzYzENjAjzaDnQ8qJILMP1+k+dPJ8ev+RF+7S6GVW0MhzE54x86c8B
         L1DFHJQrYKsgj4DQGahRccPWmqn0eXZQ+OJxgEXyC2oIVEZpu0ohJ4JWB9naB27E/0
         1FipDJSYzvmdb3X/0dkQe83h5I7P1TwG4NRNmhqn4yd2/t85vTnYrYVFM+o9j5UGSj
         udcwRk8u7dli8GOGHx2smG49CXDU63XfePfB1aVb0/tHTwn/LSsyZ7PAPZIs2lR73v
         GjIuSFAE1xFSJHQkhZ7BdG9bLv63HNIpY903a13yud4NpGTFWFlIKxplnJiaokBFS0
         /0KXQ4vFLe9zw==
Received: by mail-oi1-f175.google.com with SMTP id y128so4900133oie.4;
        Fri, 10 Sep 2021 14:44:44 -0700 (PDT)
X-Gm-Message-State: AOAM531u/6fOolyA4pqgaUnt/wjeBAuNa/HGXi8nRhNvCH+dja3z5KxV
        RjClyx0f5PGDJXpM0WmokErYut2jeI/Cx5fH1YE=
X-Google-Smtp-Source: ABdhPJw7JCE4CjTZMIYR0iXqsK0bZmmrjy56W6cOIlXblc1J7wRcG/foJ9NDmNnxp607ZjyncMf1EmlNjuBhrNR9Khc=
X-Received: by 2002:a54:418e:: with SMTP id 14mr5880009oiy.174.1631310283855;
 Fri, 10 Sep 2021 14:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210910213337.48017-1-martin.fernandez@eclypsium.com>
In-Reply-To: <20210910213337.48017-1-martin.fernandez@eclypsium.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Sep 2021 23:44:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEqjHVRNV131=o_aO3TX+58xhYzgfaVDrd0RngAqqtrVg@mail.gmail.com>
Message-ID: <CAMj1kXEqjHVRNV131=o_aO3TX+58xhYzgfaVDrd0RngAqqtrVg@mail.gmail.com>
Subject: Re: [PATCH 0/1] [RFC] x86: Export information about hardware memory
 encryption to sysfs
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        daniel.gutson@eclypsium.com, hughsient@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Martin,

Thanks for your contribution.

Your emails contain a footer that threatens with legal repercussions
if their contents are treated in a certain way. This usually means
that, even if some people may comment on the code, there is no way we
can legally merge it, given that these restrictions are incompatible
with the GPL

So please find a way to resend these emails without the footers. I'll
be happy to look into more detail once you do that.

-- 
Ard.


On Fri, 10 Sept 2021 at 23:34, Martin Fernandez
<martin.fernandez@eclypsium.com> wrote:
>
> Show the value of EFI_MEMORY_CPU_CRYPTO of the system memory as a whole
> on each memory node in sysfs.
>
> This is a first step in a serie of patches for exporting the needed
> information to userspace to determine if a machine is doing using
> Intel's TME or MKTME.
>
> In a next patch I'm going to export if TME/MKTME is activated by the
> BIOS to sysfs, since right now for the user, this information is only
> available in the kernel logs, and it's not appropiate for fwupd to scan
> the boot logs just to parse an integer. I'm looking for suggestions
> for where to store this value.
>
> Martin Fernandez (1):
>   x86: Export information about hardware memory encryption to sysfs
>
>  Documentation/ABI/testing/sysfs-devices-node | 11 +++
>  arch/x86/include/asm/numa.h                  |  2 +
>  arch/x86/mm/numa.c                           |  5 ++
>  arch/x86/mm/numa_emulation.c                 |  2 +-
>  arch/x86/platform/efi/efi.c                  | 27 +++++++
>  drivers/base/node.c                          | 80 +++++++++++++++++++-
>  include/linux/efi.h                          |  7 ++
>  include/linux/node.h                         |  5 ++
>  8 files changed, 137 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-node
>
>
> base-commit: 0bcfe68b876748762557797a940d0a82de700629
> --
> 2.30.2
>
> --
>
>
> This e-mail and any attachments may contain information that is
> privileged, confidential,  and/or exempt from disclosure under applicable
> law.  If you are not the intended recipient, you are hereby notified that
> any disclosure, copying, distribution or use of any information contained
> herein is strictly prohibited. If you have received this transmission in
> error, please immediately notify the sender and destroy the original
> transmission and any attachments, whether in electronic or hard copy
> format, without reading or saving.
>
>
>
>
>
>
>
>
>
>
>
>
