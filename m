Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4363711F442
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 22:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfLNVaM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 16:30:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45281 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNVaL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 16:30:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so2611012wrj.12
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZE43dsMkpbOowbdThDfr++A+vm8RAdpXC2KmBWEMOmk=;
        b=GdWGTxKQxlxuSKElGDnFU8WiA2IFAvEmSQg2vzKcxkinj4Cb1yT1SuQeKu9UWcc23N
         miPgUxYb/GSsPl+TCdFF4/NMU0YuJd5dm1s4J0eGr9462tl7XCHZMoIBQzvalBRJ644e
         j4xPQ3AkKsP/TDNRDElTi+TPbnvcg+KV72f+oP/JDbooHbU4BBbdsYNcIVNNnufLBqwy
         gRCvC35HXk+r/F2be2MqMH1JDVHchBQR5E7qnpLElczt63rdbm3bstOvcGpwXIqBKUEt
         lw4EiYo3sRSetaVnzLFOviAHUB4+/6mQjcMBL7UQBYsdJioCvVUiPFhZQZnLga+6h8sa
         8h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZE43dsMkpbOowbdThDfr++A+vm8RAdpXC2KmBWEMOmk=;
        b=YHgEEPiuBnl8SsprYsa6pGH7hc1fsy9GTBNXm7EnR7ofiud2XWF/SyA1jrydf5nqxC
         8Jr4tUVWTUGwrSQgR73V+3s13U7pyAedAhZT9A7+dzUToeA/4m8hu4MvIwkHd8aIrEqm
         Rs6DMiKE5YdDrE545JwIER4V+c/DF9I63Oy87k2YYNzUSdL5EwqczsQ7DGo1ju8vwSZm
         DCNXXpVMNTQBfblq1CbK0O2ZsDYMpkJ4DgTuEAO4Sk7OZ7+JOyvldTzTSz5363ZRcbHo
         onvzRDZjwTT5rru7UlluzNskAg2ZEBrn77hcLOKN4vEtNFIs8zMesbMI3QB4ZhuHoi8/
         ovaw==
X-Gm-Message-State: APjAAAW3SI4xFqjSVFyaENVzpHOYPDI1K01eT29fOuPbh06+twozXWHI
        /wQdXPidRFnJVaYsQgqt47WJ1XpZ1y6rffxY7nJl5w==
X-Google-Smtp-Source: APXvYqzgOkE0x4xUEugYy4zK1uM8VFvf6LnslZO0PGkZA6sUWQduZPl1VoXiuJHt8LwZu2c8eMW42/6WGFWe+KlS1N8=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr19877635wrj.325.1576359009672;
 Sat, 14 Dec 2019 13:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan> <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan> <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
 <20191214211725.GG140998@rani.riverdale.lan>
In-Reply-To: <20191214211725.GG140998@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 21:30:08 +0000
Message-ID: <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 14 Dec 2019 at 22:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 08:27:50PM +0000, Ard Biesheuvel wrote:
> > On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > > > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > +
> > > > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > > > +   if (efi_is_native()) {                                          \
> > > > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > > > +   } else {                                                        \
> > > > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > > > +   }                                                               \
> > > > > > > +   __ret;                                                          \
> > > > > > > +})
> > > > > >
> > Yes. I'm open to suggestions on how to improve this, but mixed mode is
> > somewhat of a maintenance burden, so if new future functionality needs
> > to leave mixed mode behind, I'm not too bothered.
> >
>
> Maybe just do
>         if (sizeof(at) < sizeof(__ret))
>                 __ret = (__typeof__(__ret))(uintptr_t)at;
>         else
>                 __ret = (__typeof__(__ret))at;
> That should cover most of the cases.

But the compiler will still be unhappy about the else clause if __ret
is a pointer type, since we'll be casting an u32 to a pointer,
