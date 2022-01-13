Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5B48DFB1
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiAMVbb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 16:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiAMVbR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 16:31:17 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB2C06161C
        for <linux-efi@vger.kernel.org>; Thu, 13 Jan 2022 13:31:17 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id i9so9675588oih.4
        for <linux-efi@vger.kernel.org>; Thu, 13 Jan 2022 13:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVN27if4TLsRCEMhCF/aqw8r/7THOayqDLYA7IAtavc=;
        b=cl/0zLZFJiGx8sFR5y9ZQu0me7yAE4sNXzqAJwzAbdsxRpWRMgUShOFWYq8N1hPJY2
         48lcCYaUXpUWBAmmXMep3197PfpmGKcgBMTygUt3HNfyP7uOOgBxNz99RILKcZoRYfqs
         Zt/3R6UjOLJefC5vcjn7sL1MXjc3KjmC+NQjSymVxGXKyYrGFTRPKZcRuLkkEg6NPefk
         U12lx/o3FRe8+qmMzea5DJ5DLvKXyzTANaRZcV9oVsgPU8w8f/XvJ3Tac1oXIB+RUkGf
         hwj4x2EZC7kxNZHRPe0QXebw4HB5BaulW7Esu1JdDEw+fpJCtRbhSQoxMNwuGdoSTe3I
         L08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVN27if4TLsRCEMhCF/aqw8r/7THOayqDLYA7IAtavc=;
        b=h/6RNEMe5WTbnnThWnvSo4sy7ofQ/1PrnPPJ8nF5FTce0FonhDHErLT6q14W0NA5dm
         0sNbMsN09Fws8SX1mMw4orjF85uhNd4sutshWe5UrBqni0SWL8oFsXzLFMTdXV+v+4eb
         Fi4RSC+Ndd/vn9YMegtvLDNyfN3w52bqiUVpUbHpWXxmQTCoER77inpp6+lUsDhAnZ+N
         jkxQzKBCTZOf/7x/r0N4qKpI/QjOqcYouu9VImyKFc05yOatI7nC02p/p9qD98YApsS+
         DCUGKup2mwphmfCbNM78CfYs9yWxxVq6blZ5A5/rWheypla2RAdZk/1dcUDbH+EJTt8+
         dX8w==
X-Gm-Message-State: AOAM531WGMvAmh20Ji5/EizfCjLleNVuLoU34vDb77fdhjhIi/Am9oK9
        d6jYxoHT5XZN9sPcW9CCTJaFRg==
X-Google-Smtp-Source: ABdhPJxJcXPnlOWnI9M6Jnqh9i6KsB4TBvlTnQrIc/FadDEsjuKYa97ar6lwUiV86vnw2DEkK9FwHA==
X-Received: by 2002:a05:6808:1a83:: with SMTP id bm3mr3785579oib.53.1642109476722;
        Thu, 13 Jan 2022 13:31:16 -0800 (PST)
Received: from localhost (115-127-16-190.fibertel.com.ar. [190.16.127.115])
        by smtp.gmail.com with ESMTPSA id o130sm1040829oig.26.2022.01.13.13.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:31:16 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v5 5/5] drivers/node: Show in sysfs node's crypto capabilities
Date:   Thu, 13 Jan 2022 18:30:27 -0300
Message-Id: <20220113213027.457282-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show in each node in sysfs if its memory is able to do be encrypted by
the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
the EFI memory map.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
 drivers/base/node.c                          | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
new file mode 100644
index 000000000000..7c0480580670
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,10 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		January 2022
+Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
+Users:		fwupd (https://fwupd.org)
+Description:
+		This value is 1 if all system memory in this node is
+		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
+		system memory is capable of being protected with the
+		CPU’s memory cryptographic capabilities. It is 0
+		otherwise.
\ No newline at end of file
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 87acc47e8951..dabaed997ecd 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -560,11 +560,21 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t crypto_capable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pglist_data *pgdat = NODE_DATA(dev->id);
+
+	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
+}
+static DEVICE_ATTR_RO(crypto_capable);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_crypto_capable.attr,
 	NULL
 };
 
-- 
2.30.2

