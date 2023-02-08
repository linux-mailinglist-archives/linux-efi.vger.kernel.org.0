Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089FA68F919
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 21:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBHUzi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 15:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHUzi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 15:55:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEFD41632D
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 12:55:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEBD71477;
        Wed,  8 Feb 2023 12:56:09 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (unknown [10.57.90.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39C5E3F8C6;
        Wed,  8 Feb 2023 12:55:25 -0800 (PST)
Date:   Wed, 8 Feb 2023 20:55:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
Message-ID: <Y+QMNzjz0l8cnW4Y@FVFF77S0Q05N.cambridge.arm.com>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-4-ardb@kernel.org>
 <ca9dc359-899b-ec69-36e0-17225189da01@intel.com>
 <Y+QCvSmdrqaJjxoT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QCvSmdrqaJjxoT@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 08, 2023 at 09:14:53PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 07:17:15AM -0800, Dave Hansen wrote:
> > On 2/6/23 04:49, Ard Biesheuvel wrote:
> > > --- a/arch/x86/kernel/apm_32.c
> > > +++ b/arch/x86/kernel/apm_32.c
> > > @@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
> > >  
> > >  	apm_irq_save(flags);
> > >  	firmware_restrict_branch_speculation_start();
> > > -	ibt = ibt_save();
> > > +	ibt = ibt_save(true);
> > 
> > My only nit with these is the bare use of 'true'/'false'.  It's
> > impossible to tell at the call-site what the 'true' means.  So, if you
> > happen to respin these and see a nice way to remedy this I'd appreciate it.
> 
> I've often wished for a named argument extention to C, much like named
> initializers, such that one can write:
> 
> 	ibt_save(.disable = true);
> 
> Because the thing you mention is very common with boolean arguments, the
> what gets lost in the argument name and true/false just isn't very
> telling.
> 
> But yeah, even if by some miracle all compiler guys were like, YES! and
> implemented it tomorrow, we couldn't use it for a good few years anyway
> :-/

Well... ;)

| [mark@lakrids:~]% cat args.c        
| #include <stdbool.h>
| #include <stdio.h>
| 
| struct foo_args {
| 	bool enable;
| 	unsigned long other;
| };
| 
| void __foo(struct foo_args args)
| {
| 	printf("foo:\n"
| 	       "  enable: %s\n"
| 	       "  other: 0x%lx\n",
| 	       args.enable ? "YES" : "NO",
| 	       args.other);
| }
| 
| #define foo(args...) \
| 	__foo((struct foo_args) { args })
| 
| 
| int main(int argc, char *argv[])
| {
| 	foo(true);
| 	foo(.enable = true);
| 	foo(false, .other=0xdead);
| }
| [mark@lakrids:~]% gcc args.c -o args
| [mark@lakrids:~]% ./args            
| foo:
|   enable: YES
|   other: 0x0
| foo:
|   enable: YES
|   other: 0x0
| foo:
|   enable: NO
|   other: 0xdead

Mark.
