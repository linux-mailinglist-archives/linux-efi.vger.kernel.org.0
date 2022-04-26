Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D452750F0CE
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 08:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiDZGUK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 02:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiDZGUI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 02:20:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD7101FC;
        Mon, 25 Apr 2022 23:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B5C0B81B3A;
        Tue, 26 Apr 2022 06:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B91C385A0;
        Tue, 26 Apr 2022 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953819;
        bh=ANH3UTZLZ+hrLRQUGigFumQFldVbaQC5gsVuGlcgcGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWgfMDM+ZJ60+fK3LlOiWlrEb0jOc3QwdWyzxmKvqG2Qstz4rqSTKh/b5UVRorkvr
         rdo5xaJI7jflFyoYq1LYu1ds9aY9rpiEr6XtxisLN+Tbeq4A4ReBcJlixUNFKOtCVA
         Cg4bgDpHANgPWx9q9PECu8I0tSOwwbtuQ0KK7AuPKlmCEFmX1VAi8KPLs4W1t4DNtO
         a19ZR22jmqTtZ+a1FPq499wlc1vDaUqawRFizxC0ImwB3Aerlr5Jg6b2GstX66J9JL
         UOynuNg+6YXYNG/XGKs1rl6UpJs7w1AGIWxr2+WndT28AZ91UHh0nzhonGdw3a1jN0
         2SIyHBB1zSLZQ==
Date:   Tue, 26 Apr 2022 09:16:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v7 2/8] mm/mmzone: Tag pg_data_t with crypto capabilities
Message-ID: <YmeOUEyGIp6HPCM4@kernel.org>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-3-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425171526.44925-3-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 02:15:20PM -0300, Martin Fernandez wrote:
> Add a new member in the pg_data_t struct to tell whether the node
> corresponding to that pg_data_t is able to do hardware memory
> encryption.
> 
> This will be read from sysfs.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mmzone.h | 3 +++
>  mm/page_alloc.c        | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 46ffab808f03..89054af9e599 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -886,6 +886,9 @@ typedef struct pglist_data {
>  	struct task_struct *kcompactd;
>  	bool proactive_compact_trigger;
>  #endif
> +
> +	bool crypto_capable;
> +
>  	/*
>  	 * This is a per-node reserve of pages that are not available
>  	 * to userspace allocations.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..a244151045b4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7699,6 +7699,7 @@ static void __init free_area_init_node(int nid)
>  	pgdat->node_id = nid;
>  	pgdat->node_start_pfn = start_pfn;
>  	pgdat->per_cpu_nodestats = NULL;
> +	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
>  
>  	if (start_pfn != end_pfn) {
>  		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
