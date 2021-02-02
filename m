Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51C730CF8E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 00:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhBBXCO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 18:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhBBXCO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 18:02:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04EDC06174A
        for <linux-efi@vger.kernel.org>; Tue,  2 Feb 2021 15:01:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a20so3250142pjs.1
        for <linux-efi@vger.kernel.org>; Tue, 02 Feb 2021 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B8aZfGV5m393mwd0q0yYkdjrdi3QZ7GO2sMeSzwIIY=;
        b=VcnAFaQTekLWePwy0mWPSng4vT5t9aL1yEGNC/21FIOv2UMkvNlD3vKB9Xt4lJ04KM
         IShGaCl5yZ47YgQD0nuS9z6p/56sQ7970gqLsIGe+ALuduGFvfMvOv+hscFOuKin4Zfc
         Hk1knf3jcVJnZm9PvLZCgEuCra/qHu7JLiYdNJlscdKceAq67MqeaizMTS2K0C/WIhm7
         Ot26cTpEPbHTGDPeoFiL3PhXIpCh5VvMvribVhV0J4a06H4204Jwt+qxxjbn/uGrOEJx
         3uOs108IsSFkglbo4fbzX07P3MG3GKbGVn8vWA8fjvYSHuuRoGxRzVwee8dKC6dp+kDF
         5ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B8aZfGV5m393mwd0q0yYkdjrdi3QZ7GO2sMeSzwIIY=;
        b=MPwB113CyO83Ngx251emGT8YwKeJM1actp0o7RlotNNsqT2f0crtjb1BFHAB5v1ISL
         6IJSTHUhhsKNXuvXrlgSR0SowGvtkxSoOEuOQs6I8Sb1/E5tNzQJ04Ot8UaDKh+OT9+Z
         eQiCnSgSfiys4l+Ash5dMvoSIz/ubTXwmk5P6RrybaekY25gsaGQgDzHOpbCS8OcU31p
         XKKsMPT2cApRAK1NqRm9xLyY55nRJFG6mwDP/cmmqAEKO61ZqJ4E3nUJpjlZmjIbDJif
         zgpfwKSwin4tQPaUdnL9SOvVmS3M3IxQwRUsTdhQAL9Y7pF6I6i4Y2fLrVMcs5nM/3k+
         odsw==
X-Gm-Message-State: AOAM533scptNWH79aUeo9xmAMFgrnaVBVjfTHIszJsWwAsBs8DKSrR2n
        JC/kg3MvpcKcS8I5VS69C1coJp2Ad7Nxzun5akQkwA==
X-Google-Smtp-Source: ABdhPJzrcpH8eQPP5ECG7Rn/utCWyAkzeK6qw1rLuh95B7EjilL0QJGAA8pky6qVityb9F8rsEGSOpnYp6pTrWk3npc=
X-Received: by 2002:a17:90a:bf10:: with SMTP id c16mr86751pjs.101.1612306893152;
 Tue, 02 Feb 2021 15:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com> <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble> <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
