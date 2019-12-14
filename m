Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C176611F4D0
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 23:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLNWOm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 17:14:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33629 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNWOm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 17:14:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so2072131wmd.0
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=le9gTEplXasSXY5+vU+POpcZ8GAoVTNi2DgRESF94BM=;
        b=CgKhjGqMjA2Ua4JZEnoVl9pkDc3irF6rNmQisnnigTz32BBdJj0Xz5PRQaXiAcUw5V
         eblM0Al8GX6idpxU+O+1z5URLpOZ39TTZ9JqoXlta344q/oKLNxi0oMNdlPCLT6eq6o+
         Paz31NM4grktE57soKYFyBqOda9J/Jq0tUuk20g6wllWE8fCCbvikAuTBkKc0zPh46DO
         4AwgSLVhpYWXLe1/PrthS5cK77yZPjZBr4fX6TFxqtMFhoeG7JmJl9uQq0Pk7O8HleWr
         8qOWZPATz2piV8ARXFuxta9CBPDQYfHUvve4r8JUb3Pma5oXnOSAgKdOZ0UJcz5bo96Z
         2JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=le9gTEplXasSXY5+vU+POpcZ8GAoVTNi2DgRESF94BM=;
        b=mquRvFQcdDSk+qfmb2v6f3urdYY3LL5AaIBBomqcVgZszNZHYMxR7StNdljsZxbVSS
         udTQXeMIZBZqpVRhC16CUjg5aXAtw4oRR+ufxnxXV+R3VXbeaLKnmzBn59GcYVHC7Mta
         wv/iTGX6Ov461qzWTp0VA44tJrMFTPRMa5YtgKflh4h1ilOtuG1+pHSvKh3Gzg8me+zN
         Ty/vtMYE27UdMTHSTjmO50h98YsJsILQW5PfyNMnW+w/6OcEVLxQMev1H6T+HPupnO6u
         bwzAQ3y77jFO6V0brgOpmmYjRbL8QDW+JMyjm2Q1o8w0FWwLmokcJo/EZ46v4QEYw8JJ
         az+w==
X-Gm-Message-State: APjAAAXG4XlAnFtcUj06DCo06rT2ul0TenmaJe6Tiyp2hwwkP5ZI1ZOz
        sFYyKdOhkOrxxspGGQ9W/yO+LdsmWReIwCLGKKpZKQ==
X-Google-Smtp-Source: APXvYqz/Z3CqaojWv8/IXIkI9cm5DNoK5eR8xmbyteKGdULWQOhr7KljxO1EoyBbnQ0OjeuG/sHwIDTV+qS+hrVBthM=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr22174711wmc.9.1576361679990;
 Sat, 14 Dec 2019 14:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan> <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan> <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
 <20191214211725.GG140998@rani.riverdale.lan> <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 22:14:38 +0000
Message-ID: <CAKv+Gu8DNwWF4FfiZNStHTqNZeUP90c1_NkSLC_80YxF4smnxA@mail.gmail.com>
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

On Sat, 14 Dec 2019 at 22:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 14 Dec 2019 at 22:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Dec 14, 2019 at 08:27:50PM +0000, Ard Biesheuvel wrote:
> > > On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > > > > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > > +
> > > > > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > > > > +   if (efi_is_native()) {                                          \
> > > > > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > > > > +   } else {                                                        \
> > > > > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > > > > +   }                                                               \
> > > > > > > > +   __ret;                                                          \
> > > > > > > > +})
> > > > > > >
> > > Yes. I'm open to suggestions on how to improve this, but mixed mode is
> > > somewhat of a maintenance burden, so if new future functionality needs
> > > to leave mixed mode behind, I'm not too bothered.
> > >
> >
> > Maybe just do
> >         if (sizeof(at) < sizeof(__ret))
> >                 __ret = (__typeof__(__ret))(uintptr_t)at;
> >         else
> >                 __ret = (__typeof__(__ret))at;
> > That should cover most of the cases.
>
> But the compiler will still be unhappy about the else clause if __ret
> is a pointer type, since we'll be casting an u32 to a pointer,

I think the answer is to have efi_table_ptr() for pointers and
efi_table_attr() for other types.
