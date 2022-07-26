Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D555818CB
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiGZRqd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiGZRqc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 13:46:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2034ABF67;
        Tue, 26 Jul 2022 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658857590; x=1690393590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jfn73eb1NtC5hyzz5MoImvxl+iN6nGyp06TBHbGvRKk=;
  b=iDQrEtiPrg3Ky0tVG0M1+dPYnE2P7AglgEhrnGNqyztHqw7F9P8GW+Xw
   /qDH/B/D4sOBj1KoAB/e6Ep8Lv1ZU7ZHSUuiPpI41P7oLCXb/ty2oTHLq
   9YOI91RtV6Hze206NsSKTyyJlC8WKknqFdYqVg1v9kMYMxWw+k5c9mgp9
   Z1/qZ/RG47gayRcY4BZDgxENTcmOMHERpG5zVRrevw9bWgyEJlsaM9YnQ
   c8z8oYHgvsS1/n7eNmTg5VmfXbCZMZ6D8ZwaLz9NWNn1eMUAsMa/cSHqR
   eWGvHRSr85y8BNUvxM5CHSQ2jBBNhlksKeA5bFs3CEWTx60kDkji6H3UQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="285565496"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="285565496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 10:46:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="658790289"
Received: from mcrowelx-mobl.amr.corp.intel.com (HELO [10.255.229.9]) ([10.255.229.9])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 10:46:28 -0700
Message-ID: <62f37ed4-eac5-250e-3056-dea2d0039b02@intel.com>
Date:   Tue, 26 Jul 2022 10:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <YuAjdYESLDIYFj8x@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YuAjdYESLDIYFj8x@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/26/22 10:25, Borislav Petkov wrote:
> Why do we need those unicode quotes and backticks in there?
> 
> verify_diff: Warning: Unicode char [“] (0x8220 in line: +	 * “guard” page is accepted in addition to the memory that needs to be
> verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 *    checks up to end+2M if ‘end’ is aligned on a 2M boundary.
> verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 * 2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
> verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 *    needs to be done to make ‘page’ usable. That work might include
> verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 *    accepting pages in addition to ‘page’ itself.

I've been encouraging folks to stick their changelogs in a Google Doc
(or even Word) when they're writing them.  This gives them better
spelling and grammar checking than is available in most editors and also
makes it easier for folks to improve it collaboratively.  I find it a
lot more efficient than sending 10 copies back and forth in email.

The downside is that those fancy programs insert unicode willy nilly for
stuff like this.  You usually need to catch it with scripts because it's
hard to spot visually.

It might make a good checkpatch addition, if it's not already there.
