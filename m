Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9181B4CD5E6
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiCDOHp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 09:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiCDOHn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 09:07:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076781B9892;
        Fri,  4 Mar 2022 06:06:54 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-252-111.2.247.pool.telefonica.de [2.247.252.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA9F91EC032C;
        Fri,  4 Mar 2022 15:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646402809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=neT0UiN3Ufi1LjeuMTNM4SQxn8WU0bORQpO1LvG3ruw=;
        b=ChTyt7PGK//kdRXY9IGRBXoPzoUFM3dYdgso/XV4M9ByjglGyB+yHbrK5Cd1ZZDGeVz6zh
        2c1Uy5t+zgwzRCehtxV4Nav/6NYzlEarmnYDzMm4iqTg4moW2c5FxAr+romAataWivvaiP
        ZUu7NoPkX5UaB9oYsHkQGxYhEHBIIV8=
Date:   Fri, 4 Mar 2022 15:06:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 44/45] virt: sevguest: Add support to get extended
 report
Message-ID: <YiIc7aliqChnWThP@nazgul.tnic>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-45-brijesh.singh@amd.com>
 <YiDegxDviQ81VH0H@nazgul.tnic>
 <7c562d34-27cd-6e63-a0fb-35b13104d41f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c562d34-27cd-6e63-a0fb-35b13104d41f@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 03, 2022 at 10:47:20AM -0600, Brijesh Singh wrote:
> I did not fail on !req.cert_len, because my read of the GHCB spec says that
> additional data (certificate blob) is optional. A user could call
> SNP_GET_EXT_REPORT without asking for the extended certificate. In this
> case, SNP_GET_EXT_REPORT == SNP_GET_REPORT.
> 
> Text from the GHCB spec section 4.1.8
> ---------------
> https://developer.amd.com/wp-content/resources/56421.pdf
> 
> The SNP Extended Guest Request NAE event is very similar to the SNP Guest
> Request NAE event. The difference is related to the additional data that can
> be returned based on the guest request. Any SNP Guest Request that does not
> support returning additional data must execute as if invoked as an SNP Guest
> Request.
> --------------

Sorry, it is still not clear to me how

"without asking for the extended certificate" == !req.certs_len

That's not explained in the help text either. And ->certs_len is part of
the input structure but nowhere does it say that when that thing is 0,
the request will be downgraded to a SNP_GET_REPORT.

How is the user of this supposed to know?

And regardless, you can still streamline the code as in the example I
gave so that it is clear which values are checked and for which does the
request get failed...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
