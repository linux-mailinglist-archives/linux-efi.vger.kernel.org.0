Return-Path: <linux-efi+bounces-1557-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE6956DFC
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9285F1F23DE3
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50499176ACB;
	Mon, 19 Aug 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8UW8Flb"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0D17557E
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079387; cv=none; b=HzZ/Q7RM89uKJT1I8fJLe+Ap0Z509TbgA0Ojna4ODPidaCI3ar52JpX65Hv+Mj/4uRYrUPlvv9sW2UzYH9YrjOS6tP64RfEDRkpn5qSTOyWdIYMJGEpG0u9OV3NeI34OpKFNv9WW/Dqq1wtiCsg2hlz1iu9q5j+NBAwA8PNcjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079387; c=relaxed/simple;
	bh=bexWma/7ne+ZIXrU6dDSPnHuDTwc7JRVTEsbOGaQTlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL0v5Y5Lp51JhE7KQGDfP4jNIS8rO6jE2EgNdvay0oxy34ZIj9nbhcunzIplqN46QV/Hhs1UB/6Aan2jg4VjmHCiSGwEg7PNA8fnN+lE1BE3Atdm0uyKNqZXdkhxCyYvLPXtzhaQXKhEPpKftR20LJSIbIpeSoydB/xDSaozSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8UW8Flb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuBomQYrL4neI9/UIiUoEKpHGEUfWQV2ECUiNi8myCc=;
	b=D8UW8FlbKYEPDCaUMpQuUohZiu7TVBsrGzxIYoiVY2gfg9/vFdoNJ4Tku3ePWFSBolOTdy
	cCIGZ0/WrqVWTXoPonKCu7kTmuVyoIAjCVSFBeS5+bE3sN+UBh9/1PzZxErOeWT3O++UHm
	/f+M9GqDOZf6px9aFJJwOvyvWcN58r0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-CWQEnUUsNYCtspDcNI2Rqg-1; Mon,
 19 Aug 2024 10:56:20 -0400
X-MC-Unique: CWQEnUUsNYCtspDcNI2Rqg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DEEC1955D57;
	Mon, 19 Aug 2024 14:56:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A8CE1955F45;
	Mon, 19 Aug 2024 14:56:09 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 9/9] arm64: kexec: Enable kexec_pe_image
Date: Mon, 19 Aug 2024 22:53:42 +0800
Message-ID: <20240819145417.23367-10-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Now, anything is ready, enable PE image loading on arm64

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig                     | 4 ++++
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b53..fb6de7b4cd008 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1550,6 +1550,10 @@ config ARCH_SELECTS_KEXEC_FILE
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 
+config ARCH_SELECTS_KEXEC_PEIMAGE
+	def_bool y
+	depends on KEXEC_FILE
+
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 9fca3a35f04d5..c259d871b8e33 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -24,6 +24,9 @@
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
+#ifdef CONFIG_ARCH_SELECTS_KEXEC_PEIMAGE
+	&pe_image_ops,
+#endif
 	NULL
 };
 
-- 
2.41.0


