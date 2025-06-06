Return-Path: <linux-efi+bounces-3819-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F20AD055E
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D56161C46
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D013DBA0;
	Fri,  6 Jun 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdlWIzRV"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18970EEB5
	for <linux-efi@vger.kernel.org>; Fri,  6 Jun 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224480; cv=none; b=Dc3yIopsXEHBdjreADNWZz5EPQOSDdu1tTQUNg/oJhyYJwCsglkR3NOxx9Q0vraLf8vhtmCuA4gJ1rU09FqujsqXxTx9e7SnUJ8ZF4Khc34mNzS8+kSbQkXiiUaPZ2JQPLzwF9ibMwnEfIl+YWGbQZy8LRs0XEnQSmjeD7GHmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224480; c=relaxed/simple;
	bh=/7iBzU3r1GPozEcYGhCVGVjgk634/K7NdYqe7dm2+gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JytCZWA7srS1WAT8cEjiYYDTWaSC+Z0FBEPF4dLxryv5zjlWmOl4Isum0lwzbdh2y7wSACupkRWnM1GwQUgKLGO+npnJtZ92s7s5MvUa7IK64IIPJ7zi8X5WexuoTC4h43MBr/AeiimpXolenHYu6oRNBFyYjJdT3pvfr17jm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdlWIzRV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749224478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NZqzUrzNJKUWHGvlIX3S4FYdgn3FdTRfiGRa2Z5gBww=;
	b=hdlWIzRVHnWBUQknUfEfl4n/edYFhkBM1aAuUqQNZdbratE8+qLYXOzy92TGLa0DFNLsjR
	pRb78jCfITxlLXO94B9JeOpGZ8Uow35m59BQLzQgFSGxxvA+nxtNK/dMQpqCKLA340kO42
	Cs6twoFw02rr9xlV6pTocpJ4a42NfxM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-iF9Zgw1FOGG9JcWAhdL19w-1; Fri,
 06 Jun 2025 11:41:17 -0400
X-MC-Unique: iF9Zgw1FOGG9JcWAhdL19w-1
X-Mimecast-MFC-AGG-ID: iF9Zgw1FOGG9JcWAhdL19w_1749224476
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0191519560A6;
	Fri,  6 Jun 2025 15:41:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.251])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E08811956050;
	Fri,  6 Jun 2025 15:41:13 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Luiz Capitulino <luizcap@redhat.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi: Drop preprocessor directives from zboot.lds
Date: Fri,  6 Jun 2025 17:41:12 +0200
Message-ID: <20250606154112.311565-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Older versions of `ld` don't seem to support preprocessor directives in
linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:

 ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
 ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error

We don't seem to need these '#ifdef', no empty .sbat section is created
when CONFIG_EFI_SBAT_FILE="":

 # objdump -h arch/arm64/boot/vmlinuz.efi

 arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little

 Sections:
 Idx Name          Size      VMA               LMA               File off  Algn
   0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, CODE
   1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
                   CONTENTS, ALLOC, LOAD, DATA

Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Note: not-yet-merged x86 version of 0f9a1739dd0e does not seem to be affected
as vmlinux.lds script is a pre-processed version of vmlinux.lds.S.
---
 drivers/firmware/efi/libstub/zboot.lds | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index c3a166675450..4b8d5cd3dfa2 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -29,14 +29,12 @@ SECTIONS
 		. = _etext;
 	}
 
-#ifdef CONFIG_EFI_SBAT
         .sbat : ALIGN(4096) {
 		_sbat = .;
 		*(.sbat)
 		_esbat = ALIGN(4096);
 		. = _esbat;
 	}
-#endif
 
 	.data : ALIGN(4096) {
 		_data = .;
-- 
2.49.0


