Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A00164BBD
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBSRTu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRTu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:50 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E07C24656;
        Wed, 19 Feb 2020 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132790;
        bh=M4r2Ez8Ut7guqGx0FgNf2afCC29E2/mHpY61lj2zi2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVh769Q66PKvWmXOtHZCOavCS6fMoGlEmkjIVgVApkiaV+6PYHCzRxvcMeTgyuMXz
         EExeUbAlJhdGRTL4ChntqilB1MEkdi5+5HKsC8N8pqXFQecOZOyL6x1E11HNrAjm53
         aUS2ij0p8GYOW+IjChiiFHC3AgZzyIld2ZZniqM8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 6/9] scsi: iscsi: use EFI GetVariable only when available
Date:   Wed, 19 Feb 2020 18:19:04 +0100
Message-Id: <20200219171907.11894-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the EFI runtime services check with one that tells us whether
EFI GetVariable() is implemented by the firmware.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/scsi/isci/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index b48aac8dfcb8..974c3b9116d5 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -621,7 +621,7 @@ static int isci_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 	pci_set_drvdata(pdev, pci_info);
 
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		orom = isci_get_efi_var(pdev);
 
 	if (!orom)
-- 
2.17.1

