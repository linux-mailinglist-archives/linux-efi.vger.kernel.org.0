Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964815FDE6F
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJMQqO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJMQqN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 12:46:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0ED1929F;
        Thu, 13 Oct 2022 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fFpGRKD8AHa/ARwki3ryHxtKPwFk5Ayh38G2pe7ZJxM=; b=h6WLuhk2JC6VEhSgvQfnTxkR4h
        KU4ZbheF9y/Fp0WewoBmW5KZ2HS6zMjut2kFSnWfE/xIOE/FryhTlXE9nt9xHYhXLAISdSYPM3tH9
        fEvvA39YzxV/lCqiHrlIjBNR3K53WwcYdMXS3vfZnxdmnV5cKw9VtG45T5D9iPlFGR17VCBzb0GQ9
        g5jWSNw3IU5SlczxNI2kS5tXuPiVm/i3tmnVZqNjAJqNMxkoLc4j/MNFuVlwoCHjb//Wxtumdt1id
        jR/DNIVV5rGqTXWv3DrxHidFDIestLCcqRl5yuUAwK7mgbFPnmi5DKjZIK73J9aIq0/ANON2Mb6jL
        PyoCU1kw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oj1LB-006rj6-HP; Thu, 13 Oct 2022 16:45:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 590413001CB;
        Thu, 13 Oct 2022 18:45:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40DB32BDD933A; Thu, 13 Oct 2022 18:45:44 +0200 (CEST)
Date:   Thu, 13 Oct 2022 18:45:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Justin He <Justin.He@arm.com>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Message-ID: <Y0hAuBkmiUGfCs8/@hirez.programming.kicks-ass.net>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
 <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 13, 2022 at 05:41:06PM +0200, Ard Biesheuvel wrote:
> On Thu, 13 Oct 2022 at 15:37, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Oct 12, 2022 at 12:04:57PM +0000, Justin He wrote:
> > > I have a concern about what if cmpxchg failed? Do we have to still
> > > guarantee the ordering since cmpxchg will not imply a smp_mb if it
> > > failed.
> >
> > Of course it will imply that. At least on x86 it does. smp_wmb() is a
> > compiler barrier there and cmpxchg() already has that barrier semantics
> > by clobbering "memory". I'm pretty sure you should have the same thing
> > on ARM.
> >
> 
> No it definitely does not imply that. A memory clobber is a codegen
> construct, and the hardware could still complete the writes in a way
> that could result in another observer seeing a mix of old and new
> values that is inconsistent with the ordering of the stores as issued
> by the compiler.

Borislav is thinking too much x86. Failed cmpxchg() does indeed not
imply any memory ordering for all architectures -- and while the memory
clobber (aka. barrier()) is equivalent to an smp_wmb() on x86, that most
certainly doesn't hold for non x86 code.

> > says, "new_cache must be put into array after its contents are written".
> >
> > Are we writing anything into the cache if cmpxchg fails?
> >
> 
> The cache fields get updated but the pointer to the struct is never
> shared globally if the cmpxchg() fails so not having the barrier on
> failure should not be an issue here.

That is how I read the code too; so if the cmpxchg fails the object is
not published and nobody cares about the ordering.

> 
> > > Besides, I didn't find the paired smp_mb or smp_rmb for this smp_wmb.
> >
> > Why would there be pairs? I don't understand that statement here.
> >
> 
> Typically, the other observer pairs the write barrier with a read barrier.
> 
> In this case, the other observer appears to be ghes_estatus_cached(),
> and the reads of the cache struct fields must be ordered after the
> read of the cache struct's address. However, there is an implicit
> ordering there through an address dependency (you cannot dereference a
> struct without knowing its address) so the ordering is implied (and
> rcu_dereference() has a READ_ONCE() inside so we are guaranteed to
> always dereference the same struct, even if the array slot gets
> updated concurrently.)
> 
> If you want to get rid of the barrier, you could drop it and change
> the cmpxchg() to cmpxchg_release().

cmpxchg_release() is strictly weaker than cmpxchg(); so I don't see the
point there other than optimizing for weak architectures. It can't
fundamentally fix anything.
