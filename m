Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2C164BBB
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSRTr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRTr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:47 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF1524676;
        Wed, 19 Feb 2020 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132786;
        bh=uEL0il3OWfIvRlo9gJQEYnsNyJNOYJQAy652WFH3og8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L12WpsohZFdSZGCow7zI1+nm3paf1fTSMkNBxiCE5nqj7n+QUajl/pUfXvkFkfaEh
         H5pZ/QdArs6X6CHZ9iuyIK+WKHAmA7eXWJkvx4eOJK6/DajncbYB3KRA1l+H3xIhix
         L1lMlhVM/3FS7VojBGWLMrs5RantglPIiUlHbpMI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 5/9] infiniband: hfi1: use EFI GetVariable only when available
Date:   Wed, 19 Feb 2020 18:19:03 +0100
Message-Id: <20200219171907.11894-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the EFI runtime services check with one that tells us whether
EFI GetVariable() is implemented by the firmware.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/infiniband/hw/hfi1/efivar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index d106d23016ba..c22ab7b5163b 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -78,7 +78,7 @@ static int read_efi_var(const char *name, unsigned long *size,
 	*size = 0;
 	*return_data = NULL;
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return -EOPNOTSUPP;
 
 	uni_name = kcalloc(strlen(name) + 1, sizeof(efi_char16_t), GFP_KERNEL);
-- 
2.17.1

