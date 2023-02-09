Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453F690E72
	for <lists+linux-efi@lfdr.de>; Thu,  9 Feb 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBIQh6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBIQh5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 11:37:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBA60315
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 08:37:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u9so3437759plf.3
        for <linux-efi@vger.kernel.org>; Thu, 09 Feb 2023 08:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I7snu9y4j4ZVL+v+vg+ofabCCqYVVfclBVWkCwWBxUM=;
        b=ZJMImQuVeGX1qrWI7qRvAabc2z6zOqkLoa+HDwFosiqYCHUrwRbe+UkWPN9c8jmvvW
         kURGQ2/ysK4XomMeWK8D3M6wAWrG0e6Lz/faB7UAJ2+KFsQvO0rr+C3SPFeGr+0bonxV
         x5vvkgnDv+5LK6IyN8EhNh43YfnQdIFGjsapI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7snu9y4j4ZVL+v+vg+ofabCCqYVVfclBVWkCwWBxUM=;
        b=yMPg5AWEU5poBbhFe8bqyedn50a5E/ws7z3++uh/XrmSf56eTUJDAvuEfDWZfA5tsY
         TQL9CsblgD22wU37pQBayBjDHo5Tqq+Xlf0ebONOs1fVhryDGsopMdGA0cFVN2u7H9Lg
         +Jna99sWlw0Z6yEkOwri7AL9OFknG73n/BUvXk+ghBSm36Ir4Hbzo9JBzFa3ohgWk3FH
         6Lw5hnG6U9NdTVLUFufHu7awbXOFz6UZSfNyFy54JncpkUAjLfalIwLLQ6fv8MPH1a4+
         T6oLOgBmoyYC5JcclUNDrRP25QHGDapSjXT/7FCP8XKJVMGsWvjQVfG2+O/gdOCkd/L6
         i0aQ==
X-Gm-Message-State: AO0yUKVj97mrzIdo72VjPlqnV5uf+6ZiG/J3XUIl9d695KFCKC1I67jo
        IqpE1MFowbXGuh0+bbGQErwwEw==
X-Google-Smtp-Source: AK7set9O+PDflVrQF9YwM/vjwNlE6aTmsdtZF+w2M9i7NB1M4FdDJtFNKNlCYweM8ShbP/zVvXV97Q==
X-Received: by 2002:a05:6a21:9205:b0:bc:7dc0:6a55 with SMTP id tl5-20020a056a21920500b000bc7dc06a55mr10894875pzb.29.1675960669255;
        Thu, 09 Feb 2023 08:37:49 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i15-20020a63b30f000000b004da5d3a8023sm1493295pgf.79.2023.02.09.08.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:37:48 -0800 (PST)
Message-ID: <63e5215c.630a0220.1f01a.2993@mx.google.com>
X-Google-Original-Message-ID: <202302090837.@keescook>
Date:   Thu, 9 Feb 2023 08:37:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-4-ardb@kernel.org>
 <ca9dc359-899b-ec69-36e0-17225189da01@intel.com>
 <Y+QCvSmdrqaJjxoT@hirez.programming.kicks-ass.net>
 <Y+QMNzjz0l8cnW4Y@FVFF77S0Q05N.cambridge.arm.com>
 <63e51b92.170a0220.ca7b5.2b23@mx.google.com>
 <CAMj1kXHZwKPifJu1Y+hvjivJWU9YMJHyR84Y23nMsYrCxM0uYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHZwKPifJu1Y+hvjivJWU9YMJHyR84Y23nMsYrCxM0uYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 09, 2023 at 05:23:02PM +0100, Ard Biesheuvel wrote:
> On Thu, 9 Feb 2023 at 17:13, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Feb 08, 2023 at 08:55:19PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 08, 2023 at 09:14:53PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Feb 08, 2023 at 07:17:15AM -0800, Dave Hansen wrote:
> > > > > On 2/6/23 04:49, Ard Biesheuvel wrote:
> > > > > > --- a/arch/x86/kernel/apm_32.c
> > > > > > +++ b/arch/x86/kernel/apm_32.c
> > > > > > @@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
> > > > > >
> > > > > >         apm_irq_save(flags);
> > > > > >         firmware_restrict_branch_speculation_start();
> > > > > > -       ibt = ibt_save();
> > > > > > +       ibt = ibt_save(true);
> > > > >
> > > > > My only nit with these is the bare use of 'true'/'false'.  It's
> > > > > impossible to tell at the call-site what the 'true' means.  So, if you
> > > > > happen to respin these and see a nice way to remedy this I'd appreciate it.
> > > >
> > > > I've often wished for a named argument extention to C, much like named
> > > > initializers, such that one can write:
> > > >
> > > >     ibt_save(.disable = true);
> > > >
> > > > Because the thing you mention is very common with boolean arguments, the
> > > > what gets lost in the argument name and true/false just isn't very
> > > > telling.
> > > >
> > > > But yeah, even if by some miracle all compiler guys were like, YES! and
> > > > implemented it tomorrow, we couldn't use it for a good few years anyway
> > > > :-/
> > >
> > > Well... ;)
> > >
> > > | [mark@lakrids:~]% cat args.c
> > > | #include <stdbool.h>
> > > | #include <stdio.h>
> > > |
> > > | struct foo_args {
> > > |     bool enable;
> > > |     unsigned long other;
> > > | };
> > > |
> > > | void __foo(struct foo_args args)
> > > | {
> > > |     printf("foo:\n"
> > > |            "  enable: %s\n"
> > > |            "  other: 0x%lx\n",
> > > |            args.enable ? "YES" : "NO",
> > > |            args.other);
> > > | }
> > > |
> > > | #define foo(args...) \
> > > |     __foo((struct foo_args) { args })
> > > |
> > > |
> > > | int main(int argc, char *argv[])
> > > | {
> > > |     foo(true);
> > > |     foo(.enable = true);
> > > |     foo(false, .other=0xdead);
> > > | }
> > > | [mark@lakrids:~]% gcc args.c -o args
> > > | [mark@lakrids:~]% ./args
> > > | foo:
> > > |   enable: YES
> > > |   other: 0x0
> > > | foo:
> > > |   enable: YES
> > > |   other: 0x0
> > > | foo:
> > > |   enable: NO
> > > |   other: 0xdead
> >
> > I am horrified and delighted.
> 
> +1
> 
> > And the resulting codegen is identical:
> > https://godbolt.org/z/eKTMPYc17
> >
> > Without this fancy solution, what I'd seen is just using an enum:
> >
> > enum do_the_thing {
> >         THING_DISABLE = 0,
> >         THING_ENABLE,
> > };
> >
> > void foo(enum do_the_thing enable)
> > {
> >         if (enable) { ... }
> > }
> >
> > foo(THING_ENABLE);
> >
> 
> I have no strong preference one way or the other, but given that
> apm_32.c is not the epicenter of new development, and the call from
> EFI code is self-documenting already ('
> ibt_save(efi_disable_ibt_for_runtime)', I'm inclined to just queue the
> patch as-is, and leave it to whoever feels inclined to spend more free
> time on this to come up with some nice polish to put on top.
> 
> Unless anyone minds?

Yeah, this was just commentary. I think the patch is fine as-is.

-- 
Kees Cook
