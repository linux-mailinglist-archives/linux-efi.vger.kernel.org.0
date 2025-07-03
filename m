Return-Path: <linux-efi+bounces-4094-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB503AF6721
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 03:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B7C189AD5E
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546E24B26;
	Thu,  3 Jul 2025 01:34:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A741853;
	Thu,  3 Jul 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506440; cv=none; b=XxTOnfNUVWBhTDQ+OfyKMutEbkG3NQLQWQv4HidMHddkKsteNcp0vqJLF7A0LpnIEa8KzGbdfVbUsEF8IMB4jttoEtXBotBU6TT6jHaSblhDNXNJ+A4F2txDB8I6SSQNPa52d3Z8/Py9tePkSBqc5p2q9Qc4qE3AjpZL6afOBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506440; c=relaxed/simple;
	bh=wB63E55R6GEbdZL69RCytBGhgs7kgufcm+3PucP2thk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPfvliJ6RgyHfaM3jogR2dQ6vSPcsx2flcgTnRIgRF1l0SMJbYu2rBZ3ayyRIeOJGqCLIgY7b0VxUvhodxnH7n8ejVJ4EMb1+WZ4sBgSynsHU8Zymj3Um3tcL3vn+NmmG6gjPzJgRDEb76A2KmyDuQb/uyEeQQsnGJjxyyaXBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bXfQl0FsWztSk4;
	Thu,  3 Jul 2025 09:32:47 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B1F001400E3;
	Thu,  3 Jul 2025 09:33:54 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 3 Jul
 2025 09:33:53 +0800
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
Subject: [PATCH v3 0/2] integrity: Extract secure boot enquiry function out of IMA
Date: Thu, 3 Jul 2025 09:43:51 +0800
Message-ID: <20250703014353.3366268-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg100016.china.huawei.com (7.202.181.57)

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

-Ruiqi

GONG Ruiqi (2):
  x86/efi: Rename IMA-related function and macro of boot mode
  integrity: Extract secure boot enquiry function out of IMA

 arch/x86/include/asm/efi.h                    |  4 +-
 arch/x86/platform/efi/efi.c                   |  2 +-
 include/linux/integrity.h                     |  1 +
 security/integrity/Makefile                   |  1 +
 security/integrity/ima/ima_efi.c              | 42 +----------------
 security/integrity/platform_certs/load_uefi.c |  3 +-
 security/integrity/secureboot.c               | 46 +++++++++++++++++++
 7 files changed, 54 insertions(+), 45 deletions(-)
 create mode 100644 security/integrity/secureboot.c

-- 
2.25.1


