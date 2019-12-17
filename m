Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4891226B8
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2019 09:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfLQIcu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Dec 2019 03:32:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLQIcu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Dec 2019 03:32:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so10290712wrn.7
        for <linux-efi@vger.kernel.org>; Tue, 17 Dec 2019 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R52GCiHJK3v0MVwNFwQLeAJ4rzyKsEn4BdptyWy4AqA=;
        b=s4cUqU7z5DxsmuduvpFWzEYurebM7Q6vMPcgppHlChAw3Vs91NrCpXn33JuKSVS5Hc
         Ta9w3XdFEwU43agc49krlQx+SLg/q+tbM/YUc0HpuNA2YzoB9WN0Ut0+EPpuby+/fXcl
         r+RG/BOj9wuqdXNIbfpjWVzYLu4Dxt+bq8vSauNM32L27vleJtqlZdLGDNpGvD37JVcP
         K6SzSmV/zSvgw4qT6qFrtQ8lJ8yzHPd4xb4HOABQBSOdlyMLv/hW9F7PNWc+XQceBwfo
         zuelU9UMLMHqGQb8sJR+UT83XbCiSNm0C4aEcAEUyGDfQixXC37ZCOqIwhwf5Vpol2q7
         hffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R52GCiHJK3v0MVwNFwQLeAJ4rzyKsEn4BdptyWy4AqA=;
        b=iB6DF/Sezc/tfoPRP8+mhYMo622Gu39AFGAkT/gGrbdH1m9VTj8+v/9McO7hHJp0+J
         FBR7HeiFQ3Dgkm14jUDr2K56rK+E5b4BX41QpNd8QiT0bThqc21aOINA38ekgu0aWqsn
         qqz4bJckiSSFPSCJrL8l3aKClmmQKPEy8hUOkRmFGv7Pqk9laij3uB1rGhtHzc6T8aMP
         whPmlazU+GrQWC1NGETacQvhNNb59kLaSsaOuQ4Q8lIWdWXBI7PeTkL9OqayhN30CfDs
         67MEZAb10gvXnLl6fLLkdY3KSoSPElsYdlZ+++SxJCAwrMxftlqaTBi+LwLHwPvh8mH2
         ZLiA==
X-Gm-Message-State: APjAAAVDnzAttnFT5Y/GGg5ZY31jzBuUcAcYJ8eo+xVISgElN34/f5QP
        7cT3FYT8NUF4CiUdbj6OdQll4EYfvejNUDxGuCKuag==
X-Google-Smtp-Source: APXvYqwQEyk2xHApao080Ej8fa/PLzVHPCsQb1w8HIAU4PKswqdlVBFdjiXoAMVnJnp9bNAXWzs6xzijUyn1oFV4ec0=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr34763145wrs.200.1576571567865;
 Tue, 17 Dec 2019 00:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-11-ardb@kernel.org>
 <20191215193054.GA2187004@rani.riverdale.lan>
In-Reply-To: <20191215193054.GA2187004@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 17 Dec 2019 08:32:39 +0000
Message-ID: <CAKv+Gu9Ycs8JRvimxfFMRy=tQ0SqX3MYnv0VfUPVAE_Q1S0y1A@mail.gmail.com>
Subject: Re: [PATCH 10/10] efi/libstub/x86: avoid thunking for native firmware calls
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

On Sun, 15 Dec 2019 at 21:31, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 06:57:35PM +0100, Ard Biesheuvel wrote:
> >
> > @@ -232,7 +232,7 @@ static inline bool efi_is_native(void)
> >  #define efi_table_attr(table, attr, instance) ({                     \
> >       __typeof__(((table##_t *)0)->attr) __ret;                       \
> >       if (efi_is_native()) {                                          \
> > -             __ret = ((table##_t *)instance)->attr;                  \
> > +             __ret = instance->attr;                                 \
> >       } else {                                                        \
> >               __typeof__(((table##_32_t *)0)->attr) at;               \
> >               at = (((table##_32_t *)(unsigned long)instance)->attr); \
>
> Is there a reason we didn't remove this cast for native-mode earlier in
> the series?
>

Yes. In patch 9/10, I fix a couple of occurrences where the protocol
pointer is a void*, so without the cast, things break.

> > @@ -242,19 +242,25 @@ static inline bool efi_is_native(void)
> >  })
> >
> >  #define efi_call_proto(protocol, f, instance, ...)                   \
> > -     __efi_early()->call((unsigned long)                             \
> > +     efi_is_native()                                                 \
> > +             ? instance->f(instance, ##__VA_ARGS__)                  \
> > +             : efi64_thunk((unsigned long)                           \
> >                               efi_table_attr(protocol, f, instance),  \
> > -             instance, ##__VA_ARGS__)
> > +                     instance, ##__VA_ARGS__)
> >
> >  #define efi_call_early(f, ...)                                               \
> > -     __efi_early()->call((unsigned long)                             \
> > +     efi_is_native()                                                 \
> > +             ? __efi_early()->boot_services->f(__VA_ARGS__)          \
> > +             : efi64_thunk((unsigned long)                           \
> >                               efi_table_attr(efi_boot_services, f,    \
> > -             __efi_early()->boot_services), __VA_ARGS__)
> > +                     __efi_early()->boot_services), __VA_ARGS__)
> >
> >  #define efi_call_runtime(f, ...)                                     \
> > -     __efi_early()->call((unsigned long)                             \
> > +     efi_is_native()                                                 \
> > +             ? __efi_early()->runtime_services->f(__VA_ARGS__)       \
> > +             : efi64_thunk((unsigned long)                           \
> >                               efi_table_attr(efi_runtime_services, f, \
> > -             __efi_early()->runtime_services), __VA_ARGS__)
> > +                     __efi_early()->runtime_services), __VA_ARGS__)
> >
> >  extern bool efi_reboot_required(void);
> >  extern bool efi_is_table_address(unsigned long phys_addr);
>
> For the efi_call macros, their definition should be enclosed in
> parentheses now that it's a ternary operator.

Ack
