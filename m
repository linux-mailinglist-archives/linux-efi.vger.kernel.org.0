Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F28595935
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 13:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiHPLCg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 07:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiHPLCE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 07:02:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808FC7F8D
        for <linux-efi@vger.kernel.org>; Tue, 16 Aug 2022 03:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19AB6B816A0
        for <linux-efi@vger.kernel.org>; Tue, 16 Aug 2022 10:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE9DC433B5
        for <linux-efi@vger.kernel.org>; Tue, 16 Aug 2022 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660645751;
        bh=usNm44vt3MI5aoRXSkxuZ1kSH2WnbUzjWWyWiIAzG50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrUQ8IU7oSQ2XHed8woL5OF0jEfQLKEnKtW2ghj/TgBB0xW+JvQ908EYU6r/++mPj
         dEuni1/hYiXBh5UbSf/mO6on270TIip7voTaT1pSdgYS7IOqJM7InAypVQfH4pYrFp
         puAVEHoWRUDFoIf9/3YmCb+HIVk8vXpNUjC3DWH1UtA2K5ZUX091E4EdiIGZ3YE5Gr
         nL7Ri4SOx+/AYDvvT99eRzsGi0y1fkz1bNSrWNarXXoFIT8kFFzxeoPnFOlzu4oV79
         38RFT5sUAKmFjdTW24Z1Jvl8WEiiGzlNNTQipMhFjwxtib+xbtCkGCbd14OeL0T+Dg
         swxQfLo0+l1UA==
Received: by mail-wr1-f51.google.com with SMTP id bs25so12104535wrb.2
        for <linux-efi@vger.kernel.org>; Tue, 16 Aug 2022 03:29:11 -0700 (PDT)
X-Gm-Message-State: ACgBeo3d49S6k29AOZs3FgimoLHSKeoBTt9Q7WtlT0LVjr1vCHitjxqD
        DiOT2IZ2SKde+qMX6h6Jaoo+m4sUWZRoBeAWbMk=
X-Google-Smtp-Source: AA6agR4/XBYhsrsQMZPvaOr3QOAPJnDRlhIYm4x5SmZuY3nyEofkbDCUAFiQsBVnx1Iaxm/Lh4MraV1qAdY+sJu7/DU=
X-Received: by 2002:adf:f40c:0:b0:225:d09:246d with SMTP id
 g12-20020adff40c000000b002250d09246dmr3834230wro.561.1660645749975; Tue, 16
 Aug 2022 03:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220815132028.732531-1-ardb@kernel.org> <YvqiiKBPockZbRqG@zn.tnic>
 <CAMj1kXE47YJhApf0Xkj9JdDL1cTGrCcWCuCSqJVVQ3MTi4u1dw@mail.gmail.com>
 <YvqqGD0IrqutH20a@zn.tnic> <CAMj1kXHUyAZQqLbT8uqKJTb9QHq1A4ZUbVnx+J0yQfZihJGjbg@mail.gmail.com>
 <Yvtuufkkzr3G6cIp@worktop.programming.kicks-ass.net>
In-Reply-To: <Yvtuufkkzr3G6cIp@worktop.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Aug 2022 12:28:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH42TepoWZvvNfC6goSALeBvyZpXtOcTaXyUiAx_0EcJQ@mail.gmail.com>
Message-ID: <CAMj1kXH42TepoWZvvNfC6goSALeBvyZpXtOcTaXyUiAx_0EcJQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-mixed: move unmitigated RET into .rodata
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Aug 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 16, 2022 at 09:04:56AM +0200, Ard Biesheuvel wrote:
> > (cc Peter and Josh)
> >
> > On Mon, 15 Aug 2022 at 22:18, Borislav Petkov <bp@alien8.de> wrote:
...
> > > For some reason, objtool is not happy here:
> > > vmlinux.o: warning: objtool: efi_thunk_query_variable_info_nonblocking+0x1ba: unreachable instruction
> >
> > [which is the instruction right after the call to __efi_thunk64()]
> >
> > However, with the same config but without the patch (i.e., v6.0-rc1
> > with nothing on top), I see:
> >
> > vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
> >
> > It appears that objtool is making inferences about whether or not
> > __efi_thunk64() returns, even though it is marked as
> > STACK_FRAME_NON_STANDARD. And note that I am not seeing any of these
> > with x86_64_defconfig, only with Boris's config (attached)
>
> STACK_FRAME_NON_STANDARD has no bearing on a call to that symbol being
> noreturn or not.
>
> noreturn is a bit of a pain point in that the compiler leaves no clue
> in the object file. Objtool has a bunch of heuristics to guess at
> noreturn, but the only surefire way to make things consistent is to
> annotate the function with __noreturn and add it to the
> global_noreturns[] array in tools/objtool/check.c
>
> Alternatively, if objtool guesses wrong, you can annotate the assembler
> with 'REACHABLE'.
>

So the problem here is that the function is *not* __noreturn, and
objtool thinks it is, resulting in the instruction after the call to
be misidentified as unreachable.
The function is called from C code, so we cannot easily annotate the
instruction after the call as REACHABLE.

I've patched it up by adding a dummy, unreachable RET into
__efi64_thunk(), which seems to make objtool happy for now.
