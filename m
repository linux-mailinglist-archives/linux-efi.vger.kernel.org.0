Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950D22A36A2
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 23:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKBWic (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 17:38:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgKBWic (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 17:38:32 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC5820870;
        Mon,  2 Nov 2020 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604356711;
        bh=KVk3UfB7fHvlt+4j/Zyd5nzE1y9+9mnY2YhO3zMimQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxtt0ti6RiEIR1iAyKE9/phzwtWG0D4yC7rCIMiFhrH+cry1E+GMVlqgFBgfPKsjd
         V4BGj3Qefv7UQ5bu3aD17aNDhYa0I4WZB6gYvjT5sH5P/3JJVPYXqGQ3Wx6CbxikOo
         VdNz9W2QyYOdN92DZlDcDMqTVDJVMYJs71XZfy1c=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, clin@suse.com,
        x86@kernel.org, jlee@suse.com, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] arm64/ima: add ima_arch support
Date:   Mon,  2 Nov 2020 23:38:00 +0100
Message-Id: <20201102223800.12181-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102223800.12181-1-ardb@kernel.org>
References: <20201102223800.12181-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Chester Lin <clin@suse.com>

Add arm64 IMA arch support. The code and arch policy is mainly inherited
from x86.

Co-developed-by: Chester Lin <clin@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f858c352f72a..ea1b608a0fad 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -200,6 +200,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT if EFI
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
2.17.1

