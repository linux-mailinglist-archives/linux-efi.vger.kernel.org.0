Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3511F407
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfLNUlB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 15:41:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33238 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNUlA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 15:41:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so1964063wmd.0
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 12:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIrmPdhUQoEFUpl9pVyfp9mVBMFH/es2QUeZpBBMI0M=;
        b=hN/H9UkJbqHG3eIyw7LV32khWF14F7HuwFEWwgG+fPhtjj90pFkDouO8IZ+uHLexMr
         px9Ad5kTt6nq9QMiRdtDunkh01u8oFtXfIpRovKtSvDSZF50GIammzIQRv1kGUuT9Inn
         Sl4DXE7MgLb1NWvBq9JL1TLYihdL4vB/XBjCzMMtuckA3XEo0CtNIubp/QFpI8bqM4xC
         Rx2HT3wKA2RCrCVprkqdNeerjCk4YIgOT7pHkyD2+cOQF6JoGcd9VEQCqznrq4GP8IDf
         JolQwhYPtA/GjJ7BUiuE4Qsw6pn0oOhr5Or8RmSGD3R+mPncu2BxnHbkYtNe3qZvcF4z
         wMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIrmPdhUQoEFUpl9pVyfp9mVBMFH/es2QUeZpBBMI0M=;
        b=KjKIadXDH04kkVG5wkeuetl7NCQx5agxBkebpfy8ItJh6Z+urcVn5TLKLqUnix5oHJ
         R0rb+JZk5sM5f5JAcY3bpnBFvNyngLr5zeInOAtGh9PJFYcvBGRkGhg8gevtdv4T0WVi
         rwHOwZvF4iARkVq1C+tdmNKcLz1jYwZYwcZd/ye4t7t7x4XR8gyy7TBn4M+ZBu3tCPQu
         ziDn9X4vTS5QgmhfQVu/zbyeJOG6w+2n7N2EBOGFymJHJubyaFh8pIXQ7PgvWtmc3hR0
         RkshtSUJEVKe0gNgIDQQJYtIwBNTcUKjPv7pbgHsOr9K4CeeHJXQrXuuqAjTX4FEKYu3
         4gdg==
X-Gm-Message-State: APjAAAXS8bLGIH5F7C2fkV7Sgkw3Ww8/P7ug2555aXnzbDJckKvh+qCw
        SLkbPvf8q2ZPJCZdB4xm4uqhLQA8aUi80XeSTZ/DYCbjxFoIxg==
X-Google-Smtp-Source: APXvYqw5rwBA/idqU4BftHyVMJmzJ1tZL3XDI4yM2IzqJB5Uhrlcn06heFXpeLQX/FqRMDlk4tysqAWtqNF2vinn3mk=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr21792417wmc.9.1576356058556;
 Sat, 14 Dec 2019 12:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-4-ardb@kernel.org>
 <20191214203257.GD140998@rani.riverdale.lan>
In-Reply-To: <20191214203257.GD140998@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 20:40:57 +0000
Message-ID: <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi/libstub: use a helper to iterate over a EFI
 handle array
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

On Sat, 14 Dec 2019 at 21:33, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 06:57:28PM +0100, Ard Biesheuvel wrote:
> > Iterating over a EFI handle array is a bit finicky, since we have
> > to take mixed mode into account, where handles are only 32-bit
> > while the native efi_handle_t type is 64-bit.
> >
> > So introduce a helper, and replace the various occurrences of
> > this pattern.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >
> > +#define for_each_efi_handle(handle, array, size, i)                  \
> > +     for (i = 1, handle = efi_is_64bit()                             \
> > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[0]      \
> > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[0];     \
> > +         i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)      \
> > +                                          : sizeof(u32));            \
> > +         handle = efi_is_64bit()                                     \
> > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[i]      \
> > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[i])
> > +
> >  /*
> >   * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> >   * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > --
> > 2.17.1
> >
>
> This would access one past the array, no? Eg if the array has one
> handle, i is incremented to 2 the first time the condition is checked,
> then the loop increment will access array[2] before the condition is
> checked again. There seem to be at least a couple of other for_each
> macros that might have similar issues.
>

Indeed.

> How about the below instead?
>
> #define for_each_efi_handle(handle, array, size, i)                     \
>         for (i = 0;                                                     \
>             (i < (size) / (efi_is_64bit() ? sizeof(efi_handle_t)        \
>                                           : sizeof(u32))) &&            \
>             ((handle = efi_is_64bit()                                   \
>                 ? ((efi_handle_t *)(array))[i]                          \
>                 : (efi_handle_t)(unsigned long)((u32 *)(array))[i]), 1);\
>             i++)
>

Yeah, that looks correct to me, but perhaps we can come up with
something slightly more readable? :-)
(Not saying my code was better in that respect)
