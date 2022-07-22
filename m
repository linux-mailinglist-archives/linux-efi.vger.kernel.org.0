Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E757E72F
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jul 2022 21:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiGVTS5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jul 2022 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiGVTS4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Jul 2022 15:18:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983A5925F;
        Fri, 22 Jul 2022 12:18:53 -0700 (PDT)
Received: from zn.tnic (p200300ea97297665329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7665:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AC521EC0657;
        Fri, 22 Jul 2022 21:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658517528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S7Nu4/eHKss0+qmBB7cZDNC3Q4DWm75cDoGs5TXikHo=;
        b=LIx6g/LXOmTk6uDJhPVmnoqKJ4EyZUKtMASYEeKCWrJykfa0uvj2XCpcPqEFKveUw1OzcC
        jVAmUcMNmbHoXPYgcGrCxhHJjA8xsZN1P/OyU403HZxaEvzq24nYzbK8bDBP+UCbWNjFE+
        qFKSWzhGfIcthc/2fyBXoBfWXC1k5XQ=
Date:   Fri, 22 Jul 2022 21:18:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Message-ID: <Ytr4FCV2xPGUBLqs@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic>
 <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 21, 2022 at 08:49:31AM -0700, Dave Hansen wrote:
> Acceptance is slow and the heavy lifting is done inside the TDX module.
>  It involves flushing old aliases out of the caches and initializing the
> memory integrity metadata for every cacheline.  This implementation does
> acceptance in 2MB chunks while holding a global lock.

Oh, fun.

> So, those (effective) 2MB clflush+memset's (plus a few thousand cycles
> for the hypercall/tdcall transitions)

So this sounds strange - page validation on AMD - judging by the
pseudocode of the PVALIDATE insn - does a bunch of sanity checks on the
gVA of the page and then installs it into the RMP and also "PVALIDATE
performs the same segmentation and paging checks as a 1-byte read.
PVALIDATE does not invalidate TLB caches."

But that still sounds a lot less work than what the TDX module needs to
do...

> can't happen in parallel. They are serialized and must wait on each
> other.

Ofc, the Intel version of the RMP table needs to be protected. :-)

> If you have a few hundred CPUs all trying to allocate memory (say,
> doing the first kernel compile after a reboot), this is going to be
> very, very painful for a while.
>
> That said, I think this is the right place to _start_. There is going
> to need to be some kind of follow-on solution (likely background
> acceptance of some kind). But, even with that solution, *this* code
> is still needed to handle the degenerate case where the background
> accepter can't keep up with foreground memory needs.

I'm still catering to the view that it should be a two-tier thing: you
validate during boot a certain amount - say 4G - a size for which the
boot delay is acceptable and you do the rest on-demand along with a
background accepter.

That should give you the best of both worlds...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
