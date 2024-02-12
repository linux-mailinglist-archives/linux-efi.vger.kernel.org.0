Return-Path: <linux-efi+bounces-512-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11B851F9F
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 22:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A337F1C225D5
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03254DA1D;
	Mon, 12 Feb 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7SzWMdv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF784DA0F
	for <linux-efi@vger.kernel.org>; Mon, 12 Feb 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773523; cv=none; b=lCAAjQeOe3Z4X9ArlF7yQCv5sEVdYtvab/DCI09N9HDNLPoKJgl1vUIVED/TJ+cDpmYfeqGMxqSPa5fNx3QBQcCQIDl8XYV1HAP491zos9wWY5quFz4vBiiOJLUIouP5DHYB/IiE/nOo05PvOw3Pbet8yoiduAuHDM46LA5OGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773523; c=relaxed/simple;
	bh=dessp0Y0iydAOQinVxc9bvgHWYMKmwFPgKm6nVqH9Cs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=pHtHV3YG8967klfGvXNc2l/OomfIfrd93vQyzyWMn9lrCCJmuOlds2V0quQ+8vhd6zgdPOjKmoDjybmtqKeuscxsKBLcsdhx4d3HEB/+KF0afYE+LvEIt7en4L5eTwGsPFVGVyO9bYPU9Pvc91h/JtM3g3eIzxNaC4CpAfciP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7SzWMdv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so7579883276.2
        for <linux-efi@vger.kernel.org>; Mon, 12 Feb 2024 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773521; x=1708378321; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ35JcQOD8sngOY/PRE6LAzcrcvofp80cB9j/4A7v3U=;
        b=K7SzWMdvmea3hjbDgaKsjraad4vgI0rdi715XseSAT2erL0qicZ+OJQbMwTxgTW8IA
         3JVBEOyTlCqlKTiZHu8uuXGEU/cV/e9e2nVpRIRhrpIHWVnn5W+NQIgKrtJc9mITwzVO
         FBZU5IoogTq2BMhQTG52HG5W0IMS4+zGrCe4vzcm2kaNwVRUFxvJJxJKh2LRahtyqgSe
         4dNIb0eULHWrrWPVz1PgnoTrkJ71wAw4dAPviyCzJFuw/AzBDWRQeCQyKyKD3X8o/PvR
         sYJLPDW7F8Mv4e30ejWAxObfa0eKPJ9wcuZ+1DGHFT455OCyXsXQbL+aIN6XJK1z5J9d
         3x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773521; x=1708378321;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ35JcQOD8sngOY/PRE6LAzcrcvofp80cB9j/4A7v3U=;
        b=MHV2HZt3up+Qwneur4VGy3SYHfPvdB21w3FOd8QxzxpcIiYpuc6SdkBrcb9G9S/Z5a
         B8OZzZ3/P1EqiC4k4g0QWDvMoNBrlidkP0ZaGojES0dg1o8Nf9+aYR3GxfviZtr2PoXf
         pPDJ7XaBAgvJb8qw37dxxPZYw0oqDK8155q69ERozbFinNrvatp60mVA6IYS9hnheNBV
         faU5Sr+ljZlBzRAa3la1TUFPb8xN/ikyfMLg9x+kIYkyYKsxrlLzOwBspLAyRaLJfJfE
         NOm1lr42NO/fZdmthSmvCifS/dXnLy/vcCnsBh9fxROFQP9qdv4XM5vz42/aW0e0vBjR
         f46g==
X-Gm-Message-State: AOJu0YwhnWqcTNj+C8PtuFfGTLP6AbkjJCai2ISC7ZQ//z0NIzR9p1TG
	vRRtar6PUI+vdmQB5FTCA7JTIUdVrS67jY0jwf3MkCCVLUSGTkJuCb58Fsrt3fcM1dohBr8DBXf
	bO2CWtgPq5RjwEA==
X-Google-Smtp-Source: AGHT+IHrNTiOANFi6Wik/igA8DAgLlLqlmFQTuxh1SYfHdUxTWNn7OObp7z0Jf+9QFwAM3tEUCLtAp8BPCqfywE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:496d:5de1:a404:8bee])
 (user=saravanak job=sendgmr) by 2002:a25:6910:0:b0:dc2:398d:a671 with SMTP id
 e16-20020a256910000000b00dc2398da671mr2027894ybc.10.1707773521205; Mon, 12
 Feb 2024 13:32:01 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:44 -0800
In-Reply-To: <20240212213147.489377-1-saravanak@google.com>
Message-Id: <20240212213147.489377-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The post-init-supplier property can be used to break a dependency cycle by
marking some supplier(s) as a post device initialization supplier(s). This
allows an OS to do a better job at ordering initialization and
suspend/resume of the devices in a dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++++++
 MAINTAINERS                                   |  13 +--
 2 files changed, 108 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/post-init-supplier.yaml

diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml b/Documentation/devicetree/bindings/post-init-supplier.yaml
new file mode 100644
index 000000000000..aab75b667259
--- /dev/null
+++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020, Google LLC. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/post-init-supplier.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Post device initialization supplier
+
+maintainers:
+  - Saravana Kannan <saravanak@google.com>
+
+description: |
+  This property is used to indicate that the device(s) pointed to by the
+  property are not needed for the initialization of the device that lists this
+  property. This property is meaningful only when pointing to direct suppliers
+  of a device that are pointed to by other properties in the device.
+
+  A device can list its suppliers in devicetree using one or more of the
+  standard devicetree bindings. By default, it would be safe to assume the
+  supplier device can be initialized before the consumer device is initialized.
+
+  However, that assumption cannot be made when there are cyclic dependencies
+  between devices. Since each device is a supplier (directly or indirectly) of
+  the others in the cycle, there is no guaranteed safe order for initializing
+  the devices in a cycle. We can try to initialize them in an arbitrary order
+  and eventually successfully initialize all of them, but that doesn't always
+  work well.
+
+  For example, say,
+  * The device tree has the following cyclic dependency X -> Y -> Z -> X (where
+    -> denotes "depends on").
+  * But X is not needed to fully initialize Z (X might be needed only when a
+    specific functionality is requested post initialization).
+
+  If all the other -> are mandatory initialization dependencies, then trying to
+  initialize the devices in a loop (or arbitrarily) will always eventually end
+  up with the devices being initialized in the order Z, Y and X.
+
+  However, if Y is an optional supplier for X (where X provides limited
+  functionality when Y is not initialized and providing its services), then
+  trying to initialize the devices in a loop (or arbitrarily) could end up with
+  the devices being initialized in the following order:
+
+  * Z, Y and X - All devices provide full functionality
+  * Z, X and Y - X provides partial functionality
+  * X, Z and Y - X provides partial functionality
+
+  However, we always want to initialize the devices in the order Z, Y and X
+  since that provides the full functionality without interruptions.
+
+  One alternate option that might be suggested is to have the driver for X
+  notice that Y became available at a later point and adjust the functionality
+  it provides. However, other userspace applications could have started using X
+  with the limited functionality before Y was available and it might not be
+  possible to transparently transition X or the users of X to full
+  functionality while X is in use.
+
+  Similarly, when it comes to suspend (resume) ordering, it's unclear which
+  device in a dependency cycle needs to be suspended/resumed first and trying
+  arbitrary orders can result in system crashes or instability.
+
+  Explicitly calling out which link in a cycle needs to be broken when
+  determining the order, simplifies things a lot, improves efficiency, makes
+  the behavior more deterministic and maximizes the functionality that can be
+  provided without interruption.
+
+  This property is used to provide this additional information between devices
+  in a cycle by telling which supplier(s) is not needed for initializing the
+  device that lists this property.
+
+  In the example above, Z would list X as a post-init-supplier and the
+  initialization dependency would become X -> Y -> Z -/-> X. So the best order
+  to initialize them become clear: Z, Y and then X.
+
+select: true
+properties:
+  post-init-supplier:
+    # One or more suppliers can be marked as post initialization supplier
+    description:
+      List of phandles to suppliers that are not needed for initializing or
+      resuming this device.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+      items:
+        maxItems: 1
+
+examples:
+  - |
+    gcc: clock-controller@1000 {
+        compatible = "vendor,soc4-gcc", "vendor,soc1-gcc";
+        reg = <0x1000 0x80>;
+        clocks = <&dispcc 0x1>
+        #clock-cells = <1>;
+        post-init-supplier = <&dispcc>;
+    };
+    dispcc: clock-controller@2000 {
+        compatible = "vendor,soc4-dispcc", "vendor,soc1-dispcc";
+        reg = <0x2000 0x80>;
+        clocks = <&gcc 0xdd>
+        #clock-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3dfe7ea25320..79719af714be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6055,12 +6055,6 @@ S:	Maintained
 F:	drivers/base/devcoredump.c
 F:	include/linux/devcoredump.h
 
-DEVICE DEPENDENCY HELPER SCRIPT
-M:	Saravana Kannan <saravanak@google.com>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	scripts/dev-needs.sh
-
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
@@ -8295,6 +8289,13 @@ F:	include/linux/firewire.h
 F:	include/uapi/linux/firewire*.h
 F:	tools/firewire/
 
+FIRMWARE DEVICE LINK (fw_devlink)
+M:	Saravana Kannan <saravanak@google.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/post-init-supplier.yaml
+F:	scripts/dev-needs.sh
+
 FIRMWARE FRAMEWORK FOR ARMV8-A
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0.687.g38aa6559b0-goog


