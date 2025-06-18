Return-Path: <linux-efi+bounces-3832-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03BADEC00
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jun 2025 14:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8784A5E25
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jun 2025 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BAB136A;
	Wed, 18 Jun 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1Z/tgcZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F94EB38
	for <linux-efi@vger.kernel.org>; Wed, 18 Jun 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249221; cv=none; b=pOt0JSUv3KvS9cnVlsmURZ9WWh27UgtKXvO/zdkVvwJABydf8Vacb2bXyNYAsH8DEFWTli6OwlYJNHcCPGcS9S5sdsgYNcGF0A3PwKHYoMM1c6yTE4kt1pd72mqfT31qRsy3yQNyFFJ/Qp37o98dSFY7ySFXApvQ5SaMksac3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249221; c=relaxed/simple;
	bh=yj6XDEI0c/leEStzGKY33blMwFsgVYk4D3HOjU1TB08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5x8pXpgIZN3dOPfBgySEMjHYGsk3X3GJkur1FLp1vyLagT6E2J25iVXXePi+XsRK3g+Z7+X9PiIAfe0lEKjxiv0XT3gbdz7Z5Q2zVHAZ9Zp0+u7KRqAk2C/IqcRx+Wr17Ss35QbJ2BYCBjQbEltk8sUrOO1HnMRBo4C0I6aius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1Z/tgcZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750249217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hFe+rPDX96ojkb7TEirKpA4zOH706+y0bje5dKVQll4=;
	b=M1Z/tgcZUWTag4c77SQICFvg/SHl1EWb0hcJogk/aXmo22IhgxIlwuqWUq8zpmhX5Z+h9c
	ySHFh3fplIXrcW3WanwSc+oePI5CRBCKLNBMt9svAG9APd6Y4m9saNoPLI1Ubx1660sBIG
	NCyqPdagLRxT16e3Ptu6lXbWSgqbq5o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-al53DCeKMbCd84UoKQ3-3Q-1; Wed,
 18 Jun 2025 08:20:14 -0400
X-MC-Unique: al53DCeKMbCd84UoKQ3-3Q-1
X-Mimecast-MFC-AGG-ID: al53DCeKMbCd84UoKQ3-3Q_1750249213
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 166A019560B1;
	Wed, 18 Jun 2025 12:20:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.43])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C5E18003FC;
	Wed, 18 Jun 2025 12:20:10 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Jones <pjones@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Subject: [PATCH] efi: Fix .data section size calculations when .sbat is present
Date: Wed, 18 Jun 2025 14:20:08 +0200
Message-ID: <20250618122008.264294-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
section") neglected to adjust the sizes of the .data section when
CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
incorrect and some tools complain about it. E.g. 'sbsign' reports:

 # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
 warning: file-aligned section .data extends beyond end of file
 warning: checksum areas are greater than image size. Invalid section table?

Note, '__data_size' was also used in the PE optional header. The field is
supposed to reflect "The size of the initialized data section, or the sum
of all such sections if there are multiple data sections.". While OVMF
based firmware doesn't seem to care much about what's there, it sounds like
including .sbat in the calculation is more correct.

Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/firmware/efi/libstub/zboot-header.S | 2 +-
 drivers/firmware/efi/libstub/zboot.lds      | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index b6431edd0fc9..65df5f52e138 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -41,7 +41,7 @@ __efistub_efi_zboot_header:
 	.short		.Lpe_opt_magic
 	.byte		0, 0
 	.long		_etext - .Lefi_header_end
-	.long		__data_size
+	.long		__all_data_size
 	.long		0
 	.long		__efistub_efi_zboot_entry - .Ldoshdr
 	.long		.Lefi_header_end - .Ldoshdr
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 4b8d5cd3dfa2..f423204fba0f 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -58,6 +58,8 @@ SECTIONS
 PROVIDE(__efistub__gzdata_size =
 		ABSOLUTE(__efistub__gzdata_end - __efistub__gzdata_start));
 
-PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
-PROVIDE(__data_size = ABSOLUTE(_end - _etext));
+PROVIDE(__data_rawsize = ABSOLUTE(_edata - _data));
+PROVIDE(__data_size = ABSOLUTE(_end - _data));
+/* The sum of all data sections, i.e. .data and .sbat */
+PROVIDE(__all_data_size = ABSOLUTE(_end - _etext));
 PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
-- 
2.49.0


