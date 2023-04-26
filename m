Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F236EF255
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbjDZKmJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZKmI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 06:42:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BFF4C33;
        Wed, 26 Apr 2023 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682505728; x=1714041728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLwcUviicm5zFgsdk4z3rBcMK/+14kP8fClgG+/9Z2M=;
  b=dNv7BFAzIKdxgWxVlUhVCM4SfdWM593xamuABXu7lCPUtbzP8FeKiiBP
   54rcNdPOEJYNTZfNFISXflQoi0reIuo7gwE5X+HnW3e6bv+uQGKJll13p
   rlmjGV1gHg+i8srQfhdYzQD6VBbCT5k3Ty4pMAPKAkEywvIUe52snJQlb
   DC1vUGGGSgNfv7OX9Pahv/cs3YI5jEjaHON8lksGn0zUWXo7yw3x0rJZg
   guY7jGW+HX+HvBvZ+pbNYYmgTV4D9A4MgXvjWKlGdJr5rp6QUXsJ+G/n0
   W8XDNFBQHScqQeBoPpv7gQttAr35bXTSX8gyLKMdrrfldlyTEqRSE+ixH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="349873704"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="349873704"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 03:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="758563453"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="758563453"
Received: from schoenfm-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.34.172])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 03:42:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 665AC10CDFB; Wed, 26 Apr 2023 13:42:00 +0300 (+03)
Date:   Wed, 26 Apr 2023 13:42:00 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/6] x86: efistub: Perform 4/5 level paging switch from
 the stub
Message-ID: <20230426104200.drmuewhwmhh3xljh@box.shutemov.name>
References: <20230424165726.2245548-1-ardb@kernel.org>
 <20230424165726.2245548-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424165726.2245548-5-ardb@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 24, 2023 at 06:57:24PM +0200, Ard Biesheuvel wrote:
> In preparation for updating the EFI stub boot flow to avoid the bare
> metal decompressor code altogether, implement the support code for
> switching between 4 and 5 levels of paging before jumping to the kernel
> proper.

I must admit it is neat. I like it a lot.

Any chance we can share the code with the traditional decompressor?
There's not much that EFI specific here. It should be possible to isolate
it from the rest, no?


> @@ -792,6 +925,14 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>  				(get_efi_config_table(ACPI_20_TABLE_GUID) ?:
>  				 get_efi_config_table(ACPI_TABLE_GUID));
>  
> +#ifdef CONFIG_X86_64
> +	status = efi_setup_5level_paging();
> +	if (status != EFI_SUCCESS) {
> +		efi_err("efi_setup_5level_paging() failed!\n");
> +		goto fail;
> +	}
> +#endif
> +
>  	/*
>  	 * If the kernel isn't already loaded at a suitable address,
>  	 * relocate it.
> @@ -910,6 +1051,10 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>  		goto fail;
>  	}
>  
> +#ifdef CONFIG_X86_64
> +	efi_5level_switch();
> +#endif
> +
>  	return bzimage_addr;
>  fail:
>  	efi_err("efi_main() failed!\n");

Maybe use IS_ENABLED() + dummy efi_setup_5level_paging()/efi_5level_switch()
instead of #ifdefs?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
