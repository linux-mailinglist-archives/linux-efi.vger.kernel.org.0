Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811AA655AC0
	for <lists+linux-efi@lfdr.de>; Sat, 24 Dec 2022 17:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiLXQqx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Dec 2022 11:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQqw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Dec 2022 11:46:52 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A10C761;
        Sat, 24 Dec 2022 08:46:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B59975C00B7;
        Sat, 24 Dec 2022 11:46:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 24 Dec 2022 11:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1671900406; x=1671986806; bh=t8
        vduv9DbvrjoxOtqDnh44h4iMss7CWjs2Pq59gUuaU=; b=NWJNmQWlc1yX7VwmdS
        vsbEK1gcqwRN4VWiiG6Y/MKYFM/3r5Kvmg2AR+c1DQJKJX/w9NDAGqE9itriBoXq
        nkXIfg34BHV5rh5Z7L6myHd/cyf3eUYqRYstetBy+5V5c4noayRzzuKHYw/q8oeU
        Nq7iOkSmcyvlF5zUdG5L44WLM137+/oKzZInfAfgOy0/lS/VTX7uuxfQmXVLqS6f
        gdmWFnGX2tUvexRgVn7sdqBAzf+lukNK9cWT7mSmR2FkDZjkh1BgM6hpeqfFSVq3
        22HrU2q3fTcYRhfw6zTr2Z4QgrSS+xNIukH1VxxhA7IXO+4ZRB1VPC5bEkbbUxu1
        3Pyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671900406; x=1671986806; bh=t8vduv9DbvrjoxOtqDnh44h4iMss
        7CWjs2Pq59gUuaU=; b=Sjk6EcaUuMPfYH+3OLi+3eMS+V9JH9PYTiZX1tcH2YPY
        LQKB3w0Sl090kntKm3bvrjant6if7RE3pWzyFxwTZPQ1j0BD+T1eWaP2OoXKAuhI
        v3k/nertXhaiOCR4J+vFbolmMnXy2HWYZ7nRwITHcHxm9mH1VhtBf4rnUyW1qxUW
        p6TpJkpnLVLAz+u75w3HsGoIiNr58Xb2I66cj+xv7v5iREmUF8JClBDcTKjE3HY/
        N0bSBook5jsFu+9E3GL9fdLMIR0H+EMn+mJBEQ/z2De1vVe/8IcxN70mWnooBHs5
        9pkPwysmIfrRQY6bNLnrNcvqqKqnaE8eUOsXw/hSYw==
X-ME-Sender: <xms:8yynY0Qsj8FHMKO6yWO9IaJBOZKBycUVIoIQYjeAJoymkRegZ2j3EQ>
    <xme:8yynYxwNYRommeNKCfDMFE3LdbVgsvhwB3gby2R9mGF1v38AY3Vxu7UnUs-4Ld1px
    ProyfINp2bPfUGSapg>
X-ME-Received: <xmr:8yynYx0VSsIsiP23ZUcBSQbKqDz7BYw-6I9sIfZewZw1olDACOx0w315bnsJhUxFQttNbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrheeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:8yynY4B3IipTyYwgsRsgtufqxavXfhZkDNr71EVbsb1UAmP4bgJ8RQ>
    <xmx:8yynY9ilTU6D9rWb8GIu7wc8m7b9HsHt13DdFBSSk-GHxhJTzjeZBg>
    <xmx:8yynY0pJFs50G4o6JBThYGhlu8sI59f5zMPahBJTb8oimkg3Rs-8WQ>
    <xmx:9iynY4NDRDAdmPIzSUcZvSlUZDm8Romp7buK2fUpwL6zTMtFpz7WnQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Dec 2022 11:46:43 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3B47A10BA34; Sat, 24 Dec 2022 19:46:39 +0300 (+03)
Date:   Sat, 24 Dec 2022 19:46:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv8 02/14] mm: Add support for unaccepted memory
Message-ID: <20221224164639.pb3hrvbxtlodgm5e@box.shutemov.name>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-3-kirill.shutemov@linux.intel.com>
 <f944459f-76a6-60c3-7dae-0918d9ef0c5d@suse.cz>
 <20221209192616.dg4cbe7mgh3axv5h@box.shutemov.name>
 <3ab6ea38-5a9b-af4f-3c94-b75dce682bc1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab6ea38-5a9b-af4f-3c94-b75dce682bc1@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 09, 2022 at 11:23:50PM +0100, Vlastimil Babka wrote:
