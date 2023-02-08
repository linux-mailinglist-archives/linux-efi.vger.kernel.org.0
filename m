Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3850768F8A6
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 21:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjBHUPK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 15:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBHUPJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 15:15:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE230C9
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIGjviOgXze5b7+zeKAQeI0LE6+VOVtjUNzfe8RYYy0=; b=HUelxowCuz4dWmqHwTB3QKjlSs
        tf0wciqscxac1S3UvZ7Jhas8TSJeQON3QXXM0XK6cNg6zvmnZjUX3S0itElkFZqnIyEP2hnDHaylC
        a44jnq+Dr+ilueBddMBYyIRaxY7XUZh4pvzEO4DtJwMzuku0XKZtVRGECHnOUYgmbhGRQmYFYGD22
        i0KaSRQ5P0RMXbU3HjUVnjjgKVhC7Iz5oFjff6pemC/ArP5bY3QiyzxWYv8fjbiDSN5LgVC07aEn/
        7lSJmUixIT56+vmq6QsSv1mOAkbKV5J3BV08oNI0Nn++CVlr+fsXNF7/zovDf3acVvMx2bpjUhL+g
        L9m90ehw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPqqD-001W5W-8t; Wed, 08 Feb 2023 20:14:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34A84300446;
        Wed,  8 Feb 2023 21:14:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DE5120F194A5; Wed,  8 Feb 2023 21:14:53 +0100 (CET)
Date:   Wed, 8 Feb 2023 21:14:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
Message-ID: <Y+QCvSmdrqaJjxoT@hirez.programming.kicks-ass.net>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-4-ardb@kernel.org>
 <ca9dc359-899b-ec69-36e0-17225189da01@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca9dc359-899b-ec69-36e0-17225189da01@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 08, 2023 at 07:17:15AM -0800, Dave Hansen wrote:
> On 2/6/23 04:49, Ard Biesheuvel wrote:
> > --- a/arch/x86/kernel/apm_32.c
> > +++ b/arch/x86/kernel/apm_32.c
> > @@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
> >  
> >  	apm_irq_save(flags);
> >  	firmware_restrict_branch_speculation_start();
> > -	ibt = ibt_save();
> > +	ibt = ibt_save(true);
> 
> My only nit with these is the bare use of 'true'/'false'.  It's
> impossible to tell at the call-site what the 'true' means.  So, if you
> happen to respin these and see a nice way to remedy this I'd appreciate it.

I've often wished for a named argument extention to C, much like named
initializers, such that one can write:

	ibt_save(.disable = true);

Because the thing you mention is very common with boolean arguments, the
what gets lost in the argument name and true/false just isn't very
telling.

But yeah, even if by some miracle all compiler guys were like, YES! and
implemented it tomorrow, we couldn't use it for a good few years anyway
:-/
