Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7948BF4E8
	for <lists+linux-efi@lfdr.de>; Thu, 26 Sep 2019 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfIZOT6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Sep 2019 10:19:58 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:15098 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIZOT5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Sep 2019 10:19:57 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 10:19:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1569507596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mQvPFse3w+s0uK80XprrGzqDEhnYGYER/mAVNdleSwU=;
  b=NP0w8y1RwnBWpHQHdNYQgJkXoSTNc/tomzbWtZIi03hsMgGmGCwnPQ9r
   R0hvEiWyjFJ1vyq/b/lWVMATaWJjpmR3mVxqWCvXm/XcZlmNePUQyUO9l
   HBPfReIKvH4EfYMXv0/Z3vqcJcBFyH/1KZEYs2XjolamkBvQagjyxhQtr
   M=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=ross.lagerwall@citrix.com; spf=Pass smtp.mailfrom=ross.lagerwall@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  ross.lagerwall@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="ross.lagerwall@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  ross.lagerwall@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="ross.lagerwall@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: BOnG5Zh9TXKxTyxuCF9+N0ix41AG3MFkVpivV34zKTew6GEZ2P35uyjvI6SCbFrPM0qBOL/qOU
 1BoA0yFYh11nK/aWWRECc8giHOnn1OgAX/89CeXiO307uSkVaf8vwZVY2J366IpTRnwiuCF/pj
 rowQsT2G4d2+Lbyjchk4v5ajpI8Ytl4/aSFyrQCp3B7WVe8H3FEc0Ki8Ku22yMyQJgxut5iTkm
 9QMmdtoKyjOzs+WsrtfqisqLBKwRbAuWvCPqw7w9AhGv+VT562xloKGvpE2/s9g7Nu9WnbwxFq
 HbA=
X-SBRS: 2.7
X-MesageID: 6396973
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,552,1559534400"; 
   d="scan'208";a="6396973"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-efi@vger.kernel.org>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] x86/efi: Don't require non-blocking EFI callbacks
Date:   Thu, 26 Sep 2019 15:12:34 +0100
Message-ID: <20190926141234.8271-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If a backend does not implement non-blocking EFI operations, it implies
that the normal operations are non-blocking. Instead of crashing
dereferencing a NULL pointer, fallback to the normal operations since it
is safe to do so.

Fixes: 5a58bc1b1edc ("efi/x86: Use non-blocking SetVariable() for efi_delete_dummy_variable()")
Fixes: ca0e30dcaa53 ("efi: Add nonblocking option to efi_query_variable_store()")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 arch/x86/platform/efi/quirks.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd679cea9..4167f5e8f3e8 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -106,11 +106,13 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
 */
 void efi_delete_dummy_variable(void)
 {
-	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
-				     &EFI_DUMMY_GUID,
-				     EFI_VARIABLE_NON_VOLATILE |
-				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
+	efi_set_variable_t *set_variable = efi.set_variable_nonblocking ?:
+					   efi.set_variable;
+
+	set_variable((efi_char16_t *)efi_dummy_name, &EFI_DUMMY_GUID,
+		     EFI_VARIABLE_NON_VOLATILE |
+		     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+		     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
 /*
@@ -127,10 +129,12 @@ query_variable_store_nonblocking(u32 attributes, unsigned long size)
 {
 	efi_status_t status;
 	u64 storage_size, remaining_size, max_size;
+	efi_query_variable_info_t *query_variable_info =
+		efi.query_variable_info_nonblocking ?:
+		efi.query_variable_info;
 
-	status = efi.query_variable_info_nonblocking(attributes, &storage_size,
-						     &remaining_size,
-						     &max_size);
+	status = query_variable_info(attributes, &storage_size,
+				     &remaining_size, &max_size);
 	if (status != EFI_SUCCESS)
 		return status;
 
-- 
2.21.0

