Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8BF690E13
	for <lists+linux-efi@lfdr.de>; Thu,  9 Feb 2023 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjBIQNT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 11:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBIQNQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 11:13:16 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A61F5C7
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 08:13:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id be8so3327969plb.7
        for <linux-efi@vger.kernel.org>; Thu, 09 Feb 2023 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u4wdKHfmBS2U9u4YdoKj2BVpoNJ8KUYVHUoM1kpqWqU=;
        b=TMjpeTjllGoSXJflwYsYF33Ae4VA5qvqbi/O0+Z6V6YtjQLU98sbg0XQEg+++3U4fq
         4xTheUD1+PUhhueWB3O2urHm5qFCDDXCrX2mlMBVXK6+EZMq7eE1Wq7XJe13RStzG4xX
         UvYtLTtFVNDU6K7BuklWxZHT8Ni4AzP1ylhHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4wdKHfmBS2U9u4YdoKj2BVpoNJ8KUYVHUoM1kpqWqU=;
        b=59nBhCAklMr6rX0kbzSlURHMv/sCOPQEn7xL93ZeQLeSgA32kiFNS5qwAj2+ODDqzR
         Jolss3lu+Tmp6jd58ZwplbDoybX1EqQUe99j2RnHL6sN71ASYczp/V1k8GpQ7WTu/82l
         Nd9XfTjRR671KCE9VJntSdBygcASgpBkP95fMoVnR51BiYrJ4RRMb++5i6JHVG/k0uFe
         hSN7EGDJbKldfFOsLA2zRxFVC0M/6qE94qCVtqUJgPrB73A6iyFdCwXmvvY0BAWi1zV+
         Fxn3oa3ku1yzDDQkuS/BSJEYPJS7L986l47w+5ad/pvFwYSfu8VPgJOUEIWePa10FpS9
         Zy0A==
X-Gm-Message-State: AO0yUKWDG2idb9VCYyhVLyLvenbH2lTukcIsBaKzGIyry9I3/axLQvQf
        CbRKbSesuaqhb0e+LHBrkUZx4g==
X-Google-Smtp-Source: AK7set/pi9GTSxFWigEkpSOEbJx+RIQhuxkAPImjjkicRR4/9uFasmo37zcOaReTN4eEvRQO5IUGNg==
X-Received: by 2002:a17:90b:3b44:b0:231:2248:7da1 with SMTP id ot4-20020a17090b3b4400b0023122487da1mr4374506pjb.26.1675959186844;
        Thu, 09 Feb 2023 08:13:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090ab10b00b0023128531084sm1545778pjq.32.2023.02.09.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:13:06 -0800 (PST)
Message-ID: <63e51b92.170a0220.ca7b5.2b23@mx.google.com>
X-Google-Original-Message-ID: <202302090811.@keescook>
Date:   Thu, 9 Feb 2023 08:13:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QMNzjz0l8cnW4Y@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 08, 2023 at 08:55:19PM +0000, Mark Rutland wrote:
> On Wed, Feb 08, 2023 at 09:14:53PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 08, 2023 at 07:17:15AM -0800, Dave Hansen wrote:
> > > On 2/6/23 04:49, Ard Biesheuvel wrote:
> > > > --- a/arch/x86/kernel/apm_32.c
> > > > +++ b/arch/x86/kernel/apm_32.c
> > > > @@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
> > > >  
> > > >  	apm_irq_save(flags);
> > > >  	firmware_restrict_branch_speculation_start();
> > > > -	ibt = ibt_save();
> > > > +	ibt = ibt_save(true);
> > > 
> > > My only nit with these is the bare use of 'true'/'false'.  It's
> > > impossible to tell at the call-site what the 'true' means.  So, if you
> > > happen to respin these and see a nice way to remedy this I'd appreciate it.
> > 
> > I've often wished for a named argument extention to C, much like named
> > initializers, such that one can write:
> > 
> > 	ibt_save(.disable = true);
> > 
> > Because the thing you mention is very common with boolean arguments, the
> > what gets lost in the argument name and true/false just isn't very
> > telling.
> > 
> > But yeah, even if by some miracle all compiler guys were like, YES! and
> > implemented it tomorrow, we couldn't use it for a good few years anyway
> > :-/
> 
> Well... ;)
> 
> | [mark@lakrids:~]% cat args.c        
> | #include <stdbool.h>
> | #include <stdio.h>
> | 
> | struct foo_args {
> | 	bool enable;
> | 	unsigned long other;
> | };
> | 
> | void __foo(struct foo_args args)
> | {
> | 	printf("foo:\n"
> | 	       "  enable: %s\n"
> | 	       "  other: 0x%lx\n",
> | 	       args.enable ? "YES" : "NO",
> | 	       args.other);
> | }
> | 
> | #define foo(args...) \
> | 	__foo((struct foo_args) { args })
> | 
> | 
> | int main(int argc, char *argv[])
> | {
> | 	foo(true);
> | 	foo(.enable = true);
> | 	foo(false, .other=0xdead);
> | }
> | [mark@lakrids:~]% gcc args.c -o args
> | [mark@lakrids:~]% ./args            
> | foo:
> |   enable: YES
> |   other: 0x0
> | foo:
> |   enable: YES
> |   other: 0x0
> | foo:
> |   enable: NO
> |   other: 0xdead

I am horrified and delighted. And the resulting codegen is identical:
https://godbolt.org/z/eKTMPYc17

Without this fancy solution, what I'd seen is just using an enum:

enum do_the_thing {
	THING_DISABLE = 0,
	THING_ENABLE,
};

void foo(enum do_the_thing enable)
{
	if (enable) { ... }
}

foo(THING_ENABLE);


-- 
Kees Cook
