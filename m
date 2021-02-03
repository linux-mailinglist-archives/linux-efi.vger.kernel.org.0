Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74D30D954
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 12:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhBCL6Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Feb 2021 06:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhBCL6Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Feb 2021 06:58:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACABC0613ED;
        Wed,  3 Feb 2021 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qV09Im9zStsEDN3aK7Y5tK1FdFUYhtdI63Y+lrzaDhc=; b=oMNuAy5gx4vP9iN+v48oFdTUkz
        Zd119CdRuTFGy4J6KaIHwrSvqGRhBCUXcw48dXLfprFp7AhMoGA7J8U/m6cL4eFUNV4KoF5qFu7m5
        u0ByNkvAtdaPxi74AU0eX4aldWXbd29MVqbwM+o4jEqDd86uC86Pa3gcLnidkZ5MYpaUEGUbnwti+
        rSoPd478W8MmCcAkXBm5+Tq2wUHdhd/VbJ5lD4NmQoyjs3a8FkbDDcE2Le4xNW+Ub9vTHVWYNH+Y5
        yEL1PpTgyO8DmWyL8uJIhF4yhH50wNruWO9eYAZSrhTBtDoeyFuD50umDOLd23EcLthyyfxgxDrt8
        o8CzFQeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Gml-00GmtO-US; Wed, 03 Feb 2021 11:57:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 412043003D8;
        Wed,  3 Feb 2021 12:57:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A5702364E363; Wed,  3 Feb 2021 12:57:27 +0100 (CET)
Date:   Wed, 3 Feb 2021 12:57:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>, swine@google.com,
        yonghyun@google.com
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <YBqPp53EM/E+o5TA@hirez.programming.kicks-ass.net>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
 <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
 <20210203001414.idjrcrki7wmhndre@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203001414.idjrcrki7wmhndre@treble>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 02, 2021 at 06:14:14PM -0600, Josh Poimboeuf wrote:
> > Sure, but this is what production unwinders do, and they don't require
> > compiler plugins, right?
> 
> What do you mean by "production unwinders"?  Generally unwinders rely on
> either frame pointers or DWARF, but (without validation) those aren't
> robust enough for live patching in the kernel, so I'm not sure how this
> is relevant.

Not to mention that DWARF and consequently it's unders are horribly
large, complex and above all fragile things.

There's a reason ORC got invented, DWARF is simlpy unacceptable and
inadequate.

Now, one avenue that has been mentioned in the past, but I've not seen
recently, is to have objtool use DWARF as input to help it understand
the code. At least in userspace we can rely on DWARF libs. But I'm
fairly sure people aren't jumping up and down for having to always build
their kernel with DWARFs on, compile speed etc..
