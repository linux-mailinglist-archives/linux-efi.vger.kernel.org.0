Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5BB53A952
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353648AbiFAOjy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354941AbiFAOjy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 10:39:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB431238
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 07:39:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s6so3074732lfo.13
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31EA6vRKdwEKuRnjDw/ZYtreHn9B2KdDbzd1nRyYZOQ=;
        b=uVWoHyvzgsqsVh284rkDPfCaL4cl8DXc+3JtebyZYXNFjjb1aE1cOGO5YW3d3b9k/N
         a3ltGR3Y7zIGFrrS/RmfqjlGFcCB/CkOHIxJizEb9PrGL1PTkLMNOHTrSTpisovoaN4Y
         KCbz/HRuA6d0ftXtT8uo8zptAsflNcNJN8UkjpkShiQC8oR9R1R1VOj52hJrV/BNFVZk
         6TwTVl7LwVVGHdLYwk1fPaFlCMNqXftkg6X7Lrq0B72xuOah6kabVgQ2/PhVIj5Foway
         dA59fZwUd4i+MY5O0zc0w3f4zQVGVOeYBwb0gvlPnmRkhkrVrcoG4Ocjk1Ddg0yelLl4
         D9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31EA6vRKdwEKuRnjDw/ZYtreHn9B2KdDbzd1nRyYZOQ=;
        b=GT06B7PZL4icAQEPkfnL7PgCeSmWgdpXWJrCfGUY4tGSPax+eVAXyXRNEvGNXaMnd8
         vO2fPB1LDYDX6E1Y36DARz10pL0/GBXsy/U3hgYzmKEqd/gdDlnwSr5z+BJ9iZjhPKho
         nI6dRnYHqSOYd5+PsdB8qgaIVR1DcjTYKPnNiXVZVrxKbsUcHcCpuVSGdHuum/lIwIdu
         Dlx3GiSlSymmYL5f4mHN6mWzK2qO6suiMWGvgyO1Rv3Qiy+TmfpotDHf+i24WyU0+oBo
         VWVSaktSmh62Ht2VXC9uxaA6bKqEqD2QcNr7eF4+oQRU+f3ZSX9SBOw2yK+2x2DlYNCO
         Iu5Q==
X-Gm-Message-State: AOAM533y/bK769T/ZDiqu7ZiDITOXO0j7OBKEABikAf8ifPT6moTj5By
        XHcuoRfosi8dx2NE0XSkZ6fTKA==
X-Google-Smtp-Source: ABdhPJytzV7/7pe53tLyOeHlbGNCloSYChNpAaJazKo2Ow7frOawx90Wzg5h4MwOnTDSTluYhB+amg==
X-Received: by 2002:a05:6512:2255:b0:478:da8f:e2e3 with SMTP id i21-20020a056512225500b00478da8fe2e3mr43581lfu.50.1654094390799;
        Wed, 01 Jun 2022 07:39:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q23-20020a2e9157000000b002554d2a5ea1sm353365ljg.10.2022.06.01.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:39:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A464F109789; Wed,  1 Jun 2022 17:41:48 +0300 (+03)
Date:   Wed, 1 Jun 2022 17:41:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 15/15] mm/vmstat: Add counter for memory accepting
Message-ID: <20220601144148.2saee3gw7jgvusgt@box.shutemov.name>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-16-kirill.shutemov@linux.intel.com>
 <76adccb2-2925-e102-db6f-529492d885c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76adccb2-2925-e102-db6f-529492d885c7@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 01, 2022 at 11:05:40AM +0200, David Hildenbrand wrote:
> On 17.05.22 17:34, Kirill A. Shutemov wrote:
> > The counter increased every time kernel accepts a memory region.
> > 
> > The counter allows to see if memory acceptation is still ongoing and
> > contributes to memory allocation latency.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/mm/unaccepted_memory.c | 1 +
> >  include/linux/vm_event_item.h   | 3 +++
> >  mm/vmstat.c                     | 3 +++
> >  3 files changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> > index 6ecd79101922..fe1dabfae326 100644
> > --- a/arch/x86/mm/unaccepted_memory.c
> > +++ b/arch/x86/mm/unaccepted_memory.c
> > @@ -74,6 +74,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >  		}
> >  
> >  		bitmap_clear(bitmap, range_start, len);
> > +		count_vm_events(ACCEPT_MEMORY, len * PMD_SIZE / PAGE_SIZE);
> >  
> 
> It's a bit weird that this is accounted from arch code

That's very serialization happens.

We can do it in the core mm if we can tolerate sporious vmcount bump.
Otherwise it has to happen under the lock in the arch code.

> Also, I'm a bit
> confused about the granularity here (PMD_SIZE).

That's how we track it in x86. The count itself is in pages. Different
arch can choose different granularity.

> >  		/* In early boot nr_unaccepted is not yet initialized */
> >  		if (nr_unaccepted) {
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > index 16a0a4fd000b..6a468164a2f9 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -136,6 +136,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >  #ifdef CONFIG_X86
> >  		DIRECT_MAP_LEVEL2_SPLIT,
> >  		DIRECT_MAP_LEVEL3_SPLIT,
> > +#endif
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +		ACCEPT_MEMORY,
> >  #endif
> >  		NR_VM_EVENT_ITEMS
> >  };
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index b75b1a64b54c..4c9197f32406 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1397,6 +1397,9 @@ const char * const vmstat_text[] = {
> >  	"direct_map_level2_splits",
> >  	"direct_map_level3_splits",
> >  #endif
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +	"accept_memory",
> > +#endif
> >  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
> >  };
> >  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
> 
> How exactly would I be able to figure out if "memory acceptation is
> still ongoing" if there is one last remaining page stuck at the tail of
> the freelist?

"still ongoing" in sense it is happening now, like if it increases system
does memory accept.

> Wouldn't it make more sense to actually count the number of unaccepted
> pages in the buddy? Once that number drops to 0, one knows that there is
> no unaccepted memory left in the buddy.

Patch 10/15 does this, but not in buddy.

-- 
 Kirill A. Shutemov
