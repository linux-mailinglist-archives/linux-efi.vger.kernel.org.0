Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3988630D031
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 01:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhBCAQD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 19:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231436AbhBCAQB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 19:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612311272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SiaraPMcWlUGQ15HgWRnEvPFg5Cm3xwMPN0LwTOYT8c=;
        b=agnhJAtKz8i+bQHm7wdMz5h/NXs6tovDFJwpKl0z+dpqphbDlfLTuZhVcPnrfZnyxCjKOT
        Cf3Iza4Do3Ow9KDabPg5tQ+0Lb0XYkiYVwPLdqKtpz3NiH/F9GvAk28P6QSHTPC2yhxrbJ
        Z8x1S8sGffXtNjUT6doz1c2tJaERPVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-6TM_tgRuO0-KZsWk2A-z2Q-1; Tue, 02 Feb 2021 19:14:28 -0500
X-MC-Unique: 6TM_tgRuO0-KZsWk2A-z2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E9E801817;
        Wed,  3 Feb 2021 00:14:26 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD7118993;
        Wed,  3 Feb 2021 00:14:21 +0000 (UTC)
Date:   Tue, 2 Feb 2021 18:14:14 -0600
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
        Bill Wendling <morbo@google.com>, swine@google.com,
        yonghyun@google.com
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210203001414.idjrcrki7wmhndre@treble>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
 <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 02, 2021 at 03:01:22PM -0800, Nick Desaulniers wrote:
> > >> Thus far we've been able to successfully reverse engineer it on x86,
> > >> though it hasn't been easy.
> > >>
> > >> There were some particulars for arm64 which made doing so impossible.
> > >> (I don't remember the details.)
> >
> > The main issue is that the tables for arm64 have more indirection than x86.
> 
> I wonder if PAC or BTI also make this slightly more complex?  PAC at
> least has implications for unwinders, IIUC.

What is PAC/BTI?

> > On x86, the dispatching jump instruction fetches the target address from
> > a contiguous array of addresses based on a given offset. So the list of
> > potential targets of the jump is neatly organized in a table (and sure,
> > before link time these are just relocation, but still processable).
> >
> > On arm64 (with GCC at least), what is stored in a table is an array of
> > candidate offsets from the jump instruction. And because arm64 is
> > limited to 32bit instructions, the encoding often requires multiple
> > instructions to compute the target address:
> >
> > ldr<*>  x_offset, [x_offsets_table, x_index, ...]  // load offset
> > adr     x_dest_base, <addr>          // load target branch for offset 0
> > add     x_dest, x_target_base, x_offset, ...  // compute final address
> > br      x_dest        // jump
> >
> > Where this gets trickier is that (with GCC) the offsets stored in the
> > table might or might not be signed constants (and this can be seen in
> > GCC intermediate representations, but I do not believe this information
> > is output in the final object file). And on top of that, GCC might
> > decide to use offsets that are seen as unsigned during intermediate
> > representation as signed offset by sign extending them in the add
> > instruction.
> >
> > So, to handle this we'd have to track the different operation done with
> > the offset, from the load to the final jump, decoding the instructions
> > and deducing the potential target instructions from the table of offsets.
> >
> > But that is error prone as we don't really know how many instructions
> > can be between the ones doing the address computation, and I remember
> > some messy case of a jump table inside a jump table where tracking the
> > instruction touching one or the other offset would need a lot of corner
> > case handling.
> >
> > And this of course is just for GCC, I haven't looked at what it all
> > looks like on Clang's end.
> 
> Sure, but this is what production unwinders do, and they don't require
> compiler plugins, right?

What do you mean by "production unwinders"?  Generally unwinders rely on
either frame pointers or DWARF, but (without validation) those aren't
robust enough for live patching in the kernel, so I'm not sure how this
is relevant.

> > > I think the details are pertinent to finding a portable solution.  The
> > > commit message of this commit in particular doesn't document such
> > > details, such as why such an approach is necessary or how the data is
> > > laid out for objtool to consume it.
> > >
> >
> > Sorry, I will need to make that clearer. The next patch explains it a
> > bit [1]
> >
> > Basically, for simplicity, the plugin creates a new section containing
> 
> Right, this takes a focus on simplicity, at the cost of alienating a toolchain.
> 
> Ard's point about 3193c0836f20 relating to -fgcse is that when
> presented with tricky cases to unwind, the simplest approach is taken.
> There it was disabling a compiler specific compiler optimization, here
> it's either a compiler specific compiler plugin (or disabling another
> compiler optimization).  The pattern seems to be "Objtool isn't smart
> enough" ... "compiler optimization disabled" or "compiler plugin
> dependency."

You're taking the two absolute worst case scenarios (one of which is
just a patch which doesn't look like it's going to get merged anyway)
and drawing a false narrative.

In this case the simplest approach would have been to just give up and
disable jump tables.

We try as hard as possible (beyond turning objtool into a full emulator)
to avoid doing that kind of thing because objtool isn't supposed to
dictate kernel optimizations.  Otherwise we would have disabled jump
tables (even for non-retpolines) a long time ago, because that's been a
serious PITA.

You might not like the plugin -- I don't like it either -- but the goal
was to avoid penalizing the kernel with "objtool-friendly"
optimizations.

That said, jump tables are such a pain for objtool (and currently
impossible to deal with for arm64) that I'm completely open to just
disabling them if they're shown to have negligible benefit for the
kernel.

-- 
Josh

