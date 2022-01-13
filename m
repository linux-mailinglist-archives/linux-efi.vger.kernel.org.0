Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB53548D30C
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 08:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiAMHmS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 02:42:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54782 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiAMHmS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 02:42:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58890B821C6;
        Thu, 13 Jan 2022 07:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED3DC36AE3;
        Thu, 13 Jan 2022 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642059735;
        bh=YhsgT/VGvn7iC/tWrV+hAmkAlLPkGfoehuUgvcT8PxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afoWXEa6BISUUp8I9HVzp7qlC7k1nW4vb1wONJSckOZNzpBEk2Oen3EtDwVSw+1El
         xx/9f2+bKgCToDN1Ictko8OP+u9pyjh/q/zt+zKsQVvdlXPBCDftMBwEwoY8FPrLl+
         mqWoagur7cWNCiXf2mElwp9eAucVF9q6l5MR9tFNzKo9blsdwM6pOUsjwOaE9BcUnH
         k6KMX/cJqDVsW+SjUZPwz/hbJWpiqDejLZ1u+472+BTau+8USPjn7TZYy0xCdpZeBl
         RjMDP9/liJmWJNYCG6p9FTPgT7dhKIskJ9f0/hvhdygA/icU/xPh7pN+9ce/lyO4zh
         GeoIpPIGhXuJw==
Date:   Thu, 13 Jan 2022 09:42:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/7] mm: Add support for unaccepted memory
Message-ID: <Yd/Xy+L61YewxE21@kernel.org>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-2-kirill.shutemov@linux.intel.com>
 <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
 <20220112183054.uedczc4ldntrj25j@box.shutemov.name>
 <af7ceba3-c27e-9f18-6c1b-c251428d8da4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7ceba3-c27e-9f18-6c1b-c251428d8da4@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 12, 2022 at 10:40:53AM -0800, Dave Hansen wrote:
> On 1/12/22 10:30, Kirill A. Shutemov wrote:
> > On Tue, Jan 11, 2022 at 11:46:37AM -0800, Dave Hansen wrote:
> > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > index 1018e50566f3..6dfa594192de 100644
> > > > --- a/mm/memblock.c
> > > > +++ b/mm/memblock.c
> > > > @@ -1400,6 +1400,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> > > >    		 */
> > > >    		kmemleak_alloc_phys(found, size, 0, 0);
> > > > +	accept_memory(found, found + size);
> > > >    	return found;
> > > >    }
> > > 
> > > This could use a comment.
> > 
> > How about this:
> > 
> > 	/*
> > 	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> > 	 * requiring memory to be accepted before it can be used by the
> > 	 * guest.
> > 	 *
> > 	 * Accept the memory of the allocated buffer.
> > 	 */
> 
> I think a one-liner that might cue the reader to go look at accept_memory()
> itself would be fine.  Maybe:
> 
> 	/* Make the memblock usable when running in picky VM guests: */

I'd s/memblock/found range/ or something like that, memblock is too vague
IMO
 
> That implies that the memory isn't usable without doing this and also points
> out that it's related to running in a guest.

-- 
Sincerely yours,
Mike.
