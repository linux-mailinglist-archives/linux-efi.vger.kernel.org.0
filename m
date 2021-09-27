Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED7418F14
	for <lists+linux-efi@lfdr.de>; Mon, 27 Sep 2021 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhI0GoE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Sep 2021 02:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232983AbhI0GoD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Sep 2021 02:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632724945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dAcybXZptWhXuaEnwPAcHdlIaUsfWP7DKdFq484lIaw=;
        b=ARxRKoDiTP0ZhRyH79hp1abgmdHfLs8oqECzsLVrLb288vd0+hSnQ0I+N8p3ty6mAbUR1D
        eViZaT1FX4W4IjiMyJQvDgRPs479ZuMwMOpHVRDB9iHJl9sLDC5Pv0hz8+9pu5XnoXLKb9
        vDGwTEPXydlKU1QmWEPM22qu/IpVwus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573--8vK7PZVOGeQzBTMxcruEQ-1; Mon, 27 Sep 2021 02:42:23 -0400
X-MC-Unique: -8vK7PZVOGeQzBTMxcruEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ABE91006AA3;
        Mon, 27 Sep 2021 06:42:22 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BEA160936;
        Mon, 27 Sep 2021 06:42:16 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        robh@kernel.org, maz@kernel.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 0/2] Specify empty NUMA node
Date:   Mon, 27 Sep 2021 14:41:17 +0800
Message-Id: <20210927064119.127285-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are multiple empty nodes, where no memory resides in, are allowed
in virtual machine (VM) backed by QEMU. I don't find anywhere to document
how the corresponding device nodes are populated. This series adds one
section in Documentation/devicetree/bindings/numa.txt to document how
the empty NUMA nodes are handled: no device nodes are existing for these
empty NUMA nodes, but the NUMA IDs and distance map are still valid in
"numa-distance-map-v1" compatible device node.

PATCH[1] adds one section in Documentation/devicetree/bindings/numa.txt
         to specify how device nodes are populated for these empty NUMA
         nodes.
PATCH[2] fetches NUMA IDs and distance maps from "numa-distance-map-v1"
         compatible device node.

Changelog
=========
   * No device nodes for empty NUMA nodes                     (Rob)
   * Add patch to fetch NUMA IDs and distance map from the
     "numa-distance-map-v1" compatible device node            (Rob)

Gavin Shan (2):
  Documentation, dt, numa: Add note to empty NUMA node
  of, numa: Fetch empty NUMA node ID from distance map

 Documentation/devicetree/bindings/numa.txt | 46 +++++++++++++++++++++-
 drivers/of/of_numa.c                       |  2 +
 2 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.23.0

