Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180F3080F2
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jan 2021 23:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhA1WLg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jan 2021 17:11:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34908 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhA1WLe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jan 2021 17:11:34 -0500
Received: from [192.168.254.32] (unknown [47.187.219.45])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7F77920B7192;
        Thu, 28 Jan 2021 14:10:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F77920B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611871853;
        bh=ZA2oSM80w+RdJ/gENbHPlEraVHFQ5GUGuDOI84otWqQ=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=b1XGVIJ11p8YrFEjhTOOsWPkgVJ1pwfcR9jZ+MllQtZMHIWyYefW7DKgPJatPai+7
         Dz7hbE72mu7+23aHXEWklEXI7+cnEwZ1vcsBxJ9nq7MlZTar2idPNvNO9c86/AYmH4
         78ogAZo3+o5tEXQX2VNOWZoF16HDXD/bYTvewRCs=
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org, live-patching@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
 <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
 <20210121185452.fxoz4ehqfv75bdzq@treble>
 <20210122174342.GG6391@sirena.org.uk>
 <CAMj1kXF31FxCTbo4M8MX0aaegaq7AQXMUdCtsm6xrKUFSpkzjA@mail.gmail.com>
Message-ID: <c8f0cfec-b23e-dc84-0c43-feb9d892ea26@linux.microsoft.com>
Date:   Thu, 28 Jan 2021 16:10:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXF31FxCTbo4M8MX0aaegaq7AQXMUdCtsm6xrKUFSpkzjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

I sent this suggestion to linux-arm-kernel in response to the Reliable Stacktrace RFC from Mark Brown
and Mark Rutland. I am repeating it here for two reasons:

- It involves objtool.

- There are many more recipients in this thread that may be interested in this topic.

Please let me know if this suggestion is acceptable. If it is not, please let me know why.
Thanks.

Also, I apologize to all of you who have received this more than once.

FP and no-FP functions
=====================

I have a suggestion for objtool and the unwinder for ARM64.

IIUC, objtool is responsible for walking all the code paths (except unreachable
and ignored ones) and making sure that every function has proper frame pointer
code (prolog, epilog, etc). If a function is found to not have it, the kernel
build is failed. Is this understanding correct?

If so, can we take a different approach for ARM64?

Instead of failing the kernel build, can we just mark the functions as:

	FP	Functions that have proper FP code
	no-FP	Functions that don't

May be, we can add an "FP" flag in the symbol table entry for this.

Then, the unwinder can check the functions it encounters in the stack trace and
inform the caller if it found any no-FP functions. The caller of the unwinder can
decide what he wants to do with that information.

	- the caller can ignore it

	- the caller can print the stack trace with a warning that no-FP functions
	  were found

	- if the caller is livepatch, the caller can retry until the no-FP functions
	  disappear from the stack trace. This way, we can have live patching even
	  when some of the functions in the kernel are no-FP.

Does this make any sense? Is this acceptable? What are the pitfalls?

If we can do this, the unwinder could detect cases such as:

- If gcc thinks that a function is a leaf function but the function contains
  inline assembly code that calls another function.

- If a call to a function bounces through some intermediate code such as a
  trampoline.

- etc.

For specific no-FP functions, the unwinder might be able to deduce the original
caller. In these cases, the stack trace would still be reliable. For all the others,
the stack trace would be considered unreliable.

Compiler instead of objtool
===========================

If the above suggestion is acceptable, I have another suggestion.

It is a lot of work for every new architecture to add frame pointer verification
support in objtool. Can we get some help from the compiler?

The compiler knows which C functions it generates the FP prolog and epilog for. It can
mark those functions as FP. As for assembly functions, kernel developers could manually
annotate functions that have proper FP code. The compiler/assembler would mark them
as FP. Only a small subset of assembly functions would even have FP prolog and epilog.

Is this acceptable? What are the pitfalls?

This can be implemented easily for all architectures for which the compiler generates
FP code.

Can this be implemented using a GCC plugin? I know squat about GCC plugins.

Thanks!

Madhavan
