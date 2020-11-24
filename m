Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD622C2AA4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbgKXPBy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 10:01:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389251AbgKXPBy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 10:01:54 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C345A20897;
        Tue, 24 Nov 2020 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606230113;
        bh=Pq2QjOElY2atSJIbAEqdXL7pcwR7IP+wkCWzqWeTqfM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bX331kPp58DquCe7eALZNxB6xaKkgQyyygyY/d1M7drF90Hbt4B9Fie/8ZQFgggXi
         zakAWHGwcNjH1HobJiX/3LfQZNnRmJzhRtcvUe/NmWlD1zl97k3aRtxxOVaMhEsg+3
         7rKoDdrtiU7hcYJRM+xRWjeP9QMGhSTTDqvV4Ui8=
Received: by mail-oi1-f175.google.com with SMTP id w15so868042oie.13;
        Tue, 24 Nov 2020 07:01:53 -0800 (PST)
X-Gm-Message-State: AOAM532wQNp0xyyvhM4xlViNECWpr8oYgSXCIu+7NHMagxKzivyJxp1A
        0koyuh1VlKPshN9VKRnnlrrYSaVWkBLefmE5ntE=
X-Google-Smtp-Source: ABdhPJyd98uh/S0MHUyz9fOpm/Val/LRpbi7SUroXXm227LsL5uKH0kjENdSP/A/lRbINi1YfDRmCbKilEHrpD3RJb8=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr2992989oib.33.1606230111951;
 Tue, 24 Nov 2020 07:01:51 -0800 (PST)
MIME-Version: 1.0
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
 <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com> <3e96bbfe476b4b3d876e480ce6b20b58@AcuMS.aculab.com>
In-Reply-To: <3e96bbfe476b4b3d876e480ce6b20b58@AcuMS.aculab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 16:01:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE3xM__pA6eaXwWV=we4sWrnecH1f7oUbuyGeHc9TPmOg@mail.gmail.com>
Message-ID: <CAMj1kXE3xM__pA6eaXwWV=we4sWrnecH1f7oUbuyGeHc9TPmOg@mail.gmail.com>
Subject: Re: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Nov 2020 at 15:58, David Laight <David.Laight@aculab.com> wrote:
>
> From: Ard Biesheuvel
> > Sent: 24 November 2020 14:24
> >
> > On Tue, 24 Nov 2020 at 15:22, David Laight <David.Laight@aculab.com> wrote:
> > >
> > > I've just updated to the head of Linus's tree (5.10-rc5) and got the following
> > > 'splat' during shutdown.
> > >
> > > Userspace is Ubuntu 20.04.
> > >
> > > rc4 rebooted fine.
> > >
> > > I'll try to bisect - but it isn't quick.
> > >
> >
> > Surely caused by
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/efivarfs?id=fe5186cf12e30
> > facfe261e9be6c7904a170bd822
>
> Yep, reboots fine with that kfree() commented out.
>

Thanks for confirming.

Does it also work when keeping the kfree() and setting
inode->i_private to NULL explicitly afterwards?
