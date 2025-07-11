Return-Path: <linux-efi+bounces-4283-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94629B01405
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27797B17EA
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F101E7C18;
	Fri, 11 Jul 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx3bW+Pp"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1341E521F
	for <linux-efi@vger.kernel.org>; Fri, 11 Jul 2025 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217467; cv=none; b=nGEIw0IsRfX7O1ycW6/ZdLAqw71Tg0cwjXPvNuFFYfbwoZqK0SoJbJ0uqlaOXiOi6/t4Fn+g3EkWMzIcaJ5JD+N/VvSJxfhDDSUwEOjF78+ii9Ps5jREL2486mOs0Jn4MtkS7DsROnSyKypd1ccaOR+UljuBE5fsaO6QJFnECaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217467; c=relaxed/simple;
	bh=qY+9hOJvt3smSdifJr60WwKCGN7aBvnCE1D6D2NWtug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZIPtjUTF02ifovpCexSZ3qelwXH+jsdZByABdtpvPaOePDWS6FykZtu/P0jhqZ5w320W9eY9s/e92na0kpCMtughR5WmrB8h3lGtPvPWVAG+LYSY8YmFz2HtNgAG90h7+O3Zd+AsAO3KMRAPJIYrYbn8ZPxCa/m5oAaaMcn7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx3bW+Pp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752217465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Mb5TKDQZ34m4zy+JEIT+Wrxi+rmT6FW7pNHMJM2OTM=;
	b=Jx3bW+PpevIWkdRaFrb3rWd6upBShXRdMY5cqctFSVaqNrloSkAyVl2czbdZaqP5krvyCw
	5ePfBAdXahRy17w5OfeRsjL0bTfKaPn5dL4/T5vyIoo1qTFrUH1ORX6LA6Y9TK2j6JmQI2
	pcPHCUWsLAL9KfMWkg4kVOiAp6kdakc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-KmRaUBegOLessUeWWwUSwA-1; Fri,
 11 Jul 2025 03:04:21 -0400
X-MC-Unique: KmRaUBegOLessUeWWwUSwA-1
X-Mimecast-MFC-AGG-ID: KmRaUBegOLessUeWWwUSwA_1752217460
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 785481956094;
	Fri, 11 Jul 2025 07:04:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.214])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08C019560A3;
	Fri, 11 Jul 2025 07:04:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AC55818009DD; Fri, 11 Jul 2025 07:44:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi: add API doc entry for ovmf_debug_log
Date: Fri, 11 Jul 2025 07:44:46 +0200
Message-ID: <20250711054446.1537700-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Documentation/ABI/testing/sysfs-firmware-efi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
index 5e4d0b27cdfe..927e362d4974 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -36,3 +36,10 @@ Description:	Displays the content of the Runtime Configuration Interface
 		Table version 2 on Dell EMC PowerEdge systems in binary format
 Users:		It is used by Dell EMC OpenManage Server Administrator tool to
 		populate BIOS setup page.
+
+What:		/sys/firmware/efi/ovmf_debug_log
+Date:		July 2025
+Contact:	Gerd Hoffmann <kraxel@redhat.com>, linux-efi@vger.kernel.org
+Description:	Displays the content of the OVMF debug log buffer.  The file is
+		only present in case the firmware supports logging to a memory
+		buffer.
-- 
2.50.1


