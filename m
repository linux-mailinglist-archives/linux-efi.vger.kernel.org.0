Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB09D238
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfHZPB5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 11:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfHZPB4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Aug 2019 11:01:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845CD23407;
        Mon, 26 Aug 2019 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566831716;
        bh=I6e2z6xG6NNp+2Wpt9kGj+eQ5xIpFiafpE0oAydyqz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCskg3zWYS8sUfIN6SpZQxIOcvVswWxnixVypxSGkkK4sWFtFSIsWK8y001UJ3VVq
         YwDsf8c4gc4K/d7W/i03gofw7+kYrrB1Yv+9KAveARF2SiykU7hsc4ZC9ryTJQzK8K
         kzHLkzUW39HoCAGUes5rLeWxtjERSq0yjP8ranhY=
Date:   Mon, 26 Aug 2019 17:01:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] sysfs: add BIN_ATTR_WO() macro
Message-ID: <20190826150153.GD18418@kroah.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826140131.GA15270@kroah.com>
 <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This variant was missing from sysfs.h, I guess no one noticed it before.

Turns out the powerpc secure variable code can use it, so add it to the
tree for it, and potentially others to take advantage of, instead of
open-coding it.

Reported-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

I'll queue this up to my tree for 5.4-rc1, but if you want to take this
in your tree earlier, feel free to do so.

 include/linux/sysfs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 965236795750..5420817ed317 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -196,6 +196,12 @@ struct bin_attribute {
 	.size	= _size,						\
 }
 
+#define __BIN_ATTR_WO(_name) {						\
+	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
+	.store	= _name##_store,					\
+	.size	= _size,						\
+}
+
 #define __BIN_ATTR_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
 
@@ -208,6 +214,9 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
 #define BIN_ATTR_RO(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
 
+#define BIN_ATTR_WO(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
+
 #define BIN_ATTR_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
-- 
2.23.0

