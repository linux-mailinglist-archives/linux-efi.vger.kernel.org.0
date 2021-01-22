Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF6300F1F
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jan 2021 22:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbhAVVph (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jan 2021 16:45:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43716 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbhAVVpR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Jan 2021 16:45:17 -0500
Received: from [192.168.254.32] (unknown [47.187.219.45])
        by linux.microsoft.com (Postfix) with ESMTPSA id DBC8A20B7192;
        Fri, 22 Jan 2021 13:44:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBC8A20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611351876;
        bh=geh+hCTtjutzehHxzhcv4bTi/qNORksnmBQi0+Nv/1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jBujqEnpeGP8xwMuai3OpICq6dba6Y6FnMrQX0k/3qGa1kEu9oXnQw7zaZA+Q7OYi
         ONuz424856s5wNjf/3HgofM7gmBvyCAdU5uQ8jCtiSX/2EOTopOT68MKYePxgWNrpp
         xkmbNj55Bn0rG95YgVF4+/0sUgWLxANIlK995gus=
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Julien Thierry <jthierry@redhat.com>,
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
 <bebccb15-1195-c004-923e-74d8444250e1@linux.microsoft.com>
 <CAMj1kXFr0wvx-hG6nBY4ibju9ww4x0CGhQber3MZQ2ZZn9LHWw@mail.gmail.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <c52dd4e2-2a9e-fdcd-1cca-4d6b237993b4@linux.microsoft.com>
Date:   Fri, 22 Jan 2021 15:44:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFr0wvx-hG6nBY4ibju9ww4x0CGhQber3MZQ2ZZn9LHWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/22/21 3:43 PM, Ard Biesheuvel wrote:
> On Fri, 22 Jan 2021 at 22:15, Madhavan T. Venkataraman
> <madvenka@linux.microsoft.com> wrote:
>>
>>
>>
>> On 1/22/21 11:43 AM, Mark Brown wrote:
>>> On Thu, Jan 21, 2021 at 12:54:52PM -0600, Josh Poimboeuf wrote:
>>>
>>>> 2) The shadow stack idea sounds promising -- how hard would it be to
>>>>    make a prototype reliable unwinder?
>>>
>>> In theory it doesn't look too hard and I can't see a particular reason
>>> not to try doing this - there's going to be edge cases but hopefully for
>>> reliable stack trace they're all in areas where we would be happy to
>>> just decide the stack isn't reliable anyway, things like nesting which
>>> allocates separate shadow stacks for each nested level for example.
>>> I'll take a look.
>>>
>>
>> I am a new comer to this discussion and I am learning. Just have some
>> questions. Pardon me if they are obvious or if they have already been
>> asked and answered.
>>
>> Doesn't Clang already have support for a shadow stack implementation for ARM64?
>> We could take a look at how Clang does it.
>>
>> Will there not be a significant performance hit? May be, some of it can be
>> mitigated by using a parallel shadow stack rather than a compact one.
>>
>> Are there any longjmp style situations in the kernel where the stack is
>> unwound by several frames? In these cases, the shadow stack must be unwound
>> accordingly.
>>
> 
> Hello Madhavan,
> 
> Let's discuss the details of shadow call stacks on a separate thread,
> instead of further hijacking Julien's series.
> 

OK. Sounds good.
