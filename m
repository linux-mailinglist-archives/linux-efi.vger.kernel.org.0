Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6C5587AB
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jun 2022 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiFWSg4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jun 2022 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiFWSge (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Jun 2022 14:36:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBDB1FB;
        Thu, 23 Jun 2022 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656005906; x=1687541906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ge8OT7HLhcFlVbvHiA8m+7kVqj79aSFXytPp7Abwn4s=;
  b=KTAG1de30dwoAycsXKYsU+JlTZJoZXWk77qY8AoxEknbM5ibLsITinKW
   hsLxqlgUQWefCwHAqZ/CeTnyj+USWnjIUQmN8qrRKbOBSZDoN/Fjzab+1
   zQ7R5y28amKIOFEdEyGvxT2eHseI7ht+PcD1yW6AHTNOqy+kL80QgISuG
   IEuyCIWqDQt6p2fqxbc7rm36reKedlsloUrxn+4vlivlLTAIibnyyvSV9
   gZRxLOwes8zTegTpnQsd879o1bQ1v4T34myS06ddLyQo5FCnWFxzfHcBO
   TKDjaARDmCbugatgkGDv4H811IcsBVPjMH2YeZ90MDTWoP4gg/j9MWtQU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279557652"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="279557652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:38:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="563536244"
Received: from ckeane-mobl1.amr.corp.intel.com (HELO [10.209.81.98]) ([10.209.81.98])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:38:25 -0700
Message-ID: <6321fc25-ea69-df76-208b-856daf81afe6@intel.com>
Date:   Thu, 23 Jun 2022 10:37:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 01/14] x86/boot: Centralize __pa()/__va() definitions
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
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120231.48165-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 05:02, Kirill A. Shutemov wrote:
> Replace multiple __pa()/__va() definitions with a single one in misc.h.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 8 --------
>  arch/x86/boot/compressed/misc.h         | 9 +++++++++
>  arch/x86/boot/compressed/sev.c          | 2 --
>  3 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
