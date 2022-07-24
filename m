Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC22357F67B
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiGXSex (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Jul 2022 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGXSew (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Jul 2022 14:34:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D87DF9D
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 11:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B761CB80D91
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 18:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C076C341D1
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658687688;
        bh=0ExqYLfmzvNIMo77H0Ygs3fXJ8xGnk2AUhJ43MqYVd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/0l+YXDZRuZ7E9Dsa3sIV4R/TRPAeJjGKAhvicrnET+wC2EBBQs7bskUmzCim5Qp
         kX7TZaY8MHGhPYZ47Eo0Y7MSaG7Ob7THM9NQOk1pOpadvr+3CdfD85ZP0yCKDMFWVU
         T+DCaw58iL7hzMlKnGtrDgU2VuLenVkHTXgYAd3R1bzm7B/7LlkIezDHmOkkMcOGbI
         JJoJGF0f8JvcX92iituXnnA2N5IaL5Hod75jxsmZHCwxtVlsuMKNsAg6Barcz4ZRtD
         uGofrLzcOzGDLD3H+NAoJJlIxaWMZcPR4Gs4cvQMTtKfAZB9d7zXfKRS42EoBb3bXm
         MafpYMCn/toXQ==
Received: by mail-oi1-f173.google.com with SMTP id n206so11102447oia.6
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 11:34:48 -0700 (PDT)
X-Gm-Message-State: AJIora9US5aZ5laOZnW0HnO3yaT66QdDb5uythDHC4DmkfPMUm8hQM0A
        qlcAgcZvzmHEVal4CBMIpXComCy7E+XU77/0usc=
X-Google-Smtp-Source: AGRyM1vi3o2TWRi57w0yjxBFeZcowxLgNmKHouNEnHsOZzSd0tmSEqhvetg01K7HG4WI6JVnI+0yYi61kn2gYQsMz+8=
X-Received: by 2002:a05:6808:300b:b0:337:b697:b077 with SMTP id
 ay11-20020a056808300b00b00337b697b077mr4071712oib.126.1658687687497; Sun, 24
 Jul 2022 11:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220722160612.2976-1-ardb@kernel.org> <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
 <CAMj1kXGT7OEZc3Y6B-AcWWmec2POZFYb+UpE1eMcHuVag9LSew@mail.gmail.com> <Yt2BHIMhXPd0cuMt@zn.tnic>
In-Reply-To: <Yt2BHIMhXPd0cuMt@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 24 Jul 2022 20:34:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEM2tXxCqcjDDNSS_OHsnJ1XTDNWBGdfFc-4zKJKpkTXg@mail.gmail.com>
Message-ID: <CAMj1kXEM2tXxCqcjDDNSS_OHsnJ1XTDNWBGdfFc-4zKJKpkTXg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-mixed: leave RET unmitigated but move it into .rodata
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 24 Jul 2022 at 19:28, Borislav Petkov <bp@suse.de> wrote:
>
> On Sun, Jul 24, 2022 at 10:39:45AM +0200, Ard Biesheuvel wrote:
> > Fair enough. I still think it is better for general hygiene to apply
> > these changes, but if there is no urgency, I'll leave this for now and
> > revisit+rebase somewhere during the next cycle.
>
> Best it would be if you do that early in the cycle so that it gets
> maximum testing in linux-next.
>

Sure

> Oh, and my compiler doesn't like it for whatever reason:
>
> /tmp/ccLB2vIC.s: Assembler messages:
> /tmp/ccLB2vIC.s: Error: invalid operands (.rodata and .text sections) for `-' when setting `.L__sym_size___efi64_thunk'
> make[3]: *** [scripts/Makefile.build:322: arch/x86/platform/efi/efi_thunk_64.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
>

Are you sure you fixed up the conflict correctly? It seems the
__efi64_thunk end marker ends up in .rodata in your case.


> But otherwise, I like the direction where this is going, of us not
> mapping as much into the EFI PGT. But I've said that already...
>

Yes. I'll update the patch to unmap text and rodata entirely, and only
leave the trampoline mapped.
