Return-Path: <linux-efi+bounces-4604-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40437B346B8
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CBC189C7C1
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86B2FF66D;
	Mon, 25 Aug 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="MvBwvLfA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC129E0F4
	for <linux-efi@vger.kernel.org>; Mon, 25 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138044; cv=none; b=FwYKkMC7j+xSsQp6+aYpYeNUjeHtxr+4VupUN6cEIRDx14ZaYWNHCrDCfv/tmchy5vVaxSsqnPNQuHojHszA6xr0LXGQJue0h5tuOoISO9KP6pCSIB3kcT8Q+VrkI+8wyooE4ofUoww/ij50ezniLE9YwT3NgoJu0KeOBNkRMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138044; c=relaxed/simple;
	bh=2Dd39Z5VLNV8NHl8byVSZhxo6MEB4pLX7stKC85GgiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PaiJzVgbD7rG78CtIrSjSfJm09I+ijTdZWn1yE/+F+/0+UMIp6lHGTZKwYfoR7fIhx5MRWG0h3wpGVr4/RsXkvX41Q8pVJed2lDUG4KZOBFly4FDPqwBYGFwZhe/bQNhLIuptlegEHy/mYDbJDc2u4OHjl0rAfEYHAyLpa4YwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=MvBwvLfA; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250825160713b668193a0adc3c482e
        for <linux-efi@vger.kernel.org>;
        Mon, 25 Aug 2025 18:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=op8QEMoJkTGO/bD4ByGq2ruh0tz1u/z+bRtk06GRpeg=;
 b=MvBwvLfAFzh1802zqugSzurNxZbE7JP9ga9wMgjMx5UaC2AEq9Lg5EtAl75/dWUDIbWZXQ
 nCl6aSqYL2R8hFw9T0xYOO1PYthHjUkVmqDbDsWp94JmGyEX8IuggLMh0WywbsE4Tj3ZVh4l
 TmNzfNbZnJk+/Xw9Gd3vuodvz/BtlSx6b4kFAZw7BInB2iRQxRoM07iV7ryFwEXly8xGwHym
 ooC2MHVPJayc/WzExcjkYofOp05+Yo3q6HeWpmskCZ1BDkDgyiK9n4D4yJrUpZXZm/PQjABW
 JcASNFjUV9u34uhsOm2hE3FosFobbi3QdvgCJAla2YIA1hZxOv+sDDhg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v3 0/4] efi: stmm: Fix for incorrect buffer allocation and cleanups
Date: Mon, 25 Aug 2025 18:07:09 +0200
Message-ID: <cover.1756138033.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v3:
 - improve description of patch 3

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


