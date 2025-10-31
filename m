Return-Path: <linux-efi+bounces-5288-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31CC24624
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ECE189D145
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99333859E;
	Fri, 31 Oct 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IOJbVzeU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A15334C28
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905436; cv=none; b=MYYWb3+JkqrrSq9BS1zY+AOQweRQ/JVer2h+wGaSQ+hkK3CTpTqHamS3z7BnAm32fYeTVlK9IezsRYzxPv0G05cQyzXrr8oViWWArUzj44LuwVsDVWgudKliQmnMwr4T07fqItgw6iqcC3RATSWLFjjiCnctlawfHFAygg6uwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905436; c=relaxed/simple;
	bh=RbMe08vlLWqNMGEsZHE9UGbw90gmR9WrQSsWUknLDWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK0ZJoY66+YrTJOwdjhc70J9OMlxYo4KlOI7UMcIukSKgqbet4B0OwX1evW37gfPH+4SCjLS8GcF7whwza3DdXITyiKxovx85ny3Y8vOkfp97JPbXVGdllarE6H1iGdIdXSHZH/uftT4AuZ7iOpEPBUjeLNdsqIdJZcWsqIEnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=IOJbVzeU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a2687cb882so334874b3a.3
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761905428; x=1762510228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCqSLgxWkeVXekojaut52uxcCHN+33LWNwdmvrJ9Ias=;
        b=IOJbVzeUmAB7TuKv9QtAqoc6fVb7bL/e9tuiB8ewibay0cEamF+4MOmEEK2FAcsuzo
         qgoti8+g8PHV0zBePZpJH7KWCyZBXRl7HCGiXMe1Fx5aOI81lHLCl38PXk6D6pSxrY1M
         S8Z7xZxCAVCXSNIc6PkDRA5lG4gBhhLVLHqElp9Dh+shK+W5buHAXRC8wbpNhfSqQlKg
         xl8FFXm8wu9VxCth0q0WYP8DFagr0a9+V+cR74g1IQUNwVekJbx4RvULMFzdzDxVbPkm
         FzF5RFGdQWaTAUQcbSPukzC+o4TIR4aR1KAha3O2Au+aspZojk+84dDdMamTBal6RtgB
         dEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905428; x=1762510228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCqSLgxWkeVXekojaut52uxcCHN+33LWNwdmvrJ9Ias=;
        b=w3MeswdHC+GuyEEboUBspgb/6V4VL31hB8AjSOHGOkj3x/DK3SXQCqcDfdKSBoOp3v
         Kpd6YUGrUscO/sxg84CsGFo8ad2qq2Ql1hMFjZVyc39LnrmqdI9GqDICizlkStMnzGyW
         HoAHfJL4hMhhzh+7aDlpnOs9VLXZrSfVABkHsxOdEos8C4bblkgNOrfNdWNuw/Qp5jO2
         VK+mOpaFaqS5evUSdqcWcSR6Fy1Wn6RjS6QAa7+HosFsmCX3cgthWQ/j+EKf4ocV4HaC
         2iNs2WXQukFYKwDXEMdyiJXxlKZFsh+Al+FgwOZnXY2apjT19FFaQOpogtb4Rfw3EXoO
         iYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhngsz+o4Sy8U0zz/6b2wCr+2ObX8nj93Veeg+DaSfUlvKNGyzEL59d81+VI/IwffEczHLJq+xOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJeK3grzj/o65FI8cZtxbrHg0ubONyervJppzeAAdLa32PyrY
	X9GollNcAH+b50nPoWcPgbuSdQSdpl3d69U74StrVH1yARawH9VgodeS7zIylO9zYw==
X-Gm-Gg: ASbGncuLL7q1UehpAuS/PHE92Z9jawzLFxgN+H8A9k0qQCNUCcVLO9XKq9hHmBKQhFx
	KKa0hexPOdwz5EjvP2o4tPNEERqpXHcvsiKj8ZU8UhrMI+cUx3VmjECh7KQ7j0i47OeW6PS1Ce7
	Cw0jsZZbNh0RRrVLi1kdQ7Erzwy7BKc0vwowKmNRoyTabAJQiLzOQZvXSHojL72mFxC9/xGWxy4
	byG8AnsUUlHuYuqUkLUAlSbtp7R5cvpHo/MWJPXItQNv9YgBDBFHbI4hloL1aQNxhGPTZAPON8X
	JkBLUwWfIWY4MSXyaQuYJbD0M02NKeUYG3piue+iXuoLMmBkZaZymi2W7Wb1qEFPGYHIvsbR6MC
	TjC4J+0VDwl22Y/3suzbxGD6X5dSQdXXcUTsB2465MyLuv+KiqZwushb/v9X1+TtQBBCW5FWMSy
	9ny+RRrlE0nA6/Wb0Et2ZNEGWCH/trmLN+ECgC
X-Google-Smtp-Source: AGHT+IGBRA0aoJzpM2hpeOsBENB5JR9uquyfQ/tR+Q/1DkGVQwwAaqar76fSPxcZLwaLxPBcSDvpSQ==
X-Received: by 2002:a17:902:ec86:b0:290:8d7b:4041 with SMTP id d9443c01a7336-2951a524b65mr23527095ad.10.1761905428261;
        Fri, 31 Oct 2025 03:10:28 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm17458545ad.99.2025.10.31.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:10:28 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: firmware: Add binding for SMBIOS /chosen properties
Date: Fri, 31 Oct 2025 03:10:08 -0700
Message-ID: <20251031101009.704759-2-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031101009.704759-1-adriana@arista.com>
References: <20251031084101.701159-1-adriana@arista.com>
 <20251031101009.704759-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: adriana <adriana@arista.com>
---
 .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml

diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml
new file mode 100644
index 000000000000..4d1521c685ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Arista Networks
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/linux,smbios3-entrypoint.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Memory location for SMBIOS entry point 
+
+description: |
+  This property is used in the /chosen node to pass the physical address
+  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
+  tables from firmware to the kernel. This is typically used on non-EFI.
+  
+maintainers:
+  - Adriana Nicolae <adriana@arista.com>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  linux,smbios3-entrypoint:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The 64-bit physical address of the SMBIOSv3 entry point structure.
+
+additionalProperties: true
-- 
2.51.0


