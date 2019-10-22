Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE28E0ADD
	for <lists+linux-efi@lfdr.de>; Tue, 22 Oct 2019 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfJVRnE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 13:43:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34624 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfJVRnE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Oct 2019 13:43:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id 83so14971941oii.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Oct 2019 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHo+bPZ3FyZTrXrvFae5gOHqYffPj0NYcnQ23J1Mtd8=;
        b=D8bfP3dYb9Xw3Ejz/XW6sJaiJoIzrU0if9m7dseFDXz0GuoQXFZZBSTgbjJU0sjON7
         CTsIv3bjWf2AvHSPeKOaRXcyEjBAx+URak3jnpv4lulJ/EVuiqqWnNdoWoe554TF/cJ0
         FU8/9VTLt4e6HnKwcSlzNGR54imzjgAORjvN05VsZdT3aFYiGR+7MO+6zvojPCzmaXQe
         rqmerCdhyIjHFH+noVK7tj/FkhNO4aAZ0Up4wIhGTOOBiYn85Qd1A+J2olHu9J0wWQTq
         mFpeecULEnrKhZxONseYGkjQ356U0Iwm1ionhs0PmWk/gwCIyyzyxv1w+qkcqY7dnMsh
         p2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHo+bPZ3FyZTrXrvFae5gOHqYffPj0NYcnQ23J1Mtd8=;
        b=UYt1z3nduUcaN5L768/wZVrsprdWZVyryWMSvMzULgbnU3+WJXs0fuycU7B6bGFwpk
         I+/7QxHJTpRbcE9B7SV7YubgoCUrRmg4TO9PpDm21askEq+zWc9M7LZ0PtVtbb7hFLPB
         QULzdiRwS4ttuPuUjCsPxOx99tR8vRlA4raErohc6Kxg6vAm+tJCY1lzfPsqH0dajX64
         YdTV8QQW1oHAGiYUtkDe+OyoDSOMGoLUxtB+bBDyvY7xR2AX3mowfKssSRA+pyJi68wx
         Xhu7ueR75zvQIqo8u3RZgGFLsW+yzupVpZwSfGefq9ppKK+3WZVtF+fGAS+2TWDevvFv
         wcRA==
X-Gm-Message-State: APjAAAUKXBUiD4wbTVSs1vJXsSE9f70K1qSWt0qucjUmpbwt+e0V/MJk
        jzFcA/kE64nFHMxmp48xTZ4Y4PEcPE+ixqebaT6h+Q==
X-Google-Smtp-Source: APXvYqxfVwLHQu/nljm2npVYMv0/xxXLHw8hKdDqlhGb7PXQz9eRPAcgKMk0ub1hWAYFfjq7ip3as3hOP5jSlLN4VGw=
X-Received: by 2002:aca:f492:: with SMTP id s140mr4056153oih.83.1571766180963;
 Tue, 22 Oct 2019 10:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-2-elver@google.com>
 <20191022154858.GA13700@redhat.com>
In-Reply-To: <20191022154858.GA13700@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Oct 2019 19:42:48 +0200
Message-ID: <CANpmjNPUT2B3rWaa=5Ee2Xs3HHDaUiBGpG09Q4h9Gemhsp9KFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Oleg Nesterov <oleg@redhat.com>
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
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

On Tue, 22 Oct 2019 at 17:49, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/17, Marco Elver wrote:
> >
> > +     /*
> > +      * Delay this thread, to increase probability of observing a racy
> > +      * conflicting access.
> > +      */
> > +     udelay(get_delay());
> > +
> > +     /*
> > +      * Re-read value, and check if it is as expected; if not, we infer a
> > +      * racy access.
> > +      */
> > +     switch (size) {
> > +     case 1:
> > +             is_expected = expect_value._1 == READ_ONCE(*(const u8 *)ptr);
> > +             break;
> > +     case 2:
> > +             is_expected = expect_value._2 == READ_ONCE(*(const u16 *)ptr);
> > +             break;
> > +     case 4:
> > +             is_expected = expect_value._4 == READ_ONCE(*(const u32 *)ptr);
> > +             break;
> > +     case 8:
> > +             is_expected = expect_value._8 == READ_ONCE(*(const u64 *)ptr);
> > +             break;
> > +     default:
> > +             break; /* ignore; we do not diff the values */
> > +     }
> > +
> > +     /* Check if this access raced with another. */
> > +     if (!remove_watchpoint(watchpoint)) {
> > +             /*
> > +              * No need to increment 'race' counter, as the racing thread
> > +              * already did.
> > +              */
> > +             kcsan_report(ptr, size, is_write, smp_processor_id(),
> > +                          kcsan_report_race_setup);
> > +     } else if (!is_expected) {
> > +             /* Inferring a race, since the value should not have changed. */
> > +             kcsan_counter_inc(kcsan_counter_races_unknown_origin);
> > +#ifdef CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> > +             kcsan_report(ptr, size, is_write, smp_processor_id(),
> > +                          kcsan_report_race_unknown_origin);
> > +#endif
> > +     }
>
> Not sure I understand this code...
>
> Just for example. Suppose that task->state = TASK_UNINTERRUPTIBLE, this task
> does __set_current_state(TASK_RUNNING), another CPU does wake_up_process(task)
> which does the same UNINTERRUPTIBLE -> RUNNING transition.
>
> Looks like, this is the "data race" according to kcsan?

Yes, they are "data races". They are probably not "race conditions" though.

This is a fair distinction to make, and we never claimed to find "race
conditions" only -- race conditions are logic bugs that result in bad
state due to unexpected interleaving of threads. Data races are more
subtle, and become relevant at the programming language level.

In Documentation we summarize: "Informally, two operations conflict if
they access the same memory location, and at least one of them is a
write operation. In an execution, two memory operations from different
threads form a data-race if they conflict, at least one of them is a
*plain* access (non-atomic), and they are unordered in the
"happens-before" order according to the LKMM."

KCSAN's goal is to find *data races* according to the LKMM.  Some data
races are race conditions (usually the more interesting bugs) -- but
not *all* data races are race conditions. Those are what are usually
referred to as "benign", but they can still become bugs on the wrong
arch/compiler combination. Hence, the need to annotate these accesses
with READ_ONCE, WRITE_ONCE or use atomic_t:
- https://lwn.net/Articles/793253/
- https://lwn.net/Articles/799218/

> Hmm. even the "if (!(p->state & state))" check in try_to_wake_up() can trigger
> kcsan_report() ?

We blacklisted sched (KCSAN_SANITIZE := n   in kernel/sched/Makefile),
so these data races won't actually be reported.

Thanks,
-- Marco

> Oleg.
>
