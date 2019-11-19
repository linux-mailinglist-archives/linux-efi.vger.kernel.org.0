Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B35102D0C
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 20:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKSTy1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 14:54:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41303 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKSTy1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Nov 2019 14:54:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so19017541oty.8
        for <linux-efi@vger.kernel.org>; Tue, 19 Nov 2019 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EhLUhFf+dWrZRS+as37pEKZIEswUZkBGb2xI++P3+j8=;
        b=oURkgRgGWUkSxDSZ1GZcf9JKZThTVFiPnKTPYV6+NAQo4qwintbC2XWKkuqirZuVFU
         bTYZKRscOUCeu16ZKaeZ3gXmUectwJqraAkzc8IBVgzlI8PbblowyxH6P3Ln12UZk9iO
         Pl0kfXxMBXKjXj6d8JggILhmHIA8f4ZCcFz6nGlkz7lVmiWjRLK+0aGRrkffeyuCuNkI
         0zslGM9F/hSRR4n8JF2dvLzZiZ64O/OcPnSgVvg+FuFKwOq/W9YtVItB909hWO3GwyqT
         +0ZUwJKbggzqgLthIVoIszbE1Prv8ek/hgwno+wjPrrY7IKe9Gu3nZy0IvutjK5EGayQ
         o9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EhLUhFf+dWrZRS+as37pEKZIEswUZkBGb2xI++P3+j8=;
        b=o+1iiXiaG7p/MdRiHXprLhXQutQWa1o1VFrV4bzF0n6/aDgHLilAlvqwh1J5hxteLI
         A6ELnZhJ9dp9VI3Z305aIq062CPWdQXy/8yXR6PNpboMBIq7ZppO/ykbdcnz/Sy5qF4Y
         LOHuTbNCz3IVawo0zAk+waz3lVVBiaRULQotiqYBRtDQFi5qQeRJm+vMLZ1bugiC6Wte
         quS8vOUk4yJ0+mOiMpkQOYZ0feQE3ivprsjh7rcASOXjLxs7AURRHA5XVnU9kykIZqx7
         9ede5KQREeOcyQ7AQfEr3St+5KI08s3usua8A8sDKOodhJX1w2pDKM/FBteER/+3c7Vz
         1cIQ==
X-Gm-Message-State: APjAAAXi1M05KJr1YMSi15t5yoeZTv9eHl2rN36HtRmSLL9eZlnj0kAu
        GA49a4xftGRVxpwy1XOYVxsI8YKD9TQRQrhW6cy5FQ==
X-Google-Smtp-Source: APXvYqyGgnRzC/YRie64niefMvgawW6RK21yPqM0zialvJFEd4a6Z7iuhn/AjgaPZsvq+/fqUfeR5iVlCDr+6w9vWVk=
X-Received: by 2002:a05:6830:2308:: with SMTP id u8mr5018538ote.2.1574193265740;
 Tue, 19 Nov 2019 11:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20191114180303.66955-1-elver@google.com> <20191114180303.66955-2-elver@google.com>
 <1574191653.9585.6.camel@lca.pw>
In-Reply-To: <1574191653.9585.6.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Nov 2019 20:54:14 +0100
Message-ID: <CANpmjNPiKg++=QHUjD87dqiBU1pHHfZmGLAh1gOZ+4JKAQ4SAQ@mail.gmail.com>
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
        Mark Rutland <mark.rutland@arm.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Nov 2019 at 20:27, Qian Cai <cai@lca.pw> wrote:
>
> On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
>
> > +menuconfig KCSAN
> > +     bool "KCSAN: watchpoint-based dynamic data race detector"
> > +     depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
>
> "!KASAN" makes me sorrow. What's problem of those two?

Both of them instrument memory accesses, and gcc doesn't let us
combine '-fsanitize=3D{kernel-,}address' and '-fsanitize=3Dthread'.

> cc1: error: =E2=80=98-fsanitize=3Daddress=E2=80=99 and =E2=80=98-fsanitiz=
e=3Dkernel-address=E2=80=99 are incompatible with =E2=80=98-fsanitize=3Dthr=
ead=E2=80=99

In principle, it may be possible:
- either by updating the compiler, which we want to avoid because we'd
have to convince gcc and clang to do this; I can see this being
infeasible because the compiler needs to become aware (somehow
propagate in the IR) of what is ASAN inline-instrumentation and what
is TSAN instrumentation and not emit recursive instrumentation.
- or somehow merging the instrumentation, but, IMHO this is probably a
really bad idea for various other reasons (complexity, performance,
stability, etc.).

Regardless of approach, my guess is that the complexity outweighs any
benefits this may provide in the end. Not only would a hypothetical
kernel that combines these be extremely slow, it'd also diminish the
practical value because testing and finding bugs would also be
impaired due to performance.

Thanks,
-- Marco
