Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B36102EAF
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 22:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKSVyG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 16:54:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44442 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfKSVyB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Nov 2019 16:54:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id c19so19320531otr.11
        for <linux-efi@vger.kernel.org>; Tue, 19 Nov 2019 13:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwQvEr0/UaVV1k90qxcSpFl3vFq94C3DTr9L5ipVOwI=;
        b=os/9/wpFP/DXclPEjwrDUzXZ9xZyYOLNYumwPQAx6DyFBIR7SoxEqKwNn+/IZhR//X
         OQOeRncPuE1vhO2moGvPoo7z6/z3zTRs91p3NkWjOK3lktd5iMvMjjFDe19mGrjssLPS
         zmmzHsKAaRO/a/uzddjHH/kpp2a3Rz2HX47MN7hGP8BL5NJEV0SKqDceVCAlwP4KAUz3
         brpZdGqYvdc1o2yKVBKQgsX5jRGCrki9za3mxu8k5xR82ifHBeu43F7TGh7R70va38Ns
         vrNtgb7acdZidnXSx39yPOh3nrgilOQsv6q8diSKlHIdchPOifk+39wxRB9wr4KJgIql
         CzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwQvEr0/UaVV1k90qxcSpFl3vFq94C3DTr9L5ipVOwI=;
        b=oLxQvJGxCCsPdE9Cp9Wx7RbPt5009PS/GzjMqd6NUuD+GwNfNzkNC4KZanXYeVH42K
         8N+gUv84G/pQUBrstD++RU4Z3+DNEle2etSz2FUltjsvLOXRWaQAW9Ek+kFJizEinKQc
         zCFSZh+b/nuco148WZQGXNqbyJupRX+J3OiabFucwcbvS6s9MZkzt1O5S7S6ytERWUON
         qi+wqJxYLcqkI0Q1QxNqJRQZClEg0Hul5BS4CSADVx7dkk6Iia3q3a7OvfMjUC6kHmQ5
         k0euOEde+YaRmtd9zYajSXHbfgYQMcvLc3z2l7ZI/ZUNV+8gsptWiYkq4Mlv5N+4W7qo
         PRyA==
X-Gm-Message-State: APjAAAXh0RLVzJEgEJLH2cJpslsSGyfD1N5fds0gYl804O0IR7MtXsuE
        GBYD58+N5v9U3s4wLVU8zz4kKnRFVGYo3L5QYEFlog==
X-Google-Smtp-Source: APXvYqz2fsoAggh7I5N4oqb965IJ4kPem0JLzhQ1wxS9dVs2sFp6YDXQH7OhcFkNUVDUWie4TDvvMj1XJov8Z8A+PIE=
X-Received: by 2002:a9d:82e:: with SMTP id 43mr5680239oty.23.1574200440363;
 Tue, 19 Nov 2019 13:54:00 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNPiKg++=QHUjD87dqiBU1pHHfZmGLAh1gOZ+4JKAQ4SAQ@mail.gmail.com>
 <A74F8151-F5E8-4532-BB67-6CFA32487D26@lca.pw>
In-Reply-To: <A74F8151-F5E8-4532-BB67-6CFA32487D26@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Nov 2019 22:53:48 +0100
Message-ID: <CANpmjNOJdWi6i+2Nn70UQDvF0a0pQTVVye7CTTJgqOHa3UmHMQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Qian Cai <cai@lca.pw>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Nov 2019 at 22:42, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Nov 19, 2019, at 2:54 PM, Marco Elver <elver@google.com> wrote:
> >
> > Regardless of approach, my guess is that the complexity outweighs any
> > benefits this may provide in the end. Not only would a hypothetical
> > kernel that combines these be extremely slow, it'd also diminish the
> > practical value because testing and finding bugs would also be
> > impaired due to performance.
>
> On the other hand, it is valuable for distros to be able to select both for the debug kernel variant. Performance is usually not a major concern over there and could be migrated by other means like selecting powerful systems etc.

Fair enough. However, right now none of gcc nor clang would support
this. It is something to revisit in future, but is certainly not
something that can trivially be resolved.

Thanks,
-- Marco
