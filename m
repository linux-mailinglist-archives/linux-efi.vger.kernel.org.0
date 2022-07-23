Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B395657F093
	for <lists+linux-efi@lfdr.de>; Sat, 23 Jul 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiGWRUz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 Jul 2022 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRUy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 Jul 2022 13:20:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED11DF0A
        for <linux-efi@vger.kernel.org>; Sat, 23 Jul 2022 10:20:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so13495566eju.10
        for <linux-efi@vger.kernel.org>; Sat, 23 Jul 2022 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FP2r3riK2yrQHvyc+4EvSeIKePUcQiFBu/tBh37fDYc=;
        b=INjAGhhZ5Ne45IPSO+C88rDvwYMwtPP0Ia+zZtTohrn447L2ljf5sGYFiJ5xC6gY1Q
         cPmpok+O1+v952dm3W2jT2/Ps+Z0XfSMWSOkbzvecw4NCBM3ZBUaQRUM82+UN+zXqqjf
         0L+NBen7VBfiKmCnIgf7AeMsqZQj8zO39qC/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FP2r3riK2yrQHvyc+4EvSeIKePUcQiFBu/tBh37fDYc=;
        b=Sag/CLje9NSMLmGEiXaJ+rlYGTweojH40HKhzussLdGCo5Olsg9mNM0ihvCKNpU8sc
         OYiv1MkoC+Nn8PJpKxe5uVL5ngEGPe5V46T/j9JSUmz7/czsZK8vmBUOaBgP4/0GevVL
         7pSjdm50of/6GVYagCiD4aVzaVD46Fkrk7fU+vtIKmSGQ2DiLg4zrqlnUetEIP0GkdYe
         /Syv+pCq//cW0CeaAuAjBN1X+fyVzDCP3e3kDAFfB8CU2vJaH+z4tD+W9SqmywkuJrpI
         hKCbgoh2ZV9/tGCufLY8m5w+aEzpJZB5hlC3fb23Z9BIIYvuQ3O3JvyunscQGHZEUJ68
         h80A==
X-Gm-Message-State: AJIora8VYOfgkR6gz+rOL1Qm8sF6wm3yfHrF5ZctG3pc9cNAXi/qonwh
        gdx9CdintTxS/wQ8BQXK0GdMIdO7sGD0LS2n
X-Google-Smtp-Source: AGRyM1toEg1cCqiFPoT6TkS8jcGbySjxkwzUzOnebMWmaokqlX3MipMYYGtSIxUHZ7pIb7PE/A3g3Q==
X-Received: by 2002:a17:906:cc5a:b0:72b:1459:6faa with SMTP id mm26-20020a170906cc5a00b0072b14596faamr4152611ejb.221.1658596851802;
        Sat, 23 Jul 2022 10:20:51 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090631d700b0072b55713daesm3272695ejf.56.2022.07.23.10.20.50
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 10:20:50 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so4060121wmm.4
        for <linux-efi@vger.kernel.org>; Sat, 23 Jul 2022 10:20:50 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr3446939wmf.38.1658596849955; Sat, 23 Jul
 2022 10:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220722160612.2976-1-ardb@kernel.org>
In-Reply-To: <20220722160612.2976-1-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Jul 2022 10:20:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
Message-ID: <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-mixed: leave RET unmitigated but move it into .rodata
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 22, 2022 at 9:06 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Thadeu reports that the retbleed mitigations have broken EFI runtime
> services in mixed mode, as the RET macro now expands to a relative
> branch that jumps to nowhere when executed from the 1:1 mapping of the
> kernel text that the EFI mixed mode thunk uses on its return back to the
> caller.
>
> So as Thadeu suggested in [1], we should switch to a bare 'ret' opcode
> followed by 'int3' (to limit straight line speculation). However, doing
> so leaves an unmitigated RET in the kernel text that is always present,
> even on non-EFI or non-mixed mode systems (which are quite rare these
> days to begin with)
>
> So let's take Thadeu's fix a bit further [..]

Note that Thadeu's patch already made it into my kernel as commit
51a6fa0732d6 ("efi/x86: use naked RET on mixed mode call wrapper"), so
that "take the fix further" should probably be done incrementally.

I'm going to ignore this for 5.19, because I'm not sure how big of a
problem that "unmitigated ret" is. Honestly, it's probably easy enough
to find byte 0xc3 as part of other instructions and constants in the
kernel data section anyway, so I wouldn't worry too much about "hey,
we have a 'ret' instruction here that people could mis-use".

           Linus
