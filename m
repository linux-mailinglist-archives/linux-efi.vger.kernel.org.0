Return-Path: <linux-efi+bounces-477-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD5849D51
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B4F281CA5
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7C36123;
	Mon,  5 Feb 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nVIOOvS7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93093418B
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144292; cv=none; b=OLKl/EuM9e1AwQsnLjDJQgUWTluRKdvXr4AgMRqFulRac3txdLWlnzFphfGJ00NNeLXyGYxCwcWdfZyb6mmGtUMMnHsGpBtTMIqkM4t2mGjOdPvo/b/PgspGEUMIDgvxxErjp+aXv9i8hR2sKOK/M3fEkV53Ua4hyE8Q642/HHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144292; c=relaxed/simple;
	bh=IdCdB0KKUa61egVepWgNq0MYZnF4/nYiQpsjALtWijA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnbhMpXBJuKwqbqjZP3jPWv3ou4KmgSzU/GlJ8syagvmaHnbs7a713jwNtZsRFa8TG77ev9WK2d9YakoorGOWCpAQqe+ZnyET3Gx4g77nN49g2yOR14OdfvHRaERWmq1HkNT7ngG0tWaEbM9WNHldrmDcnyhX2kvrSuA2qqMxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nVIOOvS7; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [80.240.223.29])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9859540755E8;
	Mon,  5 Feb 2024 14:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9859540755E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707144288;
	bh=htc5rAqji3dtNuzDApkDPw3CL4AMSYZOeew5AhJmz9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVIOOvS74wY7dqjxzboHycymvsCE2aLuIDy8+fG5rXFDJMtU+a8AfmQK7tER6J2hH
	 AQv2EdFQOJcobIQwSPwK4q8dZuHrvGaNkfAbYGrr/weU5WNsFPNTyNu0VMxJX5gLmk
	 +DfOaWsLuldOc1Mn3U/68zWDqOYCQyctLcAG5YXo=
From: Evgeniy Baskov <baskov@ispras.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Evgeniy Baskov <baskov@ispras.ru>,
	Mike Beaton <mjsbeaton@gmail.com>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-efi@vger.kernel.org
Subject: [PATCH 2/2] x86/boot: Align .compat virtual size
Date: Mon,  5 Feb 2024 17:44:01 +0300
Message-ID: <9b99e3e3c2c6c32a674ffa3272f85fa9443e33a0.1707141974.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707141974.git.baskov@ispras.ru>
References: <cover.1707141974.git.baskov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if this section is discardable, it still needs to have virtual memory
size aligned on section alignment to be compliant.

Align compat section on section alignment. This adds ~4k of memory after
the kernel image during EFISTUB execution but, it's not a problem on
x86 architecture.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/header.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 097b84ab288c..128e35f5c89b 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -184,7 +184,7 @@ section_table:
 #ifdef CONFIG_EFI_MIXED
 	.asciz	".compat"
 
-	.long	8				# VirtualSize
+	.long	pecompat_vsize			# VirtualSize
 	.long	setup_size + ZO__end		# VirtualAddress
 	.long	pecompat_fsize			# SizeOfRawData
 	.long	pecompat_fstart			# PointerToRawData
-- 
2.43.0