In-Reply-To: <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Feb 2021 15:01:22 -0800
Message-ID: <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 2, 2021 at 12:57 AM Julien Thierry <jthierry@redhat.com> wrote:
>
>
>
> On 2/2/21 12:17 AM, Nick Desaulniers wrote:
> > On Mon, Feb 1, 2021 at 1:44 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>
> >> On Fri, Jan 29, 2021 at 10:10:01AM -0800, Nick Desaulniers wrote:
> >>> On Wed, Jan 27, 2021 at 3:27 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>>>
> >>>> On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
> >>>>>> From: Raphael Gault <raphael.gault@arm.com>
> >>>>>>
> >>>>>> This plugins comes into play before the final 2 RTL passes of GCC and
> >>>>>> detects switch-tables that are to be outputed in the ELF and writes
> >>>>>> information in an ".discard.switch_table_info" section which will be
> >>>>>> used by objtool.
> >>>>>>
> >>>>>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> >>>>>> [J.T.: Change section name to store switch table information,
> >>>>>>         Make plugin Kconfig be selected rather than opt-in by user,
> >>>>>>         Add a relocation in the switch_table_info that points to
> >>>>>>         the jump operation itself]
> >>>>>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> >>>>>
> >>>>> Rather than tightly couple this feature to a particular toolchain via
> >>>>> plugin, it might be nice to consider what features could be spec'ed out
> >>>>> for toolchains to implement (perhaps via a -f flag).
> >>>>
> >>>> The problem is being able to detect switch statement jump table vectors.
> >>>>
> >>>> For a given indirect branch (due to a switch statement), what are all
> >>>> the corresponding jump targets?
> >>>>
> >>>> We would need the compiler to annotate that information somehow.
> >>>
> >>> Makes sense, the compiler should have this information.  How is this
> >>> problem solved on x86?
> >>
> >> Thus far we've been able to successfully reverse engineer it on x86,
> >> though it hasn't been easy.
> >>
> >> There were some particulars for arm64 which made doing so impossible.
> >> (I don't remember the details.)
>
> The main issue is that the tables for arm64 have more indirection than x86.

I wonder if PAC or BTI also make this slightly more complex?  PAC at
least has implications for unwinders, IIUC.

>
> On x86, the dispatching jump instruction fetches the target address from
> a contiguous array of addresses based on a given offset. So the list of
> potential targets of the jump is neatly organized in a table (and sure,
> before link time these are just relocation, but still processable).
>
> On arm64 (with GCC at least), what is stored in a table is an array of
> candidate offsets from the jump instruction. And because arm64 is
> limited to 32bit instructions, the encoding often requires multiple
> instructions to compute the target address:
>
> ldr<*>  x_offset, [x_offsets_table, x_index, ...]  // load offset
> adr     x_dest_base, <addr>          // load target branch for offset 0
> add     x_dest, x_target_base, x_offset, ...  // compute final address
> br      x_dest        // jump
>
> Where this gets trickier is that (with GCC) the offsets stored in the
> table might or might not be signed constants (and this can be seen in
> GCC intermediate representations, but I do not believe this information
> is output in the final object file). And on top of that, GCC might
> decide to use offsets that are seen as unsigned during intermediate
> representation as signed offset by sign extending them in the add
> instruction.
>
> So, to handle this we'd have to track the different operation done with
> the offset, from the load to the final jump, decoding the instructions
> and deducing the potential target instructions from the table of offsets.
>
> But that is error prone as we don't really know how many instructions
> can be between the ones doing the address computation, and I remember
> some messy case of a jump table inside a jump table where tracking the
> instruction touching one or the other offset would need a lot of corner
> case handling.
>
> And this of course is just for GCC, I haven't looked at what it all
> looks like on Clang's end.

Sure, but this is what production unwinders do, and they don't require
compiler plugins, right?  I don't doubt unwinders can be made simpler
with changes to toolchain output; please work with your compiler
vendor on making such changes rather than relying on compiler plugins
to do so.

> > I think the details are pertinent to finding a portable solution.  The
> > commit message of this commit in particular doesn't document such
> > details, such as why such an approach is necessary or how the data is
> > laid out for objtool to consume it.
> >
>
> Sorry, I will need to make that clearer. The next patch explains it a
> bit [1]
>
> Basically, for simplicity, the plugin creates a new section containing

Right, this takes a focus on simplicity, at the cost of alienating a toolchain.

Ard's point about 3193c0836f20 relating to -fgcse is that when
presented with tricky cases to unwind, the simplest approach is taken.
There it was disabling a compiler specific compiler optimization, here
it's either a compiler specific compiler plugin (or disabling another
compiler optimization).  The pattern seems to be "Objtool isn't smart
enough" ... "compiler optimization disabled" or "compiler plugin
dependency."

> tables (one per jump table) of references to the jump targets, similar
> to what x86 has, except that in this case this table isn't actually used
> by runtime code and is discarded at link time. I only chose this to
> minimize what needed to be changed in objtool and because the format
> seemed simple enough.
>
> But I'm open on some alternative, whether it's a -fjump-table-info

Yes, I think we could spec out something like that.  But I would
appreciate revisiting open questions around stack validation (frame
pointers), preventing the generation of jump tables to begin with
(-fno-jump-tables) in place of making objtool more robust, or
generally the need to depend on compiler plugins.

> option added to compilers with a different format to do the links. The
> important requirement is to be able to know all the candidate targets
> for a "br <reg>" instruction.
>
> [1] https://lkml.org/lkml/2021/1/20/910
>
> Thanks,
>
> --
> Julien Thierry
>


-- 
Thanks,
~Nick Desaulniers
