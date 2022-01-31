Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12B4A527A
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 23:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiAaWiq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 17:38:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:5448 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbiAaWiq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Jan 2022 17:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643668726; x=1675204726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M7mZJap8bWp6kqusTez3NXr8dHFfMt8bmhpv8eupywQ=;
  b=AAWhacRXe1FJSRQAkBcgW3RVMYyEJX+MmpSOY4+e3h9WpRRwg5Sx6fmy
   rIqZ6q1Qo7TkRrz2/MLBuwrWjtH0O2At3RXF+y2JRruYCOir6COq7H1Ie
   510BAw8/vWUqLx+UxRCNiIMgCCRfOP+YMpPXBX4GnE8ALLjnv0TKWB9lj
   ompiHdG1NsMw+zRKc0L6lpaA/AuVpJpgq6NbSp3bevvr4i3YL7PtZNBaO
   OitxDqBHLmXiNn6Hot+kDXrtydPpaIyfkSiYCsPtM6KzJDtWjEMRzqav5
   CSF3e1LpsvCte6iMC52erEFB1nW41/KRyTlzFUFzGXwaBLwGkHPYi01S6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245156731"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="245156731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:38:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="630180014"
Received: from kcoopwoo-mobl1.amr.corp.intel.com (HELO [10.252.132.7]) ([10.252.132.7])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:38:45 -0800
Message-ID: <101a4497-ae17-ab69-640d-667c79da639b@intel.com>
Date:   Mon, 31 Jan 2022 14:38:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv3 2/7] efi/x86: Get full memory map in allocate_e820()
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
 <20220128205906.27503-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220128205906.27503-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/28/22 12:59, Kirill A. Shutemov wrote:
> Modify allocate_e820() to get a full memory map.

Dumb question time: why doesn't the current code get a full memory map?
 This looks simpler.  What's the downside?  Memory consumption?
