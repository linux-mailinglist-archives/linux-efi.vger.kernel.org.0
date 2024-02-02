Return-Path: <linux-efi+bounces-452-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA38474E8
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 17:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAEA1C26861
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8337C6E9;
	Fri,  2 Feb 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="szB/kNWD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A751487CD
	for <linux-efi@vger.kernel.org>; Fri,  2 Feb 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891687; cv=none; b=eAV64uKipir1k4RM31BM/EA1d/uYZmLjGAki7oKAa2uT9Iq8cXe1+rbXMkTIH++a/LEL/MsfaKbC5Sp/lYtUfW1aP7BqdUS2RgRcK+2r7KFnrayQmuqgvsqz0grDKdvRFfkWDcfPDD4ModHax/bNL/o/NvfHP1q5I0njQbuk8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891687; c=relaxed/simple;
	bh=+v1TZF2URicEdYFQLC2qCb57HIjFgUlWEfgDgy3fcIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtYONCrXGb1CSzkb8h+3FX8SADDOUAMFz8A3JkAScypwc8saYz3aLCWarhzwKfGSdVdklFkIlj9/LCBgZIuUVFTmdzBOHE1DRV4MvCsm9RtA4nbYc9GGtqV/lHRI92AufnG0fxOYjZzfO7AKt3LnAmMXCVwGsTsilFDf89B79rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=szB/kNWD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7431e702dso19962855ad.1
        for <linux-efi@vger.kernel.org>; Fri, 02 Feb 2024 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706891685; x=1707496485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdXQdXt7uLhKSI5m7G79mULu/VguSqRuThE3UzF0G/M=;
        b=szB/kNWDzAQIVgS3oUNOCGjtj3CEu7vg1kpIviotUksxSakMzSRWEzahbTPGuZeDzG
         oLniVkn9YHe4g1KAerTVesWb+g/We8k3isiu0qRUzs2RaCTxL2CybD9uTeb+a1hYDfkr
         9PJAl6tNtn7zR/IAjeX2V90bESl4cKZvkr2YqMi5H+JRM0ncu2bZApLTWca0DCbV+q/7
         /T0twG0I5dBTcE4iLnetY5s3PKecL/CyhWv3CCdUheFennhehwyGA93TXTi87g6I3NpG
         bzsEeZP2TfvMTurrWv7yH6uIL5npAXeKDIMLBVSsfXcUE5jnGgt+fvqYsoiULq+WmaaD
         NA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891685; x=1707496485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdXQdXt7uLhKSI5m7G79mULu/VguSqRuThE3UzF0G/M=;
        b=B9VBONdM8wmHu0g9u8ymLG/P1Y7XAeSFQh7qjYKtZ9yScz/eoF6xT3gYdcfxuY4FLh
         /oeLYiwXD/ugGTGxEm+kP1eYLi44h54qqWbAOCvdEj15/gykIJLg0zXil6x3Klvdg4yR
         Bco9IUEr9foItpNr93IOK+qm3naAcyFtoIGgNLvh36iRm3eYxnHhwXi4ARmLkiG1nCrr
         vzjuDDSp4WyRxOscLLz+8jyxeFXY0OQjXaW8C+pOTD0t6yd1hJtzSCh+7mCKcp/gq7sz
         WhrWqmydVZnmhfWMmELygouEW0m9Rh3/p2+PHXSOjsVKpGaxez4Kxueb705hndG7CYjw
         Vb5w==
X-Gm-Message-State: AOJu0YxqeQS7JSUEzNk6eOPTpF5TOBWK7jM6rvtkDlO4/wWFwENlPITm
	L7D5tfiU0u6+0Uhp0JIYHn2RmgsvmasVxQQ2ia1HqxKioOhhRp/UZv+QxHfsk7u1/dsmlOFNYl4
	Hjno=
X-Google-Smtp-Source: AGHT+IGeSXexknJyqCvxmwiH4L2JVOdEJAH5LevXg0Rh8dfbIrxux5chSbtz0h0DsQdD5qCN3QQDlA==
X-Received: by 2002:a17:903:32cb:b0:1d9:6091:6f3b with SMTP id i11-20020a17090332cb00b001d960916f3bmr4721097plr.47.1706891684987;
        Fri, 02 Feb 2024 08:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqKdY77sH4w/gkgczn3OarUbhZoeewIrRVoedcjoAmpjy2EH+uuY1EUYIhfWI+JJqio+FklxQl1cB3xtxG4uHlt7uG5w2uVyoK08N64wTmY9ggGPUC4khyuhLoXSSaR3gl8O4yqPnNHGFN2yb1OgBwCPFDfETYS3r+yVfJV3L5S/2Hv8vXEiAY0AJncaVFLy0F6jA6ymeNnJQJePdLRpir1N3kZ5q37J7r1diC2vku+m06f8Uq1NHv9cmGmScGAx+ePj6Q4VKXQBjr
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d75c26e857sm1784870plb.288.2024.02.02.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:44 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH 0/2] efi: Fixes for EFI_MEMORY_SP memory on RISC-V and ARM64
Date: Fri,  2 Feb 2024 08:34:31 -0800
Message-Id: <20240202163433.786581-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes to enable the use soft-reserved/special-purpose memory
(EFI_MEMORY_SP) with dax_kmem on RISC-V (and ARM64, I think, though I
don't have a platform to test it on).

Patch 1 fixes a trivial integer narrowing bug. Patch 2 prevents adding
memblocks for unusable memory (including soft-resreved memory) so that it
can later be hotplugged by dax_kmem.

Tested on a RISC-V platform that presents a range of EFI_MEMORY_SP with
Bjorn's MEMORY_HOTPLUG series[0] applied.

[0]: https://lore.kernel.org/lkml/20230512145737.985671-1-bjorn@kernel.org/

Andrew Bresticker (2):
  efi: runtime: Fix potential overflow of soft-reserved region size
  efi: Don't add memblocks for unusable memory

 drivers/firmware/efi/arm-runtime.c   |  2 +-
 drivers/firmware/efi/efi-init.c      | 12 +-----------
 drivers/firmware/efi/riscv-runtime.c |  2 +-
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.34.1


