Return-Path: <linux-efi+bounces-5287-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C0C2460C
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12834603B5
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFD31E11D;
	Fri, 31 Oct 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="a2J2cfjn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A13375CB
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905435; cv=none; b=WuBH/OhX5S7FgGxvi/NenwVPMBSLC5DYvsEh9ZicLSCyHQ7D3Mi6OXy1meU+WGCyKc9lSO2/LvoKdPfU3OGS+wtMtOU7su6VFDEzrA0hltvhI+zuf9/uJ3YSLFwC7ibuMAdxeolbLYbGfQgL1EC3MDSy/BKMU3SfZwLvVAouWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905435; c=relaxed/simple;
	bh=rbSsCcpdfOQMl/imm+AJcUjwxWBfACxcRCYWxMrFHNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQWvIibfSBQae32iZk49ECVmiNuwy8sgoQ0q0oBaQxtMzs+JLHiWTQox1ujX2xB1RF82OyFfos7+eG/1FeSTJtaSo0yfNcmQ567hgbIDmmWJ2XhMFiyX9YoBX4+GcOrdpmsqeHkGj4Gcdk8UUaxDUJdyS8qENXu4jfaJKqYjdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=a2J2cfjn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3404904539dso323014a91.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761905426; x=1762510226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmq+bAz1UkNsQtohwkVTzYtE5dGD+y13agWhpu9mVtU=;
        b=a2J2cfjnZuI5VOVVkeApPsb9t15WgODmbXroqXozQLpNk5zfJdTSNMS/ttvJ4hYhDZ
         p37Nai6pl3IS1XPuz7GEXARycMVt5OAOE6O//Q8AW4OjVqMNts5RBuEjC0M5Teq3BG49
         CbUstNkCDPf3Xq1KGQnRhY2lxnvKX10TEhqBvTbdwuNtlcbI/IreHGqkMJ6Im88+gg3a
         z/D1Fa3zcx678eyL6xrkrcm4CwgM1jQGJBHmE+4tKHDXvlKxYzZ6ajdVL0ZLgJJQ1+oW
         TOC1bKEPasUqJdXvet7hSuB1HcdM0nLPDUeT15fsIagRaFmc+ey0c0tiT6OsUNYOPfna
         gExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905426; x=1762510226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmq+bAz1UkNsQtohwkVTzYtE5dGD+y13agWhpu9mVtU=;
        b=mSlbzWHbRiuKytYoICIBtlgKsGKo4FJ5T3u8dRJaIiCS/1wYlh8Gl4ZrghMvmr7uE3
         wJC6WG9Lj383ACHG6mNF9ZVMa7ImRp4zOgFlzx9ZketpqrtZE1bz/Ic1Xj7yAyKrtdoe
         MW+zkYgqy3sfxLNT2UglY9z9tm31FKXU8fVuwfrhbByzNpJ2E7dDo722POkD2lDPHmAA
         pAn/pvP18rFm5FAcJOiWi5fcR1SMZA4u/mNGUSEJm1hBuTrzZNlp2adFT7LMwDTTaujB
         nWzIN9C1mxFR13O2XabgUJrq5oYd28/u2j8P80J7WgxD/cIGMCuxeg/tBp1KwRKOcOQn
         wVxg==
X-Forwarded-Encrypted: i=1; AJvYcCWaJ/Lbtk8tImIIGhFs+IXJhha40s+JGcmD5BDVKXXFbWVUxB9J1Kmv0IYRy/NKE96sPIJboTlFKqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwl2CElHYCwzN65UnKUFpjNuXSzqLjPfOFv06urlakSdc1N0Qc
	EXkDEBDnKXjHg5j8USTRtoBu30WxdafnYDtw+5LAJHI9Cn097HeU8Hc5s8Uy/bF35w==
X-Gm-Gg: ASbGnct2C24xFtO+zS3KD/R2FRfcpnykCS+ePXQkm1V481IH95bVQNMffxhSjq2KOHF
	AfY77AculI1GA+o/dnQuetUvkokOXgvpvXXoRLRXx5nu+lR4vmwbpqD7OHg2vnHQ3c8+Y1vaLZo
	pJrDEw/YLiRwTws7KAu1Uo18T1w3UaANZ1DPvAfjVFEEZtBhlpSRpMVh8Xikt1qFodPUXNEkN2q
	GimqAx0xTXyLCOjYNAFZ9NP35a58MNodKCU4GTTh0/ZcJZMRlNM0GFxfIB6W+EnvDRtYXV9bVtF
	kToIF5k4A6A6EdcC+WJbctyFsq46HB4GikqmgEMAjdjkIF/Mg+wmQjeEnLtm0G/+HcB6gUDdelz
	L3kHGBrZy1qZNBXxHJy2EZmh/LlIm+CCC18jLkeoT0sAvdcpU1+x8v9/CYaMIW5AmGcXtL1fOVK
	TvnDrGaLWe0ejj6/ANLUAECbygy2Lbx+CKIWJrpiyOFTuOOn4=
X-Google-Smtp-Source: AGHT+IHP0KcJILf7X9uuGPb4TLUcbh/zJGOXAc0JvgPUtH5JkTiBAWLIYK309sM/jCBKRYZpJQMPaA==
X-Received: by 2002:a17:902:c94d:b0:27e:e96a:4bf with SMTP id d9443c01a7336-2951a37bb0dmr23125135ad.2.1761905425939;
        Fri, 31 Oct 2025 03:10:25 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm17458545ad.99.2025.10.31.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:10:25 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com
Cc: robh@kernel.org,
	krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	adriana <adriana@arista.com>
Subject: [PATCH v4 0/2] DMI: Scan for DMI table from DTS info
Date: Fri, 31 Oct 2025 03:10:07 -0700
Message-ID: <20251031101009.704759-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031084101.701159-1-adriana@arista.com>
References: <20251031084101.701159-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders like U-boot, particularly for the ARM architecture,
provide SMBIOS/DMI tables at a specific memory address. However, these
systems often do not boot using a full UEFI environment, which means the
kernel's standard EFI DMI scanner cannot find these tables.

This series adds support for the kernel to find these tables by
reading the associated property from the Device Tree /chosen node. The
bootloader can specify the physical addresses using the property
"linux,smbios3-entrypoint".

The first patch introduces the device tree binding documentation for this
new ABI, and the second patch implements the driver logic in dmi_scan.c.

Changes in v4:
  - Renamed linux,smbios3-table.yaml file, removed mention of ARM/ARM64
    (Patch 1/2).
  - Drop the second definition of dmi_scan_from_dt() and fold checking
    for CONFIG_OF (Patch 2/2).
  - Drop unnecessary goto on the success case (Patch 2/2).
  - Replace magic number for entrypoint size with SMBIOS3_ENTRY_POINT_SIZE
    definition (Patch 2/2).

Changes in v3:
  - Removed linux,smbios-table property, only keep the SMBIOSv3 property
    (Patch 1/2).
  - Search DT for linux,smbios3-table only, removed the code searching
    for the previous property (Patch 2/2).

Changes in v2:
  - Add missing Device Tree binding documentation (Patch 1/2).
  - Split the original patch into a 2-part series (binding + driver).
  - (No functional changes to the driver code in patch 2/2).

adriana (2):
  dt-bindings: firmware: Add binding for SMBIOS /chosen properties
  drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT

 .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++
 drivers/firmware/dmi_scan.c                   | 54 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml

-- 
2.51.0


