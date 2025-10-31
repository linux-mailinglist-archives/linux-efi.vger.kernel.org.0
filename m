Return-Path: <linux-efi+bounces-5280-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28865C23DCE
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447E83BEE02
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4D3043C8;
	Fri, 31 Oct 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J0pIiH9Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A92E9EA1
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900107; cv=none; b=S5skJqtFvMmevWvmiDPXYliocK5/YmfUiPwosm7N8kuNFXFyYydiGZlA22RaZcjGRGRLrnYnH0eX67X24vwZBJl1m1uttY2Y0derCxTqwvRH2qxg13aNpKADnKULMDdlep2P+yGHE1juyl55xzJ4WeNsSxFAYX8lNdSl1eBhR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900107; c=relaxed/simple;
	bh=q7F646AzdYc76OTBCsP9t3pDfnvuW4UFLdlFD6HwKxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhRBd/JQniCtZDdaM32TPpySaUVf5bePixpajrmARsI8aVzskOaPyXuYT+Mpd4sSc4W43MvHzBfQg+eFWWuIrVU9NI6RLbV2gCKK9mnVSbjEIaVBpYa+kSJsBtzaIvI+WnbBXHf3QlGhUNNJTPRDEes9txbcNitHTVWJ9M627/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=J0pIiH9Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295291fdde4so622995ad.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761900104; x=1762504904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hrqrHmQlBw4QJPx8h9w/0Rntf7sgvlCyYtGGSssQKQ=;
        b=J0pIiH9Zns5a9giqqyT+bqBh5h6gpFTWOahr5LqanRAml6RR6j4Xe8nuaeVXuadGvm
         TWRPNcarXt64HYgSnN8F/73Go5uymsfHqutRx5YQcCUYefbs/ClG/TgKIq4bPZjDV/17
         NJTo6QRJVjHBuXByYRtiMN0rMMA73aFox5BXe9oHki7TXyUVcM5TtAxsVEoL0iUvKy9Q
         deILWhvKH5t6C1WiWJb6MmJXez/yThalOVUCP7QwGVnvIsL7oXRoqSUEt4i3IFvWx107
         7Oeit/gv0azpS+u5GsCb4gVA1AD9i9IAxKMJfyguUqba/o7h7X0uEnm4AIjoutUYoEuu
         gl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900104; x=1762504904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hrqrHmQlBw4QJPx8h9w/0Rntf7sgvlCyYtGGSssQKQ=;
        b=wJRDCGFpffeAFILWprx9zEyrszO3QFJjZYUnmO5qatgq/NnZsjUqFmzQd7Y8oVnySE
         Nw+0Yha9cNxePlPDriJlKdVtal/U6WUgToAfcrRyguWc4C5ETTPqskYvuHhc2TKQAyon
         PKfkCh5Gn5QCoN5coqbVv84/yQIxHa92SOo7sfXQkG7P9EUIeZ0GIa9Pm04RCOO9pF5z
         UBWvtv5tNASzSkQu2Qao8GlZHONcL5fwD1rrwYJ3cIPbS5iGcL7N3M3T2/OLTQvfCXRg
         4cKMUbiTKwodPuIzandjt7m0tteAKnGvUYb7S4gl0smQgNRL9cRTaZYbumKfTaVteNe2
         WRYw==
X-Forwarded-Encrypted: i=1; AJvYcCWXc1Vq46PqdcoPbM2+VHcDGQXNX0ZtDSq5CUypNMXwutbxfaoKRz2ECGkWEtZuMzbAnveGYpxxq8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFNoUCZ9LBdK+TG9AXe3wYDI/gF/iwNuhYT3fKeDhJDA7t0WW
	PAQp5wfnz05UQOe+8X8XMMWc5lixW+Jc32I7iZAmQyJzeUMhwYehIIbWG/2+6cn4fQ==
X-Gm-Gg: ASbGncsPa20CI5BYmKyFj6Fss7Ib9fVgAyb2KCd+Tx5WdYjYOADjMquO0nX5noCE7fE
	kuMA6BLjwDTUBd41pL8Z1VWlUxz7WTyjYCXx8T/MvikjoV8mQdR2KXggevGE1GDtl3u3ZEVEBtQ
	BJKJoRp70Zpf31aeT7Vmax6C17D/JtWb3toaZY0yhpRAH5qAta6gkBJGr1zvVWWgpiOu7xgZntz
	fc22QW9/IHo+VxSRRaQRnY+ZdAdrePKnG4vA7x2YPkmCoa8XgcWv93CVFQvKMwtA3pqzrfCslm7
	BSKntf3p5p41MZEaLg/H5c5w80UK4WUvTKxSbQtV6p8l/QM/YYLHQ+FJCgkg3vFN+RWYRqG8GiW
	Q/C224RcuBDQxECtvmJVT/AHslyV4je5lkBetkSm4qT94ucV21expS2HPuxzbehM3yKuQd7mIwX
	wwqTfBs2iJ41YfSYBIfvJ2wE0+8RQTIxIKfymWuxxlhTo8uzE=
X-Google-Smtp-Source: AGHT+IHV+akqMcvywb+3Zt1mSlS+9NiogDpHMm8+bQv2d+CTnogKsWMGLQBpDjl5fxPEL0XtSkMFeA==
X-Received: by 2002:a17:902:c412:b0:264:cda8:7fd3 with SMTP id d9443c01a7336-2951a46d112mr24811375ad.6.1761900103678;
        Fri, 31 Oct 2025 01:41:43 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm15333505ad.84.2025.10.31.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:41:43 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: firmware: Add binding for SMBIOS /chosen properties
Date: Fri, 31 Oct 2025 01:41:00 -0700
Message-ID: <20251031084101.701159-2-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031084101.701159-1-adriana@arista.com>
References: <20251022114527.618908-1-adriana@arista.com>
 <20251031084101.701159-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adriana Nicolae <adriana@arista.com>

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
 .../bindings/firmware/linux,smbios-table.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml

diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
new file mode 100644
index 000000000000..b78d8ec6025f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Arista Networks
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/linux,smbios-table.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Memory location for SMBIOS table 
+
+description: |
+  This property is used in the /chosen node to pass the physical address
+  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
+  tables from firmware to the kernel. This is typically used on non-EFI
+  platforms like ARM/ARM64.
+  
+maintainers:
+  - Adriana Nicolae <adriana@arista.com>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  linux,smbios3-table:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The 64-bit physical address of the SMBIOSv3 entry point structure.
+
+additionalProperties: true
-- 
2.51.0


