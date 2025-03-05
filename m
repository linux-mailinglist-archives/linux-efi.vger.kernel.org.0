Return-Path: <linux-efi+bounces-2894-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B622A4F4A3
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 03:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874493AB9EC
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B815573F;
	Wed,  5 Mar 2025 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ancLDkYO"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A185155300
	for <linux-efi@vger.kernel.org>; Wed,  5 Mar 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141347; cv=none; b=E4VNU41jaLHjqOshXA3dGpFjxizaqDHJvSnbEzN4e3Ltt4AgdOpqFnI267jxLucPo8fA/574PDEf5NidwPKxm8kNE6Eq2GRgQn9tcErGzeNYOimpk+XDGbFRHC0XQAY60YjUZYbvZ0tI868NnZyIqlUsaajllBvUXlZkKP8jVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141347; c=relaxed/simple;
	bh=rqRlavxmZUaLIf4yVkniFSJFKnQ5oM/LDJ7eUVpTdCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLNoMonKib8Jj01RjRE8f7kxFgzYLWEyITXrz0E56yO/71x1jAInr+97nCfRj0bFp/RrABLKMjmnJsS7DCFYkD9gH10SUU4WAFUatyAG8DrikfHQgl+hVrNkAE9I9vrwNDuB1MxXTrMG7j33XjZPyQ1AFhsFDQk/ji38gbe51Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ancLDkYO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741141341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z9exZRKmyKrZHf+rgrYcQi5Z7IXeB7+IoeNx/2M67zs=;
	b=ancLDkYOo6sQaCZX6XfmbpB+9hzFB5WoezJRlQhaQQJa8SJbY1E8PUWjdYVyMWbIIvoooW
	tSpx5wzHdsn/mK7GIwTk+QKVKm0m192I9ZNkETEV9OvW20NJ7pZDp4E+f1NzNtFQdK9ZsT
	nGDYW2CGqBcR8gKdO0Qm51Quwsek85U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-z9zjwkIPMNmIySsZeITidw-1; Tue,
 04 Mar 2025 21:22:13 -0500
X-MC-Unique: z9zjwkIPMNmIySsZeITidw-1
X-Mimecast-MFC-AGG-ID: z9zjwkIPMNmIySsZeITidw_1741141331
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1826A1955BFC;
	Wed,  5 Mar 2025 02:22:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C58D31954B00;
	Wed,  5 Mar 2025 02:22:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-efi@vger.kernel.org,
	Olivier Gayot <olivier.gayot@canonical.com>,
	Mulhern <amulhern@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3] block: fix conversion of GPT partition name to 7-bit
Date: Wed,  5 Mar 2025 10:21:54 +0800
Message-ID: <20250305022154.3903128-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Olivier Gayot <olivier.gayot@canonical.com>

The utf16_le_to_7bit function claims to, naively, convert a UTF-16
string to a 7-bit ASCII string. By naively, we mean that it:
 * drops the first byte of every character in the original UTF-16 string
 * checks if all characters are printable, and otherwise replaces them
   by exclamation mark "!".

This means that theoretically, all characters outside the 7-bit ASCII
range should be replaced by another character. Examples:

 * lower-case alpha (ɒ) 0x0252 becomes 0x52 (R)
 * ligature OE (œ) 0x0153 becomes 0x53 (S)
 * hangul letter pieup (ㅂ) 0x3142 becomes 0x42 (B)
 * upper-case gamma (Ɣ) 0x0194 becomes 0x94 (not printable) so gets
   replaced by "!"

The result of this conversion for the GPT partition name is passed to
user-space as PARTNAME via udev, which is confusing and feels questionable.

However, there is a flaw in the conversion function itself. By dropping
one byte of each character and using isprint() to check if the remaining
byte corresponds to a printable character, we do not actually guarantee
that the resulting character is 7-bit ASCII.

This happens because we pass 8-bit characters to isprint(), which
in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.

This results in many values which should be replaced by "!" to be kept
as-is, despite not being valid 7-bit ASCII. Examples:

 * e with acute accent (é) 0x00E9 becomes 0xE9 - kept as-is because
   isprint(0xE9) returns 1.
 * euro sign (€) 0x20AC becomes 0xAC - kept as-is because isprint(0xAC)
   returns 1.

This way has broken pyudev utility[1], fixes it by using a mask of 7 bits
instead of 8 bits before calling isprint.

Link: https://github.com/pyudev/pyudev/issues/490#issuecomment-2685794648 [1]
Link: https://lore.kernel.org/linux-block/4cac90c2-e414-4ebb-ae62-2a4589d9dc6e@canonical.com/
Cc: Mulhern <amulhern@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- userspace break words in commit log
	- Cc more list and guys

V2:
	- No change - resubmitted with subsystem maintainers in CC

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';
-- 
2.47.0


