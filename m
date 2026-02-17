Return-Path: <linux-efi+bounces-6156-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ9eLeoglGmKAAIAu9opvQ
	(envelope-from <linux-efi+bounces-6156-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:03:54 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21D149889
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA64F301DED6
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62712DBF78;
	Tue, 17 Feb 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdH2nkby"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B742D838E
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315431; cv=none; b=eCEkjIkYRZLrRZtUnpuYbikTBwOYGEIFxH3K7W5U0ytD73cV71+XPLL0O4YU8L8lfm8W3YNNZAjplZ4eKirHRW3bSEud4ejbWNMKevbghxh8wq3REvlV1oWQhNkh22A5np4/m2d9T720NYHx2hQSmB1vyvjs0R4lYeynCGDfJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315431; c=relaxed/simple;
	bh=fBXwAEZd3nALXEsGIll356q2GrHqcdxNggAcIvQq68k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r76KZTApN3ynVoyR+libxn4ESVaBQ+q+hVdeVp4RCBxGMQiDXKFKEhKbz4k25qeXE0daiiEoUxocQuHR4QpvEiKZm+gkGLqS/VoO72c5wS/13FGeod4ZS3BAk3KeeU2O4Q/tGrXxjL627X7/G/fP4WALdlQA2e4au1sqAOEUzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdH2nkby; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771315429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=j4A53eO8aaanQ6ygp53jr6CDnyXo0/FyyAuhKBZ5z/E=;
	b=SdH2nkbyk68lSwmz+awIVmVMhOALOfMRy/kxD/WDtY3VXKqm/62AYD6gsZjlcgKzIa9CrL
	d9pc75gfynYCxKfdeRRae1/1aEjlp0Skgfpw2HRkxySqLi+hQacGwzxBEYY/Gy4JrD2Xrr
	zxbAO+ePbEs88od3yQ6lc/o48BhULGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-E9ebRdzKNZyQE7MxqXtdWg-1; Tue,
 17 Feb 2026 03:03:43 -0500
X-MC-Unique: E9ebRdzKNZyQE7MxqXtdWg-1
X-Mimecast-MFC-AGG-ID: E9ebRdzKNZyQE7MxqXtdWg_1771315422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA24B1955D88;
	Tue, 17 Feb 2026 08:03:41 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60F03180058F;
	Tue, 17 Feb 2026 08:03:36 +0000 (UTC)
Date: Tue, 17 Feb 2026 16:04:14 +0800
From: Dave Young <dyoung@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org
Subject: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Message-ID: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6156-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyoung@redhat.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C21D149889
X-Rspamd-Action: no action

Kernel panic occurs during a kexec reboot when EFI runtime services
are not enabled in the first kernel. The issue is that the second
kernel cannot find the ACPI RSDP address during boot.

In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
However, kernel decompression has moved to the EFI stub for EFI boot.
Therefore, the x86 EFI stub must also be updated to store the
acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
can find it.

(Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
reboot will still utilize the legacy decompressor path, so the original
code remains functional though some cleanups can be done later.)

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux-x86/drivers/firmware/efi/libstub/x86-stub.c
===================================================================
--- linux-x86.orig/drivers/firmware/efi/libstub/x86-stub.c
+++ linux-x86/drivers/firmware/efi/libstub/x86-stub.c
@@ -484,6 +484,22 @@ static void setup_quirks(struct boot_par
 	}
 }
 
+static void setup_acpi_rsdp(struct boot_params *boot_params)
+{
+	u64 rsdp_addr;
+
+	/*
+	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
+	 * ACPI_TABLE_GUID because it has more features.
+	 */
+	rsdp_addr = (u64)get_efi_config_table(ACPI_20_TABLE_GUID);
+	if (!rsdp_addr)
+		rsdp_addr = (u64)get_efi_config_table(ACPI_TABLE_GUID);
+
+	if (rsdp_addr)
+		boot_params->acpi_rsdp_addr = rsdp_addr;
+}
+
 static void setup_graphics(struct boot_params *boot_params)
 {
 	struct screen_info *si = memset(&boot_params->screen_info, 0, sizeof(*si));
@@ -1017,6 +1033,8 @@ void __noreturn efi_stub_entry(efi_handl
 
 	setup_graphics(boot_params);
 
+	setup_acpi_rsdp(boot_params);
+
 	setup_efi_pci(boot_params);
 
 	setup_quirks(boot_params);


