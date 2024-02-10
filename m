Return-Path: <linux-efi+bounces-502-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E663585025E
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 04:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544E6B27810
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD32B9D0;
	Sat, 10 Feb 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvopdkzM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531362A1AA
	for <linux-efi@vger.kernel.org>; Sat, 10 Feb 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707534372; cv=none; b=Jy15pxrZk4GF3TxBFEwaWj9zja2+edA30vUEsa52N40uqPn4zVpcHzfA79/cn1OJuzC/Fwew/nP0FfuADMQ9H5tnRewkZNACkXrrsQ6kFT2DL+Yy40c8WmggKkPMH8PoYg7H6etLJdkveZ13aKWnyJ0s8sMgqEYAAY6W17PWblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707534372; c=relaxed/simple;
	bh=09nOuvy1xCjK1iYqCopDQXrnPVKpNm2a5rJaJXsm9lU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=V62XNQCNaSyQs0APOrTIRyAdFp5qKgLp/ECrs9ap1hd4NgZqVylNQijGT+GHg8JlBCW1odd3sWPTAoim3bP35ifb5By7CAXRjhQIykicoKAyFXp5ibnzUt3UA3zdDlPNYtRi2V5fPugfkX41IccSzj/ziUYQbjQXnKLCSYTddmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvopdkzM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so2774488276.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Feb 2024 19:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707534370; x=1708139170; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5s7UC2LI5606ztlkySRh4zEDw9ZNIX2+7Suzh+XsVU=;
        b=pvopdkzMyY7gcSDnmuhMe1Lrbk1BKJR51rbeNR4MJLexjtGVOpCgs29lJ/dds4s8ZQ
         ECWW/fQO6z9RAjRwBm4vQXP9XTyrPdmqm+UIvEAkCwh680T3W4TY9rOHlqDbQULHo7aK
         g7eAqBA1kpjkaqgGNM2mPe1eqhWyqI0bcmpk7BTziBBYJsFEzyqzit+Otvz/EhnFxzxq
         U9Dj4wP6V25ucXHOLUR4KAD0yvVCfiFo8CKXfTDB8zWUE/WicBMsrE/XfxJwTnUK54HR
         wr+m7byxq6mJw9Vsgvdq0s5oOMMrcpRmKd61MAX3ws+RdxKOpydJtWCE3ct4Jq3ELdbn
         nRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707534370; x=1708139170;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5s7UC2LI5606ztlkySRh4zEDw9ZNIX2+7Suzh+XsVU=;
        b=QL0WvWJs8VrTdWy0Xjg04gfkFtu6+LfgLMYMhOAxGnD8ssB4fgYKQ0B0YawAnzOeBx
         lDtTvhrCV6UC8kTp4NA/bVt2kvY4C6YnbbY7NHhP2EipDGoOiQfOtGFkUKl7UlWJWXZh
         diRTThXUDK5VXAunhoQ7K9U9bJUwSaLeXSR3COFFrALqDfg9zc0Lhhw6A8WDoE/87Mpl
         v/sO63uYoc+GXhjWqMMJUHJQG7MxB9gvsZ8VuzePUoCxHp4zSBjXSJepxQUp6duZuJd7
         KTULZMno7iTf1Rhn1socHSbiXax/AoQg/6UwodI/WyMfeMD00vPPcuEjbpnSHlyPZeQN
         jbWQ==
X-Gm-Message-State: AOJu0YxUs923EgpxAv516AGXf649h4FR6P62veAiqbCISRXRWUPqio5v
	oJwYvMrg1OvRzuAnClgbm+6mZQaAS0N3spQU5I58eDmisrY5gaYQtUcOJ1Oc31eQGXPtlq9EKsL
	GdU6vCU5h0NUYAA==
X-Google-Smtp-Source: AGHT+IHoaOrZfU2X7gvo32Z9ygKKDDC9jkDgw9ONDzx/dRL4i+TQaBCi1II8RxJpDFCvyqRwNSZSkNWR2n60Ftk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6b44:91e7:13e1:5d92])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1006:b0:dc6:ee88:ced2 with SMTP
 id w6-20020a056902100600b00dc6ee88ced2mr254743ybt.12.1707534369357; Fri, 09
 Feb 2024 19:06:09 -0800 (PST)
Date: Fri,  9 Feb 2024 19:05:47 -0800
In-Reply-To: <20240210030549.4048795-1-saravanak@google.com>
Message-Id: <20240210030549.4048795-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 4/4] of: property: fw_devlink: Add support for
 "post-init-supplier" property
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
index 751c11a28f33..dce451161c99 100644
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
+DEFINE_SIMPLE_PROP(post_init_supplier, "post-init-supplier", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1349,6 +1355,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
+	{
+		.parse_prop = parse_post_init_supplier,
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
2.43.0.687.g38aa6559b0-goog


