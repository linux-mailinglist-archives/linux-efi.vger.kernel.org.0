Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3768F1E7
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBHPXR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 10:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjBHPXQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 10:23:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B54671C
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869795; x=1707405795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+6lc2JZe7pOZJ+ZEzzeo5NMYX3WZ0aaZEmIs4Fc6h+c=;
  b=Mb9KXnAqqVUzFWEL45o8obW6aEc7HhNFkjZMT40BIuC5at8HrCDL/fvs
   F5kwz2yun1CUYa/rHvwcqT3xlQSItrWDoT1Ckfw0/6100tdfTLPLmnco+
   P2rwMpZ212sOTJBSnnncs3F99aHBp+fOX+HMU+WXpsM/zPKvPCPZ2MXh6
   TzqXRIlKMDpe5BqTdhmnVMcAO6nMNnHKlXbeoChWecGZX3/KQtptl7JHn
   GMiBjlhepfS/eiab28MBIZ6lYgiT/O4bHn9bOYuZm65Ffqv+KiUIyqEiz
   Lt4VHN0moMUJQKN3jK4IwrxEeqHIHitz6ec7bm+GebgNPjfQp98IAf13Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416045857"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416045857"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:17:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669224186"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669224186"
Received: from tbacklun-mobl.amr.corp.intel.com (HELO [10.209.14.225]) ([10.209.14.225])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:17:16 -0800
Message-ID: <ca9dc359-899b-ec69-36e0-17225189da01@intel.com>
Date:   Wed, 8 Feb 2023 07:17:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-4-ardb@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230206124938.272988-4-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/6/23 04:49, Ard Biesheuvel wrote:
> --- a/arch/x86/kernel/apm_32.c
> +++ b/arch/x86/kernel/apm_32.c
> @@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
>  
>  	apm_irq_save(flags);
>  	firmware_restrict_branch_speculation_start();
> -	ibt = ibt_save();
> +	ibt = ibt_save(true);

My only nit with these is the bare use of 'true'/'false'.  It's
impossible to tell at the call-site what the 'true' means.  So, if you
happen to respin these and see a nice way to remedy this I'd appreciate it.

But they're still OK as-is.  For the x86 bits:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
