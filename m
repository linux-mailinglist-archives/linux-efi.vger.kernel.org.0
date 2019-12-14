Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB09911F42F
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 22:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLNVLx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 16:11:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33480 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfLNVLx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 16:11:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so320022qkc.0;
        Sat, 14 Dec 2019 13:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDgrFmqwBbruyvbEPNvS6lroKGpuFewbY+qcvevRshA=;
        b=BPscf8unKDMk9/9oIHbHvBOJKH0tk1PilMYY7IWC8e/wmylNMy3jw8l7hP79ws3vtr
         VjpOBVUFczhc3wlpZHibWn6UZKF6l5d+zkQGhAglLdT9V/vFOm29GlQ3ZtnmBXMybXLT
         lExwL7h2RWGoe2SlsvYYTI1PaZ278DFREdiUXNAhfP4flqPvq7LMRbuA8k5qCCpOrtEq
         tYgR62CSqBxxs+M1aonbZwu5TRErIdMgBznyFNmgouhVFcUiqlQxr13pZLdm3C4V63h5
         yhczXyRKJod8Ph7FQlPSQI54rrQ1tQj2GtQx7ogjUGd7O60TgjH8ZFcDH/2wAmxJJlWN
         3nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDgrFmqwBbruyvbEPNvS6lroKGpuFewbY+qcvevRshA=;
        b=mNl4qcISM6goAfXKteR5uxXF0n9DNYfNyR1MF50WlZvazf8Bjj7nkD+7T+AK7D3mlM
         VymYas9e+XTv2u+KBLuDsg5XFfIWjORtfe0i1rR3UDmVqDGwf9BAbjNYiVgfJ7ZPbLz8
         N23tw+QEjLaaJ0Bl9ZTeJNWEP1j/ChffqlXZjYUOYeuBQHYzoXAZYuSQrHRqpHT3XOoP
         NNNMnAtdHKJgVJmZfyGmZ26dRMUP0biVK34VlQMm6YJaelaLpZZiw9+nTv1wKxa8h483
         mDKpKIApsYiMpmaJBi9Lbvi2saJvGJNSU/xkGbSwpXu+UpjrJQJdfGnKm0AYrhefTdJV
         /LlQ==
X-Gm-Message-State: APjAAAXsVpf+V+aCMUEu49xSSWbsfwFMvMjcNKxaHgReoDBNFAKfuDB+
        4/WMLeIU5qSiXSI3Sm6MeZS6A6rZkTo=
X-Google-Smtp-Source: APXvYqxpnh5ryJNu99UJk1DyouhWQX9c1rYYsT+90OGNUd8qtnam7MgMea7wQA6dTFWYWFsAhimmTA==
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr19709799qkk.128.1576357911445;
        Sat, 14 Dec 2019 13:11:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n190sm4279637qke.90.2019.12.14.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 13:11:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 16:11:49 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/10] efi/libstub: use a helper to iterate over a EFI
 handle array
Message-ID: <20191214211149.GF140998@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-4-ardb@kernel.org>
 <20191214203257.GD140998@rani.riverdale.lan>
 <CAKv+Gu-XAvYf8G+7Oi-XVM+DvR89_zkmETmou-2ftgC41tnvMw@mail.gmail.com>
 <CAKv+Gu9kEySOrKM0Q01a-ZFbSTZz51TcfmnWbSq=LWqKw=8cNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9kEySOrKM0Q01a-ZFbSTZz51TcfmnWbSq=LWqKw=8cNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 09:04:10PM +0000, Ard Biesheuvel wrote:
> On Sat, 14 Dec 2019 at 21:40, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Sat, 14 Dec 2019 at 21:33, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Sat, Dec 14, 2019 at 06:57:28PM +0100, Ard Biesheuvel wrote:
> > > > Iterating over a EFI handle array is a bit finicky, since we have
> > > > to take mixed mode into account, where handles are only 32-bit
> > > > while the native efi_handle_t type is 64-bit.
> > > >
> > > > So introduce a helper, and replace the various occurrences of
> > > > this pattern.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >
> > > > +#define for_each_efi_handle(handle, array, size, i)                  \
> > > > +     for (i = 1, handle = efi_is_64bit()                             \
> > > > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[0]      \
> > > > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[0];     \
> > > > +         i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)      \
> > > > +                                          : sizeof(u32));            \
> > > > +         handle = efi_is_64bit()                                     \
> > > > +             ? (efi_handle_t)(unsigned long)((u64 *)(array))[i]      \
> > > > +             : (efi_handle_t)(unsigned long)((u32 *)(array))[i])
> > > > +
> > > >  /*
> > > >   * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> > > >   * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > This would access one past the array, no? Eg if the array has one
> > > handle, i is incremented to 2 the first time the condition is checked,
> > > then the loop increment will access array[2] before the condition is
> > > checked again. There seem to be at least a couple of other for_each
> > > macros that might have similar issues.
> > >
> >
> > Indeed.
> >
> > > How about the below instead?
> > >
> > > #define for_each_efi_handle(handle, array, size, i)                     \
> > >         for (i = 0;                                                     \
> > >             (i < (size) / (efi_is_64bit() ? sizeof(efi_handle_t)        \
> > >                                           : sizeof(u32))) &&            \
> > >             ((handle = efi_is_64bit()                                   \
> > >                 ? ((efi_handle_t *)(array))[i]                          \
> > >                 : (efi_handle_t)(unsigned long)((u32 *)(array))[i]), 1);\
> > >             i++)
> > >
> >
> > Yeah, that looks correct to me, but perhaps we can come up with
> > something slightly more readable? :-)
> > (Not saying my code was better in that respect)
> 
> How about
> 
> #define efi_get_handle_at(array, idx)      \
>     (efi_is_64bit() ? (efi_handle_t)(unsigned long)((u64 *)(array))[idx] \
>                     : (efi_handle_t)(unsigned long)((u32 *)(array))[i])
> 
> 
> #define efi_get_handle_num(size) \
>     ((size) / (efi_is_64bit() ? sizeof(u64) : sizeof(u32)))
> 
> #define for_each_efi_handle(handle, array, size, i) \
>     for (i = 0; \
>          i < efi_get_handle_num(size) && \
>             ((handle = efi_get_handle_at((array), i)) || true); \
>          i++)

Heh, I came up with almost the same thing, but yours is slightly better,
You have a typo in efi_get_handle_at (i instead of idx in the second
line).
