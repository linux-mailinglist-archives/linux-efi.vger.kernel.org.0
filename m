Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52311F3BB
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 20:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLNTy3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 14:54:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36398 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNTy3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 14:54:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2488347wru.3
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grPI4U/TyUjvj9diEzcJptUpKJwg5d3nMyD43dEd3Zs=;
        b=Fyb0CFtwUccUksZ/E4Bu9XtdsBR7IBVk2qHA6syXHRj5uo4dP2r7FnhrJARnbF5Sl2
         8npjfaZE2CPVoLXw7OMTQAk1PWsX7DoigccMyIzECkBYNpZwi0fdgfTMuFUrf0emsPbE
         s+Hb3ojHBmL1kqYysiVzeupk4tAgKUrM4PENTYjtrueZksa7mOiWltrVCdxM2CGmTWbt
         7+/CobijwquoSYwwF5NXY1/jtXs42jGHizcbeTvjjheFHt0V5e2KYVak3WQebs+hIOUs
         J6d/g8AKpext/97p7tuAKE1g4hLMje3/woAAtd+8OUrvuVqiOqddZ8AydYhTETiUCEsV
         SlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grPI4U/TyUjvj9diEzcJptUpKJwg5d3nMyD43dEd3Zs=;
        b=PdNwqxSFpCJaHVqpsndKxQx8C5GqrW1YC7ugtmo+iJIqOKt4jpoTCvNOpn3ClSXVTd
         2cXgEi8hpY0OWDYJ1MuSAJO/DO6TXfGb346/BeOUmKqMdFz9GaNcVGQCmdMSJoAUPtdc
         ffBiaftyemB4W8PevKymRt0gSg2OgN3hBw+UviG3vLK+7NS04sKDZCczppvzvgTsQQkO
         m7CSzxFVts14ivCEs+WlFI11XD1WAORk/EhUd69qADl7Vrn4rnUrxQzsu/gfVMY2ykZs
         I2XKZz70vj6K0ku+F6BLExGIpNIPxG6roCKrmHCKL+QJeExciorvuRry55zKqhTU9tnk
         XW2Q==
X-Gm-Message-State: APjAAAVxNZfo6ySL1REJYV/RJcnQUWCAetu/OctWeg2EvTkIvCPz4ROY
        8lElbuLVaPGoECGdGoAjCs+Ght53y1+2aKQDgQuHbw==
X-Google-Smtp-Source: APXvYqylmurNXctFqjq1tsNUYL5jmp6IYmmZaVRBde+zNDBm7NX/DZ7JM62G+JJYoW0jaIno7vaB0F+MaxOEOAQvFvk=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr19266454wrr.32.1576353266872;
 Sat, 14 Dec 2019 11:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan> <20191214194936.GB140998@rani.riverdale.lan>
In-Reply-To: <20191214194936.GB140998@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 19:54:25 +0000
Message-ID: <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
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

On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > +
> > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > +   if (efi_is_native()) {                                          \
> > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > +   } else {                                                        \
> > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > +   }                                                               \
> > > +   __ret;                                                          \
> > > +})
> >
> > The casting of `at' is appropriate if the attr is a pointer type which
> > needs to be zero-extended to 64-bit, but for other fields it is
> > unnecessary at best and possibly dangerous.  There are probably no
> > instances currently where it is called for a non-pointer field, but is
> > it possible to detect if the type is pointer and avoid the cast if not?
>
> To clarify, I mean the casting via `unsigned long' -- casting to type of
> __ret should be ok. We could also use uintptr_t for cleanliness when the
> cast is required?

Could you give an example of how it could break?
