Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7C477C78
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhLPTXu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbhLPTXu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 14:23:50 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962DC06173E
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 11:23:49 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 193so24266959qkh.10
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AH5lWdN4aaOBeMJv18vhZagllhCdh1eRKSlcmjc8AEM=;
        b=cjK5uNREMFQogYWToQtq5d2khgn3l+ce6d3g5aREEMfU1ZmwxEw/1af6sNlR2wLzOz
         TUxWWdhhfiRbuozt+qIMTiJLYUf9z372ISx+k2osPtlkeESNRjfEoiiXLaPYZv85ru+w
         8PIve9b0BjG5Xe3jTS0TFmvG2NSackUAlmKal9V8BiyKbCPV8vxpGXIN49CPiqCSlkpS
         UHZvB62wPguNqonI45MQH0UobDOlB7qDsmwDPWJY4JX53bRXA0Qba6SBInDdtLbI/RbF
         aa85KLS239ucyWjsEfTofovAasO/4v7SVC5HigIe0LuGUbbtRMOCHXErYGHB9fnRIAE7
         EyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AH5lWdN4aaOBeMJv18vhZagllhCdh1eRKSlcmjc8AEM=;
        b=ZA1uTO1rEZg51f6QpC7UC1mrXZozW7s2v2MxVls2TtxnDRzuy1sQxPGy5JgUig7TSQ
         z6taggU3B3KJnCG+/PZWi3+VP8S8ZHB312NgioUjhbe/hlVDdWh8q1v4dsCLPAzccy50
         aWyU798N3+X2JSxuM4wjHOwmWsdU3nm5p+09w/zCUV7Gh1Rk/8Ove85UgLT//8M+nr3O
         FNiVCkltOuKJwiwYJpZr9zhvBSYpm8YE4Fhrwkr1Ay+mOQpM4jJ+sOcLBEB7SC1lSajT
         upX3LwRhy6YQn+BUp8mEOTWVW1kxOdoaIcFFzP3exrXBsNUiXfwapHKz5ZCTwOjLGpMa
         lt3Q==
X-Gm-Message-State: AOAM532apw4KFRX70H6+hU8OzIrnu3wibhAl+S/KqCBoh5lWUonvGBbZ
        O9d0Z2caskTYeAOKOu4B4aE2sw==
X-Google-Smtp-Source: ABdhPJwERimh+QTigiLtfVxRjB1Ls3j6fyYxSp/4R1hD2IL5zeGaIumUANrS2pIGVkdIPc/04oqx+w==
X-Received: by 2002:a05:620a:24ca:: with SMTP id m10mr13172979qkn.649.1639682629056;
        Thu, 16 Dec 2021 11:23:49 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id o4sm3258510qkh.107.2021.12.16.11.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:23:48 -0800 (PST)
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
Subject: [PATCH v4 5/5] drivers/node: Show in sysfs node's crypto capabilities
Date:   Thu, 16 Dec 2021 16:22:22 -0300
Message-Id: <20211216192222.127908-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
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
index 000000000000..93581b31225e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,10 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		December 2021
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
index b5a4ba18f9f9..67b0e2fa93b1 100644
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

