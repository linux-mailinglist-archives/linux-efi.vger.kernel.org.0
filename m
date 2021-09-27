Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96459418F1C
	for <lists+linux-efi@lfdr.de>; Mon, 27 Sep 2021 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhI0GoP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Sep 2021 02:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233035AbhI0GoP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Sep 2021 02:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632724957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7XJHc0p1FnNm1Yats8TDvDF65ghYHfrSmniJKe3ULQ=;
        b=cKVgivoHRsvbr7xNufHfrbmieP7Uf7mHOSqf2UVpN1k9VoNlgHHX7UeWD3un8jIjiR5GEY
        gpuq3TN8Ba/ryZK4B8NnlsMRSOuNHJtnGJkO4pHV7KWHY1yP7pdx4Bp5Y1XLWlPq9GHEf9
        v2cAnuhtzJshzJImY4S1MoeEMdDE1Kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-T6Ky4i-5M0mFA2scRJonRQ-1; Mon, 27 Sep 2021 02:42:33 -0400
X-MC-Unique: T6Ky4i-5M0mFA2scRJonRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698F3802935;
        Mon, 27 Sep 2021 06:42:31 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3499960936;
        Mon, 27 Sep 2021 06:42:26 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        robh@kernel.org, maz@kernel.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 2/2] of, numa: Fetch empty NUMA node ID from distance map
Date:   Mon, 27 Sep 2021 14:41:19 +0800
Message-Id: <20210927064119.127285-3-gshan@redhat.com>
In-Reply-To: <20210927064119.127285-1-gshan@redhat.com>
References: <20210927064119.127285-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is no device node for the empty NUMA node. However, the
corresponding NUMA node ID and distance map is still valid in
"numa-distance-map-v1" compatible device node.

This fetches the NUMA node ID and distance map for these empty
NUMA node from "numa-distance-map-v1" compatible device node.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/of/of_numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index fe6b13608e51..5949829a1b00 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -111,6 +111,8 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
 			return -EINVAL;
 		}
 
+		node_set(nodea, numa_nodes_parsed);
+
 		numa_set_distance(nodea, nodeb, distance);
 
 		/* Set default distance of node B->A same as A->B */
-- 
2.23.0

