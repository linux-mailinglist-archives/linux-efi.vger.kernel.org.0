Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79745CE26
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 21:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhKXUjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Nov 2021 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbhKXUji (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Nov 2021 15:39:38 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFAC06173E
        for <linux-efi@vger.kernel.org>; Wed, 24 Nov 2021 12:36:28 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id ay21so7696537uab.12
        for <linux-efi@vger.kernel.org>; Wed, 24 Nov 2021 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0bmQaOoWIKx1kavxDMlDEybQyi0u9rYz3ceRUr9+6k=;
        b=GXpulxUj/NTga06qjAE3HAjBWugm4oEzvW5KpfiAJvK6BjAZFCdV0CgjcB63DmEMHE
         E+dopXfEybcehbx/aOprHRE+ktamblL+WWYge6sP3tdkSKbK8Do14ykXWh5Ra+OURbwW
         KMGSRf0D8RIbTUOeEUjIoDMnt5YaOfEC6aXa2XwnWaLgujtezW0W4ltSpQ9OP1Rpzm2j
         LeT3Y7HCpscglgNU60UIZisIp5NqmxxLaJDBDNe/B0g85VFCCqN5238L4jhygqH5VZEh
         6QEOyMGoCLfB39NSPrMeFGEevI07bksUFAORTDZ+fO5iBhHuCP+/dB+329koc2bR35C2
         k+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0bmQaOoWIKx1kavxDMlDEybQyi0u9rYz3ceRUr9+6k=;
        b=UmJt+d6l0OR+8H+DKKEcWXwWYjeiOlVom51W1B1mI0efnNgEdHKFXclhdGAlGuFC2v
         jZurJh/+TdNmItMLCXsK29RLL53v+CMBunl9hxJmed95QaLxdsSsejFdOuBVpmXFHV+O
         w/C2s89KXTJuy45rqM6htPhphhNfn+kiLbNdDRyOvC3SLbP7Z7mTB55sKnoMbJLaSiAv
         oVpp1vhW82fju/1IyoZM8C7iSy1wsA/A59r2tJ7687WSEqPj46NyLPWybPLCRUAKdBKe
         VbaTRhPSI9YzMBAZJWFoBCVeqawj7Tg67dbe6aue9U1Q0+f9IqMN+B1DzG87taN2ajoS
         sGzA==
X-Gm-Message-State: AOAM531808UottQ3ldPNIPK5FvxfRWaiUBD6diV3O2xcnjWY7dkeTFH1
        SZubE0/Zq6c0eJ5isBd3i4fCzOdQRNWykk7Lfd1fY1Z9cAEfCr0ge0oj3SeMPGeIlWDPrnAT1sj
        8tVdAGiX/cCigIVaJYdizVgqgkgdcmNmQtFzRFjep8N0yZRz9vaxdkGIOLSNnRNLHPFRK+U6xow
        4c0Lkq3aSTbRMpi08=
X-Google-Smtp-Source: ABdhPJwnwownuw1qWugehWIJfRfCAs5vic5yWR6x7sRWk1I0s28pWe14YmN8T1VHJJPqK28xF5g/7w==
X-Received: by 2002:a9f:3e43:: with SMTP id c3mr15227660uaj.29.1637786187676;
        Wed, 24 Nov 2021 12:36:27 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id q20sm616962uae.17.2021.11.24.12.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:36:27 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v2 5/5] drivers/node: Show in sysfs node's crypto capabilities
Date:   Wed, 24 Nov 2021 17:34:59 -0300
Message-Id: <20211124203459.4578-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124203459.4578-1-martin.fernandez@eclypsium.com>
References: <20211124203459.4578-1-martin.fernandez@eclypsium.com>
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
index 000000000000..ab46fdd3f6a8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-node
@@ -0,0 +1,10 @@
+What:		/sys/devices/system/node/nodeX/crypto_capable
+Date:		October 2021
+Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
+Users:		fwupd
+Description:
+		This value is 1 if all system memory in this node is
+		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
+		system memory is capable of being protected with the
+		CPU’s memory cryptographic capabilities. It is 0
+		otherwise.
\ No newline at end of file
diff --git a/drivers/base/node.c b/drivers/base/node.c
index c56d34f8158f..4e6ef86f4523 100644
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

