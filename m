Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC65E7478
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 09:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIWHAg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIWHAf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 03:00:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5933F11D0D6;
        Fri, 23 Sep 2022 00:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o0uHXUsXUhn2jPpNOYhKHOJ7uxQ/113gO2HUCwNQKTA=; b=QXR7MPGYFu5vr5ygV25QiYtD/t
        NeXXniZZ6l1HVJ10qsWJnkAxn/1HL/vs1y57vKDtzbx4vzVEHnKsl+sDLkILL5GVRnHB1MKMWp3ub
        d6K8WlLYq2S0qUDv7NeMHpmRv0sDelO47gW90RufMbgwj4Kwg9R5FWHUpo5R7DCI//q2nZ/nyjLVB
        fxF9788n7NYendBMWpjF2QX2rlS75YqPxGSXVGbYewKJZ1rJA0F7FfxrTW6bkK4m/ACgmIcHTX9M7
        TggugOPFwcypkAy+rz6IZrbElHgOwxrp9GbdEoUAl+qyZdDYBvO1AXQac/M5eqgHmrEs8Tsv3fTGV
        uLe0j+SA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obcfC-00F9p4-Ij; Fri, 23 Sep 2022 06:59:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A948300074;
        Fri, 23 Sep 2022 08:59:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E7B52BBA9799; Fri, 23 Sep 2022 08:59:53 +0200 (CEST)
Date:   Fri, 23 Sep 2022 08:59:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
Message-ID: <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com>
 <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 23, 2022 at 12:08:57AM +0200, Ard Biesheuvel wrote:
> On Thu, 22 Sept 2022 at 21:32, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > I'm planning on sticking this in x86/mm so that it goes upstream
> > along with the W+X detection code.
> >
> > --
> >
> > A recent x86/mm change warns and refuses to create W+X mappings.
> >
> > The 32-bit EFI code tries to create such a mapping and trips over
> > the new W+X refusal.
> >
> > Make the EFI_RUNTIME_SERVICES_CODE mapping read-only to fix it.
> >
> 
> This is not safe. EFI_RUNTIME_SERVICES_CODE covers both .text and
> .data sections of the EFI runtime PE/COFF executables in memory, so
> you are essentially making .data and .bss read-only. (Whether those
> executables actually modify their .data and .bss at runtime is a
> different matter, but the point is that it used to be possible)
> 
> More recent firmwares may provide a 'memory attributes table'
> separately which describes the individual sections, but older 32-bit
> firmwares are not even built with 4k section alignment, so code and
> data may share a single page. Note that we haven't wired up this
> memory attributes table on i386 at the moment, and I seriously doubt
> that 32-bit firmware in the field exposes it.
> 
> Can we just turn off this feature for 32-bit?

Goodie; some seriously security minded people who did that EFI turd :/
Let's just heap it on the pile of 32bit sucks and should not be
considered a security target anymore and indeed kill this feature.


