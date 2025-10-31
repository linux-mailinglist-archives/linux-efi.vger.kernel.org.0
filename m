Return-Path: <linux-efi+bounces-5279-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E004EC23DC2
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9649188B302
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD32EC0A1;
	Fri, 31 Oct 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UiyKz3CI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307952236E9
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900099; cv=none; b=tzfH9Bt2Eq7hSKjDpgalhgb0ar5TvcA4QtZiMEerdtgoGB8KUGX2EndCfX8RgjhE/gTX55vyqzWcZngRKs6uaV597lmZdHKKi3oA7cXGrRKn+TbiHiX/1lDsh4/m/jAKsfi31T66gA0YyPpLbU3J18UivfCvGMNqC/ju/BKV4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900099; c=relaxed/simple;
	bh=CYRQF63TmSj0kIvLdKDBtxSpPXIpRL8qR0vZ1dpssRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlzHHhDY/qvSU32IIbl+a6MFA23FFLEC/wWVRR/lfO9sLWam2JZ2F6XMv7BOUEo4SCPMcSoi1x2toKE6c9YqUos5k30517R9DZzL46+8J44UaozDA7aCFhfSHvSaZWdP2IckVSqmDlAVwRDtHyNQs8rPyGI3900eKz6VDA608EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UiyKz3CI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295395ceda3so92705ad.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761900096; x=1762504896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPyVbe7btBrb/kbufU+DTPGJAkd1ax44z1PEdLO1daY=;
        b=UiyKz3CIWB4wR1fBW68UFpx50nP8DeApfppEbWuMCkNvDiBMA7sn9DtQZwTsSsd8LM
         /MdxgOKSNbS5gioExnQnOFbLR+wyUsHZ7T2jIBgpMquvnVxh6lkTwC9Ucu+Hou7+AlQF
         2D8iC5TRB+Y/qBhzN5e2Mm3Ts962yJZ/5J625Q1qhYpOgZeF/cYo+zLg6OuhTnC2s05N
         R1jgDABNQBRuUgu/DNExwv4v1u0xK4k3wWWyzb53XqCi7/LzGxkjdZkmB3HxtYCGOjlk
         acgbQM2ptbRE5r17llESnThHSTc0atEGhFmhpv0s4cxw5b1WNHfu4M919sHnuXKJnSCz
         /f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900096; x=1762504896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPyVbe7btBrb/kbufU+DTPGJAkd1ax44z1PEdLO1daY=;
        b=TDQT9kAYcgQ5W8ky6AH3IsYXRHaZPyuNDJx0n5y5CnOpi2xiRkSq2rrGzBjiO4F6Y/
         H8si1PV/8XwnUr4eGzzM6i4AFOmSu9EClPLk6vo9lIq0LDlP6UWLObMAWF95twQsMBuv
         b+hjm78mRMmVdVJd+zHt06uF0ZJSGFkaVVWzsl5pQAImKNac03HK/VCJbPAbiB2/Zgzo
         ckejNgfBI+MNyleYrM4rLVjs5woIk9d0ZXYR5y0OVnXpurAmcTVbW+R10K73OtmeZKvO
         x5tMboZY+UJKpiEVWGcpo9Ewlndc3XJ/h0zYf6Jxj/7b3xj1oy3HVqNdrwC3Woitd5N3
         hZpg==
X-Forwarded-Encrypted: i=1; AJvYcCW8m011/582yNcCC49viI3CgNyrhX2JGiytJXG4dbm1agwezMaaLlDRdnsRULWNswghfj+iKmQWNDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrnVrZ3ZY64Vj6slCvZtCPI21C37DydaQvjbUE3Ejs0bRNkXY
	FER6WxlK9hM3VtGUzu6J8qeuuQgf43zdngpxOUVlTfFfToERGT65mXGpkPo+KjFhpw==
X-Gm-Gg: ASbGncv8sPwB80Bq6Mnp9bUPlyRHKmnr4GtGwRDyN+prvMswpVgBa8QkojLB3Hyhhn+
	HmpnFOMepqcQPtFf9zOZwGrGgsf45u5a2sdiU0NYDOPSYJX2MvGWFttYRxzYdTU8SMFguvkS/NR
	qedTvBUZVaif66AKRBfe7FSsC9QKBjjVVfrZkhjff7TZQYiOGtobq4FWO7NX5AHAPrN2iWJCrC5
	b9LuEO8TjgJEmWgCRtu+B/+y9oQd6Qzz6YNmvWio9YCUZC6kzmUfN2eulaX167SAu8AVhJ4ku6O
	52SA3pXX4dT9Dd7uaFbQzhS+BoAxe+AGkFtN8wJzbbQwsiqM0po3015FAroEEBP0Gsjmd8/s/qy
	wUrVkk60vvcsyiIA4k2FLcVXDWfzBDwMn7IYnCZamRa7osajXEaAYkCORb3Sap13ogU/DQruIDr
	AYt4ynYmxxSbwGVOg0BAh1iYuRIJpw4o8bNDIQpqpx/D+LrLc=
X-Google-Smtp-Source: AGHT+IFRjA11KiQtuDLyXpyzr+cH+MBZZXOEiapTRE2mqruvh26mmlGWuUYPHkHWLSUbX3DkbIXD+g==
X-Received: by 2002:a17:903:38c8:b0:295:37ac:8d54 with SMTP id d9443c01a7336-29537ac8ec7mr1773595ad.9.1761900096398;
        Fri, 31 Oct 2025 01:41:36 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm15333505ad.84.2025.10.31.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:41:35 -0700 (PDT)
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
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v3 0/2] DMI: Scan for DMI table from DTS info
Date: Fri, 31 Oct 2025 01:40:59 -0700
Message-ID: <20251031084101.701159-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114527.618908-1-adriana@arista.com>
References: <20251022114527.618908-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adriana Nicolae <adriana@arista.com>

Some bootloaders like U-boot, particularly for the ARM architecture,
provide SMBIOS/DMI tables at a specific memory address. However, these
systems often do not boot using a full UEFI environment, which means the
kernel's standard EFI DMI scanner cannot find these tables.

This series adds support for the kernel to find these tables by
reading the associated property from the Device Tree /chosen node. The
bootloader can specify the physical addresses using "linux,smbios3-table".

The first patch introduces the device tree binding documentation for this
new ABI, and the second patch implements the driver logic in dmi_scan.c.

Changes in v3:
  - Removed linux,smbios-table property, only keep the SMBIOSv3 property
    (Patch 1/2).
  - Search DT for linux,smbios3-table only, removed the code searching
    for the previous property (Patch 2/2).

Changes in v2:
  - Add missing Device Tree binding documentation (Patch 1/2).
  - Split the original patch into a 2-part series (binding + driver).
  - (No functional changes to the driver code in patch 2/2).

Adriana Nicolae (2):
  dt-bindings: firmware: Add binding for SMBIOS /chosen properties
  drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT

 .../bindings/firmware/linux,smbios-table.yaml | 26 +++++++++
 drivers/firmware/dmi_scan.c                   | 58 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml

-- 
2.51.0


