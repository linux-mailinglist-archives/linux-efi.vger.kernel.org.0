Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3E50DA9E
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 09:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiDYH4a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiDYH4X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 03:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793712AB4;
        Mon, 25 Apr 2022 00:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69E4C61331;
        Mon, 25 Apr 2022 07:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14306C385A7;
        Mon, 25 Apr 2022 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650873152;
        bh=Fg1WqVAMNY8WOgqmVB7ITNAhO7ifkkAD/qCAn6UEtfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSFXlItEEANiPoHLNWdCfffltXjAiNHs7oGX1UrOdmq0rypik/36SmrRxzp7VlX23
         H1My8g+yi35giPVFpJD0Gm3ort/FjDvu2v1UR1hF1ly+rFnkZfnUSToQMRwZBX9UM0
         iCXwgGFWFPsrvCfOemhTmyQotPmrQwaxBb6wHS4LOGdQ3BLrxpf61e9VZO6RiWPwnK
         zelJ5GAEzCEG6/Vnm7mOjHeFztYvTr+lg596r2QGxCGMqb6K4QtF6gVVDWxo+iec+5
         HcsNQ0ITXgV7z+V52LEbQP3gf4qMJffFW6LnL5gdIjFvpmJ9agE3x1TfJDaxThyosR
         N8VK7aN8ON6iw==
Date:   Mon, 25 Apr 2022 10:52:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 01/12] x86/boot/: Centralize __pa()/__va() definitions
Message-ID: <YmZTNqub6dYHb1iV@kernel.org>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:23AM +0300, Kirill A. Shutemov wrote:
> Replace multiple __pa()/__va() definitions with a single one in misc.h.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/x86/boot/compressed/ident_map_64.c | 8 --------
>  arch/x86/boot/compressed/misc.h         | 9 +++++++++
>  arch/x86/boot/compressed/sev.c          | 2 --
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index f7213d0943b8..fe523ee1a19f 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -8,14 +8,6 @@
>   * Copyright (C)      2016  Kees Cook
>   */
>  
> -/*
> - * Since we're dealing with identity mappings, physical and virtual
> - * addresses are the same, so override these defines which are ultimately
> - * used by the headers in misc.h.
> - */
> -#define __pa(x)  ((unsigned long)(x))
> -#define __va(x)  ((void *)((unsigned long)(x)))
> -
>  /* No PAGE_TABLE_ISOLATION support needed either: */
>  #undef CONFIG_PAGE_TABLE_ISOLATION
>  
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index ea71cf3d64e1..9f7154a30d37 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -19,6 +19,15 @@
>  /* cpu_feature_enabled() cannot be used this early */
>  #define USE_EARLY_PGTABLE_L5
>  
> +/*
> + * Boot stub deals with identity mappings, physical and virtual addresses are
> + * the same, so override these defines.
> + *
> + * <asm/page.h> will not define them if they are already defined.
> + */
> +#define __pa(x)  ((unsigned long)(x))
> +#define __va(x)  ((void *)((unsigned long)(x)))
> +
>  #include <linux/linkage.h>
>  #include <linux/screen_info.h>
>  #include <linux/elf.h>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 28bcf04c022e..4dcea0bc4fe4 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -106,9 +106,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  }
>  
>  #undef __init
> -#undef __pa
>  #define __init
> -#define __pa(x)	((unsigned long)(x))
>  
>  #define __BOOT_COMPRESSED
>  
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
