Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9014F9B42
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiDHREQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDHREO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 13:04:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ABB1C315F;
        Fri,  8 Apr 2022 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649437330; x=1680973330;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=yyWbXS/ISGdNNtqxbp6nrln8YxFisMQHA7t8fOE4CaE=;
  b=kGWxqI14Rdj8uUEl5Ddx57f8Eh6hNx9RN+bNmra8odOaxFnYrMqJb92h
   L1tobUskA9CLiXgJAml1dkMxjseAJbtxje42CCfA3OXo+U+U3YXWjq4W8
   91XY3bo+fFWWfkRmYhob2fvwVNtPgRLoMyM6EbLSOXHV2WnsJ15banOUC
   xZqMjgTsv9WPiC38hVSwBwslNPZ+CuEWVXnOPnVh6sExrf83vIulgXj9g
   l1+x0MIrFK0vGxTzbzH3Z6mHGP5vpFVNb1cTNHluo4VrMmVzyLxoIv79i
   1+Ra1p+axv1uz/rZhi8eO/D4OPm5lL3IDrZJfHjh1qXEK95GlSU7Bk87b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="348076956"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="348076956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:02:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525448716"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:02:09 -0700
Message-ID: <95eabe79-a13b-79b1-1196-407920531f20@intel.com>
Date:   Fri, 8 Apr 2022 10:02:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 0/8] mm, x86/cc: Implement support for unaccepted memory
In-Reply-To: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/5/22 16:43, Kirill A. Shutemov wrote:
> Patches 1-6/7 are generic and don't have any dependencies on TDX. They
> should serve AMD SEV needs as well. TDX-specific code isolated in the
> last patch.

Oh, that's quite nice.  Are the SEV-SNP folks planning on using this?
If they are, acks/reviews would be much appreciated.