> On 12/9/22 20:26, Kirill A. Shutemov wrote:
> >> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >> >  			/*
> >> >  			 * Watermark failed for this zone, but see if we can
> >> > @@ -4299,6 +4411,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
> >> >  
> >> >  			return page;
> >> >  		} else {
> >> > +			if (try_to_accept_memory(zone))
> >> > +				goto try_this_zone;
> >> 
> >> On the other hand, here we failed the full rmqueue(), including the
> >> potentially fragmenting fallbacks, so I'm worried that before we finally
> >> fail all of that and resort to accepting more memory, we already fragmented
> >> the already accepted memory, more than necessary.
> > 
> > I'm not sure I follow. We accept memory in pageblock chunks. Do we want to
> > allocate from a free pageblock if we have other memory to tap from? It
> > doesn't make sense to me.
> 
> The fragmentation avoidance based on migratetype does work with pageblock
> granularity, so yeah, if you accept a single pageblock worth of memory and
> then (through __rmqueue_fallback()) end up serving both movable and
> unmovable allocations from it, the whole fragmentation avoidance mechanism
> is defeated and you end up with unmovable allocations (e.g. page tables)
> scattered over many pageblocks and inability to allocate any huge pages.
> 
> >> So one way to prevent would be to move the acceptance into rmqueue() to
> >> happen before __rmqueue_fallback(), which I originally had in mind and maybe
> >> suggested that previously.
> > 
> > I guess it should be pretty straight forward to fail __rmqueue_fallback()
> > if there's non-empty unaccepted_pages list and steer to
> > try_to_accept_memory() this way.
> 
> That could be a way indeed. We do have ALLOC_NOFRAGMENT which could be
> possible to employ here.
> But maybe the zone_watermark_fast() modification would be simpler yet
> sufficient. It makes sense to me that we'd try to keep a high watermark
> worth of pre-accepted memory. zone_watermark_fast() would fail at low
> watermark, so we could try accepting (high-low) at a time instead of single
> pageblock.

Looks like we already have __zone_watermark_unusable_free() that seems
match use-case rather closely. We only need switch unaccepted memory to
per-zone accounting.

The fixup below suppose to do the trick, but I'm not sure how to test
fragmentation avoidance properly.

Any suggestions?

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ca6f0590be21..1bd2d245edee 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -483,7 +483,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #endif
 #ifdef CONFIG_UNACCEPTED_MEMORY
 			     ,
-			     nid, K(node_page_state(pgdat, NR_UNACCEPTED))
+			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 789b77c7b6df..e9c05b4c457c 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -157,7 +157,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	show_val_kb(m, "Unaccepted:     ",
-		    global_node_page_state(NR_UNACCEPTED));
+		    global_zone_page_state(NR_UNACCEPTED));
 #endif
 
 	hugetlb_report_meminfo(m);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9c762e8175fc..8b5800cd4424 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -152,6 +152,9 @@ enum zone_stat_item {
 	NR_ZSPAGES,		/* allocated in zsmalloc */
 #endif
 	NR_FREE_CMA_PAGES,
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	NR_UNACCEPTED,
+#endif
 	NR_VM_ZONE_STAT_ITEMS };
 
 enum node_stat_item {
@@ -198,9 +201,6 @@ enum node_stat_item {
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
-#ifdef CONFIG_UNACCEPTED_MEMORY
-	NR_UNACCEPTED,
-#endif
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e80e8d398863..404b267332a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1779,7 +1779,7 @@ static bool try_to_accept_memory(struct zone *zone)
 
 	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
 	__mod_zone_freepage_state(zone, -1 << order, migratetype);
-	__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -1 << order);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, -1 << order);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	if (last)
@@ -1808,7 +1808,7 @@ static void __free_unaccepted(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	__mod_zone_freepage_state(zone, 1 << order, migratetype);
-	__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, 1 << order);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, 1 << order);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	if (first)
@@ -4074,6 +4074,9 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	unusable_free += zone_page_state(z, NR_UNACCEPTED);
+#endif
 
 	return unusable_free;
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
