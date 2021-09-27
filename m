Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17790418F19
	for <lists+linux-efi@lfdr.de>; Mon, 27 Sep 2021 08:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhI0GoL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Sep 2021 02:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233008AbhI0GoJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Sep 2021 02:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632724952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgUQa1q2yVLHuH43oDCQpdzXKKAxjWaL6vBqtSCv00M=;
        b=aseZ2k5tgTcAZc0QSA2kiugIe3aVZJ80x042v8OjqIUJoMO91fg7WeANfrfXZQ2DW2P4tl
        /j5CxH5Bsgc98OgTqRyA3cVJn+vRV1NAE7R/wsVKOLZxxpUmxSkaGSEnCEmwJW+kY+IDJK
        /aKZRo+zGneFozKghRh5SVKu/dW0Br8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-Up7L8uypM4ConrfU_bs3rA-1; Mon, 27 Sep 2021 02:42:28 -0400
X-MC-Unique: Up7L8uypM4ConrfU_bs3rA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 977BC1966320;
        Mon, 27 Sep 2021 06:42:26 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9527560936;
        Mon, 27 Sep 2021 06:42:22 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        robh@kernel.org, maz@kernel.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 1/2] Documentation, dt, numa: Add note to empty NUMA node
Date:   Mon, 27 Sep 2021 14:41:18 +0800
Message-Id: <20210927064119.127285-2-gshan@redhat.com>
In-Reply-To: <20210927064119.127285-1-gshan@redhat.com>
References: <20210927064119.127285-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The empty memory nodes, where no memory resides in, are allowed.
The NUMA node IDs are still valid and parsed, but memory may be
added to them through hotplug afterwards. Currently, QEMU fails
to boot when multiple empty memory nodes are specified. It's
caused by device-tree population failure and duplicated memory
node names.

The device-tree specification doesn't provide how empty NUMA
nodes are handled. Besides, I finds difficulty to get where
this case is documented. So lets add a section for empty memory
nodes to cover it in NUMA binding document.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/devicetree/bindings/numa.txt | 46 +++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b35053ca5a..42f282c2f3cc 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -103,7 +103,51 @@ Example:
 		};
 
 ==============================================================================
-4 - Example dts
+4 - Empty memory nodes
+==============================================================================
+
+Empty memory nodes, which no memory resides in, are allowed. There are no
+device nodes for these empty memory nodes. However, the NUMA node IDs and
+distance maps are still valid and memory may be added into them through
+hotplug afterwards.
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
+	/* Empty memory node 2 and 3 */
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

