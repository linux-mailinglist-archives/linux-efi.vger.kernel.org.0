Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0648CC10
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 20:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbiALTfe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 14:35:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:37890 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356791AbiALTf1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 14:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642016127; x=1673552127;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YuJU8sDPPXrY7j14l/N36i5HlcFv+BrkOxyMAgWnQeU=;
  b=fCC/HbAulwZ/BJzumOsPNjlqNjahwxuwvK/QP7QP3PXgdrmgyLpbQuLF
   gXJ+igfD3GqjSjWWy7swX0CxGial/Tj4+qyJiVYFVmHSBc1pczeeTyi+H
   KayPUBPFjkHru+P8UL5ctQyKykbapHDCTJ2o93dx/A4tlLAJiTUW/06vf
   4nnHkvMUQ52Hkt2mAeoJECczssd3cqrBUuZQKk9EVaCQUE9D1JwEi8RFx
   vbCBRU3HLH42tuI7yGiPN0/03V+OkK18FrTd3PWob+RDht9vkZXqnaRV9
   QEprnSOyiEOECUEAHcjy4wAdpXOqLgkgQplWM0XCO2yjIodKNDddsSbom
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="241393258"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="241393258"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 11:35:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="593118453"
Received: from kumarkan-mobl.amr.corp.intel.com (HELO [10.209.80.194]) ([10.209.80.194])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 11:35:25 -0800
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-4-kirill.shutemov@linux.intel.com>
 <b3348430-1b91-4b8b-b70c-76d48f8737f7@intel.com>
 <20220112192955.amelr4sq662pfv67@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 3/7] efi/x86: Implement support for unaccepted memory
Message-ID: <5e624c5a-387e-fef0-3870-f6a58d3f832e@intel.com>
Date:   Wed, 12 Jan 2022 11:35:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112192955.amelr4sq662pfv67@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/12/22 11:29 AM, Kirill A. Shutemov wrote:
>>> +	 * In the worst case scenario -- a huge hole in the middle of the
>>> +	 * address space -- It needs 256MiB to handle 4PiB of the address
>>> +	 * space.
>>> +	 *
>>> +	 * TODO: handle situation if params->unaccepted_memory has already set.
>>> +	 * It's required to deal with kexec.
>> What happens today with kexec() since its not dealt with?
> I didn't give it a try, but I assume it will hang.
> 
> There are more things to do to make kexec working and safe. We will get
> there, but it is not top priority.

Well, if we know it's broken, shouldn't we at least turn kexec off?

It would be dirt simple to do in Kconfig.  As would setting:

	kexec_load_disabled = true;

which would probably also do the trick.  That's from three seconds of
looking.  I'm sure you can come up with something better.
