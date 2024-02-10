Return-Path: <linux-efi+bounces-501-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA84850259
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 04:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4F228769B
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85156288B0;
	Sat, 10 Feb 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmwUDtzn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDF31EB49
	for <linux-efi@vger.kernel.org>; Sat, 10 Feb 2024 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707534369; cv=none; b=mnvFAFGrWJ6pTRH8z9DTCGi6AHk7eKTbMgllwp+EYgA/7T27LEk+uZbLPhpIahUDp6/P1coe4meiC+gslTSY+HQfz4ESY9h3YKym5FX9bQifE5V+3VPhvPfOTmSR2qIchD/pAicrsdHIUDJ/0KGv1o+P7WfUqRN0FQcSavnDJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707534369; c=relaxed/simple;
	bh=DDHVFJw3laeMHNAD1vbR4GSUPDGUWbNquUH9HPPVOrQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=p5uIXY7Gw6zOr1smgGDawfCca5HrowP7sAsfz8YQeVPMMxzo2kYpT+xgr/Ye4eR4wDBu6eVaalw1A+ZeL7JhGOuikrruHfsAk8dPfP9SScm9vmn/zixFrllo/rSxktej9Ac35nOY3EyJuw3XqBDsTsGCw7eA5Kc0i7gOzfp+oVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmwUDtzn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a4923adaso29403217b3.0
        for <linux-efi@vger.kernel.org>; Fri, 09 Feb 2024 19:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707534365; x=1708139165; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuboiLM3PiYaUht/sxY2s97Ou0aQoJajqakxuwnzARA=;
        b=MmwUDtznU4pxEV4YFkbbIuvyK8q+MXrRpXGgAtD4vZCbDvQHhZ8VOe8H4NXU/A7iEp
         k6c7lTUevqRFn/tAlvcZxnv29/YviWAEdZVHZ3sFNj9Svs2WHV1k5oxqZWcCIPOTOx9C
         5zEBzpCPUNzTrT3Y1AKjUaceKNe2nREYuB7AtTaBfoRFn8n8aOthXZ+e2vAFOw93n9AQ
         EZKB5pgOEGDw7rRJMVW3mqrmnCS4181Uv+dJEG9fcodVrroqyZIRy8wjTiF1jPwVEaOf
         Td3NDLI0u5TQJYZMzrH1cICk97SEVJcELB+Y/2AyYj9HdWF8qZ4fa9FNnPh8ZHw8iQGl
         Avqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707534365; x=1708139165;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuboiLM3PiYaUht/sxY2s97Ou0aQoJajqakxuwnzARA=;
        b=qvA9GuMbK+UiPvp+wRAJPw96LiGmexyDWr8Jxs1bumavp/sVUgXkBgwZ20ZjYba1mr
         wkg8G57BuWoLUhG2LiEpJHhcyy4G0SUnmnwk1SkLyBvk64IoGA3EOg5WJKJiq4bi+My8
         rXwGkamqnlQR8SpmwbHFUhm3FgCPyYPIse+vG8csuHtpWk+Ub+LI/EcPMQsP5guzcYjn
         vFUj1hPHUs7Bm8Bb53z2eWhY94gpFbAERyRhBIebCX7USlyXrFsCZAzLtS485Ft1aYNt
         v8gUkDL9dhN2sZfbsTJVpk2hj8BVcix07CVBgk6JwLh5wg2gbLL/SeieLfc/XWszBXxf
         l2vA==
X-Gm-Message-State: AOJu0YweJWl3Bd8axCy9TQF+t/AUNcyb4qgrGxv7jZYfzlvt5sxo5h2U
	zCQy3g0LqDMO5wzS0QJU54sBtbLZGrpdeu0dDqRiJC/kHmqnd3AuZRBBserdPXd5KFnQJIkineE
	xrC7OSA4PNtc/HA==
X-Google-Smtp-Source: AGHT+IE/vc7byscSKQlhBHSuEvA98GUKQoY9I3PklaoxpxmeP7d7CBzzkKxMJj2zLKm1tFym5Jaqg+ad29EuZwY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6b44:91e7:13e1:5d92])
 (user=saravanak job=sendgmr) by 2002:a05:690c:884:b0:604:d53e:4616 with SMTP
 id cd4-20020a05690c088400b00604d53e4616mr179243ywb.6.1707534365489; Fri, 09
 Feb 2024 19:06:05 -0800 (PST)
Date: Fri,  9 Feb 2024 19:05:46 -0800
In-Reply-To: <20240210030549.4048795-1-saravanak@google.com>
Message-Id: <20240210030549.4048795-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 3/4] dt-bindings: Add post-init-supplier property
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The post-init-supplier property can be used to break a dependency cycle by
marking some supplier(s) as a post device initialization supplier(s). This
allows the kernel to do a better job at ordering initialization and
suspend/resume of the devices in a dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../bindings/post-init-supplier.yaml          | 99 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/post-init-supplier.yaml

diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml b/Documentation/devicetree/bindings/post-init-supplier.yaml
new file mode 100644
index 000000000000..cf9071ecd06e
--- /dev/null
+++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2018 Linaro Ltd.
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
+  property.
+
+  A device can list its suppliers in devicetree using one or more of the
+  standard devicetree bindings. By default, it would be safe to assume the
+  supplier device can be initialized before the consumer device is initialized.
+
+  However, that assumption cannot be made when there are cyclic dependecies
+  between devices. Since each device is a supplier (directly or indirectly) of
+  the others in the cycle, there is no guaranteed safe order for initalizing
+  the devices in a cycle. We can try to initialize them in an arbitrary order
+  and eventually successfully initialize all of them, but that doesn't always
+  work well.
+
+  For example, say,
+  * The device tree has the following cyclic dependency X -> Y -> Z -> X (where
+    -> denotes "depends on").
+  * But X is not needed to fully initialize Z (X might be needed only when a
+    specific functionality if requested post initialization).
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
+properties:
+  # A dictionary of DT properties for this binding schema
+  post-init-supplier:
+    # One or more suppliers can be marked as post initialization supplier
+    minItems: 1
+    description:
+      List of phandles to suppliers that are not needed for initializing or
+      resuming this device.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+examples:
+  - |
+    gcc: general-clock-controller@1000 {
+        compatible = "vendor,soc4-gcc", "vendor,soc1-gcc";
+        reg = <0x1000 0x80>;
+        clocks = <&dispcc 0x1>
+        #clock-cells = <1>;
+        post-init-supplier = <&dispcc>;
+    };
+    dispcc: display-clock-controller@2000 {
+        compatible = "vendor,soc4-dispcc", "vendor,soc1-dispcc";
+        reg = <0x2000 0x80>;
+        clocks = <&gcc 0xdd>
+        #clock-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3dfe7ea25320..40fd498543a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6055,10 +6055,11 @@ S:	Maintained
 F:	drivers/base/devcoredump.c
 F:	include/linux/devcoredump.h
 
-DEVICE DEPENDENCY HELPER SCRIPT
+FIRMWARE DEVICE LINK (fw_devlink)
 M:	Saravana Kannan <saravanak@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/post-init-supplier.yaml
 F:	scripts/dev-needs.sh
 
 DEVICE DIRECT ACCESS (DAX)
-- 
2.43.0.687.g38aa6559b0-goog


