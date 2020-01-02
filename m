Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF812E97B
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgABRlq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:41:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44603 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgABRlq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 12:41:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so35149683qtr.11
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 09:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ir9wR+qOuONBXCoIUNZk8YEdnGKDb7yQ05d/b7En344=;
        b=r+6y+FFzohiUk12j4MOAFqSNgBqn+oRvirVY7WIE+WSuaR9XXqrBBl0xiGZBe0+ScN
         lp4JBZXHMAjoF5r/PH/YdCxuWuDHIBj9GUPY83hcKlOK4HfKLXsazunOEFQDQtGKn6H0
         hqwV/iypCHy0ezBAzVQ2TzP13vXmQSNTzKH6sg8XXY82ren+nd8K78lx56pQTGokJhyO
         8drj8UIwK7PxB7XqWUpxe5s8d+sue2RF9GmtE8LxZ0DchfHS3NnkBx0NY+ZDNo+vY4Qi
         KdlKYj9NS/t8cafNJRfaAGAQ3eyiXDy2ZLPjZqf7voHVClH4dg/7abVRxY1sikLwo5JM
         UzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ir9wR+qOuONBXCoIUNZk8YEdnGKDb7yQ05d/b7En344=;
        b=lPHCoibZUX0lUdjM2vxfREMkrYdtZ1gNp9b+5TdMvOVEDbnKZuwUC31Cae+svGkTzc
         uN+XogczaRqHtyXeYrAZh2BxkBe/2HslyXKXeWS3gDDCbLf8Ofd919BZ2chCGEiuce4B
         uF4lpopBqkO9LL+QoDL3FsRYSrk1rg7BodPfOlyYjdBctz9D5rnfBU2BwkCflf8qDQw5
         BiDtRD19i4jDrMT5F/D+Ai+MAHa2d6XdocMiiiL/bRNeoiUEa8Rub9pKRLIAMjErxIKa
         47MxH/AcVgGW6e+vHMMcLavFnx9PuG1YxI+OOIXSx5DY4paWK2XbB8R7tsNa7zVk3Ge0
         Rkjw==
X-Gm-Message-State: APjAAAXNk3xAyqcvikOAjDCRLV9LwoGKrgWyOuP1CNm4eHlEkmcOeB9I
        tIhiNueK9Ba9wYmlEsO1JpE=
X-Google-Smtp-Source: APXvYqzXeNLrp9Oyrofqq9XMAJpJJOr6Kv0QNnQJ3bfW1oIH0QNLM84cZzBRAtGtf43Ev1GO9ZXubA==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr61379276qte.327.1577986905334;
        Thu, 02 Jan 2020 09:41:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v7sm17325985qtk.89.2020.01.02.09.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:41:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 12:41:43 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200102174142.GA713602@rani.riverdale.lan>
References: <20200101190844.GA208136@rani.riverdale.lan>
 <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan>
 <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 06:30:46PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 18:26, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Jan 02, 2020 at 05:59:27PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 2 Jan 2020 at 17:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > > > > >
> > > > > > > Yeah, good point.
> > > > > > >
> > > > > > > I pushed as branch here;
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > > > > >
> > > > > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > > > > >
> > > > > > Haven't built it yet -- but how does this handle the GOT issues you
> > > > > > mentioned?
> > > > >
> > > > > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > > > > to the extern declaration of efi_is64, but I am having trouble to
> > > > > reproduce the original issue.
> > > >
> > > > Some background:
> > > >
> > > > https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> > > > https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
> > >
> > > OK, I have done a bit more digging, and it seems like recent
> > > toolchains can optimize away GOT indirections using R_386_GOT32X
> > > relocations, which can be converted into R_386_GOTOFF relocations by
> > > the linker if it is building a fully linked binary, making the actual
> > > contents of the GOT entries irrelevant.
> > >
> > > Note that even if the GOT entries are not fixed up, assigning a global
> > > variable and then using it again may work by accident if the memory it
> > > points to is writable, which is why it is not easy to reproduce
> > > reliably.
> > >
> > > efi_is64 only exists on 64-bit, so annotating that as 'hidden' should
> > > work. But efi_system_table() is also used on 32-bit, so I'll leave
> > > that one alone for now.
> >
> > With hidden visibility, 32-bit compiler seems to generate GOTOFF
> > relocations directly so it shouldn't depend on recent toolchain?
> >
> > https://godbolt.org/z/79iA_3
> 
> Yes, that was my assumption at the time as well, but we still ended up
> with /some/ absolute GOT dereferences for some reason in the 32-bit
> kernel.

Do you remember if we ever figured out what was wrong with Matt
Fleming's patch to fixup the GOT for the EFI stub too?

For efi_system_table, if we don't want to risk creating GOT entries, one
option would be to do what you did for is64, but define the wrapper
function as an out-of-line function in the assembler code and declare it
const.
