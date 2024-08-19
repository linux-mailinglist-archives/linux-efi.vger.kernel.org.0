Return-Path: <linux-efi+bounces-1550-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A902C956DEC
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDE41C22334
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3117556C;
	Mon, 19 Aug 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTkxBPEu"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A131741EF
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079316; cv=none; b=fvagrhXLEwhYjp5DOINp1RvrNvT4wgDwxhb+dWhrE2FNP/ShX5xAeElgTvuQ7NtrXSDSHzvjQsGXPLdNYU0g37Ya43EBs8K3A3+SAabTRudZzDAF9jF5mrGRgZx2MxF9J512/rlItdIl4NZKE5+0hB5J7DZJmJUsZjcpfAnFxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079316; c=relaxed/simple;
	bh=EowreNZLQ30N4cVY10ETji3j3fdTviu5kI0Pw22l/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM24ft4q1mhyDzTHesctCQt7lR31BvJaKQ8VaDa88hd4Xs0YInFyckYwpVaE7edvE+EAOb9fSOBR7UwVGVpQ8iq3D8jWP19Nedq3lFg14nweI0BBesKbpLNzSXxxC+wqoyOcwkcIZPluPVFs6AUS0mwCQS0wfyghGO0N9BvwJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTkxBPEu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgjZO4Zyjz7laVnuZPF54UYEyobsvNSUm+pwm24uBE=;
	b=ZTkxBPEuFbn8ro0projWq7LKLnK4CUDDWL8W6tSw52TCwgjSyew8tekKjh7eeGcUwhTUxA
	1G8dLRzrorW3SD2uyiOTuA+3mv+9QdxcLeP6Ms7SMO2YXd/OvbZuNPLYbZiS47IIqin+RO
	HOFnEnu/3rX1sJTishL1iiaGbHi3NxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Brd712sEOlOpIfxBr1n9_w-1; Mon,
 19 Aug 2024 10:55:10 -0400
X-MC-Unique: Brd712sEOlOpIfxBr1n9_w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CCB91956095;
	Mon, 19 Aug 2024 14:55:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75D3819560A3;
	Mon, 19 Aug 2024 14:54:59 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
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
	linux-kernel@vger.kernel.org
Subject: [RFCv2 2/9] efi/libstub: Complete efi_simple_text_output_protocol
Date: Mon, 19 Aug 2024 22:53:35 +0800
Message-ID: <20240819145417.23367-3-piliu@redhat.com>
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

Some uefi applications e.g systemd-stub uses more members in
efi_simple_text_output_protocol, hence extending its members as UEFI
specification.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/efistub.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 27abb4ce02917..a075d327a11ba 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -506,6 +506,13 @@ union efi_simple_text_output_protocol {
 		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
 						       efi_char16_t *);
 		void *test_string;
+		void *query_mode;
+		void *set_mode;
+		void *set_attribute;
+		void *clean_screen;
+		void *set_cursor_pos;
+		void *enable_cursor;
+		void *mode;
 	};
 	struct {
 		u32 reset;
-- 
2.41.0


