Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40432580F24
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiGZIfZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiGZIfS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 04:35:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885D63A9;
        Tue, 26 Jul 2022 01:35:14 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4ff2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4ff2:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 283591EC0742;
        Tue, 26 Jul 2022 10:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658824509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbGGwlLz+4u+Zu8n20tu0HQUB8+NXWLykgI1BXt6grw=;
        b=rju7UCtGhWP7yXchLevSbfjGlUD2yJqzHeO1sy6CAn17oz9P/fyddj8BSC7XSH4kqa2V6n
        BhButB0IIgBHJkMm4uUND4GmR2jkmZR4bRSCrUHPEKVQzVia1BJNiX6Riw3JLr710WWG8O
        CjPORjcdEVdRUNKGCJRFaoJcLSwjJFQ=
Date:   Tue, 26 Jul 2022 10:35:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 06/14] efi/x86: Implement support for unaccepted memory
Message-ID: <Yt+nOeLMqRxjObbx@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220614120231.48165-7-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 03:02:23PM +0300, Kirill A. Shutemov wrote:
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 7aa4717cdcac..e1270beff4dc 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -305,6 +305,20 @@ config EFI_COCO_SECRET
>  	  virt/coco/efi_secret module to access the secrets, which in turn
>  	  allows userspace programs to access the injected secrets.
>  
> +config UNACCEPTED_MEMORY
> +	bool
> +	depends on EFI_STUB
> +	help
> +	   Some Virtual Machine platforms, such as Intel TDX, require
> +	   some memory to be "accepted" by the guest before it can be used.
> +	   This mechanism helps prevent malicious hosts from making changes
> +	   to guest memory.
> +
> +	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
> +
> +	   This option adds support for unaccepted memory and makes such memory
> +	   usable by the kernel.
> +

This looks weird:

$ grep EFI_STUB .config
CONFIG_EFI_STUB=y
$ grep UNACCEPTED_MEMORY .config
$

So the bool needs to have a text string after it so that it is
selectable or how is UNACCEPTED_MEMORY supposed to be enabled otherwise?

If I add the string and select UNACCEPTED_MEMORY, it won't build:

mm/page_alloc.c: In function ‘accept_page’:
mm/page_alloc.c:1013:9: error: implicit declaration of function ‘accept_memory’ [-Werror=implicit-function-declaration]
 1013 |         accept_memory(start, start + (PAGE_SIZE << order));
      |         ^~~~~~~~~~~~~
mm/page_alloc.c: In function ‘page_contains_unaccepted’:
mm/page_alloc.c:1029:16: error: implicit declaration of function ‘range_contains_unaccepted_memory’; did you mean ‘page_contains_unaccepted’? [-Werror=implicit-function-declaration]
 1029 |         return range_contains_unaccepted_memory(start, end);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                page_contains_unaccepted
mm/memblock.c: In function ‘memblock_alloc_range_nid’:
mm/memblock.c:1415:9: error: implicit declaration of function ‘accept_memory’ [-Werror=implicit-function-declaration]
 1415 |         accept_memory(found, found + size);
      |         ^~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:249: mm/memblock.o] Error 1
make[1]: *** Waiting for unfinished jobs....
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:249: mm/page_alloc.o] Error 1
make: *** [Makefile:1843: mm] Error 2
make: *** Waiting for unfinished jobs....

so this is weird.

> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 504955368934..b91c89100b2d 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -15,6 +15,7 @@
>  #include <asm/setup.h>
>  #include <asm/desc.h>
>  #include <asm/boot.h>
> +#include <asm/unaccepted_memory.h>
>  
>  #include "efistub.h"
>  
> @@ -607,6 +608,17 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>  			e820_type = E820_TYPE_PMEM;
>  			break;
>  
> +		case EFI_UNACCEPTED_MEMORY:
> +			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +				efi_warn_once("The system has unaccepted memory,"
> +					     " but kernel does not support it\n");
> +				efi_warn_once("Consider enabling CONFIG_UNACCEPTED_MEMORY\n");
> +				continue;
> +			}

So that it can be grepped for:

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index b91c89100b2d..8be6b675e08e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -610,9 +610,8 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 
 		case EFI_UNACCEPTED_MEMORY:
 			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
-				efi_warn_once("The system has unaccepted memory,"
-					     " but kernel does not support it\n");
-				efi_warn_once("Consider enabling CONFIG_UNACCEPTED_MEMORY\n");
+				efi_warn_once(
+"The system has unaccepted memory, but kernel does not support it.\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
 				continue;
 			}
 			e820_type = E820_TYPE_RAM;


Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
