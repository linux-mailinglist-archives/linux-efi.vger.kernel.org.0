Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3172C6A49
	for <lists+linux-efi@lfdr.de>; Fri, 27 Nov 2020 17:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgK0Q7B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 11:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbgK0Q7B (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Nov 2020 11:59:01 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488BD221F1
        for <linux-efi@vger.kernel.org>; Fri, 27 Nov 2020 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606496340;
        bh=FEQKD2uS4NeAB7/FgDgHKjkpnVvpUbOQhMuZ5wi+4BQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CKs0nGWIwa6FAGD0jY77wCSqK5IQ50QWJ0+waj2j2q3s2AM/L9sl9Fd4EAvXP8tf0
         s+YgtyhOmiRTc0rHaManJZDFI8Dfn93Ua0OSUMbkm6pnvhviBOCZHTkraBYEKUbNqp
         7yKqxZYqTR46kW0ToPhTAkCmTEGZlsRNilvfD//M=
Received: by mail-oi1-f181.google.com with SMTP id j15so6519402oih.4
        for <linux-efi@vger.kernel.org>; Fri, 27 Nov 2020 08:59:00 -0800 (PST)
X-Gm-Message-State: AOAM532jvsNe+PzQCct9oTgx0x7Ydpbe0hwwYVdhIkdZY0IenUpTPpx5
        hcFN5hoJLG6brFzzrvdQ1dYCBPHUqfBJGOn92Pc=
X-Google-Smtp-Source: ABdhPJwI6MrNl0eEB06+C7ah/EJ89LjM1ABRclGHvTHGYvB5f9oVjQTx1zHr7yaQZEE2339fYU02i+MYoD4goaiWtpQ=
X-Received: by 2002:aca:5ec2:: with SMTP id s185mr5842127oib.33.1606496339654;
 Fri, 27 Nov 2020 08:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20201125075303.3963-1-ardb@kernel.org> <309bd3399d042ca94e5bab35980d661c@natalenko.name>
 <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com> <a07e1520-f08b-2456-a954-707e0c3bcb4a@m2x.dev>
In-Reply-To: <a07e1520-f08b-2456-a954-707e0c3bcb4a@m2x.dev>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Nov 2020 17:58:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGVE5Na8Ms4=Qi0aq=CY1MCcupAF4gsz95nnZJB8nh8JQ@mail.gmail.com>
Message-ID: <CAMj1kXGVE5Na8Ms4=Qi0aq=CY1MCcupAF4gsz95nnZJB8nh8JQ@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
To:     Jonathon Fernyhough <jonathon@m2x.dev>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <mjg59@google.com>,
        David Laight <David.Laight@aculab.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Nov 2020 at 17:56, Jonathon Fernyhough <jonathon@m2x.dev> wrote:
>
> On 25/11/2020 10:28, Ard Biesheuvel wrote:
> > On Wed, 25 Nov 2020 at 11:27, Oleksandr Natalenko
> > <oleksandr@natalenko.name> wrote:
> >>
> >> On 25.11.2020 08:53, Ard Biesheuvel wrote:
> --snip--
> >>
> >> Do we need to do this as well:
> >>
> >> #include <linux/kmemleak.h>
> >>
> >> ?
> >>
> >> Because otherwise for 5.9 I get:
> >>
> >> [  148s] fs/efivarfs/inode.c: In function 'efivarfs_create':
> >> [  148s] fs/efivarfs/inode.c:106:2: error: implicit declaration of
> >> function 'kmemleak_ignore' [-Werror=implicit-function-declaration]
> >> [  148s]   106 |  kmemleak_ignore(var);
> >> [  148s]       |  ^~~~~~~~~~~~~~~
> >>
> >
> > Ah yes, thanks for the report. I will add the include to the patch.
> >
> >
>
> Is this necessary if CONFIG_DEBUG_KMEMLEAK is not enabled in the kernel
> config? e.g. should there be an #ifdef CONFIG_DEBUG_KMEMLEAK somewhere
> in there?
>

We typically define these helpers unconditionally, and sort out the
differences in the header file. In this case, we have

static inline void kmemleak_ignore(const void *ptr)
{
}

in include/linux/kmemleak.h if CONFIG_DEBUG_KMEMLEAK is not set.

This makes the calling code much cleaner.
