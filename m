Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B486025A213
	for <lists+linux-efi@lfdr.de>; Wed,  2 Sep 2020 01:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIAXyY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Sep 2020 19:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIAXyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Sep 2020 19:54:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A0C061245
        for <linux-efi@vger.kernel.org>; Tue,  1 Sep 2020 16:54:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so1779262pfp.11
        for <linux-efi@vger.kernel.org>; Tue, 01 Sep 2020 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vr/GRpBoEYmMuCS63slKe/6FyD7UiqC7EOcVZHXrpYc=;
        b=uz93oa+cmzW9oTnATL428U6pMu17BMVfzmaMjK4fk6Pr50aa1EJBroz8GVphFXX1DC
         xakDt5YXF7xxpRdVUQJBBYUnHHokCsCzD409wTF48swCZaPGPBw8N/Eu1/iDvX+LwOHT
         /ZV87MKvTEGAyHhk5QguI3zXGk7KdqaDBxsVyNc8bquF02gR+FcCUuQtoqaAmY6eF1Ox
         YST9d4Rsw5ptQHBz/JbuP6UFlPBmOqzGa3RDnTuZedLKppgnemVaQeUSGg4TKX9/guQd
         sqjqZBf0mJY9HM1qcuiWhfcK+8/e7DJnSmsSSRZVq1yEjOyQ8y0mqq/E3jnqnuv8Tnfv
         itdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vr/GRpBoEYmMuCS63slKe/6FyD7UiqC7EOcVZHXrpYc=;
        b=n53YxTXkGSV91IepR/Vv1WfSqLs/PFwzxJ1mDdf6b0L9MqRFPCMe8majrjR0RZfXbN
         dOrV76cuPiKEp25T89qvwkzm4J3lMEF7hdvDQ7yBxRQt5JzFrgTlusUpM9oy0Vrf6NCa
         5YPGyRselbJM2ia4PJFv89UHiHemZYuEP6dpYCW2Yb/7B+JMuCNYh9GqG/Eo68WV7WH5
         xWwlDh14wJw2r06ySEkoZEkdnY0eW1Y/0HH+h1IvLI/LpljilcxV95VOuiFjCPYMK+CU
         h2TqRMd7mcga1MJpmV6et3xPAbZNNwwZk9RXKYNpG4VOqza2bGz2rc1CkVtWir9zrtDQ
         Fjjg==
X-Gm-Message-State: AOAM533zJWGFoDaOLBSIW+1EyubK5k8yoPwpruFyNgMkPSts21ZRhgfq
        VHLcGABpiV6vPrq8vaRbfkKjnQ4GuRWFuEpXI1oWAA==
X-Google-Smtp-Source: ABdhPJxTACSixKp/ZU9Zg50XGHk3ByA89yXDEzS29Y6IrN6+Y6W0mcsXbJ1k3kHy2PmcQKLZUI3aPxQZ5rHcknTWv7M=
X-Received: by 2002:a62:19cd:: with SMTP id 196mr621969pfz.143.1599004460212;
 Tue, 01 Sep 2020 16:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook> <20200901071133.GA3577996@gmail.com>
 <20200901075937.GA3602433@gmail.com> <20200901081647.GB3602433@gmail.com>
 <202009010816.80F4692@keescook> <CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com>
 <202009011616.E6DC7D54EF@keescook>
In-Reply-To: <202009011616.E6DC7D54EF@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Sep 2020 16:54:08 -0700
Message-ID: <CAKwvOdnDMvECAhKcTVEqcgM9QAUX05Gj27q7fZCbudANX-GWDg@mail.gmail.com>
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 1, 2020 at 4:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 01, 2020 at 11:02:02AM -0700, Nick Desaulniers wrote:
> > Uh oh, the ppc vdso uses cc-ldoption which was removed! (I think by
> > me; let me send patches)  How is that not an error?  Yes, guilty,
> > officer.
> > commit 055efab3120b ("kbuild: drop support for cc-ldoption").
> > Did I not know how to use grep, or?  No, it is
> > commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
> > that is wrong.
>
> Eek, yeah, the vdso needs fixing; whoops. Lucky for my series, I only need
> ld-option! ;)
>

I didn't cc everyone here on that thread, but here's the series I sent
for it: https://lore.kernel.org/lkml/20200901222523.1941988-1-ndesaulniers@google.com/T/#u
.
-- 
Thanks,
~Nick Desaulniers
