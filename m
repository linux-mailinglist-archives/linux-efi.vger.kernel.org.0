Return-Path: <linux-efi+bounces-3843-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA33AE19CE
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF35B1BC569D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4839221260;
	Fri, 20 Jun 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHHdFV4U"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64625E479
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418176; cv=none; b=Tr509nQynAOm6KSsuePzM978og6Ksusa4wP43ef9CovtE4ORGGhaGvYz59aNTfYcvlhDAJ6CwSl0iz5QfDglP+eFMDA6fdVLbG93sRBevmPyCuRe0nDYtvtMJyKReq+kXs/gHEjkIxtwrKmJxgFa2ULQM8nECZJHcnBaGz7W7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418176; c=relaxed/simple;
	bh=VpWF4/4W4NmQRZCNm2UxcqzHHT8ImMzvVW/eZ6Tt+Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sgRK3cjUNyjEjXfgKTIPxatElVKJJS4PNxLI1KH2mI7cYLhhBxHFPgOSUzARVvXje8Q9yLAJQfl6KIKwbt8jUM9lVafsqNsG9sNGw9HjCJz43WLYFyvhA3ClvJogxw4bfynVaz05x2UaYVfaIUwGl0c1R9qbpD0kyuRyNK07qT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHHdFV4U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750418173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0abdLyJa8VMRSoFUkI0FzGzOUZGFDdeAgxdmKWR9Zgo=;
	b=hHHdFV4U9y2EAg95dSkQz22Pwiht+K6Fh7O+jNmoY7SBHh5c1DLrZl9+aiPdH2d469Gj0f
	X1uuqbMSAEeWrNFiQeh3jEDNq/1o3u351M0FL6/otSdgihHBGIoX7WLRpQGZgKa94ZXKOc
	segMD++TMv8sLKLJoPVKkpQYVwYHY9Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-OySj42DhPYeXSJ--atzGxA-1; Fri,
 20 Jun 2025 07:16:12 -0400
X-MC-Unique: OySj42DhPYeXSJ--atzGxA-1
X-Mimecast-MFC-AGG-ID: OySj42DhPYeXSJ--atzGxA_1750418171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 294091956095;
	Fri, 20 Jun 2025 11:16:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C391419560B2;
	Fri, 20 Jun 2025 11:16:08 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Jones <pjones@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Heinrich Schuchardt <heinrich.schuchardt@gmx.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] efi: Fix .data section size calculations when .sbat is present
Date: Fri, 20 Jun 2025 13:16:07 +0200
Message-ID: <20250620111607.984534-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
section") neglected to adjust the sizes of the .data section when
CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
incorrect and some tools complain about it. E.g. 'sbsign' reports:

 # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
 warning: file-aligned section .data extends beyond end of file
 warning: checksum areas are greater than image size. Invalid section table?

Note, '__data_size' is also used in the PE optional header and it is not
entirely clear whether .sbat needs to be accounted as part of
SizeOfInitializedData or not. As the header seems to be unused by the real
world firmware, keeping the field equal to __data_size.

Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes in v2: drop PE optional header adjustment [Ard]
---
 drivers/firmware/efi/libstub/zboot.lds | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 4b8d5cd3dfa2..367907eb7d86 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -58,6 +58,6 @@ SECTIONS
 PROVIDE(__efistub__gzdata_size =
 		ABSOLUTE(__efistub__gzdata_end - __efistub__gzdata_start));
 
-PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
-PROVIDE(__data_size = ABSOLUTE(_end - _etext));
+PROVIDE(__data_rawsize = ABSOLUTE(_edata - _data));
+PROVIDE(__data_size = ABSOLUTE(_end - _data));
 PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
-- 
2.49.0


