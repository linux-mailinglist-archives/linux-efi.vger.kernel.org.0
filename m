Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37A513103
	for <lists+linux-efi@lfdr.de>; Thu, 28 Apr 2022 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiD1KO6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Apr 2022 06:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344998AbiD1KO3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Apr 2022 06:14:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447C62E088;
        Thu, 28 Apr 2022 03:05:37 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB99A1EC0494;
        Thu, 28 Apr 2022 12:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651140331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+wDUGHmBZE9TNmVKVV36ycJhC8l9fzDLKuJmbmQV+4c=;
        b=ImrLEEQahdLWAyftZPD+6+rrfIiUWaC1eWJI3VJmVPk8k/KMKCEhUXrSYb3ysEnTu1C4rB
        KyeP+IL/E3gazP9caU37M51frV2EZ5XEvsHBpdRs1r/HbFRnaJu8JrmKP9th+niPB51lmK
        sgVhUa/9YARi+8TAPdq4ke8uPDDo9EE=
Date:   Thu, 28 Apr 2022 12:05:32 +0200
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv5 02/12] mm: Add support for unaccepted memory
Message-ID: <Ympm7JfVSWNiweZI@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:24AM +0300, Kirill A. Shutemov wrote:
> @@ -1124,6 +1159,23 @@ static inline void __free_one_page(struct page *page,
>  done_merging:
>  	set_buddy_order(page, order);
>  
> +	/*
> +	 * The page gets marked as PageUnaccepted() if any of merged-in pages
> +	 * is PageUnaccepted().
> +	 *
> +	 * New pages, just being added to buddy allocator, do not have
> +	 * PageUnaccepted() set. FPI_UNACCEPTED_SLOWPATH indicates that the
> +	 * page is new and page_is_unaccepted() check is required to
> +	 * determinate if accaptance is required.

Unknown word [accaptance] in comment.
Suggestions: ['acceptance', ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
