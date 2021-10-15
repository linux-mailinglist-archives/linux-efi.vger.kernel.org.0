Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBD42F20C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Oct 2021 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhJON0M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Oct 2021 09:26:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32192 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239323AbhJON0M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Oct 2021 09:26:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCDR7A022067;
        Fri, 15 Oct 2021 13:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=QgrHz9GaMzKY1YbM+7BWEHWE54Ob64ad0dGBJQHfW2c=;
 b=pAcWNWzoVAy52ULn5NjNbasGrtGeyWQrYeqKdnAQBg8HYNiBwdM7mYLGCDRYw5FQa72t
 Uhxp7tWe1CUi30PT+06DUVsakrwAVhH6wtyZpS3TkA/DW+Z6lvkSWEHKop8sS0aePiRr
 fyIXzJRC5n2RnQ78NPzhpsB7WPaki45M5a46BPB0qrPQqyoIvGfq2cAfuAyUo/4loXaV
 DSFasQvF+PyJGe2+M20bZZTDN1NscVCi4iF3T/ruXz5s0xcyW2x1CMQt6bD+PvW35JBN
 /ZKSTE7ShL2GwMVU5pFkJthfMHceKHXZfoFhTdD/m0Hb8BndJ4VE8udi281PnLutNUQd Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfvegmve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 13:24:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19FDKs5B058577;
        Fri, 15 Oct 2021 13:23:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bmae47425-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 13:23:54 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 19FDNst3071336;
        Fri, 15 Oct 2021 13:23:54 GMT
Received: from t460.home (dhcp-10-175-9-30.vpn.oracle.com [10.175.9.30])
        by aserp3020.oracle.com with ESMTP id 3bmae473vd-1;
        Fri, 15 Oct 2021 13:23:54 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] efi: select CRYPTO for EFI_EMBEDDED_FIRMWARE
Date:   Fri, 15 Oct 2021 15:19:46 +0200
Message-Id: <20211015131946.13374-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UhVRJyX6SpHV_yfbLOBVUdbA1nI6RBob
X-Proofpoint-ORIG-GUID: UhVRJyX6SpHV_yfbLOBVUdbA1nI6RBob
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix the following build warning:

  WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
    Depends on [n]: CRYPTO [=n]
    Selected by [y]:
    - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]

Fixes: f0df68d5bae88 ("efi: Add embedded peripheral firmware support")
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/firmware/efi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36d..f914da9845acc 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -248,6 +248,7 @@ endmenu
 config EFI_EMBEDDED_FIRMWARE
 	bool
 	depends on EFI
+	select CRYPTO
 	select CRYPTO_LIB_SHA256
 
 config UEFI_CPER
-- 
2.23.0.718.g5ad94255a8

