Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0057070949A
	for <lists+linux-efi@lfdr.de>; Fri, 19 May 2023 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjESKQw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 May 2023 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjESKQs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 May 2023 06:16:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7881AD;
        Fri, 19 May 2023 03:16:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EB00B5C018B;
        Fri, 19 May 2023 06:16:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 19 May 2023 06:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684491405; x=
        1684577805; bh=eusJfDMu4BSNTI2WSPt51cso8c3WEiCMloVC5l7E91A=; b=b
        lCqjsuOikslXbda5V6akg2UopLQgrMQlrMPxyvtjHo/yJUKUYsSrWvC17uuKr4vM
        O3Dv3fChZ0sWQT9o+pbsyKJ3oF0P8ce1LmE7hNzWgNvVHUD7m+qKqpW9b0Imw1Mo
        88O454JJockUe2btHxFt99nIq3+F+eEfjeZciytpwoQhJLAVLBKvGCGFJNPVFgMQ
        HlxETu/Lumab7SYt93kWpZl2866CP9QND6VTMTK7Awv7LPawzIsV53d2kkASQlDX
        oSMEWGKm2uXhWPj4LjqqQ5cZ7a3VdzP3vpxAnrZqJ0cFQWRcyL69/8YB8JAmenk1
        IrTT22X/qH2pzPy4QFwYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684491405; x=1684577805; bh=eusJfDMu4BSNT
        I2WSPt51cso8c3WEiCMloVC5l7E91A=; b=dXyFgQH7P6eiAYgSleRv/Gjqb280F
        ThmzxeXcsEdqsawOM/bakg1QLciiKGf86X0jkUAbdXki8U2advF5sTZKIilcju67
        Oz0a4RkZ53yo8PRTDo9WfF8gEMuifyzzXRF3+qR1nhsdbtzwcDGuvhnof1nWAC9e
        w9T3mDF5ynVfAQf3bFdZfb+wusOfpyS4xdqSm3SHpqCkbnWNIn05qSrdfe/+gW+U
        h6pglTLWaR2rKFF9aEznZ0tseJSOR+otfGzLZTSdH535OpcEbLR4PogR0kMPWiX2
        GiNV0jvqiazvZs01yOVjM03jQ4HHnsapOH+01jwn/uTa/ZFYiw4ySkGQg==
X-ME-Sender: <xms:jUxnZKonMdhqVeRoGnusF0ygfdH53a7xUQR9toJGh1Dcgus8LewFIw>
    <xme:jUxnZIq7PnuE_JoNKgCT_0iD_-qK8wLphLkh0Sbv-kWf6a9X_9WgscpqOa8wiVroO
    qxiPRQGwq7uJud1y6Y>
X-ME-Received: <xmr:jUxnZPMtzFy5V4YjzDWJnc_iQlJwKeWE0yecE-ajf3Kv2A1QC0kUa8LjLmPFGqtx1vtnPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:jUxnZJ5OH0_GBw2ta8PpGwzuhq2DpKv03WfZy8jNrZ1HgGx_DIU-Qw>
    <xmx:jUxnZJ4x4ooMT9irvoHnf7oAQv9V5vB6jVGAuFBNJgF0IpWmbOEzAw>
    <xmx:jUxnZJiwcZ3nG37hTXfgFl6VI2a07q-CTc3itCWRDP2dp1c3sFTQAQ>
    <xmx:jUxnZLHArDRSAyu74WkwOIql1ojOGBgNqYSq6NBC0vaxyDfyimIFOg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 06:16:44 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4DA4210DFD2; Fri, 19 May 2023 13:16:41 +0300 (+03)
Date:   Fri, 19 May 2023 13:16:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv12 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230519101641.nka7ty3fttntymci@box.shutemov.name>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518231434.26080-5-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 19, 2023 at 02:14:29AM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index 67594fcb11d9..87372b96d613 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -1,9 +1,32 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include "error.h"
> +#include "misc.h"
>  
>  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  	/* Platform-specific memory-acceptance call goes here */
>  	error("Cannot accept memory");
>  }
> +
> +void init_unaccepted_memory(void)
> +{
> +	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> +	struct efi_unaccepted_memory *unaccepted_table;
> +	unsigned long cfg_table_pa;
> +	unsigned int cfg_table_len;
> +	int ret;
> +
> +	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
> +	if (ret)
> +		error("EFI config table not found.");
> +
> +	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
> +							 cfg_table_pa,
> +							 cfg_table_len,
> +							 guid);
> +	if (unaccepted_table->version != 1)
> +		error("Unknown version of unaccepted memory table\n");
> +
> +	set_unaccepted_table(unaccepted_table);
> +}

0-day reported boot failure outdise TDX guest with CONFIG_INTEL_TDX_GUEST=y.

The fixup:

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 0108c97399a5..8df3d988ae69 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -56,6 +56,9 @@ void init_unaccepted_memory(void)
 							 cfg_table_pa,
 							 cfg_table_len,
 							 guid);
+	if (!unaccepted_table)
+		return;
+
 	if (unaccepted_table->version != 1)
 		error("Unknown version of unaccepted memory table\n");
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
