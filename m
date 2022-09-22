Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369025E6BBB
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 21:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIVTcA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIVTcA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 15:32:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C810808D;
        Thu, 22 Sep 2022 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663875119; x=1695411119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/E9F/kZe4totps/FwCcYM7Ti55I6luWBRPyLjUFn72o=;
  b=ZQgftMtfowvhSGHpSN8CSHt8Q+EvOdVUTiaxzaiQGvAqYRggeumO+5Q5
   jcYoH/WG/7Cn+7PoXvHRJyMeR5AiVIbe8pP8B2xh9Q+Q4sv+Q+2mqPZ3x
   UJ9fzAbGx5h1dUgaEDdqo/bqWJ4RAa+tRinl3uaF/W8FwAwQXv7Y1dif0
   NhJ2bPYW793K/vKqAaoELBDf7guj8H/sK6C6ar57yNCY/cmy9PxJ2y+Ii
   9fqX4iD9K5vYYKEw3q6/zxWQxxtZyXzblP2zn3uH9QbcJ9DRbX9yIjTM9
   aZ4i7cP20ea024L3eiamKTXU9BcndRLNPIko/bduY4BJaJmRVe9xMTh13
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283497918"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283497918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688445664"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 12:31:57 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm+efi: Avoid creating W+X mappings
Date:   Thu, 22 Sep 2022 12:31:57 -0700
Message-Id: <20220922193157.1673623-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

I'm planning on sticking this in x86/mm so that it goes upstream
along with the W+X detection code.

--

A recent x86/mm change warns and refuses to create W+X mappings.

The 32-bit EFI code tries to create such a mapping and trips over
the new W+X refusal.

Make the EFI_RUNTIME_SERVICES_CODE mapping read-only to fix it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/all/d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net/
---
 arch/x86/platform/efi/efi_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index e06a199423c0..d81e379fcd43 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -136,6 +136,7 @@ void __init efi_runtime_update_mappings(void)
 			if (md->type != EFI_RUNTIME_SERVICES_CODE)
 				continue;
 
+			set_memory_ro(md->virt_addr, md->num_pages);
 			set_memory_x(md->virt_addr, md->num_pages);
 		}
 	}
-- 
2.34.1

