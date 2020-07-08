Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0402218F68
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGHSAm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 14:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgGHSAl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jul 2020 14:00:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F2EC08C5C1
        for <linux-efi@vger.kernel.org>; Wed,  8 Jul 2020 11:00:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so40560619ljl.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Jul 2020 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5XIR15aEBjKzEA9W2lE8KNSZAO03DuL4VvK0HEZgj4=;
        b=CAEGyWluUdS2/+/QxbS2adVKlj4rm4jaGfE9yPeCwHJLCQXNeRKWlsV7XWRfFALonl
         EOEkSlDs9UoqbJsa8I93dW0z0TyrLzuvg3G9vZueD7j1TWG4dtUAPmKzg8A+e+XxVjM2
         nwlMC//lFwzWKXwhEmZxrCOQCJEtFAfoiH78w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5XIR15aEBjKzEA9W2lE8KNSZAO03DuL4VvK0HEZgj4=;
        b=EFUZ4YELT/Jv9PaRaOdvXVKCWZ7K8SeHvZJOZnGPWEp4M9HCyaTqDRRKVWjUbqX/BR
         boKFfQJK1Kwq4AXUZ1to+HYTzNItXkiz+4UciJSo1/GvknVR+0s12EQnuE29f9jng5aL
         fWf83U1X5Pm9Rz26Yv4N78o2WWCIZs8sBKmYxwzG+n/+okbE2kQC3KfjL/HfWatcT7qV
         oqpf/bLo5phvxTwgb+6wcU8QPeJmzNEWQqT1UBADFolzGOjsji5S5wfcrEK/iCL2nKwC
         7nqwQbMvngmkAcevg5jrbiFc37BOd44sdW4xYHUCv9AouVuRgkm0lyQWOikyQnNLV5ax
         oWxg==
X-Gm-Message-State: AOAM532QfJv+ZhQ1XyCdipiceIwwhKvCaHbp/nhp/ArwmRKg2I6tGiyB
        BAxYb3Zv6QHGlPRROg5bxZKOEIoxYtc=
X-Google-Smtp-Source: ABdhPJyyRZItCb9pLPmiwBHgxrPCHa2IgO2Uf/N8T2/nwLCoA+NhR8eW6PVdMtS0Z3I9TbIaCe3s0g==
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr33476493ljp.374.1594231238456;
        Wed, 08 Jul 2020 11:00:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k6sm156738lfm.89.2020.07.08.11.00.36
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 11:00:36 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r19so4241873ljn.12
        for <linux-efi@vger.kernel.org>; Wed, 08 Jul 2020 11:00:36 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr28222464lji.70.1594231236141;
 Wed, 08 Jul 2020 11:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com> <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200708162053.GU4800@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jul 2020 11:00:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
Message-ID: <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 8, 2020 at 9:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > It's perhaps yet another reason to just skip gcc-4.8 too, since
> > apparently 4.9 works.
> >
> > gcc-4.9 really has a lot of advantages. It's where (I think) gcc
> > basically supports all C11 things, including _Generic() but also
> > __auto_type.
>
> +1
>
> Anybody for nay, or should we just do this?

I'll just do it. Let's see if anybody screams with a good reason. I
hate the whole "support old compilers", it ends up not only making for
complex code, it tends to cause these unnecessary kinds of "guys, we
tested this really well, but that crazy compiler had a very particular
odd issue, and it wasn't in any test box.

                Linus
