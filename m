Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446644CC374
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiCCRMC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 12:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCCRMB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 12:12:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E997188A35;
        Thu,  3 Mar 2022 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646327475; x=1677863475;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=vaOGjw7VdBKeP6eHbl1iLmTW0NFWNNn5qWcGsk5ZbQE=;
  b=IBsdkHHXV4wbifK/fQcmch4j2dCl+OIeR+9I3TJLZJbc+X/7oOpfuHrQ
   hdqWWgZKCK/GlUACOQgFuuVbD0kKsFRoFPX0tZLLV0DZKF5Lief0biL/g
   uJSJbwueN8QPoCzBPrzyqVHRWB26Lyd+6hL+oQ1UmpJAtO/Y9OtgKdJuP
   fSkQOcrY2PA1x2FHWQULaGWNOneVdNkWhFJ+ViFama+IcUdAjTLHxJC+1
   u4vGQ5U4RrxBvO/rfHAEqcp1ymommJHwYMuC3273UixpEI8nyE/ortQ+7
   Utv5idK+y1GauVyHG025EgKtJwZraG+BGZQUwgdoDFfr2W9pbSunDNdCV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253928899"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253928899"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:09:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642184867"
Received: from eabada-mobl2.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:09:43 -0800
Message-ID: <5ca2583b-a873-fc5d-ece6-d4bdbd133a89@intel.com>
Date:   Thu, 3 Mar 2022 09:09:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-23-brijesh.singh@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 22/45] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
In-Reply-To: <20220224165625.2175020-23-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/24/22 08:56, Brijesh Singh wrote:
> +	/*
> +	 * Allocate VMSA page to work around the SNP erratum where the CPU will
> +	 * incorrectly signal an RMP violation #PF if a large page (2MB or 1GB)
> +	 * collides with the RMP entry of VMSA page. The recommended workaround
> +	 * is to not use a large page.
> +	 *
> +	 * Allocate one extra page, use a page which is not 2MB-aligned
> +	 * and free the other.
> +	 */
> +	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
> +	if (!p)
> +		return NULL;
> +
> +	split_page(p, 1);
> +
> +	pfn = page_to_pfn(p);
> +	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
> +		pfn++;
> +		__free_page(p);
> +	} else {
> +		__free_page(pfn_to_page(pfn + 1));
> +	}
> +
> +	return page_address(pfn_to_page(pfn));
> +}

This can be simplified.  There's no need for all the sill pfn_to_page()
conversions or even an alignment check.  The second page (page[1]) of an
order-1 page is never 2M/1G aligned.  Just use that:

	// Alloc an 8k page which is also 8k-aligned:
	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
	if (!p)
		return NULL;

	split_page(p, 1);

	// Free the first 4k.  This page _may_
	// be 2M/1G aligned and can not be used:
	__free_page(p);
	
	// Return the unaligned page:
	return page_address(p+1);
