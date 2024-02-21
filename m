Return-Path: <linux-efi+bounces-627-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932685ECF4
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 00:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A040D1C21EA2
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC912D74B;
	Wed, 21 Feb 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccXHuh83"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C8F12B16B
	for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558238; cv=none; b=r8Wg1QmBS94W3q45G2XuUT0paF/Zti7G3Xrjxbe/inSwYTUUE0E/4WbBr14BNKESTSwunR0OTbgzfFuOfrBGkCPiicS70vQ6Bm0bRDaaao2Y8rHPLdIjTROVh2j3MYy4iLS3HunqNOeQ+dKnXUFuNxLkKbEMSwfzCPtFQ+qM0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558238; c=relaxed/simple;
	bh=O3k+nYu1MYBPKH6TsA/y54d2ADLO3F4v2KYWl0x8bqo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=RXxwVaZJwoIGyKQRZR7VaDnkqZ+DI/rXC85zb7IJleBMFwSokWqJMeVfItz1x7HT5U6GntrHXwafp0jPRJHARRWNX87JC2kkIvA5FExlSP9IUI3zgLmo2WeghrqlBQ5pVejaXecesdGrzU+eaetZttx+UfkyS9HOE+EJA5a+4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccXHuh83; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607cd6c11d7so107369387b3.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 15:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708558235; x=1709163035; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RZcm32i75equt/unWf5KMZ/RAcqfb/I89ao1kCyS8A=;
        b=ccXHuh83DugB0FVQYirkrAty60fONap3CK593aejGZlaS6pxh5cf7aP+nDz5jBoEm7
         KYlEeTnHJJEKVGY2myu7/+bwy0rxvFSN34PvfuFcWEB9pB123ANwq/20iTZmxMdGXEcQ
         HGuTq6NWx7HYVRdbIKzFKYJAm4n36KH1fVynRqk5YtQ7fpgvNXnIa8OSMsxH7BsEVHHD
         OfOiKjLx/qSTq096n0LfP2kq1HVqDK9GtVJi8UdPIAn94MNGG8g6yVDNOmH3kULnaS74
         8hfgdkA8Ue9aP9xmh6cXs6Oo+uh9gzuyGOPXZfmUOXcrlkxpTmVkCq1dWlH/z1RGpn5P
         lSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558235; x=1709163035;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RZcm32i75equt/unWf5KMZ/RAcqfb/I89ao1kCyS8A=;
        b=oJ70SodCwuha7tL89JRDCQl3nY9GCtqM+7VL6vCeyBsZRIcg+oy5n5iNGvHeP3JLHb
         TEEc0xJzMAeg5l+sznoftBmRasXzLIw+kzidOrkTuPoFqBgPBY2Xvo6/ENIUk+Kf9gzF
         tRlcK9whUaIqYwhJYeA01I83js0y2XmeZEg55hfvNiOJlvofXkcv0AKO6SFJTx3T+b62
         jioraQNcMKlQwrwvyMffzM8moekCDCbQ1sufdfwi5dUKNRpnzOhliu7EpJHW4I53Zb9e
         gwrKvzcQtFUmfyjJrsLzF8LGguAeIyO+t0ap4JbskH2whKhQU8Q7LY38RCWY+GPBtjk7
         DbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVwkZSWnQ2pCPmVOCyYWVKXqPemobMoI1wK+hUjic4dAOAAHvu8epgCBOhh4UE6XUCwcnz+cfmbAOwafqXQ4tf5BwxU73OY7J4
X-Gm-Message-State: AOJu0YxapfXnB9Xw5Oq0ufMNSfTzrUCUcFSb/WzL7wJLLQ/OHlTtgrC8
	SXO6pfA1E4uT929UA1dvVayDkDoub3W1fCRFTqvO9c/8XIOFxwoUt9A9XzhR19GFmKIw+IW10KV
	uhbN8LswB1UuiMw==
X-Google-Smtp-Source: AGHT+IFymqwFZX8gUcnkDHzCjCSYD5QmwOYK5TfTYepo77znZQH+G9Phdflg4Iktv+dh1kr8I9s40IenkChq33E=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4e1e:336a:2b30:13fe])
 (user=saravanak job=sendgmr) by 2002:a0d:e6c5:0:b0:608:801a:e66e with SMTP id
 p188-20020a0de6c5000000b00608801ae66emr571836ywe.3.1708558235317; Wed, 21 Feb
 2024 15:30:35 -0800 (PST)
Date: Wed, 21 Feb 2024 15:30:21 -0800
In-Reply-To: <20240221233026.2915061-1-saravanak@google.com>
Message-Id: <20240221233026.2915061-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v3 1/4] driver core: Adds flags param to fwnode_link_add()
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the callers to set fwnode link flags when adding fwnode links.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c              | 5 +++--
 drivers/firmware/efi/sysfb_efi.c | 2 +-
 drivers/of/property.c            | 2 +-
 include/linux/fwnode.h           | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9828da9b933c..adeff041d472 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -92,12 +92,13 @@ static int __fwnode_link_add(struct fwnode_handle *con,
 	return 0;
 }
 
-int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
+		    u8 flags)
 {
 	int ret;
 
 	mutex_lock(&fwnode_link_lock);
-	ret = __fwnode_link_add(con, sup, 0);
+	ret = __fwnode_link_add(con, sup, flags);
 	mutex_unlock(&fwnode_link_lock);
 	return ret;
 }
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 456d0e5eaf78..cc807ed35aed 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -336,7 +336,7 @@ static int efifb_add_links(struct fwnode_handle *fwnode)
 	if (!sup_np)
 		return 0;
 
-	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
+	fwnode_link_add(fwnode, of_fwnode_handle(sup_np), 0);
 	of_node_put(sup_np);
 
 	return 0;
diff --git a/drivers/of/property.c b/drivers/of/property.c
index b71267c6667c..bce849f21ae2 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1085,7 +1085,7 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
 }
 
 /**
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb..c964749953e3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -210,7 +210,8 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 }
 
 extern bool fw_devlink_is_strict(void);
-int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
+		    u8 flags);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 
-- 
2.44.0.rc0.258.g7320e95886-goog


