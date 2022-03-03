Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D34CC3FE
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiCCRep (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 12:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiCCReh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 12:34:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E3BAF;
        Thu,  3 Mar 2022 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646328828; x=1677864828;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/6BWrWtvMDgxG3GRtmu6+t9kH9b6E5eZZRPbC6t9AzU=;
  b=JYMrLkv7yKJlhiGS77Uea0+2fxGDbjwVhHefPfZTIVtDrzGhl3GQM1nZ
   e3yefVeALKeERJmIGHCTzIIKll7h5U7Q34YDfs21st4PGmEZrebUyeW50
   osOf5Q2i55SULRrp89FSqBFzBaX+pWsmno4s0P2LeoMrrfPoYrgXt1PDi
   l7+nSh31R0cpjVEpoKBt2kVUQtir8WL7+DtIBRKnSZZMTHG0AtOiXaDZE
   JIkrydtquFJedlU/nDQHXGsK8NU5rLpaNmgAQQdgwG7J6Y+4j6n1v/uR6
   hfHlVT0LcBGbvv2L6lBISbg3qAlJ8jbf9Dog3IZZ1Jtzf4qMhXOkPsGMF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253477473"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253477473"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:33:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642197252"
Received: from eabada-mobl2.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:33:45 -0800
Message-ID: <c85259c5-996c-902b-42b6-6b812282ee25@intel.com>
Date:   Thu, 3 Mar 2022 09:33:40 -0800
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
 <20220224165625.2175020-43-brijesh.singh@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 42/45] virt: Add SEV-SNP guest driver
In-Reply-To: <20220224165625.2175020-43-brijesh.singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> +++ b/drivers/virt/coco/sevguest/Kconfig
> @@ -0,0 +1,12 @@
> +config SEV_GUEST
> +	tristate "AMD SEV Guest driver"
> +	default m
> +	depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
> +	help
> +	  SEV-SNP firmware provides the guest a mechanism to communicate with
> +	  the PSP without risk from a malicious hypervisor who wishes to read,
> +	  alter, drop or replay the messages sent. The driver provides
> +	  userspace interface to communicate with the PSP to request the
> +	  attestation report and more.
> +
> +	  If you choose 'M' here, this module will be called sevguest.
...
> +/* Return a non-zero on success */
> +static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	u64 count = __snp_get_msg_seqno(snp_dev);
> +
> +	/*
> +	 * The message sequence counter for the SNP guest request is a  64-bit
> +	 * value but the version 2 of GHCB specification defines a 32-bit storage
> +	 * for it. If the counter exceeds the 32-bit value then return zero.
> +	 * The caller should check the return value, but if the caller happens to
> +	 * not check the value and use it, then the firmware treats zero as an
> +	 * invalid number and will fail the  message request.
> +	 */
> +	if (count >= UINT_MAX) {
> +		pr_err_ratelimited("request message sequence counter overflow\n");
> +		return 0;
> +	}
> +
> +	return count;
> +}

I didn't see a pr_fmt defined anywhere.  But, for a "driver", should
this be a dev_err()?

...
> +static void free_shared_pages(void *buf, size_t sz)
> +{
> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	if (!buf)
> +		return;
> +
> +	if (WARN_ONCE(set_memory_encrypted((unsigned long)buf, npages),
> +		      "failed to restore encryption mask (leak it)\n"))
> +		return;
> +
> +	__free_pages(virt_to_page(buf), get_order(sz));
> +}

Nit: It's a bad practice to do important things inside a WARN_ON() _or_
and if().  This should be:

	int ret;

	...

	ret = set_memory_encrypted((unsigned long)buf, npages));

	if (ret) {
		WARN_ONCE(...);
		return;
	}
	
BTW, this look like a generic allocator thingy.  But it's only ever used
to allocate a 'struct snp_guest_msg'.  Why all the trouble to allocate
and free one fixed-size structure?  The changelog and comments don't
shed any light.
