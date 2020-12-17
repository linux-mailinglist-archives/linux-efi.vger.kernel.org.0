Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8272DD19C
	for <lists+linux-efi@lfdr.de>; Thu, 17 Dec 2020 13:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgLQMmd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Dec 2020 07:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgLQMm2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Dec 2020 07:42:28 -0500
X-Gm-Message-State: AOAM533q1u8hL8SXED/zWzFu7JvZMTZRibdlxLS7M46rwS6N51v1x4nV
        0Np1+xjKe/UmTdNEWkOOL8auxwZaJjfNgIvu6hg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608208907;
        bh=0k+bdDoQxODjX8DsVE+uynsTJAL9hKIVbx9RMC4rRgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJUrSW7yp3i7tPvVoj+ariRcZLdXkhoShe/J+ZkKz7Cy0rvNyZlx+CJ3UBiQhM9Fp
         NSwvg8PvsWar7FxLyGuopHEdbb3uBJipDQUbGEwuHC2pMChSlf3pPbr6GwbeYuX61K
         LAhNxRsiT8ZtVDX7XCTmmZ9WOeao57hDa5zLvvNQPzLYu6ABIQ9HWEelcly7VBsVWU
         XwHVkCTCjbVA7UPFE19wGfV1CZ17bYOQOVGuG8B/xWklA+0CKeMXIIWkeKJWKS+5GQ
         EQLolUuKmahp0QrNB6KRyse7PmwJapjmAP73kQCo9/aQci0iwgnX9apy7PbtUKS5IS
         6YeKQcVxuTp5A==
X-Google-Smtp-Source: ABdhPJw/piQorIEquoaEZBhk5Wo+VKOwUUGE3fZhL9m1Qaqb5HnPceZGgHNjMYvC9ADZKPB++aGDQs9ZRrRLmjPcUVs=
X-Received: by 2002:aca:d98a:: with SMTP id q132mr4663135oig.33.1608208906718;
 Thu, 17 Dec 2020 04:41:46 -0800 (PST)
MIME-Version: 1.0
References: <242ea718-89f8-e74f-e48a-e6b0fa436ed1@computerix.info>
In-Reply-To: <242ea718-89f8-e74f-e48a-e6b0fa436ed1@computerix.info>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Dec 2020 13:41:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHSSZftuv-M9Gg-V+XFTJtFtii8Jfqin03kstSuF9DRJA@mail.gmail.com>
Message-ID: <CAMj1kXHSSZftuv-M9Gg-V+XFTJtFtii8Jfqin03kstSuF9DRJA@mail.gmail.com>
Subject: Re: Efistub patch breaks 5.10 for me
To:     Klaus Kusche <klaus.kusche@computerix.info>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Limonciello, Mario" <mario.limonciello@dell.com>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 17 Dec 2020 at 13:37, Klaus Kusche <klaus.kusche@computerix.info> wrote:
>
>
> Hello,
>
> tried to boot 5.10.1 (my first attempt to boot a 5.10.x).
>
> Displays
>
> EFI stub: WARNING: [Firmware Bug]: LoadOptions is an EFI_LOAD_OPTION descriptor
> EFI stub: WARNING: [Firmware Bug]: Using OptionalData as a workaround
>
> for one or two seconds on the notebook display.
>
> Then, the notebook display becomes completely black
> and the notebook does not boot and does not react to anything
> (hard poweroff needed).
>
> 5.9.15 works fine.
>
> Of course, this could be some other change 5.9 --> 5.10,
> but I think Efistub is the first suspect.
>
> Directly booting from UEFI to linux, no bootloader.
>
> Dell Precision Mobile 7740,
> dmidecode says BIOS version 1.7.0, 01/07/2020.
>
> My kernel has *no* command line arguments at all
> or at least, it should not have any
> (fully static kernel with no modules or initrd,
> all kernel parameters configured into the kernel).
>
> In 5.9.15, dmesg displays only a \x01 for the command line.
>
> Next step?
> Is there sonething to try out?
> Are there any patches I should reverse-apply?
> Should I open a bug at buzilla.kernel.org?
>
> Thanks for any help!
>

Hello Klaus,

Please try reverting

4a568ce29d3f48df95919f82a80e4b9be7ea0dc1

"efi/x86: Add a quirk to support command line arguments on Dell EFI firmware"

If this fixes things, I will let Arvind come back to you with more
detailed questions about your use case, although I suspect it may have
something to do with not having a command line at all.

Thanks,
Ard.
