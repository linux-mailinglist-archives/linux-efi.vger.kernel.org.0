Return-Path: <linux-efi+bounces-2635-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B675A125BB
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7141160122
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723D45005;
	Wed, 15 Jan 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcwM/Sx6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3F35958;
	Wed, 15 Jan 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950620; cv=none; b=D4s7rG024Bp5oP36tD1rZ3kuA0wx+Ir1+Id+J2ZhZD1Tse1bWQUWLzL8kfVw2WkWYEVcoqvt09EpbjKbgsei6GWzzKEvwNNu0qHM3xACxgZOCxGWEzZ37wTX0JMhs11jurgQyk8AFN7WkUUqTZQeT58UDBHIlOYI2d1SOXS7gjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950620; c=relaxed/simple;
	bh=rbcdyPUZNFkLVtX5RT4e3NSCN9pmRK9zP4QBk1j88nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWTy8xVkvP6PoD89vkd552uVgGs7sxnP2Egl/hYVY8+r8e3eHM7wlaw77RDiGFHH3yVXqcWCYhYJxBeDpmYABpUc3U5ktduRxE+9zYmM+8qJl9RuxTsW+6zPjFAY6XsT6aCsSa5y47qQzVbDVem8VpAbcGF3xa0klc/IjmlsqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcwM/Sx6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso121648135ad.1;
        Wed, 15 Jan 2025 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736950617; x=1737555417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Yz/4YNAJmEQe+bHvqsoKLsb7NdDyag6+bw5DYwZOyk=;
        b=CcwM/Sx6SIcqPIQ5tAthh7QJPHRDN3k2DU0n3ljx91S5tU3avZsFEZURZcSXhQlZ+c
         XLsLJUgZzWirBT5c2Kdq1XKmixiOGwOFpqDvOqkoh79EFTDPJvSsraSq6zlZvzA2e9rl
         JA/X/CkrcQVlQhANQZAG2eAi259hyTV2M6c/luiwnGhfLlHxi0I/D7OTvnda/hynnSbA
         edIkYfwM1AMGS+LFtuico35TacI156Gbu3r0XkUGxBjCg4xn0E5ZwpN+ORCYIQL2bbt0
         BjnqXWFI1m4UWOEi5Om24S6LghaV9DlPiyQEGfnJTHnDRvLGooTgGCPVGEivLD3VORdw
         s/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736950617; x=1737555417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Yz/4YNAJmEQe+bHvqsoKLsb7NdDyag6+bw5DYwZOyk=;
        b=L8H1iPaypMRlTzQ1O62dI9hIZJ7b9qZCI8eQTda8sIx1OkIv+x8ZqHJGpW62idlLjT
         8oIKaUL74tkeezhn6plaNfoIjdVgQEMXbRlc3F78BI2iqgFIxlF9mGZtmbKA3CLR/url
         3KzB7gua+4gYALIDynSeXvgPthyvybVbSBknTs8jSD3qkPfDE1CnzRXB+r+sPylH8Wpv
         E2PL3MXAe1yT/7NKK2P7g469w9TNSCLhxsX49wWza7oI9H1kC0vG2wm8VgUHADtD5xRo
         LXj5y+i7IPGpCCkfVxiUCba/bQqYczO78vNRfC9TjFAVSZbzr5pSEWjV+QAACkthq9+9
         P4+w==
X-Forwarded-Encrypted: i=1; AJvYcCX85msxK6rwT4VMgxRHh5MfKBJ2S4wBSb5vZnuInDTidq9WUiFgx/AbUUd9SkWDi4NDT5Y8dZLtM6voUWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9JW09doJFgzK+Q3xipxIcnJOxU/TmRVtLzW4BPPrPTxahjLc
	z2WradGj+OOmDYMQqshYk/hE2G7mt8v6ONMK7NfKQL8Fg1MXjrwH
X-Gm-Gg: ASbGncvOvP0zpRMFhKcRiL5R0Zsk6FXWVWprUz1r/7uVa7P+1WocTecyzSPfdSb1VH+
	DNijVW8xNrZD/xpX8AXL+i8AJv5kJgbhJOOf9o5fyV+A1nqTSzaBtbOcgAKmWMwfiDNPqPZHrt+
	zazIrTnHwDOvR0L4Pqu/5mmLQsX+ENxPZHKKtf0x6ALLc+1J02gwWLWBXhHcWW7yxpD5lvve3+Z
	r2nnPbS6g4UCXA3Fj1pBnQa2JOM/KYg8q5svJlJSZTLzEaVdozDsFo8miLntQ==
X-Google-Smtp-Source: AGHT+IF+CC3MVXmez5mTxYi7/GfORVJ/+mlUh0rIvmMjTjvoRYffJHfRmgYGoipTnJGQlJQwgncFqQ==
X-Received: by 2002:a05:6a20:3943:b0:1e8:bd15:6819 with SMTP id adf61e73a8af0-1e8bd156be3mr27651787637.22.1736950617281;
        Wed, 15 Jan 2025 06:16:57 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40568dccsm9184933b3a.47.2025.01.15.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 06:16:56 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] efi: sysfb_efi: guard EFI-specific code with CONFIG_EFI
Date: Wed, 15 Jan 2025 22:16:50 +0800
Message-ID: <20250115141650.3658827-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by the kernel test robot, the following warnings occur:

>> drivers/firmware/efi/sysfb_efi.c:331:39: warning: 'efifb_fwnode_ops' defined but not used [-Wunused-const-variable=]
     331 | static const struct fwnode_operations efifb_fwnode_ops = {
         |                                       ^~~~~~~~~~~~~~~~
>> drivers/firmware/efi/sysfb_efi.c:240:35: warning: 'efifb_dmi_swap_width_height' defined but not used [-Wunused-const-variable=]
     240 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/efi/sysfb_efi.c:190:35: warning: 'efifb_dmi_system_table' defined but not used [-Wunused-const-variable=]
     190 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~

Unused variables, functions, and macro are conditionally compiled under
CONFIG_EFI. This includes 'efifb_fwnode_ops',
'efifb_dmi_swap_width_height[]', 'efifb_dmi_system_table[]',
'efifb_add_links', 'find_pci_overlap_node','efifb_set_system',
'efifb_overlaps_pci_range', and the 'EFIFB_DMI_SYSTEM_ID' macro.

Suppress unused symbol warnings and ensure inclusion only in relevant
configurations.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501051626.SMkizYIE-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/firmware/efi/sysfb_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index cc807ed35aed..4efe383cc470 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -174,6 +174,7 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
 	return 1;
 }
 
+#ifdef CONFIG_EFI
 #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
 	{							\
 		efifb_set_system,				\
@@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 	.add_links = efifb_add_links,
 };
 
-#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)
-- 
2.43.0


