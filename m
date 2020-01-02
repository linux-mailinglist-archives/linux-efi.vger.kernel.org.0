Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0112E95C
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgABR0l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:26:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37841 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgABR0l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 12:26:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so31907686qky.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lY64rsNeACpJAoHuUyXbQn2CPvLSLWAc2kgVwlADSgM=;
        b=IFVhszecPPfFGegkGq/1AOZbgy1Pc94zvlXw3J16Mz2gI3x1zDWaGYrD4KDSgFQaMH
         m7v1M9I5ews5+ZOI44nUnOmtlnAPEOmq45KemjVBytQi2IEpdba8Oks18jwzYx4popFp
         s1UhUJDC9jXTb4ektcaTXfa5R2U5dcgYy5aZ7EqmBLFOzC2iGCWBoIm0z08xxhpA/bIw
         AuSfZcQMmKDpSYKLXNbnVmKhl3yU4ZhekMjJUFWg1VwY1xHFTssmz496ySfob0woHDkC
         KiW/cl4jdouyXnppkLDGY8aQzzW5hGlwztM+DNgWHy+xmQJnxEbdjpWgWPLwSXlo/jTL
         9K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lY64rsNeACpJAoHuUyXbQn2CPvLSLWAc2kgVwlADSgM=;
        b=lUkO0ovN5GrkCQbTmsbKjPxgx8iqkCmlE1Mh5YaMArBpwCZCE727PMSdQiRIRFomqE
         idG8pHCbx0mk1R/GcxpsE5TYzRfDla0dI8fmenM/JRIqJ3wuVxydkjaEt+Wys3SKR5mv
         LBCisSSpb+sKrikYB74hUdeWC/b1QGRWyqKL3+O9Dw5bWaFoXk0Wi8A8QOShqB/8u2pr
         oq1HA+IYJ8g2H3IPVVJsYxbrnmPis8yvjFkBVvz3degtc2EFfgXfPpe37WL3hWMoMlSH
         VkNSGzOqCRbFwTbR5VHMnHt/l4bXepeeB7UYYT6Tx6Xmhm3NlYgFoWkoH7OORCid44UC
         i6bA==
X-Gm-Message-State: APjAAAVkUQylZEkk/aZO/L4lj2ExfhlzR6vKfHW/+K7GcR423afblyVA
        irQN24aRJISe3O/l+9WfwOY=
X-Google-Smtp-Source: APXvYqwsh+Ko7nVxWmxquPB7nGYufuP3428Ca67+BKBldsrpshNI1vrFRDMbf2y1v/kH3xbbiEK8dQ==
X-Received: by 2002:a37:674a:: with SMTP id b71mr69518272qkc.471.1577986000313;
        Thu, 02 Jan 2020 09:26:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u57sm17199622qth.68.2020.01.02.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:26:39 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 12:26:38 -0500
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
Message-ID: <20200102172637.GB701372@rani.riverdale.lan>
References: <20191231230436.GA78532@rani.riverdale.lan>
 <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan>
 <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 05:59:27PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 17:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > > >
> > > > > Yeah, good point.
> > > > >
> > > > > I pushed as branch here;
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > > >
> > > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > > >
> > > > Haven't built it yet -- but how does this handle the GOT issues you
> > > > mentioned?
> > >
> > > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > > to the extern declaration of efi_is64, but I am having trouble to
> > > reproduce the original issue.
> >
> > Some background:
> >
> > https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> > https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
> 
> OK, I have done a bit more digging, and it seems like recent
> toolchains can optimize away GOT indirections using R_386_GOT32X
> relocations, which can be converted into R_386_GOTOFF relocations by
> the linker if it is building a fully linked binary, making the actual
> contents of the GOT entries irrelevant.
> 
> Note that even if the GOT entries are not fixed up, assigning a global
> variable and then using it again may work by accident if the memory it
> points to is writable, which is why it is not easy to reproduce
> reliably.
> 
> efi_is64 only exists on 64-bit, so annotating that as 'hidden' should
> work. But efi_system_table() is also used on 32-bit, so I'll leave
> that one alone for now.

With hidden visibility, 32-bit compiler seems to generate GOTOFF
relocations directly so it shouldn't depend on recent toolchain?

https://godbolt.org/z/79iA_3
