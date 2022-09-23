Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5005E85B5
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 00:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiIWWRg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 18:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWWRd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 18:17:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8EC11E97D;
        Fri, 23 Sep 2022 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663971452; x=1695507452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8tE/QBR6Q/gediWIXN96SP8n9NX5gdozFhDqCtkEAms=;
  b=TAAo2GnTWOpEr9PzjxlZtNnsmGcudY2xkDMoZxtefQ23ujLxlN3x6Jlr
   af8/S2hMWxauyr4lHmCuLxiHwSrLKbc1yZooktCiIxZQF5mvNmROz6SzF
   qcb6Ufh/ODWl4iuiXd1dUEJvtMsE2yasJlw2VE24d6cv7aUbPN8mngk+8
   9yl3v/f0fczuQXDYCnZ/bNgv2dr1t8gJqgUg87FUgjJkLyMQxQNWD6isA
   K70jvoiNq8gooiI/3GE1gB5q+iqrH92VXgb4DPAkfyo6IDCR2mC2tLZkC
   nSc0IID/lk1V+KIbhsvwsZotb210PnGMihByL8yz4oMmdn71oEUjf+fjA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="301599009"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="301599009"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 15:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="745954546"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2022 15:17:31 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Date:   Fri, 23 Sep 2022 15:17:30 -0700
Message-Id: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
even have NX support.  Even PAE builds that support NX have to contend
with things like EFI data and code mixed in the same pages where W+X
is unavoidable.

The folks still running X86_32=y kernels are unlikely to care much about
NX.  That combined with the fundamental inability fix _all_ of the W+X
things means this code had little value on X86_32=y.  Disable the checks.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com/
---
 arch/x86/mm/pat/set_memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 20b1e24baa85..efe882c753ca 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -587,6 +587,14 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 {
 	unsigned long end;
 
+	/*
+	 * 32-bit has some unfixable W+X issues, like EFI code
+	 * and writeable data being in the same page.  Disable
+	 * detection and enforcement there.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32))
+		return new;
+
 	/* Only enforce when NX is supported: */
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return new;
-- 
2.34.1

