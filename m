Return-Path: <linux-efi+bounces-2997-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483EAA6491F
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C486016E711
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A5235BE5;
	Mon, 17 Mar 2025 10:13:57 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7D235360;
	Mon, 17 Mar 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206437; cv=none; b=TH4WmmtslXcfug0LEI6FJFz9ZAlsNOZyKQIHHyGZz9mAXQ30HyU7WxB38wqfndLyUKOrATI14flPEUde0Thjzxa1jblCGmf7/J+FmYCvuA1VtFPvrzP8tWt/CV11R8CMMSxcN1nQ8nXXA4Ewswin1EmFcZBrp5SX4aIyVrzQoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206437; c=relaxed/simple;
	bh=VEokSnJyXhEftEdyfwGq561rgvWcBLhUDuj1r+l6rgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jF7QW8qqOdSNovS5olfWlTkIwmjfRRigQ6v3sCsFjElfBrT7MHHb77SGOJiqCgvmo/IozJSrdpUrWSQdXB6YkMz4ZG5eLaXzPmEU0mXL/LodpbKqGv1QzRUjgDVx/GQfTnNdlW+K783T8FRjk4ZQdktoe3aLN1XcgnV6ojqEVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B67A3169E;
	Mon, 17 Mar 2025 03:14:04 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6F0D3F673;
	Mon, 17 Mar 2025 03:13:54 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:15 +0000
Subject: [PATCH 3/9] efi: Remove redundant creation of the "efivars"
 platform device
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-3-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=VEokSnJyXhEftEdyfwGq561rgvWcBLhUDuj1r+l6rgs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/Xb8mFJLpEV+BhIVgycTArbsBBiSD4DZ+jOf
 qb6lqCzxdyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mKiAD/9eS/QzJomSLZGIIvoB2Xft1eCCfIJ9MHNOGSAyiYGUUQdgMNbhKU6WSBErRXJ29MVHIm6
 RKf8gKO0AmycYRuNT5OJYxDryIfGFRw72BYS8bb2PbHtWsbPKppb7Mf0zu2ELBtTvkrB+azesJo
 5+WFz8caY01SVQJMDN6071RiTA0/b4GMkQcT39EMGwvnkN9oMe4lP5gPFhUkpSgHreZEdR22C6i
 9SHeQlRjW3D+NTBuI+XgcIiPuI6mhxCDFEXh+CvxVmGulrSsno6kJKl28ciOqVzvXdT6kldSeMl
 VzulCOHD144uw7Cdd9ol4Ql3byCmcqlJAj/E4GYcT0W3gQZe+iG/kvTdLgfgOC9+btKWN7zrUKS
 mpaeRm25sM73daoBKSqbew++xyyOMhrzewzML0i6L07572YOelE8uLXNTmgXLCMZ8oQrM1/zwuE
 Ui2LYf+7suP83xYCTRT4fCGLo/8vkoDFpJq4I9JovlSv+XcBvWfSEfDmlyHjyukyUBKJm0i6ObL
 4O2YBy6Zit2pG/drAFU8M0HDNSGVKAiHKggdknATOyeIKb41WU2O+/SClwRVBKsGW1vbclzmoa/
 BlJ11U48D5wrEtXGMIgiQBYDQGjRaovJWZRFo7O9hNhraC6/RO24VZF7Xc6FXiZ3vzoVQLA6iTi
 4YwqYKJMxNzvk1g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The "efivars" platform device is created but never tracked or used,
as there is no driver associated with it. Since this device serves
no functional purpose, removing its creation without affecting any
functionality.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/efi/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7309394b8fc98cf7a3424af209b752f0251c8c89..eec173cb1f398d3b4f28b42c917e50e1728dc277 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -446,7 +446,6 @@ static int __init efisubsys_init(void)
 		error = efivar_ssdt_load();
 		if (error)
 			pr_err("efi: failed to load SSDT, error %d.\n", error);
-		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);

-- 
2.34.1


