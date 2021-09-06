Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9738D401567
	for <lists+linux-efi@lfdr.de>; Mon,  6 Sep 2021 06:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhIFERY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Sep 2021 00:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhIFERK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Sep 2021 00:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630901764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N/7qUCDbLedcIM9wZfeDAGpIH0/Pk2uXbgsdONv5fHc=;
        b=OFVXMRwwZLbOhsulhGqMMgONm+ip2Y0QJQxC2BMj9X/+jFLEao7bmIOqoPwfeVW58lxdoO
        J7azFE70ATMk4QpC42KTtCG0UkJMt7Qkzx3Uo/I0BrOxOoPWVd5/dommg8FaharIlhiy7Q
        fo+YiPmEJ8HSNLAUgT6kE6VwkXvUQm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-zC5vOcY3PEO1DJZod3-5Rw-1; Mon, 06 Sep 2021 00:16:02 -0400
X-MC-Unique: zC5vOcY3PEO1DJZod3-5Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8945801A92;
        Mon,  6 Sep 2021 04:16:00 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-40.bne.redhat.com [10.64.54.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A56D019C59;
        Mon,  6 Sep 2021 04:15:53 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        rdunlap@infradead.org, robh@kernel.org, drjones@redhat.com,
        ardb@kernel.org, will@kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, shan.gavin@gmail.com
Subject: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
Date:   Mon,  6 Sep 2021 12:14:24 +0800
Message-Id: <20210906041424.115473-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The empty memory nodes, where no memory resides in, are allowed.
For these empty memory nodes, the 'len' of 'reg' property is zero.
The NUMA node IDs are still valid and parsed, but memory may be
added to them through hotplug afterwards. Currently, QEMU fails
to boot when multiple empty memory nodes are specified. It's
caused by device-tree population failure and duplicated memory
node names.

As device-tree specification indicates, the 'unit-address' of
these empty memory nodes, part of their names, are the equivalents
to 'base-address'. Unfortunately, I finds difficulty to get where
the assignment of 'base-address' is properly documented for these
empty memory nodes. So lets add a section for empty memory nodes
to cover this in NUMA binding document. The 'unit-address',
equivalent to 'base-address' in the 'reg' property of these empty
memory nodes is specified to be the summation of highest memory
address plus the NUMA node ID.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/devicetree/bindings/numa.txt | 60 +++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..82f047bc8dd6 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -103,7 +103,65 @@ Example:
 		};
 
 ==============================================================================
-4 - Example dts
+4 - Empty memory nodes
+==============================================================================
+
+Empty memory nodes, which no memory resides in, are allowed. The 'length'
+field of the 'reg' property is zero. However, the 'base-address' is a
+dummy and invalid address, which is the summation of highest memory address
+plus the NUMA node ID. The NUMA node IDs and distance maps are still valid
+and memory may be added into them through hotplug afterwards.
+
+Example:
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+		numa-node-id = <0>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+		numa-node-id = <1>;
+	};
+
+	/* Empty memory node */
+	memory@100000002 {
+		device_type = "memory";
+		reg = <0x1 0x2 0x0 0x0>;
+		numa-node-id = <2>;
+	};
+
+	/* Empty memory node */
+	memory@100000003 {
+		device_type = "memory";
+		reg = <0x1 0x3 0x0 0x0>;
+		numa-node-id = <3>;
+	};
+
+	distance-map {
+		compatible = "numa-distance-map-v1";
+		distance-matrix = <0 0  10>,
+				  <0 1  20>,
+				  <0 2  40>,
+				  <0 3  20>,
+				  <1 0  20>,
+				  <1 1  10>,
+				  <1 2  20>,
+				  <1 3  40>,
+				  <2 0  40>,
+				  <2 1  20>,
+				  <2 2  10>,
+				  <2 3  20>,
+				  <3 0  20>,
+				  <3 1  40>,
+				  <3 2  20>,
+				  <3 3  10>;
+	};
+
+==============================================================================
+5 - Example dts
 ==============================================================================
 
 Dual socket system consists of 2 boards connected through ccn bus and
-- 
2.23.0

