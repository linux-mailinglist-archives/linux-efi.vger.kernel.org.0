Return-Path: <linux-efi+bounces-2758-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA917A2A984
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 14:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220543A384F
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBB21CFF7;
	Thu,  6 Feb 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ap+1hWvG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22D1A316D
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847981; cv=none; b=D9Pfdnpg7zpxh36gfvgGjvc8MaKxYpQmg4QLpkZTbyd+K+s9SunZrRkpoNt/QruOVl+ljZUMR053AEaOJEfAEdPrLMSJBmtYzeOv1byb8iFjGlZEZWz7pIKL0LfeUgu5Ixv0L4HD1f4dBHJs+Y71XzpgfaJua6V57oJNcuVFSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847981; c=relaxed/simple;
	bh=yEHGgbXYg86TqrNi2d9ZrXvNhZAg86gc9uC0y9rcKeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cb+J9b9FPjfCuJpd2NsHZXMdhSpdkogkUOwUax1o3up5w7+tl9cAMcElaGWwzNOXAxX0S9K7XsHP2vcTeRd+ziQdvFFWKj3L7E++VKlNHkiXrc16zXZ/MJgwyJx+AbOXZ6VOeb3c3YB10h78Z6/apJWIq4VF35ZiqxiyQCnhaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ap+1hWvG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f464b9a27so3326175ad.1
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738847978; x=1739452778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPBkQVcozPH35+SMd7YDKRV52t6xM/qA7YaAmlBFzAE=;
        b=Ap+1hWvGSrjhTMYG0drnBDaZZu+JtgEeX30EXz3wz2TkyGkDQEmb0DgIwQYWSkmfFn
         KjkpuCaothXgnIVIgbZ1ej1Sf45qrmgrOc+x5T+nloh0avuvr3ZvBbwGFfiyJNclwq71
         1tDFCRh0lRPkHT81LZUVFlFTDBsXd637TP/p9ZimA7K/qUQGYk4vJg3wi3HKjhnBE5Nz
         sMarVB5sJYg6FGp9pwUx2U+ko62TpzqoulQGeWtxrJfnNUmltyGcvdq8oiNE3Eah9uVu
         W+R1/GIuDi9+9nzMIr1QvY1idTjrSzk93c7u0MO0sOxRJkd2K3tdED+zha3Jvtgp47Rh
         7FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738847978; x=1739452778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPBkQVcozPH35+SMd7YDKRV52t6xM/qA7YaAmlBFzAE=;
        b=M0EsxT35R2PmcJK5JL3he5LE9nOaXl3qfG/wcx//fBBBplA41Hq5P514f1FxlzbH4U
         Nio7DV+Y+VdaZ56xFT7YWNVs8V1asGxl9hfYkhv8K420PBQ0BousDlPtycOXYO43LxOD
         vN/nzYC9MZfGZlJYi05YN+mKcgDQUyyKHFzHIri3CN9oUDlPIwF0l/gMaNxtnVF5T4j0
         MYHtjY7hW4JSTKo2HcrzLXo3vOMsDT+fXmGWkuisMRGvlMwIn5VlpwSYFHaCUPv4ZMEB
         uKXjwPHvEzuHdiTIlL+94rufgo62Zz0432Cs1BHDCbreX2+OHh0FgsBRItZm6TC3v0y2
         dq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+qB9Zj9LxvqqHEokyuV82ivLMrPSUJ1wqWIfybOhS+d3eGTDjBlkVfVUV2ozhls+Z+eFGmfKvU6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeQU9H5YQJJ1X1dMhAS1zuJ48mWMyuaWk3Y544EF1iacItIMY
	z97PPcmIy0MHM4uRHcN6gZ5ctsB4jK07Ws9TgRlLxR7t26l5s/HWx7m+R80tBt0=
