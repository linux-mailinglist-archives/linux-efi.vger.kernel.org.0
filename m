Return-Path: <linux-efi+bounces-4027-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B9AEA968
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4354E10EC
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04B265CB0;
	Thu, 26 Jun 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DJzXJFHD"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CAE25E80D;
	Thu, 26 Jun 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975982; cv=none; b=a+Bq2dVKmS/1RO1AMhNmyj6tQONOwHPSrLWxz4WHQoROQyAbihMXHHgZOC/rd4aytSUmuWhSs7nIBXmee5+alK6BXoGt5xmnEG7a+8l00XyP9gfmZCmRXU7gYIgXwga6gMBP8289EcSoZ+gDIYY1rKrNGYwn6k3Q51FOchWENRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975982; c=relaxed/simple;
	bh=H3nHtx4WdySxscS7WlwJbNB0IsYLDw5M8JaFSplT1os=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mAeD5qGBEG8FL/sx3pA/A1cbOzDtjUzboXASi9iPYBPXlsQAy2r2HRyvEpyxit3wMpxWNYnDJt2ImL7xyXLZFESl/nkUG++qv11m9JiHCitiwPH2s+agO8d907eTTuhClDQsYpEJMWcZSmfUaA4xFb5IzIunuBrBIOkH7fESrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DJzXJFHD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 651BE211519B; Thu, 26 Jun 2025 15:12:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 651BE211519B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750975974;
	bh=S/ZeQ9WRmoypM6iMdsfjPU7NXHOee6zKL+IseMlKxSg=;
	h=From:To:Cc:Subject:Date:From;
	b=DJzXJFHD2nLZyScweINr6X2Id+YkE0EH9OoBOb4KFAdfRFQuA6HM7QMviG0Bk7hSv
	 6MGdZjW1KBhWhECJJFxnbbRkqPgpl7Km2rKt37hVoSsXIzoFLsO/Osxydy2cBrcqVN
	 iEdI1YtqLNDzMNUU87zukb727cGIbFDKE4LC8WX0=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 0/2] Secure Boot lock down
Date: Thu, 26 Jun 2025 15:10:37 -0700
Message-Id: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

All major distros have had carried a version of this patch-set
out of tree for sometime now, but with a bunch of magic (typically
sprinkled in setup_arch()). Though we can avoid those architecture
specific quirks if we call efi_get_secureboot_mode() from
efisubsys_init() and that allows us to have a generic solution.

Hamza Mahfooz (2):
  security: introduce security_lock_kernel_down()
  efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT

 drivers/firmware/efi/Kconfig  | 10 ++++++++++
 drivers/firmware/efi/efi.c    |  9 +++++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  8 ++++++++
 security/lockdown/lockdown.c  |  1 +
 security/security.c           | 15 +++++++++++++++
 6 files changed, 44 insertions(+)

-- 
2.49.0


