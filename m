Return-Path: <linux-efi+bounces-4561-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866BB2864C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 21:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B63B62B0B
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A828137E;
	Fri, 15 Aug 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="d9Itf7ek"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E57275846
	for <linux-efi@vger.kernel.org>; Fri, 15 Aug 2025 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285776; cv=none; b=b8jHtnZEysZkLxOc3HUTFGV3L7ag5WJboe3knXzNZSNQTsj8dWx3MxPx/wsPt1Q3BxSPJ8MNNBlt0pdZR2qWr6gPjzpAPdkAbu7zFUmgF05ZPkHILpFk3e1wa1LSyZtVAvn6Ak9GwIht5fSiaBJ6DiYV9OBR39Vfts9Ss0F1aZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285776; c=relaxed/simple;
	bh=+zChAHpfi3lHjY4gO3zWsfDescL+7k7+vqAaN7hvtFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9S8gTnGsM9NKHwVXh/NdNlz5/EJN9soRPPDzE/cD3S100vULbFrYwWWbTQZrBZ1c0TwHrpArUTglxKJhPfWJJZolKFzMPIaWLk1/A4FS4tbFFBbF0TVThqxfWv738XHmGsFnefB9dFj12KjkSr0x9whU0XWk0DPta4L1rxNlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=d9Itf7ek; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202508151912426e551a173ee1c2fce6
        for <linux-efi@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=USxneUXUzwvy4ONZPxHVb3S2bzpXkI+fylWBF3uXSu0=;
 b=d9Itf7ek6ywE5gLyhu19HYz7POAjVg0c5DgpH5ZK2Rgyyto70aGPqOvdZQuQgjT48aIwh+
 4FLWgMsQmwduOfWt/4efI5/sRW4aDoGjSoOj+HmSYyXE4K3jQj1/dc0Iv9qPvTTIvEi4Kxsb
 VHz5Mdg9tMr27JTpulCrmHNljPm1jzJ1lxZkA9FyvOmGqwLDlwM3y2VHSsnEDZsUEy3MAfC+
 beokb1IzJHTndjI5WbpXD3SEbfmaNpBcKhAqA55UiDPa15xRUIiyB7nOsW5LOgJkNTBpUO4o
 MvfExDCCo+4eRdxMSo8kDbF9VD/WyFF19OMyBbKtgAcJn80/NMjJerTg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/3] efi: stmm: Fix for incorrect buffer allocation and cleanups
Date: Fri, 15 Aug 2025 21:12:38 +0200
Message-ID: <cover.1755285161.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

One critical fix for the EFI StMM driver and two smaller cleanups.

I'm carefully optimistic that we will get better test coverage in the
future: I have a working RPMB model for QEMU, and this is where the
crash was found now and debugged in.

Jan

Jan Kiszka (3):
  efi: stmm: Fix incorrect buffer allocation method
  efi: stmm: Use EFI return code of setup_mm_hdr
  efi: stmm: Drop unneeded null pointer check

 drivers/firmware/efi/stmm/tee_stmm_efi.c | 59 ++++++++++++++----------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
2.43.0


