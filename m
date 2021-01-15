Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5CD2F85CA
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 20:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbhAOTzT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 14:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbhAOTzR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Jan 2021 14:55:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9504235F8;
        Fri, 15 Jan 2021 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610740477;
        bh=3P6UzwvfBE7I8FHg+VBGNcbWcvpdD9Wa7p1LGDVMHzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=og1RkAf/ZcgBndINyfwmX4RYO3dOBLwN6SlYxgJiU4oMjg0HBBGUJoMLyIeU0CgYI
         Cnsbu8mCZqrmuclUYI2ux3344/nhnWWLBgz0IaWPW9nATckk5GAPYlR7owO8GS0yYE
         EP14qQPGEiDmW/j/86ytD7xoJa8sZuthlSDJJRR3nwuyAhX/Qo443hargiPv2iuHJb
         BP1wDuqPL/qvN5l1k4YoE+rA4iQyorvMuRy1E0cCsD01euH4MJKL9oaNGlbb/cyawX
         8TTD4Y4N34jwHqydzHcejAaQeRBSq1e4HCHbDTU70B+jLaqli5kz6f8aX+cDD3b95o
         LDMH2HBjO5ziQ==
Received: by mail-ot1-f46.google.com with SMTP id d8so9705610otq.6;
        Fri, 15 Jan 2021 11:54:36 -0800 (PST)
X-Gm-Message-State: AOAM53002x0NM45XOpdxuPBCEaeYQCBu2zIE8bJCbsSPJMiG0SyXLP8a
        /u5S8jWhB7DtliW0pQ2dFitYbS4Xc2MrYLxmGMs=
X-Google-Smtp-Source: ABdhPJxQE2QUt8HCjVvyUcq6bQG9A+Jwffvpto1nf8XVkIzv0pvcaSdwa5eDX784wCKpffGC+37VqQhsxqGdle7ekeg=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr2326419otk.210.1610740476133;
 Fri, 15 Jan 2021 11:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20210107223424.4135538-1-arnd@kernel.org> <20210115182300.GD9138@zn.tnic>
 <20210115183203.GA1991122@ubuntu-m3-large-x86> <20210115190729.GE9138@zn.tnic>
 <YAHo3ZEMu+6mESZA@rani.riverdale.lan> <20210115191833.GF9138@zn.tnic>
In-Reply-To: <20210115191833.GF9138@zn.tnic>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 20:54:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a39vtF8GvRVQtEYssc+GvX-75j9-4pwXj4qhc7LK2RgNw@mail.gmail.com>
Message-ID: <CAK8P3a39vtF8GvRVQtEYssc+GvX-75j9-4pwXj4qhc7LK2RgNw@mail.gmail.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 8:18 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 15, 2021 at 02:11:25PM -0500, Arvind Sankar wrote:
> > That's how build-time assertions work: they are _supposed_ to be
> > optimized away completely when the assertion is true. If they're
> > _not_ optimized away, the build will fail.
>
> Yah, that I know, thanks.
>
> If gcc really inlines p4d_index() and does a lot more aggressive
> optimization to determine that the condition is false and thus optimize
> everything away (and clang doesn't), then that would explain the
> observation.

One difference is that gcc does not have
-fsanitize=unsigned-integer-overflow at all, and I don't see the
assertion without that on clang either, so it's possible that clang
behaves as designed here.

The description is:
    -fsanitize=unsigned-integer-overflow: Unsigned integer overflow, where
     the result of an unsigned integer computation cannot be represented in
     its type. Unlike signed integer overflow, this is not undefined behavior,
     but it is often unintentional. This sanitizer does not check for
lossy implicit
     conversions performed before such a computation (see
    -fsanitize=implicit-conversion).

The "-68 * ((1UL) << 30" computation does overflow an unsigned long
as intended, right? Maybe this is enough for the ubsan code in clang to
just disable some of the optimization steps that the assertion relies on.

        Arnd