X-Gm-Gg: ASbGncuxu4NjEKqtqThkGuNGaVv3KJMd5lt0Qlwzw4xZhRqFI0wyP15zAWbqU59hHUy
	AbLXSz8bz/IvMPozCT/RP3ZNOCazdYiKkLzgyCu9WU6M/CHgyu7NsxPn90hxcS27qrnTDayy2Zq
	E3MieTF8hb3hmwxMYA2RqvDjE8j59hGQI+ZpKcTY2xLJJH8aGDIMzFUIqq5Y6XVTpBLP76w8hyq
	yrpYfGiVJ5WiDkVaZli4UBhbdZ8C3r/VVqwr/qQMEEKvu2fJXG+413DD1/Tn6UYsSkjDUdPG3vQ
	kp4Lc/1MXd+LH5FP7w==
X-Google-Smtp-Source: AGHT+IHeug9cYWBwdxegaLKcOfC/AYX//xp3oimUmbvosm7CRYX6S5ANS8ab4mETPqqD02YJJ1FQbQ==
X-Received: by 2002:a17:903:1cd:b0:21f:1521:42f with SMTP id d9443c01a7336-21f17f2a696mr113150885ad.53.1738847978566;
        Thu, 06 Feb 2025 05:19:38 -0800 (PST)
Received: from L4CR4519N7.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d987sm12170775ad.120.2025.02.06.05.19.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Feb 2025 05:19:38 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	haibo1.xu@intel.com,
	guohanjun@huawei.com,
	sunilvl@ventanamicro.com,
	samuel.holland@sifive.com,
	parri.andrea@gmail.com,
	ericchancf@google.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [RFC 0/5] riscv: initial support for Generic Hardware Error Source (GHES)
Date: Thu,  6 Feb 2025 21:19:21 +0800
Message-Id: <20250206131926.91289-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

NOTE: Before compiling the kernel, enable ACPI, APEI and GHES in menuconfig
The following options must be enabled in .config file.
   CONFIG_HAVE_ACPI_APEI=y
   CONFIG_ACPI_APEI=y
   CONFIG_ACPI_APEI_GHES=y

Through fault injection, we can see the following example output

[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[Hardware Error]: event severity info
[Hardware Error]: Error 0, type: corrected
[Hardware Error]:  section_type: memory error
[Hardware Error]:   error_status: Storage error in DRAM memory (0x018d8480019304f0)
[Hardware Error]:  node:0 card:0 module:0 rank:0 bank:0 device:0 row:0 column:0
[Hardware Error]:  error_type: 2, single-bit ECC
[Hardware Error]: Error 1, type: corrected
[Hardware Error]:  section_type: Flle error
[Hardware Error]:  port_type: 4, root port
[Hardware Error]:  version: 3.0
[Hardware Error]:  command: 0x0146, status: 0x0011
[Hardware Error]:  device_id: 0000:00:00,0
[Hardware Error]:  slot: 0
[Hardware Error]:  secondary_bus: 0x01
[Hardware Error]:  vendor_id: 0x1e93, device_id: 0x1010
[Hardware Error]:  class_code: 060400
[Hardware Error]:  bridge: secondary_status: 0x0000, control: 0x0003
[Hardware Error]:  aer_cor_status: 0x00001000, aer_cor_mask: 0x0000000
[Hardware Error]:  aer_uncor_status: 0x00000000, aer_uncor_mask: 0x04000000
[Hardware Error]:  aer_uncor_severity: 0x004e3030
[Hardware Error]:  TLP Header: 000000000 000000000 0000000000000000


Rui Qi (5):
  riscv: select HAVE_ACPI_APEI
  efi: add riscv APEI generic processor error printing support
  riscv: add fix map index for GHES IRQ
  RISC-V: ACPI: define arch_apei_get_mem_attribute
  RISC-V: define ioremap_cache

 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/acpi.h   | 18 ++++++++++++++++++
 arch/riscv/include/asm/fixmap.h |  3 +++
 arch/riscv/include/asm/io.h     |  5 +++++
 drivers/firmware/efi/cper.c     |  4 ++++
 5 files changed, 31 insertions(+)

-- 
2.20.1


