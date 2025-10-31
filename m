Return-Path: <linux-efi+bounces-5294-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516CC24E41
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B77094E2238
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C59346E7F;
	Fri, 31 Oct 2025 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NY03c2px"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A126330B03
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911964; cv=none; b=gq2PgWgcmCWJhowNnyXvQ0a9u3amjTj0Ehdknye4Mdi0YqNTQ85xdYisHc0GNfRfW2qCscHQPisZi2Vv8pb+yNEwRthZGWeTyRrLfyhmYgy6BmhycKyWQNUpQNOqAUy//RqPMULA7bWBNf1OH/F++FuiezI8eEnQTtrOoqg9/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911964; c=relaxed/simple;
	bh=QVnWjOAXd7aPZ68ee1nAsyAELz6UdZxKtmQM9NHmoz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d07K339YeZH98cSqWyk5qnU6UbuNWjfFKAHAz67bA0IdShaqJccWj9NvUyCm1UL3X8Ve8VUfReOYfZK0zr8IrbGpzlLb2ZL41vnfDm5Er3tvguuYpbgV4OfoO0M2vR51s8qROQxccAm7rGYC6mwDBFgN4SNCOrZshYvLQb0vWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NY03c2px; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5509894ee9so216302a12.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761911962; x=1762516762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqPGPofsDjLbOGH0rnbeWAJ0+JsLnxZQ9584rgmYpJM=;
        b=NY03c2pxudtxTpqhNveGHQacdPbIPcc7U9XcuvL/GN80R2O8D+/nmhxeyQbEbCVJf8
         zpoLu1y/eP9Hc5PeLy6vnr8tkTvLXn+TO/eAm1ZIKfUCofbZLTpOzwFfBPxazLN27Sca
         nPBIWku9mL99JDtxt3aC6s2Na1VTuX1xLn2QYOb68ZBN9DzKo2VSxM0kyOpF7cg3hpMq
         PACkE9o9vhnxSUPV6/D1PALFC/jHLiS7k9gfm8hX1q4GiJvglYjxZVKTcd2Dv4+S+yhs
         arP+Gb69kQAYF183bMrD3tNTQGzu4HCVCchD7AtgbQWcd+aAaWEn3knMCpGOaOZblh0Z
         WZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911962; x=1762516762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqPGPofsDjLbOGH0rnbeWAJ0+JsLnxZQ9584rgmYpJM=;
        b=P6eyKzTMyAlJ+mSFSqLYuupMi62J5L0T4VotLE8ysUqtr+vzMlk9fA/yHtg5wxQZuc
         YpUuEFiOJQf2v/PHKZDqL6N2ZplnraiKGrV3q6jTYeMPFCtRs85+T1Eh5s1P2aQmJ1VW
         tuuttbVMkduQ4IUfFrv1Ne20+6vabP2KkoJoR1ytn6tunsb9cBjxCA0eoH5cQ0Qs2Kf4
         FggSrj6hRVa0A+TmdOtImJizvsUjySqzv0z5AmudZxfbFGWEBRyPGdGZwLkOaenMA8I7
         Im+qa/JNz/FFOU48gCldGLkpys3hMG1O2BTiOPZ1p4gD1HbhbO/Yyg9QHvYQnDGsJrhz
         scLg==
X-Forwarded-Encrypted: i=1; AJvYcCX6qyR92g0IcvzzaicCT8smAYtwMFQd2E6N2NjpTn+v63aFj0HMT+wYeEP9EurFJYmG1+0ZohNERhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFiMmJ6isXM7glr/QdKC9bkyA5laNLU//Z45z1bBJPjHLA90RF
	2tEq7Bz5jTsKNh8dUzrmUOpCZrfISvIuea0HzRbJIfPDdbKVogdfmgH52HMM/X3qyg==
X-Gm-Gg: ASbGncsy0eMkgIF4DTB5MvtwWwDyom3Ea7BLGdZB7s/ToFgD5xCLsIG02qwXzbd84c6
	qXZjbPw+EdT5o2A76KZq6mgikIuk6qE8moLmeYA1G+a1yUV9Qz4XLCM7LjganzyRkyC9BRFYSi5
	hFdfp2B8Tsqs13Nw9VLSVi3d2mNJ86vsYxWk4GdlSmZk38+xO9PmT1ioBolbaUGxldp85bP4yfU
	GD0zXmufssPg34owHZt7G4lqIWNhEd+B/kTB/heqklNq/8YQdMgyxSjU7LdoNUmFrQ0BLbJkT6t
	wOeBKm1iZ7uBgCls5eTyIgC/LXOEBTrp/9gCXt2U5wcTK73695MOi9VYWNs0uCt9phqmVN1d19L
	JOrYku/gFKzQIoRK7ZOSR9UhyUKdTfvo17zZ8CwM/VpW6WeyqcTnkVr2KVn1bcQpj/aLAe7P+5y
	+8wk/ifdT/SWDwxI7HSckiFCh/CMlKA+5nzPUtaA7216zdv60=
X-Google-Smtp-Source: AGHT+IG5NB5+LRZtm0ExsbVUC4NOlOx/SwbXsQNMfhC5es5sBTc2hH9ErmodwvJH/vPOTN6UenpeVA==
X-Received: by 2002:a05:6a00:39a0:b0:77e:ec80:b3d0 with SMTP id d2e1a72fcca58-7a7797c305emr2344339b3a.3.1761911961486;
        Fri, 31 Oct 2025 04:59:21 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7dbb61839sm1973837b3a.71.2025.10.31.04.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:59:21 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com,
	robh@kernel.org
Cc: krzk@kernel.org,
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
Subject: [PATCH v5 0/1] DMI: Scan for DMI table from DTS info
Date: Fri, 31 Oct 2025 04:59:16 -0700
Message-ID: <20251031115917.713105-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031101009.704759-1-adriana@arista.com>
References: <20251031101009.704759-1-adriana@arista.com>
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
"smbios3-entrypoint".

This patch implements the driver logic in dmi_scan.c.

Changes in v5:
  - Removed linux,smbios3-entrypoint.yaml file and the first patch.
  - Renamed property to "smbios3-entrypoint".

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

adriana (1):
  drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT

 drivers/firmware/dmi_scan.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

-- 
2.51.0


