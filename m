Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4675730DC0E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBCN7R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Feb 2021 08:59:17 -0500
Received: from foss.arm.com ([217.140.110.172]:40636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231869AbhBCN7Q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Feb 2021 08:59:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8148F13D5;
        Wed,  3 Feb 2021 05:58:29 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A40443F73B;
        Wed,  3 Feb 2021 05:58:25 -0800 (PST)
Date:   Wed, 3 Feb 2021 13:58:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>, swine@google.com,
        yonghyun@google.com
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210203135822.GN55896@C02TD0UTHF1T.local>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
 <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
 <20210203001414.idjrcrki7wmhndre@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203001414.idjrcrki7wmhndre@treble>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 02, 2021 at 06:14:14PM -0600, Josh Poimboeuf wrote:
> On Tue, Feb 02, 2021 at 03:01:22PM -0800, Nick Desaulniers wrote:
> > > >> Thus far we've been able to successfully reverse engineer it on x86,
> > > >> though it hasn't been easy.
> > > >>
> > > >> There were some particulars for arm64 which made doing so impossible.
> > > >> (I don't remember the details.)
> > >
> > > The main issue is that the tables for arm64 have more indirection than x86.
> > 
> > I wonder if PAC or BTI also make this slightly more complex?  PAC at
> > least has implications for unwinders, IIUC.
> 
> What is PAC/BTI?

PAC is "Pointer Authentication Codes". The gist is that we munge some
bits in pointers when they get stored in memory (called "signing"), and
undo that with a check (called "authentication") when reading from
memory, in order to detect unexpected modification. There's some new
instructions that may exist in function prologues and epilogues, etc.

There's a basic introduction at:

https://events.static.linuxfound.org/sites/events/files/slides/slides_23.pdf
https://www.kernel.org/doc/html/latest/arm64/pointer-authentication.html

Return address signing/authentication uses the SP as an input, so
without knowing the SP something was signed against it's not possible to
alter it reliably (or to check it). The arm64 unwinder ignores the PAC
bits, and ftrace uses patchable-function-entry so that we don't have to
do anything special to manipulate the return address.

Today the ABI used by the kernel doesn't mess with the pointers used in
jump tables, but that may come in future as toolchain folk are working
to define an ABI that might.

BTI is "Branch Target Identification", which is a bit like CET's
indirect branch tracking -- indirect branches need to land on a specific
instruction, or they'll raise an exception.

Thanks,
Mark.
