Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9E32CE81
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 09:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhCDIay (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Mar 2021 03:30:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:59975 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236846AbhCDIa2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Mar 2021 03:30:28 -0500
IronPort-SDR: /iGx4LNkEZ+svI+ykph96Gwb/sest8QtyZFeqqpazMR0RFTROCGw0MS3hHzI2zYHwOs/k2JDp8
 oaa+OkiJT01g==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251412271"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="251412271"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 00:28:42 -0800
IronPort-SDR: a+5FA/O99ccXH6gP1yj+lsBK725ZCVogDq8lyqKgX97F9M0GQbLZiW11RLgWLiIPfkNMTeyh6n
 HUfPsb5zojeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507273958"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 00:28:37 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/apple-properties: Handle device properties with software node API
Date:   Thu,  4 Mar 2021 11:28:37 +0300
Message-Id: <20210304082837.22262-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The old device property API is going to be removed.
Replacing the device_add_properties() call with the software
node API equivalent, device_create_managed_software_node().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/firmware/efi/apple-properties.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index e1926483ae2fd..4c3201e290e29 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -157,7 +157,7 @@ static int __init unmarshal_devices(struct properties_header *properties)
 		if (!entry[0].name)
 			goto skip_device;
 
-		ret = device_add_properties(dev, entry); /* makes deep copy */
+		ret = device_create_managed_software_node(dev, entry, NULL);
 		if (ret)
 			dev_err(dev, "error %d assigning properties\n", ret);
 
-- 
2.30.1

