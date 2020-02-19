Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE5164BC2
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSRT5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBSRT4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:56 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6941D24680;
        Wed, 19 Feb 2020 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132795;
        bh=h+tuakNcgoRmbltb5wRmkwf67McBEmqsj9caQdfjLLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEYIGo7HMdb2atbEUkgTmvlk5AGebqyp10o7t+KNvNLe+pTSuPMGBwIOadFPWfXOm
         PRxfjwYsDhT1qWd++yX31ad+WDozEKoBVRtFpA4pPxGr35l0Vld9E/FMhCNxdHZh7k
         K3uscsaA/ECnu48wrWGnwLpo3wbgBQS2VMU36JcA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org
Subject: [PATCH 8/9] x86/ima: use EFI GetVariable only when available
Date:   Wed, 19 Feb 2020 18:19:06 +0100
Message-Id: <20200219171907.11894-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the EFI runtime services check with one that tells us whether
EFI GetVariable() is implemented by the firmware.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/ima_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 4d4f5d9faac3..cb6ed616a543 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -19,7 +19,7 @@ static enum efi_secureboot_mode get_sb_mode(void)
 
 	size = sizeof(secboot);
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
 		pr_info("ima: secureboot mode unknown, no efi\n");
 		return efi_secureboot_mode_unknown;
 	}
-- 
2.17.1

