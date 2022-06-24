Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584755A0B0
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiFXSOa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFXSO3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 14:14:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906D4707F;
        Fri, 24 Jun 2022 11:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656094468; x=1687630468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YeV/d+4LsC7Rh9IZcGmWfqXWcLSrc2sIo/Y1Mv7nibY=;
  b=GCo0mhYc/H6FzyBwRxwoAqUFinUnqC0twLgVD8cDkDG9YBceW2nIGFEL
   XIzRTXnZlgrUmY6HM6iQmA3GrY7QpTrXUp8PM6CYqi9oBK93B8IQXTfWt
   lhtp9c+JgWB1HwTfU/iYseyZaBgkhltoRRVJ3vJsqJaphYuJBZU+pbMFy
   fqtQjqZ0zZ7rOBzGzNu+UIwJvKL1Wq1sRp85tvqqHFXdJbqrnIZRwmOIa
   1rsgrTQP41RU8Pfy8BmeI+RnKIL2MjTm2HoZu859Z38qw7V++/JYUHLWL
   Bcbd1CfCoOXJF8n8SO0ghPAcdSMUN4qcxZfN80puxaSvt5xvygx7JqyQQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="282146947"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="282146947"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 11:14:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="731418689"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 11:14:05 -0700
Message-ID: <b3000916-3be3-58e5-0440-ec9abda69934@intel.com>
Date:   Fri, 24 Jun 2022 11:13:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     Marc Orr <marcorr@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo <marcelo.cerri@canonical.com>, tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <5af19000-4482-7eb9-f158-0a461891f087@intel.com>
 <CAA03e5F480=psSECDAkXQEvNKk3une-4dJV57Hde4z4MMzh=1A@mail.gmail.com>
 <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com>
 <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
 <1e7ad728-d796-c84d-b7ba-b96d8f9fcd0c@intel.com>
 <CAMkAt6pzMSUuuA7Kc-sVEGw1FYpDoRrKs-dco++2rpqB219_ng@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMkAt6pzMSUuuA7Kc-sVEGw1FYpDoRrKs-dco++2rpqB219_ng@mail.gmail.com>
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

On 6/24/22 11:10, Peter Gonda wrote:
>> How big is the window going to be where we have guests that can have
>> unaccepted memory, but don't have acceptance support?  For TDX, it's
>> looking like it'll probably _just_ be 5.19.  Is TDX on 5.19 in shape
>> that cloud providers can deploy it?  Or, is stuff like lack of
>> attestation a deal breaker?
> This is complicated because distros don't run upstream linux versions.
> If I understand correctly (I see some distro emails on here so please
> correct me) distros normally maintain forks which they backport things
> into. So I cannot answer this question. It is possible that a
> hypothetical distro backports only the SNP/TDX initial patches and
> doesn't take these for many releases.

Distros could also backport a bare-bones version of this set that
doesn't do anything fancy and just synchronously accepts the memory at
boot.  No bitmap, no page allocator changes.  It'll slow boot down, but
is better than having no RAM.
