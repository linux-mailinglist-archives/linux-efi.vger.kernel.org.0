Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184357F423
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiGXIkL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Jul 2022 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiGXIkI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Jul 2022 04:40:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990916594
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 01:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C13A7B80D41
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 08:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF69C341C0
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658651997;
        bh=LXYFyUabShc07PXuBpZPdk8JApRZHUVPUhJVN+xqga4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o89efcGoXCpAzAFSEJ8ImZFA1hwwmirTQwJLyK5FeS9rcX/8BUvXTJ2Wl1zizRz2q
         DzSI7Yy6izvvyrgE6JVQTLLle3s0N8GgcyMtdEpyGgeCdVGK9m0EN7BYi9tBPN1MQx
         BEhUmAceXUPZ8iXz60oFLg1/uihJ+vAjU+jMuEY6FJPV8OgWZMv4qYRBlpS+PieSlk
         JuJjK+4qBuPOY26ephEvYotojJbtLxg/hp5N5Dlv6aHsv7VcdTDQcBAk3VlIjbt8m/
         DiBY3WLRZPQE8+0R/Y7BDcyHee7axyK1zMGKd9p4hyzdyvHz5P9bIGeudybuo1fatI
         DFRCmFDna++9Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10d8880d055so11266401fac.8
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 01:39:57 -0700 (PDT)
X-Gm-Message-State: AJIora/5mfOOtm6MmoYy9aVJIm+EFZfEnuXpMbsaVirp1kexULUjXCZs
        FQEobweAUz+m3r8BiQrgv6MdZSVYjZoRhDUOXXQ=
X-Google-Smtp-Source: AGRyM1sS61+ZHvcKxpRGwjEMz5Dt713CSVgtyewNTbklA2cS9dzU7TfJp8zUPMSnrR90RppMa0wXz1SIVQio9pMYpLQ=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr3684787oab.126.1658651996488; Sun, 24
 Jul 2022 01:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220722160612.2976-1-ardb@kernel.org> <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
In-Reply-To: <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 24 Jul 2022 10:39:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGT7OEZc3Y6B-AcWWmec2POZFYb+UpE1eMcHuVag9LSew@mail.gmail.com>
Message-ID: <CAMj1kXGT7OEZc3Y6B-AcWWmec2POZFYb+UpE1eMcHuVag9LSew@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-mixed: leave RET unmitigated but move it into .rodata
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
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

On Sat, 23 Jul 2022 at 19:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 22, 2022 at 9:06 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Thadeu reports that the retbleed mitigations have broken EFI runtime
> > services in mixed mode, as the RET macro now expands to a relative
> > branch that jumps to nowhere when executed from the 1:1 mapping of the
> > kernel text that the EFI mixed mode thunk uses on its return back to the
> > caller.
> >
> > So as Thadeu suggested in [1], we should switch to a bare 'ret' opcode
> > followed by 'int3' (to limit straight line speculation). However, doing
> > so leaves an unmitigated RET in the kernel text that is always present,
> > even on non-EFI or non-mixed mode systems (which are quite rare these
> > days to begin with)
> >
> > So let's take Thadeu's fix a bit further [..]
>
> Note that Thadeu's patch already made it into my kernel as commit
> 51a6fa0732d6 ("efi/x86: use naked RET on mixed mode call wrapper"), so
> that "take the fix further" should probably be done incrementally.
>
> I'm going to ignore this for 5.19, because I'm not sure how big of a
> problem that "unmitigated ret" is. Honestly, it's probably easy enough
> to find byte 0xc3 as part of other instructions and constants in the
> kernel data section anyway, so I wouldn't worry too much about "hey,
> we have a 'ret' instruction here that people could mis-use".
>

Fair enough. I still think it is better for general hygiene to apply
these changes, but if there is no urgency, I'll leave this for now and
revisit+rebase somewhere during the next cycle.
