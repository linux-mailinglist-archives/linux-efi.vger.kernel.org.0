Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627485586E3
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jun 2022 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiFWSSn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jun 2022 14:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiFWSSP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Jun 2022 14:18:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D487B62A1;
        Thu, 23 Jun 2022 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656005081; x=1687541081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HyD7sZmGzSIHx03CaYUHtjWHrLaftO9PYHM6NFaUHG0=;
  b=cInEJ/OfBt/UerM5ZmBpBAYpdjXlp8Pl5hgIau9o+rmZD0trj3DNdFTj
   Elc0NoqWhXqRDs8S9JYSwRWmYTFUJnnRZ0M1HX7qh8K/YAqRSA99TbFNF
   pbaCPW6yEXh8SKluG0EC4ERGk0aLroTh8zzfGNIWAsKrF4mh7k4plSk5z
   Pv27dABxFNTthbzw5uo/Ueg8kTPFwjlkFBL/TpkvjlpboQvl3GvwZJ6Ql
   k0Kv33RDJayG2+wz38jG+aD7/OrWuRonHo899k1bBukNZ2c5N5bGpykhA
   MqMo+0Z7cEz4JPINsuoJJb8P11GqMA/gm2JHBtHO6rM7+R7/47QXvsN0H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269511427"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="269511427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:24:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="563531696"
Received: from ckeane-mobl1.amr.corp.intel.com (HELO [10.209.81.98]) ([10.209.81.98])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:24:25 -0700
Message-ID: <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
Date:   Thu, 23 Jun 2022 10:23:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

... adding kexec folks

On 6/14/22 05:02, Kirill A. Shutemov wrote:
> On kexec, the target kernel has to know what memory has been accepted.
> Information in EFI map is out of date and cannot be used.
> 
> boot_params.unaccepted_memory can be used to pass the bitmap between two
> kernels on kexec, but the use-case is not yet implemented.
> 
> Disable kexec on machines with unaccepted memory for now.
...
> +static int __init unaccepted_init(void)
> +{
> +	if (!boot_params.unaccepted_memory)
> +		return 0;
> +
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * TODO: Information on memory acceptance status has to be communicated
> +	 * between kernel.
> +	 */
> +	pr_warn("Disable kexec: not yet supported on systems with unaccepted memory\n");
> +	kexec_load_disabled = 1;
> +#endif

This looks to be the *only* in-kernel user tweaking kexec_load_disabled.
 It doesn't feel great to just be disabling kexec like this.  Why not
just fix it properly?

What do the kexec folks think?
