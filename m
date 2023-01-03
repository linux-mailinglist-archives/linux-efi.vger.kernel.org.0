Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0265C12F
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjACNwn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Jan 2023 08:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjACNwn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Jan 2023 08:52:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C5228;
        Tue,  3 Jan 2023 05:52:42 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90BC81EC04A9;
        Tue,  3 Jan 2023 14:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672753960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jenftXUsLCjYgVrpPBjfO/iyCDXDPDkEsFq22/aOs1Y=;
        b=ZYVEZy40bpZKRPNEb8A+GuJDwo7co0rlr98fvB9Y46v2y2MaROimAin4irtrRaH0yfVsVu
        YJFlUTK+92Y1n157kbiM0mqAgVZirhb4LrcZxhZhM8StngsMJoYWzHWJdG5iLOxBw3rMP9
        JoTXTSzQ+35L8T7r5FofStb4YRVIDmw=
Date:   Tue, 3 Jan 2023 14:52:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 05/14] x86/boot: Add infrastructure required for
 unaccepted memory support
Message-ID: <Y7QzI0GqNeG9OHy1@zn.tnic>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207014933.8435-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 07, 2022 at 04:49:24AM +0300, Kirill A. Shutemov wrote:
> Pull functionality from the main kernel headers and lib/ that is
> required for unaccepted memory support.
> 
> This is preparatory patch. The users for the functionality will come in
> following patches.

No need for that sentence.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/boot/bitops.h                   | 40 ++++++++++++
>  arch/x86/boot/compressed/align.h         | 14 +++++
>  arch/x86/boot/compressed/bitmap.c        | 43 +++++++++++++
>  arch/x86/boot/compressed/bitmap.h        | 49 +++++++++++++++
>  arch/x86/boot/compressed/bits.h          | 36 +++++++++++
>  arch/x86/boot/compressed/find.c          | 54 ++++++++++++++++
>  arch/x86/boot/compressed/find.h          | 79 ++++++++++++++++++++++++
>  arch/x86/boot/compressed/math.h          | 37 +++++++++++
>  arch/x86/boot/compressed/minmax.h        | 61 ++++++++++++++++++
>  arch/x86/boot/compressed/pgtable_types.h | 25 ++++++++
>  10 files changed, 438 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/align.h
>  create mode 100644 arch/x86/boot/compressed/bitmap.c
>  create mode 100644 arch/x86/boot/compressed/bitmap.h
>  create mode 100644 arch/x86/boot/compressed/bits.h
>  create mode 100644 arch/x86/boot/compressed/find.c
>  create mode 100644 arch/x86/boot/compressed/find.h
>  create mode 100644 arch/x86/boot/compressed/math.h
>  create mode 100644 arch/x86/boot/compressed/minmax.h
>  create mode 100644 arch/x86/boot/compressed/pgtable_types.h

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
