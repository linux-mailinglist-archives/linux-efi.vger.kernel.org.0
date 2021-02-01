Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0732A30B23E
	for <lists+linux-efi@lfdr.de>; Mon,  1 Feb 2021 22:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBAVqD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Feb 2021 16:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhBAVqB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Feb 2021 16:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612215875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSmYYJUxjx/txjv3Ym8eyrnxTI/eSH9db57IFYwcwok=;
        b=ZHjf6r0okTKGJE+rd8C5s3NRksNjGxpWh69K9LpVENXe1C8EbwfN9z25zRjCprNJy8HqVL
        A8jF/8GujXq4ddA1U3nTZGhxeX+KS8kqdRQN1abKr+w2lvoSQz87yhGy/TI9ukbLKyd0PQ
        BOD/JJGTQsjMUe0IkVumxcd3CQeik6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-WO1Z_rXeMVGapiLOI2ZcNQ-1; Mon, 01 Feb 2021 16:44:30 -0500
X-MC-Unique: WO1Z_rXeMVGapiLOI2ZcNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F5401005513;
        Mon,  1 Feb 2021 21:44:28 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0341739A50;
        Mon,  1 Feb 2021 21:44:24 +0000 (UTC)
Date:   Mon, 1 Feb 2021 15:44:23 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210201214423.dhsma73k7ccscovm@treble>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 29, 2021 at 10:10:01AM -0800, Nick Desaulniers wrote:
> On Wed, Jan 27, 2021 at 3:27 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
> > > > From: Raphael Gault <raphael.gault@arm.com>
> > > >
> > > > This plugins comes into play before the final 2 RTL passes of GCC and
> > > > detects switch-tables that are to be outputed in the ELF and writes
> > > > information in an ".discard.switch_table_info" section which will be
> > > > used by objtool.
> > > >
> > > > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > > > [J.T.: Change section name to store switch table information,
> > > >        Make plugin Kconfig be selected rather than opt-in by user,
> > > >        Add a relocation in the switch_table_info that points to
> > > >        the jump operation itself]
> > > > Signed-off-by: Julien Thierry <jthierry@redhat.com>
> > >
> > > Rather than tightly couple this feature to a particular toolchain via
> > > plugin, it might be nice to consider what features could be spec'ed out
> > > for toolchains to implement (perhaps via a -f flag).
> >
> > The problem is being able to detect switch statement jump table vectors.
> >
> > For a given indirect branch (due to a switch statement), what are all
> > the corresponding jump targets?
> >
> > We would need the compiler to annotate that information somehow.
> 
> Makes sense, the compiler should have this information.  How is this
> problem solved on x86?

Thus far we've been able to successfully reverse engineer it on x86,
though it hasn't been easy.

There were some particulars for arm64 which made doing so impossible.
(I don't remember the details.)


> > > Distributions (like Android, CrOS) wont be able to use such a feature as
> > > is.
> >
> > Would a Clang plugin be out of the question?
> 
> Generally, we frown on out of tree kernel modules for a couple reasons.
> 
> Maintaining ABI compatibility when the core kernel changes is
> generally not instantaneous; someone has to notice the ABI has changed
> which will be more delayed than if the module was in tree.  Worse is
> when semantics subtly change.  While we must not break userspace, we
> provide no such guarantees within the kernel proper.
> 
> Also, it's less likely that out of tree kernel modules have been
> reviewed by kernel developers.  They may not have the same quality,
> use the recommended interfaces, follow coding conventions, etc..
> 
> Oh, did I say "out of tree kernel modules?"  I meant "compiler
> plugins."  But it's two different sides of the same coin to me.

I thought Android already relied on OOT modules.

GCC plugins generally enforce the exact same GCC version for OOT
modules.  So there's no ABI to worry about.  I assume Clang does the
same?

Or did I miss your point?

> FWIW, I think the approach taken by -mstack-protector-guard-reg= is a
> useful case study.  It was prototyped as a GCC extension, then added
> to GCC proper, then added to LLVM (currently only x86, but most of the
> machinery is in place in the compiler to get it running on arm64).  My
> recommendation is to skip the plugin part and work on a standard
> interface for compilers to implement, with input from compiler
> developers.

I like the idea.  Is there a recommended forum for such discussions?
Just an email to GCC/Clang development lists?

-- 
Josh

