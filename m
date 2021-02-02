Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3792E30B3CD
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 01:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBBADm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Feb 2021 19:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230214AbhBBADk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Feb 2021 19:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612224132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMnypghb7eobehgvuvyvI6ftY8R6Uotx581HxzZ88OM=;
        b=VMXON0Y5kGhBMftY2mrcCs/FBvFCgGo8RwD83LSlbxnk+FyJhZyf8oV0qOQyzqvbxp9XOR
        8HQpq3VfHm1qK1ySzKPtz0uFhaAwDklOrrIYdqhBDIJYsqzCNy/zGMY8GZYXpHWRzE74DJ
        ++/cAHRa6KJmBJfxlo/OiUvmQFLSGcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-PjoyMbgUNiSDiR5nWhS47g-1; Mon, 01 Feb 2021 19:02:10 -0500
X-MC-Unique: PjoyMbgUNiSDiR5nWhS47g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FE43107ACE6;
        Tue,  2 Feb 2021 00:02:07 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4250E5D9CA;
        Tue,  2 Feb 2021 00:02:05 +0000 (UTC)
Date:   Mon, 1 Feb 2021 18:02:03 -0600
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210202000203.rk7lh5mx4aflgkwr@treble>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 01, 2021 at 03:17:40PM -0800, Nick Desaulniers wrote:
> > > > > Rather than tightly couple this feature to a particular toolchain via
> > > > > plugin, it might be nice to consider what features could be spec'ed out
> > > > > for toolchains to implement (perhaps via a -f flag).
> > > >
> > > > The problem is being able to detect switch statement jump table vectors.
> > > >
> > > > For a given indirect branch (due to a switch statement), what are all
> > > > the corresponding jump targets?
> > > >
> > > > We would need the compiler to annotate that information somehow.
> > >
> > > Makes sense, the compiler should have this information.  How is this
> > > problem solved on x86?
> >
> > Thus far we've been able to successfully reverse engineer it on x86,
> > though it hasn't been easy.
> >
> > There were some particulars for arm64 which made doing so impossible.
> > (I don't remember the details.)
> 
> I think the details are pertinent to finding a portable solution.  The
> commit message of this commit in particular doesn't document such
> details, such as why such an approach is necessary or how the data is
> laid out for objtool to consume it.

Agreed, the commit message needs more details.

> > > > > Distributions (like Android, CrOS) wont be able to use such a feature as
> > > > > is.
> > > >
> > > > Would a Clang plugin be out of the question?
> > >
> > > Generally, we frown on out of tree kernel modules for a couple reasons.
> > >
> > > Maintaining ABI compatibility when the core kernel changes is
> > > generally not instantaneous; someone has to notice the ABI has changed
> > > which will be more delayed than if the module was in tree.  Worse is
> > > when semantics subtly change.  While we must not break userspace, we
> > > provide no such guarantees within the kernel proper.
> > >
> > > Also, it's less likely that out of tree kernel modules have been
> > > reviewed by kernel developers.  They may not have the same quality,
> > > use the recommended interfaces, follow coding conventions, etc..
> > >
> > > Oh, did I say "out of tree kernel modules?"  I meant "compiler
> > > plugins."  But it's two different sides of the same coin to me.
> >
> > I thought Android already relied on OOT modules.
> 
> Android Common Kernel does not *rely* on OOT modules or compiler
> plugins.  Android doesn't forbid vendors from using OOT modules,
> though, just as the mainline kernel does not prevent modules from
> being built out of tree, or users from insmod'ing them.  It's
> certainly a pragmatic approach; idealism doesn't work for all OEMs.

No judgement, RHEL is similar.  Linux is nothing if not pragmatic.

> Personally, I lean more towards idealistic; I prefer in-tree modules,
> dislike compiler plugins (for much the same reasons), and idealize
> loose coupling of software components. This series looks to me like it
> tightly couples arm64 live patching to objtool and GCC.
> 
> On the earlier thread, Julien writes:
> 
> >> I think most people interested in livepatching are using GCC built
> >> kernels, but I could be mistaken (althought in the long run, both
> >> compilers should be supported, and yes, I realize the objtool solution
> >> currently only would support GCC).
> 
> Google's production kernels are using livepatching and are built with
> Clang.  Getting similar functionality working for arm64 would be of
> interest.

Well, that's cool.  I had no idea.

I'm curious how they're generating livepatch modules?  Because
kpatch-build doesn't support Clang (AFAIK), and if they're not using
kpatch-build then there are some traps to look out for.

> > GCC plugins generally enforce the exact same GCC version for OOT
> > modules.  So there's no ABI to worry about.  I assume Clang does the
> > same?
> >
> > Or did I miss your point?
> 
> I think so.  It would seem that the current solution for stack
> validation would require multiple different compiler plugins to work
> reliably.  If jump tables are an issue, I don't see why you wouldn't
> pursue a more portable option like -fno-jump-tables first, then work
> to claw back any performance loss from that, if relevant?  Then
> there's no complaint about toolchain specific implementations or tight
> coupling.
> 
> Objtool support on arm64 is interesting to me though, because it has
> found bugs in LLVM codegen. That alone is extremely valuable.  But not
> it's not helpful if it's predicated or tightly coupled to GCC, as this
> series appears to do.

I agree 100%, if there are actual Clang livepatch users (which it sounds
like there are) then we should target both compilers.

And yes, objtool has been pretty good at finding compiler bugs, so the
more coverage the better.

I like the -fno-jump-tables suggestion, assuming it doesn't affect
performance significantly.

> The idea of rebuilding control flow from binary analysis and using
> that to find codegen bugs is a really cool idea (novel, even? idk),
> and I wish we had some analog for userspace binaries that could
> perform similar checks.

Objtool is generic in many ways -- in fact I recently heard from a PhD
candidate who used it successfully on another kernel for an ORC
unwinder.

It could probably be used on user space without much effort.  That was
an early original stated goal but I definitely don't have the bandwidth
or incentive to work on it.

> > > FWIW, I think the approach taken by -mstack-protector-guard-reg= is a
> > > useful case study.  It was prototyped as a GCC extension, then added
> > > to GCC proper, then added to LLVM (currently only x86, but most of the
> > > machinery is in place in the compiler to get it running on arm64).  My
> > > recommendation is to skip the plugin part and work on a standard
> > > interface for compilers to implement, with input from compiler
> > > developers.
> >
> > I like the idea.  Is there a recommended forum for such discussions?
> > Just an email to GCC/Clang development lists?
> 
> linux-toolchains@vger.kernel.org is probably a good start.

Thanks, I'll write something up (maybe a more specific proposal) and
post it.

-- 
Josh

