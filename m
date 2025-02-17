Return-Path: <linux-efi+bounces-2795-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4CA379C4
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2025 03:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EE83AD407
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2025 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAD2940B;
	Mon, 17 Feb 2025 02:36:50 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A8C8FE;
	Mon, 17 Feb 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759810; cv=none; b=Uavq7GXdbj0SmXNFDSM2F3M/VKjZxQGFYmgZur8nvHCrJ1ziSSeCd+JUbA9kq8mrMGmkWUCsH58XnqlXWUqpVfFWzSW+qs1a9GgR29Ky1jvrZdi0QL0yefASNMN20DqcFtT8N+A7JO0cw7G+na5V4BBKxy1Ib91kbYfYEjATh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759810; c=relaxed/simple;
	bh=I2rRDOaKvJmH/fo4VfvrvXCEyC3FkbqRpsXWolij3SY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIl8YPzUnCQDDu8RnkkukhBGZ1OIMa208KLc8wF89kw6ep0UNZXNH/m8+FkbbrRRseMuznms11BmTXBbFEujZ2F3F3GK7vgsrYpci0CNkyZ88ylXgU4tGEf3j/limeBdwK97+bt0jge7n/1Xun+YB1F52pcysPXGCuGPgJFq8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yx6Bp68Lbz1ltbV;
	Mon, 17 Feb 2025 10:32:50 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 776E71402C7;
	Mon, 17 Feb 2025 10:36:42 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 10:36:40 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <peterz@infradead.org>, <masahiroy@kernel.org>, <mgorman@suse.de>,
	<guoweikang.kernel@gmail.com>, <mingo@redhat.com>,
	<vincent.guittot@linaro.org>, <hpa@zytor.com>, <agordeev@linux.ibm.com>,
	<vschneid@redhat.com>, <tzimmermann@suse.de>, <dave.hansen@linux.intel.com>,
	<ardb@kernel.org>, <mhiramat@kernel.org>, <juri.lelli@redhat.com>,
	<geert@linux-m68k.org>, <bp@alien8.de>, <pavel@ucw.cz>,
	<simona.vetter@ffwll.ch>, <bp@suse.de>, <rostedt@goodmis.org>,
	<bsegall@google.com>, <nicolas@fjasle.eu>, <sebastian.reichel@collabora.com>,
	<tglx@linutronix.de>, <akpm@linux-foundation.org>,
	<mathieu.desnoyers@efficios.com>, <dietmar.eggemann@arm.com>,
	<lkundrak@v3.sk>, <changhuaixin@linux.alibaba.com>, <nathan@kernel.org>,
	<javierm@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<bobo.shaobowang@huawei.com>, <linux-kbuild@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH 1/5] ring-buffer: Update pages_touched to reflect persistent buffer content
Date: Mon, 17 Feb 2025 10:46:35 +0800
Message-ID: <20250217024639.1980139-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)

From: Steven Rostedt <rostedt@goodmis.org>

The pages_touched field represents the number of subbuffers in the ring
buffer that have content that can be read. This is used in accounting of
"dirty_pages" and "buffer_percent" to allow the user to wait for the
buffer to be filled to a certain amount before it reads the buffer in
blocking mode.

The persistent buffer never updated this value so it was set to zero, and
this accounting would take it as it had no content. This would cause user
space to wait for content even though there's enough content in the ring
buffer that satisfies the buffer_percent.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250214123512.0631436e@gandalf.local.home
Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0419d41a2060..bb6089c2951e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1850,6 +1850,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 				cpu_buffer->cpu);
 			goto invalid;
 		}
+
+		/* If the buffer has content, update pages_touched */
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
 		local_set(&cpu_buffer->head_page->entries, ret);
-- 
2.25.1


