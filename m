Return-Path: <linux-efi+bounces-6172-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGa3EfGYlGkoFwIAu9opvQ
	(envelope-from <linux-efi+bounces-6172-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 17:36:01 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB73D14E491
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61CA0300908A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B536F419;
	Tue, 17 Feb 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryOTnV6d"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8336F411;
	Tue, 17 Feb 2026 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346150; cv=none; b=qT/dWopWVnJUfEHwU6iIRTvYstIjzcmupeHqnXfO7KIKS/4rB2TYcx4upIg9Yol5Hnj6Q4Tes7sa4KNaVyt2kvF7pcjncYS1GAEBoeYUbV5VLgNkDoow+74JsAuy4WDeHULGxkFBBWS7/gJRZTVYLyZgAxlksY0CDKdJST1E0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346150; c=relaxed/simple;
	bh=ecVx3g7x2p1shiCF2ISWvvUcCXEBjZVSsOCRXIKuBkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4RZn+t2SZBuHuYE5SULwnAlxR+cI3N8Asqaemy36yft7Gqzds5OtrF0imfUuyJTDgz0Z6Ug7cNMncjTC3eAJH0tSMuQSGi8WRjeSoJR+Wqa658uDa7AhmuVU8nPMmtWs8lXHgjoVxuiXh84gC35GREcTaa0HXxZnljy/y1tqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryOTnV6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67B1C19425;
	Tue, 17 Feb 2026 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771346149;
	bh=ecVx3g7x2p1shiCF2ISWvvUcCXEBjZVSsOCRXIKuBkw=;
	h=From:To:Cc:Subject:Date:From;
	b=ryOTnV6dtaTPJFKS6oy+jRC9bg1G/XjWoSllzNmeRivYW5DtSCOkmU9Hg/sUG/Gw0
	 9FcOXwHOTQsFd6pF8AJZdsgf4UQXr3RnomX4un4r31/y+peUkRH+GhBjI0CNKeeDlu
	 jwtZs54wzLlvrCfo1UWrvwTSIxr0SbBNHfvoqHFcalTjsp1Q4p5Ntu1vFN2Z3yp12g
	 1uYta0+JSy+vMTsCOhA1KO6IrdCXL1aqloSUEhRt1p1+Jpy6YVr8yazCtpyokDrQyG
	 4lRsHhrPknQ/WxsKB4fBnr0uvNZrpY9y/J+GEiDSPY67bQlHcaQf0OCBO+0P6jSI08
	 +QtOmGh+AiFsA==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH] x86/kexec: Copy ACPI root pointer address from config table
Date: Tue, 17 Feb 2026 17:35:32 +0100
Message-ID: <20260217163532.5166-1-ardb@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6172-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB73D14E491
X-Rspamd-Action: no action

Dave reports that kexec may fail when the first kernel boots via the EFI
stub but without EFI runtime services, as in that case, the RSDP address
field in struct bootparams is never assigned. Kexec copies this value
into the version of struct bootparams that it provides to the incoming
kernel, which may have no other means to locate the ACPI root pointer.

So take the value from the EFI config tables if no root pointer has been
set in the first kernel's struct bootparams.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Cc: <stable@vger.kernel.org> # v6.1
Reported-by: Dave Young <dyoung@redhat.com>
Tested-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/linux-efi/aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Unless anyone minds, I intend to take this via the EFI tree as a fix.

 arch/x86/kernel/kexec-bzimage64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7508d0ccc740..24aec7c1153f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 
 	/* Always fill in RSDP: it is either 0 or a valid value */
 	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+	if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
+		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+			params->acpi_rsdp_addr = efi.acpi20;
+		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+			params->acpi_rsdp_addr = efi.acpi;
+	}
 
 	/* Default APM info */
 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
-- 
2.53.0.273.g2a3d683680-goog


