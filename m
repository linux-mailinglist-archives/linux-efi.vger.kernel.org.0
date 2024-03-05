Return-Path: <linux-efi+bounces-717-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E146871522
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 06:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998E7B23E95
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8C44361;
	Tue,  5 Mar 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1FpB/Jy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334F45977
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615114; cv=none; b=LpKRo3N+xYqDLD7z4EmL9I9HTVNJ4xre+r5dpsjVDBpNnGfKpmRDC5HBTZla1kEyZB68NXflmlhuCG55DyMlbtH8WvUu+agMcYsZs7Xvj+2P8OZcrQ795kZng+H4yrPTw8je6cPHMqfhp1WhmarK+WNoAkw9An4fE/IBI7NqXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615114; c=relaxed/simple;
	bh=FgXbHdYbzu0zV1Fn+0Sm3Z2N29NaUTHdcJVRWQiFOe4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=QrGZUzsD8WO9p6YMtnKI2n0W0zr2Vux/WoppcnsIlnTaTUuJrH7SoC6MCoFoIv6PyVvVwdtMK1vJf9S3eGGaNqgc4ai6CzsZMSR0LK9StvmL9Z8NDSn60sWMiMdImv6WOrqAuKKlc/QNAWZLKE0K+MP1VjxoGsIuvg+oGIr5sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1FpB/Jy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609c800881fso7634037b3.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 21:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709615112; x=1710219912; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AK1RvhjBdB4hDhmPTNWoUxZx2sr2tNAM1/EjrC2JoM=;
        b=y1FpB/Jyx5C6fSs1Ap3r6/w8H9k3Y60pZNpsSMYvIHhyejogBqCcddbXL+JrFXK4jr
         LVGPWpQfaA9gk8QavlnbBmNOLdMXd4LKwFa+pdSqStD85Si0Y50hXqrLMdhAL5RG1K92
         jUFHm95otGHqlWABF6YAX33/2QUJQfafQwseyAXK9xZWiYYzZ666Gut3dTBvV/pcQEdg
         QclDAB1zTRRbNCO/YzoHmyzYndCM+/wVLt/MgEMBoF/4GhWn3gbxXo3upofhlctmnmzK
         XfzdoWMyKEcjnnePfb6EOeXBpW5LsWbH1PGEFxin35vVIt/L1P/NaQrMxqkrDkCz4l95
         hcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615112; x=1710219912;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AK1RvhjBdB4hDhmPTNWoUxZx2sr2tNAM1/EjrC2JoM=;
        b=f8IPOw816FyPg0i+9uRTOXBLBwPQKKFwEIMNqnBlds3YsODC+oG/jE8MTF3aB+54rX
         wjbfm6zXl5kdkO4gzsfuQMfGueBY+xlvs7KLIFg1MX/cwKhj5Hxx7RoUHlFp9dTYv+VY
         569jCCHFq5pEiS2mhbdmGzyaTi0R8/EkKWyYqcgxA9e744kcyIo4f8A9xUjoPaAwiJwj
         X54Q3cYfjjSnPaOVwu63qO2DQLZczJPE/9e6YCCwiDMxMCYIrWci3g1uVFriAf1/r0Vr
         LxMVYiKPaIbPzjjlpFG968+aI1hbDcsNwAlPyi9vQk5d9yHJBOpdC/ypx00Ml7qV3W6N
         CY+A==
X-Forwarded-Encrypted: i=1; AJvYcCVExZAK9IVCJnvfR/I0tgI/HfpiBHqSdoUZ0gU0y2ZYb1GNCrCIEjsBYYjvfZgmNHzhYbk2t5jrRKOzwTGqPsOZplazVNdO3cCx
X-Gm-Message-State: AOJu0YymZYAp2xTxOzAL28ICCR6WOWhbd5XYXXMcPEvYB4aT3XT6qrVg
	hvxAW4l8kkPURe3mGf3EKtAy2EVyrq73nIhN2yhHPMoBn6NlKpEBilf4fehk4rX8Y6jgXErQCTh
	Ea3bKA2ma16iqtA==
X-Google-Smtp-Source: AGHT+IH2KzRd8ijTXs0JYOCur+G/X47aFWeD6zQZ4dffImANFZRDeEhSxZMnhoOcs3UOxIj6Er5VZdNgNg1tQNM=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d64:6ee3:55a9:46e6])
 (user=saravanak job=sendgmr) by 2002:a05:690c:c9d:b0:607:cd11:5464 with SMTP
 id cm29-20020a05690c0c9d00b00607cd115464mr3058844ywb.9.1709615112162; Mon, 04
 Mar 2024 21:05:12 -0800 (PST)
Date: Mon,  4 Mar 2024 21:04:56 -0800
In-Reply-To: <20240305050458.1400667-1-saravanak@google.com>
Message-Id: <20240305050458.1400667-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305050458.1400667-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v5 3/3] of: property: fw_devlink: Add support for
 "post-init-providers" property
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add support for this property so that dependency cycles can be broken and
fw_devlink can do better probe/suspend/resume ordering between devices in a
dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/property.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index bce849f21ae2..b517a92dabca 100644
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
 
@@ -1085,7 +1086,7 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), flags);
 }
 
 /**
@@ -1198,6 +1199,8 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  *		 to a struct device, implement this ops so fw_devlink can use it
  *		 to find the true consumer.
  * @optional: Describes whether a supplier is mandatory or not
+ * @fwlink_flags: Optional fwnode link flags to use when creating a fwnode link
+ *		  for this property.
  *
  * Returns:
  * parse_prop() return values are
@@ -1210,6 +1213,7 @@ struct supplier_bindings {
 					  const char *prop_name, int index);
 	struct device_node *(*get_con_dev)(struct device_node *np);
 	bool optional;
+	u8 fwlink_flags;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1240,6 +1244,7 @@ DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
+DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1349,6 +1354,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{
+		.parse_prop = parse_post_init_providers,
+		.fwlink_flags = FWLINK_FLAG_IGNORE,
+	},
 	{}
 };
 
@@ -1393,7 +1402,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-			of_link_to_phandle(con_dev_np, phandle);
+			of_link_to_phandle(con_dev_np, phandle, s->fwlink_flags);
 			of_node_put(phandle);
 			of_node_put(con_dev_np);
 		}
-- 
2.44.0.278.ge034bb2e1d-goog


