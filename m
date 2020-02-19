Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE30164BC3
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBSRT7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBSRT7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:59 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B4122467B;
        Wed, 19 Feb 2020 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132798;
        bh=E/PcfT9bzCiG6jJeBiaKC/Y8ja54FFFZo6IyIkCdiZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+p/U9s3H8PIHXnElTWRGV9ZE0R4iH6d+ZOZEXFVT87vtgtzTWV68AJaXj9gzkgup
         uElLFK4WvwZbbbxeaDO9YUq2FQeS44FCrzulsHzJbSMz2dwCiPA7Qr0vHfdKgOEjZT
         pDJaLq2It30lH9rzpFCUReGlWPANGyfzN/7aboKI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 9/9] integrity: check properly whether EFI GetVariable() is available
Date:   Wed, 19 Feb 2020 18:19:07 +0100
Message-Id: <20200219171907.11894-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Testing the value of the efi.get_variable function pointer is not
the right way to establish whether the platform supports EFI
variables at runtime. Instead, use the newly added granular check
that can test for the presence of each EFI runtime service
individually.

Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 security/integrity/platform_certs/load_uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56e..e2fe1bd3abb9 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -76,7 +76,7 @@ static int __init load_uefi_certs(void)
 	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
 	int rc = 0;
 
-	if (!efi.get_variable)
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return false;
 
 	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
-- 
2.17.1

