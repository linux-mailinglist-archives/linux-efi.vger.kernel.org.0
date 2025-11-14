Return-Path: <linux-efi+bounces-5511-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B972AC5C172
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1455E3518A4
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455CE301473;
	Fri, 14 Nov 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC0N4+sC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E95301035;
	Fri, 14 Nov 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110286; cv=none; b=lUtJh45dIUySH/GN3AWWJlmzhqLebZJldNgUkreizShQfRxThZdjaaKqIkE2THkAawfz6vtE/42ZpD0JsmAaQWNd5Uni2pW7PMS6tq4HBpQWkw8djVOuKrUICAIKfXVbaButO8Nhw71QDm9cHzjCWSpss1MyB2d4wAgJBpuV58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110286; c=relaxed/simple;
	bh=7Ml5g5GMw5hImaogyfCGwLHRO/LZ+w2FiswOQQXR/7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuxSfp1BCDHmqJmHpHZUsrx0QC/HyCQPkSMkfa8Dx4X3i+ShLjyr8TQLf07R4LeN8w7q4uz/DpP+EkEBCF/AmMsDSCtz3TUwNTVK3GudcyPkjsKn4ukeerle3MGW4tbmg3k9LRT3L3K+9f5kla4M6xtgKyZFwSTykCUMG9ACCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC0N4+sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E038C4CEFB;
	Fri, 14 Nov 2025 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763110285;
	bh=7Ml5g5GMw5hImaogyfCGwLHRO/LZ+w2FiswOQQXR/7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DC0N4+sCVSEjmRQD36WAiQDt1Mshz+uRKYeQLzf2cQHtW90HVokHMFG3EUjWldgTU
	 09jg0R86G4oJmuG0h635UMsFGaMA4U7V1EI5Wln98IXiNqk7LHcAxmyMf/62UE6OFn
	 olRdeY3rh/mF3yrbfpxSXRv1bh9eAKMzxVaGfB21D4vONW82uRIBplQ44s0mG16YaI
	 wEpxQC5Ml6RTgYDcAJJecask5EStgQCa74Kb/WlsUOfQsqhguJnPrIIAQ8PkhZLvxN
	 sJh9mn0+O0fhv2xT3cuBljtdUSJjQqZNAhJsMxa0hlWsI62D42n7y1CespYcGN8aMP
	 gMJO7tIuWNnXw==
From: Sumit Garg <sumit.garg@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	mark.rutland@arm.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	shivendra.pratap@oss.qualcomm.com,
	leif.lindholm@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 2/2] arm64: efi: Pass reboot cmd parameter to efi_reboot()
Date: Fri, 14 Nov 2025 14:20:58 +0530
Message-ID: <20251114085058.2195900-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114085058.2195900-1-sumit.garg@kernel.org>
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

EFI ResetSystem runtime service allows for platform specific reset type
allowing the OS to pass reset data for the UEFI implementation to take
corresponding action. So lets pass the reboot cmd parameter for the EFI
driver to determine whether it's a platform specific reset requested or
not.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fba7ca102a8c..51784986c568 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -136,7 +136,7 @@ void machine_restart(char *cmd)
 	 * ResetSystem().
 	 */
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		efi_reboot(reboot_mode, NULL);
+		efi_reboot(reboot_mode, cmd);
 
 	/* Now call the architecture specific reboot code. */
 	do_kernel_restart(cmd);
-- 
2.48.1


