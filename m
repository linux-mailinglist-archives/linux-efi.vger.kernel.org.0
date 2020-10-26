Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2539B298747
	for <lists+linux-efi@lfdr.de>; Mon, 26 Oct 2020 08:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768974AbgJZHQM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Oct 2020 03:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768973AbgJZHQM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Oct 2020 03:16:12 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DA92231B;
        Mon, 26 Oct 2020 07:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603696571;
        bh=CQ9MMeJK8IiX2zTHx9I5QZWhpOCCMI9BEx0OR7BGlV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fMZevWHapQ+IQJUhp9b/w1z5DkxjzivvG0u6Zcgox+bp7unovt8UTgUQqHd8X8LaO
         TvsBd9RK29T/gAI4KM+4/0tr0H3tN2TQZ9ObKOB+MbYrtq3hYb4BPOlci+OoMYrQIb
         eVDYiB2vzvbUg1apuU2cgn1ZwCjIi3ItzUSRrWmE=
Received: by mail-oi1-f173.google.com with SMTP id m128so9579001oig.7;
        Mon, 26 Oct 2020 00:16:11 -0700 (PDT)
X-Gm-Message-State: AOAM531T67i5FqYpUnfjORoZ9V5JnfZnB9p4Luq7iwlMOBeGpulIRQPF
        rr4wPGhZiDwGxiFf6vue1lk30BZYfBZmVmipxic=
X-Google-Smtp-Source: ABdhPJwNVKiSePeVxbGMzgURAguH0pxG3OyFiSVvclR/g+b4rsKvJeTpvjZxloBNXXkV/PnQ7CxNzWcYxsjCEBL1lco=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr13038005oig.174.1603696570431;
 Mon, 26 Oct 2020 00:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201023115429.GA2479@cosmos>
In-Reply-To: <20201023115429.GA2479@cosmos>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Oct 2020 08:15:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEaLF7kvWORrTF+UM8qCbgzXzr4WLtOTM_aDm8Ggyao5Q@mail.gmail.com>
Message-ID: <CAMj1kXEaLF7kvWORrTF+UM8qCbgzXzr4WLtOTM_aDm8Ggyao5Q@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: fix memory leak in efivarfs_create()
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 23 Oct 2020 at 13:54, Vamshi K Sthambamkadi
<vamshi.k.sthambamkadi@gmail.com> wrote:
>
> kmemleak report:
>   unreferenced object 0xffff9b8915fcb000 (size 4096):
>   comm "efivarfs.sh", pid 2360, jiffies 4294920096 (age 48.264s)
>   hex dump (first 32 bytes):
>     2d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  -...............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000cc4d897c>] kmem_cache_alloc_trace+0x155/0x4b0
>     [<000000007d1dfa72>] efivarfs_create+0x6e/0x1a0
>     [<00000000e6ee18fc>] path_openat+0xe4b/0x1120
>     [<000000000ad0414f>] do_filp_open+0x91/0x100
>     [<00000000ce93a198>] do_sys_openat2+0x20c/0x2d0
>     [<000000002a91be6d>] do_sys_open+0x46/0x80
>     [<000000000a854999>] __x64_sys_openat+0x20/0x30
>     [<00000000c50d89c9>] do_syscall_64+0x38/0x90
>     [<00000000cecd6b5f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> In efivarfs_create(), inode->i_private is setup with efivar_entry
> object which is never freed.
>
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>

Queued as a fix, thanks!

> ---
>  fs/efivarfs/super.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 15880a6..f943fd0 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -21,6 +21,7 @@ LIST_HEAD(efivarfs_list);
>  static void efivarfs_evict_inode(struct inode *inode)
>  {
>         clear_inode(inode);
> +       kfree(inode->i_private);
>  }
>
>  static const struct super_operations efivarfs_ops = {
> --
> 2.7.4
>
