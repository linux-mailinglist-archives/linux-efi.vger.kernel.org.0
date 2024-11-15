Return-Path: <linux-efi+bounces-2151-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A669CDB8B
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A911F22B5D
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71218DF89;
	Fri, 15 Nov 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaa8fHs2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBB18785D
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662935; cv=none; b=t+1XaJVMEp2mAsSp1AHLmxn4a54zJwvIml7Il1NtGJcz/d3BQjamAXoE8vW8DoIi8DTRDLqlD+Lxpp9E3/KrADNndpYfV/1PJAEfyVZE7sM8Ze+DH/fGpYY7uirqdEmThNSvG67vd1UUj42xIiromW6oqPZhODBt96uT3xrVaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662935; c=relaxed/simple;
	bh=90tPx57ecYokCX8TFKoiDt+c5cNgo6hbf2UHFyjECIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QfOZPtAaAuv6OW4/ez/EVQOoCmBtbgFZgb+EKrXBGPWdqCtetSZRAth1rauQ7Eri8xP9RsJK1Tr8g1vIFuGYDCJ/h3FAvfNtrzOJ5Oa0sXyOQPowvkkz8BdCh/RJBfRCeTiKnEvOxisOEs3TY69Y+t9ILBAKOZvHGQvS0oGKHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaa8fHs2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso14643685e9.2
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 01:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731662932; x=1732267732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDr83wTkAKDBKCmJsAmga2K6mdI7ocsaso6pmKyg8Jw=;
        b=jaa8fHs2n9zk7VvyBd5Kc9wFfOMy4DpNpKHjKT3wOKqVi11AePM9AsieByEHEIVyiR
         ZWz7gS6JA3b0m+VnVhno8BiwLE5P1HByTm7ejm7jh1B031crGl35zPnOqcDw2pPNxYlN
         S27ZFzuIhDaQJq3GaWXe2qa0Uq4QWR6Z/GsepTa+6qxFDARbygBbPqQ0BNTdaXp7GhJ9
         KR30vm/Q8ZFu3xBzyNAzeyM3RZXMTVmB5AlMrYOInFQm41+LROTcYKYtzKjOPjdFW0X0
         YsVQ/WTqDyfsZIxkBsZc5nN18V3aYcz+itPAYqlmg93pb/0SUkQZFnvl/fikk/ciiO4F
         jUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662932; x=1732267732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDr83wTkAKDBKCmJsAmga2K6mdI7ocsaso6pmKyg8Jw=;
        b=PwyzRpZXfpM+rWn8WsqS3k7cqABJJXc9D0MHza0xs86/Tw5zNDd+tG1nT9QbKHdg5N
         uBkljcw4Zh1VqqAReXKf6bGuAAfm3Zib/d2yMBoDatSRj7Zd184F/QrWeaIeVZ8aPHYX
         /kDDb4wTcla7vxtWQqJqzp0lCecahKtwZSf4xuzz3Wr6hisyJ/Y9CHPyBZOgXbP8c9Vd
         MxaQZPawDnUjhlE5ioi4vbgAeHz4L3B5EzhlOPQck+4XCV/dyNvA31VpbeDMvkPgezsu
         EdLyo8Hdyi6Q0rZyl5MGr2zq2x4pAHuC3iBDMlHWsRbaWvLjVip9Ktqb0rxQhA1PbXHC
         ehPQ==
X-Gm-Message-State: AOJu0YzfahXKjICPz2bhOFLoRUKmjuDUKtugEzqDVQ+feViy5/ipMRBa
	gaO003y1o+gHBSvPYcJgxwqq5KF9UgfPxbaRNGGVf6ELCjzERpqtJ1Cb3jV+toQVStBWt6c1Jk0
	PSNwUnTeGSLIyuUPCC/5mftE5mq9EW11Z9svaZ1TFsefnsGEHXbGuX9ZC5FjUBW1bvmhmTjsk0w
	22nfPV6+ccbtN0fHrzPCoa02S5qw==
X-Google-Smtp-Source: AGHT+IGDaaj7JD5P8b86+te4zrGMjd4Lv0gMV1VsaNlSXu8ljJ9nAUBwwlTHMbe6bV7/CfGtWpYhu/ej
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a7b:c34f:0:b0:42c:a585:5ec3 with SMTP id
 5b1f17b1804b1-432df78aa15mr15775e9.4.1731662931569; Fri, 15 Nov 2024 01:28:51
 -0800 (PST)
Date: Fri, 15 Nov 2024 10:28:40 +0100
In-Reply-To: <20241115092838.3080857-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115092838.3080857-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=ardb@kernel.org;
 h=from:subject; bh=Od9s2orxtV/zBkZhZ0hqQkiFfS0N/e9PjgNv2GVoxvg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1cxP3k11et0Ul1b/f/erAh4suVHQzGKm8D53/RqLe71
 pva9XlxRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIbkmGf3ZPY+1uHRJ4JPqp
 eeOq8yosi3Xb9FW3unv+zmjR37O51ZXhn9HrtsPVp1I1zn67XTfjyb8Du1s8nbZMWH4wvlSvzIm /hAsA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115092838.3080857-6-ardb+git@google.com>
Subject: [PATCH 2/4] efi/libstub: Parse builtin command line after bootloader
 provided one
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Jonathan Marek <jonathan@marek.ca>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When CONFIG_CMDLINE_EXTEND is set, the core kernel command line handling
logic appends CONFIG_CMDLINE to the bootloader provided command line.
The EFI stub does the opposite, and parses the builtin one first.

The usual behavior of command line options is that the last one takes
precedence if it appears multiple times, unless there is a meaningful
way to combine them. In either case, parsing the builtin command line
first while the core kernel does it in the opposite order is likely to
produce inconsistent results in such cases.

Therefore, switch the order in the stub to match the core kernel.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index fc71dcab43e0..382b54f40603 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -126,28 +126,25 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		status = efi_parse_options(cmdline);
+		if (status != EFI_SUCCESS)
+			goto fail_free_cmdline;
+	}
+
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
 	    cmdline[0] == 0) {
 		status = efi_parse_options(CONFIG_CMDLINE);
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse options\n");
-			goto fail_free_cmdline;
-		}
-	}
-
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
-		status = efi_parse_options(cmdline);
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse options\n");
+		if (status != EFI_SUCCESS)
 			goto fail_free_cmdline;
-		}
 	}
 
 	*cmdline_ptr = cmdline;
 	return EFI_SUCCESS;
 
 fail_free_cmdline:
+	efi_err("Failed to parse options\n");
 	efi_bs_call(free_pool, cmdline);
 	return status;
 }
-- 
2.47.0.338.g60cca15819-goog


