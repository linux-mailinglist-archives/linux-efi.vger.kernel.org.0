Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200E5958F9
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiHPKvH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiHPKug (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 06:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A00CE447
        for <linux-efi@vger.kernel.org>; Tue, 16 Aug 2022 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HgqeyUTXX3FZUQq2VGK36jBd/82HyyTY7s6+z4I2q0s=; b=NRxyDrqIqNfF1K7tBGJTQHp9pr
        IHLuusmG1Kdn26lQJz4uYd8Ymg223U46g5mTSWX72exbubX0y4zZrthCJKZpTr0J+0BPFQJrKPFtM
        eALM4ns//Ta3b/ypoy+FpTSFGr8zNQvHZMWq7kjdN/r96FMBN9SerQsI55gXLYpVmc62UhtJqJXCQ
        sSO9neTyb4Iho+xHyOEHpeZlxxUFI0w8WURO/2F/jJ1ulc5MF6LAa+j7ggRI5ztk1/9x/7sAc5BnT
        IincukPCw/127fEm7AXe46FYJ/dUwtHxqylf3W0QYLhtnynEdtqWU5+pPA4fnvf4XiDGvJwVkrGfx
        3qn02Qow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNtda-006occ-7p; Tue, 16 Aug 2022 10:17:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58559980083; Tue, 16 Aug 2022 12:17:29 +0200 (CEST)
Date:   Tue, 16 Aug 2022 12:17:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/x86-mixed: move unmitigated RET into .rodata
Message-ID: <Yvtuufkkzr3G6cIp@worktop.programming.kicks-ass.net>
References: <20220815132028.732531-1-ardb@kernel.org>
 <YvqiiKBPockZbRqG@zn.tnic>
 <CAMj1kXE47YJhApf0Xkj9JdDL1cTGrCcWCuCSqJVVQ3MTi4u1dw@mail.gmail.com>
 <YvqqGD0IrqutH20a@zn.tnic>
 <CAMj1kXHUyAZQqLbT8uqKJTb9QHq1A4ZUbVnx+J0yQfZihJGjbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHUyAZQqLbT8uqKJTb9QHq1A4ZUbVnx+J0yQfZihJGjbg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 16, 2022 at 09:04:56AM +0200, Ard Biesheuvel wrote:
> (cc Peter and Josh)
> 
> On Mon, 15 Aug 2022 at 22:18, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Aug 15, 2022 at 09:57:50PM +0200, Ard Biesheuvel wrote:
> > > I'm not seeing that warning. Any config in particular beyond
> > > x86_64_defconfig that you have enabled?
> >
> > It is my workstation's tailored config. Attached.
> >
> > > I'm using Debian GCC 12.1.0 btw
> >
> > gcc (Debian 11.2.0-19) 11.2.0
> >
> 
> Complete thread here:
> https://lore.kernel.org/all/20220815132028.732531-1-ardb@kernel.org/
> 
> On Mon, 15 Aug 2022 at 22:18, Borislav Petkov <bp@alien8.de> wrote:
> >
> > For some reason, objtool is not happy here:
> > vmlinux.o: warning: objtool: efi_thunk_query_variable_info_nonblocking+0x1ba: unreachable instruction
> 
> [which is the instruction right after the call to __efi_thunk64()]
> 
> However, with the same config but without the patch (i.e., v6.0-rc1
> with nothing on top), I see:
> 
> vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
> 
> It appears that objtool is making inferences about whether or not
> __efi_thunk64() returns, even though it is marked as
> STACK_FRAME_NON_STANDARD. And note that I am not seeing any of these
> with x86_64_defconfig, only with Boris's config (attached)

STACK_FRAME_NON_STANDARD has no bearing on a call to that symbol being
noreturn or not.

noreturn is a bit of a pain point in that the compiler leaves no clue
in the object file. Objtool has a bunch of heuristics to guess at
noreturn, but the only surefire way to make things consistent is to
annotate the function with __noreturn and add it to the
global_noreturns[] array in tools/objtool/check.c

Alternatively, if objtool guesses wrong, you can annotate the assembler
with 'REACHABLE'.

Josh; should we create a config file for objtool to contain many of this
stuff? Then again, parsing a config file over and over and over again
isn't going to make it faster :/
