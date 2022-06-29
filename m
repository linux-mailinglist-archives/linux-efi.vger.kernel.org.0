Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FE55F241
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jun 2022 02:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiF2AMG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiF2AMG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 20:12:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328F275D9;
        Tue, 28 Jun 2022 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656461524; x=1687997524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1rJZNOGjRv+TC9F6qD+OHSFaxGFTvIixlfRghRPUsaE=;
  b=CRN4rwK+NjWoBDzuUM809iUIq7kfEQkPbzWA65vhHZctkFQ40+2eNHPd
   hFnJNESkr2OOyPsAPm4CI9QkBcqIyAtoQR5ba6s+QVwMIpB38TH+fsbKu
   xGlMTEIIF/oqzTJWQR2ap9WKF/t66F9QCkQtZaU7CXcShPtDfxHF1ey7N
   /EL57sXtDn4B/MK9CUEVRgPRdMnQ1TNfsIXY6kUlHGAaZIw94PGPOvFiA
   XgJMH7yB9TNPQH5K/a/Nk83B0yV1c4iAQsRu2QNy+wLA8K790vaeAU2Vx
   mHYS5tA13RFYjGoFWTNjstMR3AS0o4wjGTETjJQL1/U8Y880CgbubKV+3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="279426051"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="279426051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:12:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="617369374"
Received: from staibmic-mobl1.amr.corp.intel.com (HELO [10.209.67.166]) ([10.209.67.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:12:03 -0700
Message-ID: <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
Date:   Tue, 28 Jun 2022 17:10:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
 <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
 <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
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

On 6/28/22 16:51, Kirill A. Shutemov wrote:
> On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
>>> If there is some deep and fundamental why this can not be supported
>>> then it probably makes sense to put some code in the arch_kexec_load
>>> hook that verifies that deep and fundamental reason is present.
...
> +	/*
> +	 * TODO: Information on memory acceptance status has to be communicated
> +	 * between kernel.
> +	 */

So, the deep and fundamental reason is... drum roll... you haven't
gotten around to implementing bitmap passing yet?!?!?   I have the
feeling that wasn't what Eric was looking for.

