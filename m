Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1A2C0E83
	for <lists+linux-efi@lfdr.de>; Mon, 23 Nov 2020 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbgKWPL4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Nov 2020 10:11:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:5778 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389411AbgKWPL4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Nov 2020 10:11:56 -0500
IronPort-SDR: oeC1jl5ZbHWIU38pOofx89Yv38VAJuUqS4zFqoHI170uDteIcshxF+U2QtSopoqkqRotcYOZ2p
 vkt/4pVlrtRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="189897423"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="189897423"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 07:11:56 -0800
IronPort-SDR: uyuIbRRmxDGAqSnrGrW5/VcM0s49NC+ICHKAZ/Zg2Cvt3Es6UlgrX8rqA87BqCMs/5HEu5DJ6C
 XPZynEcMuqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="402628595"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
  by orsmga001.jf.intel.com with ESMTP; 23 Nov 2020 07:11:54 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] efi/efivars: Set generic ops before loading SSDT
Date:   Mon, 23 Nov 2020 12:28:17 -0500
Message-Id: <20201123172817.124146-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Efivar allows for overriding of SSDT tables, however starting with
commit bf67fad19e493b ("efi: Use more granular check for availability for variable services")
this use case is broken. When loading SSDT generic ops should be set
first, however mentioned commit reversed order of operations. Fix this
by restoring original order of operations.

Fixes: bf67fad19e493b ("efi: Use more granular check for availability for variable services")
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5e5480a0a32d..6c6eec044a97 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -390,10 +390,10 @@ static int __init efisubsys_init(void)
 
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
 				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
-		efivar_ssdt_load();
 		error = generic_ops_register();
 		if (error)
 			goto err_put;
+		efivar_ssdt_load();
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 
-- 
2.25.1

