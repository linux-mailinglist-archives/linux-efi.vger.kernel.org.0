Return-Path: <linux-efi+bounces-4112-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D1AF89B3
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 09:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0000588326
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6D283128;
	Fri,  4 Jul 2025 07:40:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D1281366;
	Fri,  4 Jul 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614835; cv=none; b=uxUOViY+DM0BMeCatpnJAiNzvLNTogtymUlgfRIV8zWDQWMRMj2G59H0fFZliSIKq1ZY8LscomS6DmX7/JK9Z46x9rRCWtnAoYaJwHkP8WuIFsf3t9jsZUxTlPGO38GfNrk4IKMuX12wR1+3fffdIArt3iIhR6sBYYXjY16lt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614835; c=relaxed/simple;
	bh=EhK+9hAf8j3eh4CjyTaHOFdygunU/xE6sAbakQJe0fY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHWSw91Rx/ryKX9OLGkxRwswkhDy4wMxDBZBcfx10Qu3SM7o3UriLneZ9kOmE8CwSJlCoTJc91kKQGfy3YB0gmgENsW4AdpKfPDfdc81ufEXus/dv+FPU91RuLRapZ3ixWgmxfDavGVPzjWHtMfK6whG7pBDN6WKYiOS+Sz8lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bYQWF3k8PztS35;
	Fri,  4 Jul 2025 15:39:21 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id F298D140258;
	Fri,  4 Jul 2025 15:40:28 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 15:40:28 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <keyrings@vger.kernel.org>, Lu Jialin
	<lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH v4 0/2] integrity: Extract secure boot enquiry function out of IMA
Date: Fri, 4 Jul 2025 15:51:12 +0800
Message-ID: <20250704075114.3709609-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg100016.china.huawei.com (7.202.181.57)

v4:
- Rename secureboot.c to efi_secureboot.c, as Mimi suggested.
v3:
- Redesign the implementation. Keep the name of arch_ima_get_secureboot
  to escape from the morass consisted of multiple arch and configs.
- Rephrase the commit message.
v2:
- Fix compile errors for CONFIG_IMA_ARCH_POLICY=n on s390 & powerpc

---

Hi,

We encountered a boot failure issue in an in-house testing, where the
kernel refused to load its modules since it couldn't verify their
signature. The root cause turned out to be the early return of
load_uefi_certs(), where arch_ima_get_secureboot() returned false
unconditionally due to CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n, even
though the secure boot was enabled.

This patch set attempts to remove this implicit dependency by shifting
the functionality of efi secure boot enquiry from IMA to the integrity
subsystem, so that both certificate loading and IMA can make use of it
independently.

The code has been compile-tested on x86/arm64/powerpc/s390, with as much
as config combinations I can think of.

-Ruiqi

GONG Ruiqi (2):
  x86/efi: Rename IMA-related function and macro of boot mode
  integrity: Extract secure boot enquiry function out of IMA

 arch/x86/include/asm/efi.h                    |  4 +-
 arch/x86/platform/efi/efi.c                   |  2 +-
 include/linux/integrity.h                     |  1 +
 security/integrity/Makefile                   |  1 +
 security/integrity/efi_secureboot.c           | 46 +++++++++++++++++++
 security/integrity/ima/ima_efi.c              | 42 +----------------
 security/integrity/platform_certs/load_uefi.c |  3 +-
 7 files changed, 54 insertions(+), 45 deletions(-)
 create mode 100644 security/integrity/efi_secureboot.c

-- 
2.25.1


