Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522421F99CB
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgFOOPk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 10:15:40 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:60952 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgFOOPi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jun 2020 10:15:38 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 05FEFFuc001841;
        Mon, 15 Jun 2020 23:15:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 05FEFFuc001841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592230515;
        bh=xmQzt5ozqUDfusz/+X9tTq5Zy7GppPGRYRP3NXmssX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CoxsK5UqwzZtQIy2bAWA1dkV2aYZCFEcHX8OOVC/AC23vI4UYkamBipCyAwaQHsNC
         W8Uf9NlwRq0KuMpuK4te2tLdIBt0Rs8NeTAJ6HMZne8e3XdKqsvtl0t3MMtOGTlO2K
         WcvFtYLDrgQJKsEhRfJdytQl3exxC+rJ5nY53eYQ/Z+URmm3cUA31VG8eCM4oSy+21
         OyRlAzPZEu3ycCxYygW1yiskY7999e3MOPdxa0fY1rmcEYjxoBUVfCX2j9IwPpMcUx
         1I24NyNhJuTYLDGnEm286TqBe1C2O42phDlOZG+sHL5meVg+BGT2RRHFooVjmDA9pr
         hPFphn4g44KpA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id i8so1122297uak.9;
        Mon, 15 Jun 2020 07:15:15 -0700 (PDT)
X-Gm-Message-State: AOAM530wGKXVt7v5anSk1Ekfnc1vXHT42S13QTOHeEa/GYX/HqPdaO9x
        fgTZJQ4xAglZcyGiXYlCc0NF9L0A/yIBLydLLSw=
X-Google-Smtp-Source: ABdhPJwGbVy/6TjyF65GLtUD4/lPeWjMrUoVu8Kl4lBNcgY1L1EifCammXZkd6BT/Cgh7HUPvFAO52Hed6qKoukOZRQ=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr19609339uae.121.1592230514499;
 Mon, 15 Jun 2020 07:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200604022031.164207-1-masahiroy@kernel.org> <20200604022031.164207-2-masahiroy@kernel.org>
 <CAMj1kXEHDFnhgsz4w+6DuwPxcSZ5P8o0rMzQ504Nt4i31MXwJQ@mail.gmail.com> <CAMj1kXFhULbche0kbGr+mHofOYBU2WT8i7Bgx-qgz6Cp6AE8ow@mail.gmail.com>
In-Reply-To: <CAMj1kXFhULbche0kbGr+mHofOYBU2WT8i7Bgx-qgz6Cp6AE8ow@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 15 Jun 2020 23:14:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcq2O5redrnBnLuRXGs7HxyRxn_VSs2oRtDwOLkxLMdA@mail.gmail.com>
Message-ID: <CAK7LNARcq2O5redrnBnLuRXGs7HxyRxn_VSs2oRtDwOLkxLMdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 15, 2020 at 7:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 15 Jun 2020 at 12:26, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 4 Jun 2020 at 04:20, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Documentation/kbuild/makefiles.rst says:
> > >
> > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > >
> > > This is because lib-y is inteded to be hooked to KBUILD_VMLINUX_LIBS,
> > > which is passed down to scripts/link-vmlinux.sh.
> > >
> > > Besides, lib-y is not so interesting because objects from lib-y are
> > > mostly linked in normal usecases. For example, lib-y only saves 364
> > > bytes for x86_64_defconfig. You can see the details in commit
> > > 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when
> > > CONFIG_MODULES=y").
> > >
> > > I think we should consider to deprecate lib-y syntax at some point
> > > because we should aim for better solution like dead code elimination
> > > or LTO.
> > >
> > > Other than lib/ and arch/*/lib, this Makefile is the only user of
> > > lib-y. Replace lib-y with a custom rule.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Series queued in efi/urgent.
> >
>
> Actually, I am seeing this now
>
> /home/ard/linux/scripts/Makefile.build:421: warning: overriding recipe
> for target 'drivers/firmware/efi/libstub/lib.a'
> /home/ard/linux/drivers/firmware/efi/libstub/Makefile:131: warning:
> ignoring old recipe for target 'drivers/firmware/efi/libstub/lib.a'



Sorry, please drop this patch for now.

(Actually, it was working when I submitted it,
but is broken after e578edc72276280b8fae57f6bf79cb443ceee7a2)



-- 
Best Regards
Masahiro Yamada
