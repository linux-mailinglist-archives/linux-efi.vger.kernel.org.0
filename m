Return-Path: <linux-efi+bounces-4652-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED9B3BF0A
	for <lists+linux-efi@lfdr.de>; Fri, 29 Aug 2025 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31E83B0C15
	for <lists+linux-efi@lfdr.de>; Fri, 29 Aug 2025 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23049314B82;
	Fri, 29 Aug 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8O06JfK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF53218B4
	for <linux-efi@vger.kernel.org>; Fri, 29 Aug 2025 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480741; cv=none; b=RmoQXu5lUvmsBPSyOVtHJ2tB+7pSn2MJb1a30Tk3lNTYJmrYzTTAZDgpH4vP88GY853jaD6D/gLhwAxTQS3N6/ILOxdFomYj5Ihg5cbKSSxUbZ1qMuZvbnFI3odL1yrUdKjDjyZZzkssFrePzgim7DonG5RzUuuvoQBdyveQbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480741; c=relaxed/simple;
	bh=6duPvaL1EIPjpADyYzYn6z4IPZ/wD/3dbUWFCybGe+g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rO1445bP+lad1IWj09Ol3LzbhT5mrQrrP2iYCPekc70B29CntW0fL4xMkSKDei+7vJPcsSYqJQ+igrOzkB6bMfKnUTwsVfG6+YIohzbZgikIxhoy5nonTOnHvxuwf91IrTCGqyW/4AIu+Lq7KLug8Dfgz4BIsfj/v2q/g/Jg0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8O06JfK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b72ef3455so9724165e9.3
        for <linux-efi@vger.kernel.org>; Fri, 29 Aug 2025 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756480738; x=1757085538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHVUTsguZzIYhdRMIll3tA1CcySMXO1fF1Ay19HNe28=;
        b=a8O06JfKafzSiLBQayHIiCxGv+lhYcjQV1HPdHx5Cf7zOBPyW6LichC2K0HtfbzKrE
         TeBVuISXmJtg9dUXo8q1Cl41Gt5q5uO/jEOAOVsQaTD22o87jRzVZmJRqOhLun8WJwB/
         pvGHYO1AOpduoPrAR2g0oYAs8fZV2P+zp0TYN2lxSnocgDinV3V67jG8wqVB4MvndNqv
         MMaf/PKvdrK3hDyOPOgeMzm+XMx2cHc2D8qzBr7mfxhTqoTm6W/E916Mha8w5gCH3F7P
         Si+DyurbJb/wIwTOi6pEIs7SjCNrA43pYHYmf68NL10T9Wl4qi+ONGlEg1LKHmdZYCKr
         T3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480738; x=1757085538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHVUTsguZzIYhdRMIll3tA1CcySMXO1fF1Ay19HNe28=;
        b=LhFFCB5RsrOarKREL8XE2nz53Z/w5DRlvL73vDDvUe5GKv4Rushq1SFM2zHi0XrSy0
         AqWqVPPL2i3aq6p45Ok/RmbUE3XW5Sc9TbrSlSG/vEGV/3iO1EMynCymXawzQ3JO3js1
         VFlmG28eI3ctvu/ujx99VVhY169jlEKOaMr0ZLIuRbVKoQnc2Xku2p0EFpQlOpGuADI+
         5CSjgH2UqLd68wX1x4a6mhIZUnKUVGaumlLoWQhTN/8yszhGl4Vkk3M2+2XdvU03Hom/
         OgRYOtanlTsfwxdsp3R/158psvOf/9nEp8l5cKRMd0SaVgjcYSRyuzQGAzkhS/hruSB3
         losg==
X-Gm-Message-State: AOJu0YzIBc25XYC0HC2aTfRPhd7YG60pZfwC5zGfMN2zZW0k97P/S1pU
	tBs270dGr8N/TZaJ5KTj1yXMU+tMn5i0DA2kpp0M+5NcbXx3GtOvpgIenWsy4QZmx4PePcbeSA=
	=
X-Google-Smtp-Source: AGHT+IEuoWePC7CkjQ+VzyxIqo8k+6LNt6AyFz2XnNJ58qanE69lNyijovQ+7nMOIpAQtsOhcJZuQB5P
X-Received: from wmqa9.prod.google.com ([2002:a05:600c:3489:b0:45b:7f5a:2151])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4451:b0:456:fdd:6030
 with SMTP id 5b1f17b1804b1-45b517cfeacmr238236715e9.19.1756480737810; Fri, 29
 Aug 2025 08:18:57 -0700 (PDT)
Date: Fri, 29 Aug 2025 17:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=ardb@kernel.org;
 h=from:subject; bh=amQai6IdGi/bkXe3whZhUlcNNHu/aUe2Th1YK6Dltqo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPjkVse5z/ohjXN3aLpMufrx+1HeZNPrS2xOPIkbcaEp
 RPDTW6ndpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJfDdl+F9ktD5y5q2LP6er
 HDrFwa3NtK7UsnPnJ+YuNpaTe3Wj81YxMnxYLRBrbNrfrXOE++jFlF+OIatNc7Yb/Kg02bv/moT YeUYA
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829151849.2602707-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.17 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linuxfoundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the EFI fixes below. 


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.17-1

for you to fetch changes up to a6358f8cf64850f3f27857b8ed8c1b08cfc4685c:

  efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare (2025-08-28 08:39:49 +0200)

----------------------------------------------------------------
EFI fixes for v6.17 #1

- Assorted fixes for the OP-TEE based pseudo-EFI variable store

- Fix for an OOB access when looking up the same non-existing efivarfs
  entry multiple times in parallel

----------------------------------------------------------------
Jan Kiszka (4):
      efi: stmm: Fix incorrect buffer allocation method
      efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
      efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
      efi: stmm: Drop unneeded null pointer check

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

 drivers/firmware/efi/stmm/tee_stmm_efi.c | 61 ++++++++++++++------------------
 fs/efivarfs/super.c                      |  4 +++
 2 files changed, 31 insertions(+), 34 deletions(-)

