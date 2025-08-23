Return-Path: <linux-efi+bounces-4591-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17106B32B40
	for <lists+linux-efi@lfdr.de>; Sat, 23 Aug 2025 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253E65A63E8
	for <lists+linux-efi@lfdr.de>; Sat, 23 Aug 2025 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D142E7BDC;
	Sat, 23 Aug 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="DrpSLUG8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7D238C08
	for <linux-efi@vger.kernel.org>; Sat, 23 Aug 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755969747; cv=none; b=BRJgf7iqOmbUUOEjjNf1n1mAjsxEEqFIwO0DLh17yQEobNeV8qdruI4Vf2iY8mbgC0DEQW1PApmFwmRwpdDkKXpDBiNrEkHe3bWHXh1daTnYg/wAI1Q0u4gfEJtXD6jGw5FILvWoEOAb8k75N5wlViA0r2lAErvwrsdzvYNJCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755969747; c=relaxed/simple;
	bh=dM46RXyH/aMl7u/7A0ttmcz0Kh8ii5Pd/XfE/P4bis8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phiDFyT6xxWApD6fOnuBP5638NQrbCWnY7OtiPH59mJeLAK6dROUd+8MpVm6/kSS8mYwdG6fIexMBmLNCwx62xR1gLqoDAWtIZhoyPipdLXjy6Uq5/5R5YTwlTSk5G5fav+qQVqj8EM6iJjEQD5s4E5w/MxeNh9aBCmd1bt6nWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=DrpSLUG8; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202508231722150dd4872b36e728b70d
        for <linux-efi@vger.kernel.org>;
        Sat, 23 Aug 2025 19:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=DOGrsBXBExLY0BU7dK5MY10gmBjXIGI3LqJjS4dcuZI=;
 b=DrpSLUG8GtA3mZmzKbNU6Z5Z8cDDuCpgHkO9LRwkWEHHNoKWQf7Tr8DLnP1lcW3MdBWkns
 cxpJDhjIeuXvbGn65EtpETUYkdsHj9KIcisCv+LmEDhUkZiCylW/osr18NC575Ei1If0S3Lt
 dz+4hm57UFrpR/56OA+cO9R6WSSIP0B3DpxtF+bi+Y8roRiPBKHpWGyERIKIgsH7GbVwsAd4
 hqaDQcVtu9+8xydyyhoC8r0XMM7cPRHy1TvvTOdu5hZNLMK4ihU3tdKqlChXQf/NLfairyq7
 GpvLEj5cTmKcRyuUHUQFNAvyz+lyK6lpNAjF73x1iddapSEhdn+4JwFg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 0/4] efi: stmm: Fix for incorrect buffer allocation and cleanups
Date: Sat, 23 Aug 2025 19:22:10 +0200
Message-ID: <cover.1755969734.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v2:
 - simplify page allocation approach
 - switch to returning EFI_DEVICE_ERROR on ENOMEM
 - drop efi return value argument from setup_mm_hdr

One critical fix for the EFI StMM driver, one error return code
adjustment and two smaller cleanups.

Note that the suggestion to convert tee_shm_register_kernel_buf to take
pages instead of buffer addresses is not forgotten, just in the backlog.
I wanted to avoid that the critical fix has to wait for me finding time
to refactor the API as well.

Jan

Jan Kiszka (4):
  efi: stmm: Fix incorrect buffer allocation method
  efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
  efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
  efi: stmm: Drop unneeded null pointer check

 drivers/firmware/efi/stmm/tee_stmm_efi.c | 61 +++++++++++-------------
 1 file changed, 27 insertions(+), 34 deletions(-)

-- 
2.43.0


