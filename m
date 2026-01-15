Return-Path: <linux-efi+bounces-6000-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4BD273E7
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3A631B7DAC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0403BF307;
	Thu, 15 Jan 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCY+zevU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34F27AC5C
	for <linux-efi@vger.kernel.org>; Thu, 15 Jan 2026 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497979; cv=none; b=JDPdMDhUHGop7uIHA6hICIh32Q5d37kU/P7EwvPRVsWBGTxfcNwq/bu42Wq41H+hoER0sMBXV1eZZy4QgjkJuR+w1Lq5C2+/oIYBCJwBwP2a9D9PMewOu5QWz8zuSDfUf1X8PHFFotLcVRB/+2SiXJm6IvAl+EC+Ev6kLMXRAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497979; c=relaxed/simple;
	bh=EcB0QbK1bwgOfkkGaTfahgK115JpVMerDYWFEZ2Hqog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U5iHVuza/IfREZBe4AEFNM9Wbames/4GLzYFMP+yVcOCmMK11dyuBItId4Naaqro5Wngb+NQuq5jvYsgrbcxclFH1CPn1ARR/IYQjY9t95hSG8srVgx+gLia8Dhg1BYgARWLORphWesUC26m8IY8lt7IBWwWCk/OhmCoqj/M/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCY+zevU; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-434302283dcso1001388f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 15 Jan 2026 09:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768497976; x=1769102776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7cxmZ4X/5dY/j3CQ73dlFIA0x0ahCnKGS0p9MFNZwA=;
        b=TCY+zevUi0A5Hz3Jd/lRV/kcdh/5B/qstrw+rabSUWy/31mk4isk6yHB+qOnURyFre
         zHK9nwcocLBn9qdU9XLaqFDiBRqxMwS9F6yCVVnyxBKZ65QTAE/gO1hQM6rA+SGyVyah
         Rtw7oM7vXMPl3ChBgfQrqFItlh4QBBy+tI93eczrTJFQLsFm6zwIgeF6VD5kJs6o/Zq1
         kvDpSdvEHoZszTe4SH6kW72/5+zQHaVvcVVuuiW/d5s5K0J6nWggGgJ9Wq9iYEHx3BGU
         g/Uh+pNe9g3ziS83qszRPO8kJIO4kHTPqxHEv3Bc341BdcTzr+5+JdQ7wkRgZXZG/5B3
         CFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497976; x=1769102776;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7cxmZ4X/5dY/j3CQ73dlFIA0x0ahCnKGS0p9MFNZwA=;
        b=V55SZkDk3zvaWiQcLIPX8YQDmNv2L7KtbL/X8x42j98dxerD7SfMT9LI3ivRj37Gt3
         82rKJSbdIU11Vi2f+56OH37FP7qFZKlRoFGr/sl8Igu8mml1T/GVMtPHDVcBjz3Wavrw
         ytyQ38oTBL2CSWCehl8+KL9J9e+48Ig7M2GysLM+vRzw3s7qSqmIK8dH4tf0SWIh5kYA
         eFF6IwAXyKQ1NR2i/TyV0aoT4S9bWWRNZSbLcXpEp9ppYI83LcO8V+iQqc8A9sccT6qi
         IFh+pL0ydnM7y3yZI+Mx2cJrrrY0OJ/7E+x/quU/nQ25cCmEhcyrnTdxvkN09nOPOlWP
         Rv1g==
X-Gm-Message-State: AOJu0YwrVtc3sUCnTjeInen3L3sPrgUgX69ysB/pUdyVyJyi/+c8UrZD
	toheZaS/nueYuLOPMypQg7/3QNogsaHyustwIft6US3DxyUbrEILCyK6Qnppb/IKP+WdS6sPuA=
	=
X-Received: from wmbh20.prod.google.com ([2002:a05:600c:a114:b0:477:76c6:3a81])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45d4:b0:45d:d8d6:7fcc
 with SMTP id 5b1f17b1804b1-4801e347c1fmr7067505e9.27.1768497976409; Thu, 15
 Jan 2026 09:26:16 -0800 (PST)
Date: Thu, 15 Jan 2026 18:26:11 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=ardb@kernel.org;
 h=from:subject; bh=fpqR0euVTnPH+TdLJsSIiE9XLXBZEtH8KfA/pMZUUSA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JITNT2ejTE82gpO60jeL7DL8cletyKY/fuLI1e6doVx7T8
 cu3p03oKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJlmRkaDjz0OL2yRRzIZGd
 DRGm22IF2J228Bteefjv+s4Vdcm7LzMyvP0U4ziLh8H3icSB2zIHDymLvpwuWDJV9euzCFtmbc0 3TAA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115172610.1844636-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.19 #2
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the EFI fixes below:


The following changes since commit cfe54f4591e675cedf2c0d25287ff4c0a2e0cb9d:

  kthread: Warn if mm_struct lacks user_ns in kthread_use_mm() (2025-12-24 21:32:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-2

for you to fetch changes up to d7f1b4bdc7108be1b178e1617b5f45c8918e88d7:

  efi/cper: Fix cper_bits_to_str buffer handling and return value (2026-01-14 11:34:42 +0100)

----------------------------------------------------------------
EFI fixes for v6.19 #2

- Wipe the INITRD config table upon consumption so it doesn't confuse
  kexec

- Let APEI/GHES maintainers take responsibility for CPER processing
  logic

- Fix wrong return value in CPER string helper routine

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: Wipe INITRD config table from memory after consumption

Mauro Carvalho Chehab (1):
      MAINTAINERS: add cper to APEI files

Morduan Zang (1):
      efi/cper: Fix cper_bits_to_str buffer handling and return value

 MAINTAINERS                 | 2 ++
 drivers/firmware/efi/cper.c | 2 +-
 drivers/firmware/efi/efi.c  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

