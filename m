Return-Path: <linux-efi+bounces-171-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB880CF3A
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 16:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721D9B20ED2
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D704B5BC;
	Mon, 11 Dec 2023 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eH/hVFqX"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443E11F;
	Mon, 11 Dec 2023 07:12:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29B90E000F;
	Mon, 11 Dec 2023 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702307572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFRNTXiHpB5q4OBf51HMQ0MXG7WMAPuA7YrMIImpGe0=;
	b=eH/hVFqXLeGU/34uyK7mc9EgkXkva33CrQszVtV40e1/5u6zGyGh9h36e4GlExYnIYOOHh
	+FEJ1Q7arcqVy235e191ce9lFPMVqL302sckpRP2VeKq7Y9d9WFAsh9mBxRC82//Ef7t0x
	AbRDSZmDH8bl8BhgULMlAkSLZNByGPttTtIxJc7poOMK3XuErAyfjYaN7GAumSJtRmjUu+
	PB3e6PZSdQP3ctZgagW5pPmILOl/EVMhN+3Er7BTjn0QFEWILCfLmQ1p1ETYt2a7NPcbAT
	5+b4qBtrDNqT6EUmLDIH71QbQF3tzOle1vR7RX+xk/LkFxO5e383G23QUMe8Kw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [RFC PATCH 6/6] dt-bindings: mtd: add GPT partition bindings
Date: Mon, 11 Dec 2023 16:12:42 +0100
Message-ID: <20231211151244.289349-7-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211151244.289349-1-romain.gantois@bootlin.com>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

Allow parsing GPT layouts on MTD devices.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../bindings/mtd/partitions/gpt.yaml          | 41 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/gpt.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml b/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml
new file mode 100644
index 000000000000..3c538562e3e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GUID Partition Table (GPT)
+
+description: The GPT format is commonly used on block devices to describe a
+partitioning scheme. It mainly consists of a Legacy or Protective MBR for
+backwards compatibility, a primary GPT header with an array of Partition Table
+Entries, and a backup header with a backup array of PTEs. This partition table
+format can be used on MTD devices, specifically NOR flash devices, since NAND
+flashes are susceptible to bad blocks which could easily corrupt the GPT layout.
+Logical Block Addresses (LBAs) are defined to target 512-byte blocks.
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+select: false
+
+properties:
+  compatible:
+    const: gpt
+
+  '#address-cells': false
+
+  '#size-cells': false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    flash@0 {
+      partitions {
+        compatible = "gpt";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..f2b1565d5d0a 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -18,6 +18,7 @@ oneOf:
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
   - $ref: fixed-partitions.yaml
+  - $ref: gpt.yaml
   - $ref: linksys,ns-partitions.yaml
   - $ref: qcom,smem-part.yaml
   - $ref: redboot-fis.yaml
-- 
2.43.0


