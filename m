Return-Path: <linux-efi+bounces-5957-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDFFD02AD4
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 13:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5372E301B312
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EF4AACCB;
	Thu,  8 Jan 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3xSQKI6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F779495529;
	Thu,  8 Jan 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872137; cv=none; b=g/lvxJQZ0BGXnuhSjO2XdbclyETcXL4Y3LLXAVatBhL6yBF3OgqxT9PutoymRQVrn95uwIM8ou9Bj5F/SGfxV8VoiWN4NDJ20s4Zm9wKFg+0hLcjJUZ8LhyQGqjVEpU40KjC9sxe514WnNzSEPQa6X2s6iLH5vtist9HV1Vk3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872137; c=relaxed/simple;
	bh=7ClOr2/SXZvL7/2ZcJPhfqf9+Zeyoc7xjpGBwuIaGtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5Xd3CSEq63EAVZHujxCtJ6kbZx4QdBpyLao4gFatn2i+AccSyXGrrRvmg6crJDxmqweo43saE3GPvF96xoG4P+vgPu/NVZ8hluyF/QL/fwxs8Mglr/uici61zu9nnumduCPYgAkG0C7OaTfCOYdQ+53U2jd1VKnuq9/erhBrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3xSQKI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E93DC19421;
	Thu,  8 Jan 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767872136;
	bh=7ClOr2/SXZvL7/2ZcJPhfqf9+Zeyoc7xjpGBwuIaGtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3xSQKI6e8ONZTUffaDWdBa9taK+4xZA1ufJmKzvcNUEqrzOQaXb5uEM5t6Tvp21j
	 Aq7c38CL2HsuJOTaCF0ZwnsxHm9yO8nJn7SoZWy5l6HwDVL9rK42gbhmqpoA2fcCnj
	 o8y3O0SX9RVpLIdEn51RkhxbJvcF+v1QvmqFd8lgUyz36aL2C2f6nAr2sEJ5fQqwfQ
	 6k3CqTc6o+1Lr2LvkMjgy6SchZqhoiR4tAedDRJhZNLS09baRdKLyO6/UsmoOGez7W
	 jlYZ2cBWqLsvMgk2d45ShitMo5kVU+toIQVJrzzuxyRo+VC1+3EAceWpg4Ius6rBfd
	 Blq6nMhfLMq1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdoIg-000000033yK-0JFk;
	Thu, 08 Jan 2026 12:35:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v6 4/4] efi/cper: don't dump the entire memory region
Date: Thu,  8 Jan 2026 12:35:06 +0100
Message-ID: <1752b5ba63a3e2f148ddee813b36c996cc617e86.1767871950.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767871950.git.mchehab+huawei@kernel.org>
References: <cover.1767871950.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The current logic at cper_print_fw_err() doesn't check if the
error record length is big enough to handle offset. On a bad firmware,
if the ofset is above the actual record, length -= offset will
underflow, making it dump the entire memory.

The end result can be:

- the logic taking a lot of time dumping large regions of memory;
- data disclosure due to the memory dumps;
- an OOPS, if it tries to dump an unmapped memory region.

Fix it by checking if the section length is too small before doing
a hex dump.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/firmware/efi/cper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 88fc0293f876..0e938fc5ccb1 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -560,6 +560,11 @@ static void cper_print_fw_err(const char *pfx,
 	} else {
 		offset = sizeof(*fw_err);
 	}
+	if (offset > length) {
+		printk("%s""error section length is too small: offset=%d, length=%d\n",
+		       pfx, offset, length);
+		return;
+	}
 
 	buf += offset;
 	length -= offset;
-- 
2.52.0


