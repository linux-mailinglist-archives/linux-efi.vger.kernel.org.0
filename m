Return-Path: <linux-efi+bounces-1214-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2A590782C
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 18:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082771C23173
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB4524D7;
	Thu, 13 Jun 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdVquD6g"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7396145FFD
	for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295668; cv=none; b=Msau8S9L9ivCTiK+aGVTcQIBgqgyXRz4ZE3p9SJ9+ftJcUh0qcMveEawt2bFfgPeiyprffNR0SDFd37QuzVqzBXZ2JzPYB4xk7fovESRS60OQwr2ilvcvMMgP4hjGcURyBnp4HUzE9ujwHkdwwCttLcaH2/jVKNc6FviBemuKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295668; c=relaxed/simple;
	bh=7RNjx97Es6Px6fI1XW8Y1JgBcCTpBzveKL8xtiQsFFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E3/zNLfcPkYtVrEwVB+Om1lEQLFTkILdXDU+Lo1i7LQCKRfC6symVgvKWVxMgv7ngDmA+utJy/b/x/U6aG3el7lFw0EDPfqJlwC9Bl21fBsQOWh0Kr4REmAs5C8hnhzd6VCPyrlAF3d0MSPsmficrFxqsU3moItYr7hBTR/Gy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdVquD6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718295665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C6E639UIwAtkQNEr9kBB2jPUHGaI+pSB3aws83mC+K4=;
	b=FdVquD6gLt+m79XYP5xqQUsftS7Lds+F0rMmT9fbehfq1SAt15jnDmth2J9l20l0CUAjm7
	7Ho0OAWiBt3QQte3iQDBUAdH2DPVUzZAy04sKQ9bJV4Nia1bd1b3bdBGlZQmzgsYAshCxx
	PGuGNndufnvOq7VW7nQvAwiA5OmDHxA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-LJN3tRSLPLa-rlbG8gSRcg-1; Thu,
 13 Jun 2024 12:21:02 -0400
X-MC-Unique: LJN3tRSLPLa-rlbG8gSRcg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B924F1955F2C;
	Thu, 13 Jun 2024 16:21:00 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.195])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3FF419560AD;
	Thu, 13 Jun 2024 16:20:58 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] arm64/efi: Fix kmemleak false positive in arm64_efi_rt_init()
Date: Thu, 13 Jun 2024 12:20:31 -0400
Message-Id: <20240613162031.142224-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The kmemleak code sometimes complains about the following leak:

unreferenced object 0xffff8000102e0000 (size 32768):
  comm "swapper/0", pid 1, jiffies 4294937323 (age 71.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000db9a88a3>] __vmalloc_node_range+0x324/0x450
    [<00000000ff8903a4>] __vmalloc_node+0x90/0xd0
    [<000000001a06634f>] arm64_efi_rt_init+0x64/0xdc
    [<0000000007826a8d>] do_one_initcall+0x178/0xac0
    [<0000000054a87017>] do_initcalls+0x190/0x1d0
    [<00000000308092d0>] kernel_init_freeable+0x2c0/0x2f0
    [<000000003e7b99e0>] kernel_init+0x28/0x14c
    [<000000002246af5b>] ret_from_fork+0x10/0x20

The memory object in this case is for efi_rt_stack_top and is allocated
in an initcall. So this is certainly a false positive. Mark the object
as not a leak to quash it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/arm64/kernel/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 4a92096db34e..712718aed5dd 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -9,6 +9,7 @@
 
 #include <linux/efi.h>
 #include <linux/init.h>
+#include <linux/kmemleak.h>
 #include <linux/screen_info.h>
 #include <linux/vmalloc.h>
 
@@ -213,6 +214,7 @@ l:	if (!p) {
 		return -ENOMEM;
 	}
 
+	kmemleak_not_leak(p);
 	efi_rt_stack_top = p + THREAD_SIZE;
 	return 0;
 }
-- 
2.39.3


