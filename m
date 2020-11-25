Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465D2C3DA0
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 11:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgKYK2w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 05:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKYK2w (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Nov 2020 05:28:52 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435F2208B8
        for <linux-efi@vger.kernel.org>; Wed, 25 Nov 2020 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606300131;
        bh=9rkFG5iMnBJNZz8HOBS0/x5a5Bz407XS6Cu+P0I54+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CaLUsqn0twxjCeL+wW4Sa+jdhBX8uGpRRYVMBmVx3FHRh4idMg4IpUhqEBSVmlVnb
         KYBKyw+7waAi1dTpAFjnvPaT3ycYF/ae6unfT1DTCFqEPqhePYw6yfoKUEIaSie0OQ
         kz2VU0d/Pz4v6UbhWeIUV0xOmuIZ2gaGavk8RlTA=
Received: by mail-ot1-f44.google.com with SMTP id h39so87729otb.5
        for <linux-efi@vger.kernel.org>; Wed, 25 Nov 2020 02:28:51 -0800 (PST)
X-Gm-Message-State: AOAM530J0kBuzRT5VeRjwaSN7ecD5hrHmRK5tFGXiqLFq0FIPdEtxaun
        dIrRtU0IEcPAPCo/7Z+g5zTJi2IX6lOE7GQUrI8=
X-Google-Smtp-Source: ABdhPJzeZEXIPUul+8/eQyDW9fgcO0eYy5B8wVg8oLZpYZ+aQkoQtX+FJYsrt9xDBvrewh6AxUdaG26O/tec82OjaEQ=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr2249863otd.90.1606300130463;
 Wed, 25 Nov 2020 02:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20201125075303.3963-1-ardb@kernel.org> <309bd3399d042ca94e5bab35980d661c@natalenko.name>
In-Reply-To: <309bd3399d042ca94e5bab35980d661c@natalenko.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Nov 2020 11:28:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>
Message-ID: <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-efi <linux-efi@vger.kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <mjg59@google.com>,
        David Laight <David.Laight@aculab.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Nov 2020 at 11:27, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> On 25.11.2020 08:53, Ard Biesheuvel wrote:
> > The memory leak addressed by commit fe5186cf12e3 is a false positive:
> > all allocations are recorded in a linked list, and freed when the
> > filesystem is unmounted. This leads to double frees, and as reported
> > by David, leads to crashes if SLUB is configured to self destruct when
> > double frees occur.
> >
> > So drop the redundant kfree() again, and instead, mark the offending
> > pointer variable so the allocation is ignored by kmemleak.
> >
> > Cc: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
> > Fixes: fe5186cf12e3 ("efivarfs: fix memory leak in efivarfs_create()")
> > Reported-by: David Laight <David.Laight@aculab.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  fs/efivarfs/inode.c | 1 +
> >  fs/efivarfs/super.c | 1 -
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> > index 96c0c86f3fff..38324427a2b3 100644
> > --- a/fs/efivarfs/inode.c
> > +++ b/fs/efivarfs/inode.c
> > @@ -103,6 +103,7 @@ static int efivarfs_create(struct inode *dir,
> > struct dentry *dentry,
> >       var->var.VariableName[i] = '\0';
> >
> >       inode->i_private = var;
> > +     kmemleak_ignore(var);
>
> Do we need to do this as well:
>
> #include <linux/kmemleak.h>
>
> ?
>
> Because otherwise for 5.9 I get:
>
> [  148s] fs/efivarfs/inode.c: In function 'efivarfs_create':
> [  148s] fs/efivarfs/inode.c:106:2: error: implicit declaration of
> function 'kmemleak_ignore' [-Werror=implicit-function-declaration]
> [  148s]   106 |  kmemleak_ignore(var);
> [  148s]       |  ^~~~~~~~~~~~~~~
>

Ah yes, thanks for the report. I will add the include to the patch.


> >
> >       err = efivar_entry_add(var, &efivarfs_list);
> >       if (err)
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index f943fd0b0699..15880a68faad 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -21,7 +21,6 @@ LIST_HEAD(efivarfs_list);
> >  static void efivarfs_evict_inode(struct inode *inode)
> >  {
> >       clear_inode(inode);
> > -     kfree(inode->i_private);
> >  }
> >
> >  static const struct super_operations efivarfs_ops = {
>
> --
>    Oleksandr Natalenko (post-factum)
