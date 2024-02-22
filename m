Return-Path: <linux-efi+bounces-640-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B413185F017
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 04:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414E51F21106
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5841C6AB;
	Thu, 22 Feb 2024 03:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRy22DHV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA11B7FE
	for <linux-efi@vger.kernel.org>; Thu, 22 Feb 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573604; cv=none; b=koD2mV19FiT7OAEfDixNZZBpM7epPZHXZbIbzYjyPiT5hby094UJO88XweT+CMCDnN6JqLyciJE+OIS7lWAaD0+HH70c/3wttaczR/bA1z6139nho/1d82ZC00XUj5eHFrZ/3dLO43PeFNZnG9Pbk3eK9xUyuJ6GQEnlDnjnicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573604; c=relaxed/simple;
	bh=BYJ0NZJqbtsDWKL5M2UsBKoeU9XD22jULrfryxgvv50=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=OU+vJ1WJ/izi0NJqQLYLAUOoUptWeekz+XjcKiWqvcKqD3zR/3HfYPE6RqQfMtpO2caaZN0pY/Ytrlb2cANRRTGRwyZhGvmr+ezFbeVx5sY9sg6UB162tag9IqHUgmEkKnZFVgBlaWqL+stqknwgs5KNgqa3cggRBmB0c6Qrplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRy22DHV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6085e433063so51729187b3.1
        for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 19:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708573602; x=1709178402; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=raWZBAYgki529t/WhxJsWod/PF9BbEcSvIxTt/14UCc=;
        b=zRy22DHV0i/8GoOTEt5NG9RaIEs4ONI6qGKz6htHAyLu0Y+ze9SUdiW2cjkX0yaar/
         5py1BMb+AXTxLTxM/r5bmJE/TFtQveF8t6Wh4y7/mE/GObgFuXoGxWoJ0XU3zlQU9Y0l
         MkAZ9LzptdK/LCKuVz9Q4aohP6s4kottbwx+xHwg/6IMFQj+xwCiUSQO2oO5+zfKYP3L
         iCyh2XeE6ocTm9+OUU1ti8E5mdzxOUj3R+ooLnffQtg2CgOgdDcZs6Ej8ixOe5QcCubq
         meaulOtQklEC+J1kZ7eq6BQS8uW4mXGYNol8htPnb0gRT2+jSbrC+kG4X5ZpCydPSwNY
         +sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573602; x=1709178402;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raWZBAYgki529t/WhxJsWod/PF9BbEcSvIxTt/14UCc=;
        b=QjqBe03gXanqdTfTmR9Ju+jZLO2inFWlZfTDMNGOBRGSoQ/E45x0SAp4S/y8KgO80s
         FFBorVdkakU9Vh5fXcBM5RBEnTgZcA2Opy9MvE7wk/HCXfx8/uCctUJAWWdLHDsYhmmq
         yB61CZDGigA10Wx8FhXkxX3Vlug5ieDZyqQVZR3E2ZG1ppF6lznOyxkjx2yge/etZOw2
         2ttX1CUPegQTrsnd6xWEGBVGLyRnzqlPY02PP9Rg7782BHgRFYyOwZvCaj+hW+63Jo8w
         oI62rEYoA+vcAQJ2yWLRuavzFJC6mxdOAlNu5/XhN7wOy0IkmEz+NwOAk8rvAfHYd8cU
         3Lew==
X-Forwarded-Encrypted: i=1; AJvYcCWRK+WuXvZWK9XkmowuBzAuk/x6LF9aLqjNvg5VOG0tmkqT0/tcyHEJNQuegtZgCaddejhV9Ua/1eumSV2w2Ds3Y111fLpL4aZe
X-Gm-Message-State: AOJu0YyDSPBWsQG4k1mBWl9V/f0jUxfTs0zuBfXfOKtvneVpfyI8VDjG
	QSCXAZrmyRasyCupEVfiJAY+EsgvgxG2gLJMJBIf5T3zX8cOcxaBq9T7SmaljzUbwMdpJ6CvMJh
	WwIqjHo8rMJgI5Q==
X-Google-Smtp-Source: AGHT+IE/lOZLkCoDwwKEREqFgcV+j6qm2injtDVFnE3QKKkoaWAEUaYOgBuNsQDaJd9X9bCZCw8l/KV68FOgUzU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:451c:c6c5:1fb1:a2a1])
 (user=saravanak job=sendgmr) by 2002:a25:b47:0:b0:dc7:8e30:e2e3 with SMTP id
 68-20020a250b47000000b00dc78e30e2e3mr329609ybl.2.1708573602344; Wed, 21 Feb
 2024 19:46:42 -0800 (PST)
Date: Wed, 21 Feb 2024 19:46:22 -0800
In-Reply-To: <20240222034624.2970024-1-saravanak@google.com>
Message-Id: <20240222034624.2970024-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222034624.2970024-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v4 4/4] of: property: fw_devlink: Add support for
 "post-init-providers" property
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

Add support for this property so that dependency cycles can be broken and
fw_devlink can do better probe/suspend/resume ordering between devices in a
dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index bce849f21ae2..15ccad6cba4a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1066,7 +1066,8 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 }
 
 static void of_link_to_phandle(struct device_node *con_np,
-			      struct device_node *sup_np)
+			      struct device_node *sup_np,
+			      u8 flags)
 {
 	struct device_node *tmp_np = of_node_get(sup_np);
 
@@ -1085,7 +1086,8 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np),
+			flags);
 }
 
 /**
@@ -1198,6 +1200,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  *		 to a struct device, implement this ops so fw_devlink can use it
  *		 to find the true consumer.
  * @optional: Describes whether a supplier is mandatory or not
+ * @fwlink_flags: Optional fwnode link flags to use when creating a fwnode link
+ *		  for this property.
  *
  * Returns:
  * parse_prop() return values are
@@ -1210,6 +1214,7 @@ struct supplier_bindings {
 					  const char *prop_name, int index);
 	struct device_node *(*get_con_dev)(struct device_node *np);
 	bool optional;
+	u8 fwlink_flags;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1240,6 +1245,7 @@ DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
+DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1349,6 +1355,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{
+		.parse_prop = parse_post_init_providers,
+		.fwlink_flags = FWLINK_FLAG_IGNORE,
+	},
 	{}
 };
 
@@ -1393,7 +1403,8 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-			of_link_to_phandle(con_dev_np, phandle);
+			of_link_to_phandle(con_dev_np, phandle,
+					   s->fwlink_flags);
 			of_node_put(phandle);
 			of_node_put(con_dev_np);
 		}
-- 
2.44.0.rc0.258.g7320e95886-goog


