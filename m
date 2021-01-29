Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB544308C31
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jan 2021 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhA2SLD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jan 2021 13:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhA2SKx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jan 2021 13:10:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E5C061756
        for <linux-efi@vger.kernel.org>; Fri, 29 Jan 2021 10:10:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d4so5666370plh.5
        for <linux-efi@vger.kernel.org>; Fri, 29 Jan 2021 10:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8bQLC4KTV3CkyE7ZwNAPVrk7LCX4mmpuoPxOJQrWiE=;
        b=KvqRCWR7yYnMWqMPB85CIlQ9uuauY32Z1DzrJGBzcW0aqXSXWSL+GTldnhHkS6AKzM
         Z+dKRERAy31Z5zbVPZRInzz7qitp8nuSvP4G6GBay3e5DDFmiNyfUZFJ7xH1bD6wSsEX
         u7qSwj9pH6oMtqk64thV9cxPBWytlOGsF8nIsIynlNxnxsL3KJFG0t+6vpo8+vGyL6/N
         u9GvbFypr9EN6ePRjWq0JE4N/ZnHMTnOGk4YRA2/T2ZVGF5ne2y00SPxYmNQiDSUHNbW
         N7D4SxHDqYDmjHcyJq20+7BNR075rraIU/iNjmNN1SoTBzKFhI3DXt7QVsjxqczfDV6e
         cTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8bQLC4KTV3CkyE7ZwNAPVrk7LCX4mmpuoPxOJQrWiE=;
        b=dn2TVHPckOjF/kNd8bxhKsXOVpWbeksW0oCXIzhhZdyMBN/O+D2y+OyhR01/i9Yk/B
         O/aypwD7FrpjS1JqpHkNYZBltkg+RWVrcKzQiR6iIkKble+6Bu7XJwvWJkwdyMK59pTn
         sp5phBvK/hd+roItMLhe4l+0isw6GFtKAttZKQ4xsKp0ryPJEvbH3agkC538uP+TlTFs
         sMGWhZ1jOxOeNX28Vat/vP7rz61cIISn95bK9vzYvudCqcg1z0DPDfXzT8rvqTFMugZc
         MMr7FZhy5no22EMtIKUG+3YP8YSZGjSO5a/CJ0m3y7bvCo5dLOWnBa7FXGqTUxoRu8EU
         YgDw==
X-Gm-Message-State: AOAM532TgFkBjCrfPbPJFo45GR66JzZP0vKVS9YnBP8fz559gUr0hzcX
        9KkckQkCkK7ejTz5P9UxcxXieFKTuT3XspNpcg4VEg==
X-Google-Smtp-Source: ABdhPJzNOCqxQWJ9Oc6G5S88I6N7IbWrIQufk+V18JCZ1n4SuRaCwOpg3TVxWVz17PfOIZCgcQ1Gfy3YkqFIXZFD3bI=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr5473562plc.10.1611943812360; Fri, 29 Jan
 2021 10:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com> <20210127232651.rj3mo7c2oqh4ytsr@treble>
In-Reply-To: <20210127232651.rj3mo7c2oqh4ytsr@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 10:10:01 -0800
Message-ID: <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 27, 2021 at 3:27 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
> > > From: Raphael Gault <raphael.gault@arm.com>
> > >
> > > This plugins comes into play before the final 2 RTL passes of GCC and
> > > detects switch-tables that are to be outputed in the ELF and writes
> > > information in an ".discard.switch_table_info" section which will be
> > > used by objtool.
> > >
> > > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > > [J.T.: Change section name to store switch table information,
> > >        Make plugin Kconfig be selected rather than opt-in by user,
> > >        Add a relocation in the switch_table_info that points to
> > >        the jump operation itself]
> > > Signed-off-by: Julien Thierry <jthierry@redhat.com>
> >
> > Rather than tightly couple this feature to a particular toolchain via
> > plugin, it might be nice to consider what features could be spec'ed out
> > for toolchains to implement (perhaps via a -f flag).
>
> The problem is being able to detect switch statement jump table vectors.
>
> For a given indirect branch (due to a switch statement), what are all
> the corresponding jump targets?
>
> We would need the compiler to annotate that information somehow.

Makes sense, the compiler should have this information.  How is this
problem solved on x86?

>
> > Distributions (like Android, CrOS) wont be able to use such a feature as
> > is.
>
> Would a Clang plugin be out of the question?

Generally, we frown on out of tree kernel modules for a couple reasons.

Maintaining ABI compatibility when the core kernel changes is
generally not instantaneous; someone has to notice the ABI has changed
which will be more delayed than if the module was in tree.  Worse is
when semantics subtly change.  While we must not break userspace, we
provide no such guarantees within the kernel proper.

Also, it's less likely that out of tree kernel modules have been
reviewed by kernel developers.  They may not have the same quality,
use the recommended interfaces, follow coding conventions, etc..

Oh, did I say "out of tree kernel modules?"  I meant "compiler
plugins."  But it's two different sides of the same coin to me.

FWIW, I think the approach taken by -mstack-protector-guard-reg= is a
useful case study.  It was prototyped as a GCC extension, then added
to GCC proper, then added to LLVM (currently only x86, but most of the
machinery is in place in the compiler to get it running on arm64).  My
recommendation is to skip the plugin part and work on a standard
interface for compilers to implement, with input from compiler
developers.
-- 
Thanks,
~Nick Desaulniers
