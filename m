Return-Path: <linux-efi+bounces-862-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DE887739
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 07:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38E2B22B00
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 06:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC944A06;
	Sat, 23 Mar 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxJHeHs0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8C2107
	for <linux-efi@vger.kernel.org>; Sat, 23 Mar 2024 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711175626; cv=none; b=rvmcOHweYFngkJo725QjHA39Z4xRgMr4Dti00yMWwL8fqKf1bCZa86LCfhSNwakw/nRxuostVx0TxK7IqGiUqQ9jq1dPA/3MefHSpbVx6WjnmeZQfTEzkSEEikXmfuLqY9MB7zPfmQy+tVpRk5YpI00CerhfE3fprQZidfmdApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711175626; c=relaxed/simple;
	bh=9MoRzpMorl4jmgjybPXxJ3FOpwPB8iAT0iT1EWRFdR8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q02MYdkdNdJW8WCiMSdjPrg2KTik1qvAOOX0BxKWA2CvhVR6Chb4vKZK5sQPhGJLpHzRb89K0+vCL5O5G4Xhwiz5BoGdcCVFsdyFqLwiXzyG4Ysm5KvZe3hesH+zy1AGYy1GkjnQ1T7GGyMwdOaT7do71RY22jPWUqNcY81OrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxJHeHs0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cc00203faso47958757b3.2
        for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711175623; x=1711780423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txx7wotKqYRR4TcLWSwMoKBZaEfj0wAl/bTcQ8vVQKg=;
        b=OxJHeHs0Hv+yCqQjLHaB23SluVeUJE9GjE7FKuiyjZzMX4NHtasCaGDOOm/aeyoHGO
         8sWQsYDMzX2Eaqbjp6i1s5DO1Tc4Cxy83IbzEiO/UT101GP7FI3l2XGSy8HgWfG+xXS7
         /notuJVtG2c1W20RxLEV6SK9J7hT0geqWO60Do2BdG/+VAvyZLCUY57idZ9QW+EoX2Ql
         YElaq5k9O/vs7wcmN3JV64hmIXmeNXDKEhMenrk4n8ruwV2wvSgNapVuNtbjHThpioqG
         46n/yvxCnH7eXrRG9YpSLOEChnMr7kY+dC8HQ16Ot/q/VgP2wQQdiMjxF2v56esx1Bf7
         wBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711175623; x=1711780423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txx7wotKqYRR4TcLWSwMoKBZaEfj0wAl/bTcQ8vVQKg=;
        b=a9MFcBWNteJBR9bNPtIZpKYHQVxm4AdJ/iNLExQ5PXVmH4jDvdCm5NXEUMxRLjcSiw
         nubezGtzvQIg1Ebu7qC9/VmKrTirEIGXCUP9atFhBCTFB03c6jxYT59D4vSbVvxdwVrj
         N+PqKDCUaqx4mdsfKqpJDKCUt3zyIN4foL/3QX/0QrsOArahIdtnRXTsnQTQTIXvv5u4
         tXURUDD0VGUk6KcX7nulSiaCLjpdxmxzjLHQhnqnQ9FwZ9mp2q+7atG+rJuFv2suI5FN
         REHRyXitqjZ6Qqnz/QoghbNFDmYY3ppH9VcOYO4QMxtzv2G1ryGzfNRKZFJGSzNcbyfH
         chDw==
X-Forwarded-Encrypted: i=1; AJvYcCU/R5SzaMnBQEWsDe6SNXVtMvMb1pjA7sJsVCc+Ec7Da2dIsFtqmoDLnwQ0BiV/XprTHDaAO4u5wUUd0DlvFILx8VobY9Pl7jlv
X-Gm-Message-State: AOJu0YwvcVqAQpxTcrgQHr0P/lmnyZkUC+JisaecaMAcUEXLPJcIz7/b
	nOmcJ8sTtWRHKQMEblWJJiEtE/CB3XDlXHmgJ+Eva0r5k0oqV37Gn5yFFX0xUSt27w==
X-Google-Smtp-Source: AGHT+IEk5aj2iQAOOQTVlpVPwtoj+Ahn1h2Lsg5jYpIXleZg2+JKC8U+krr/mfKR++Kv6+vz8+cIUOs=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a81:49cd:0:b0:60c:c986:7cdd with SMTP id
 w196-20020a8149cd000000b0060cc9867cddmr435562ywa.0.1711175623549; Fri, 22 Mar
 2024 23:33:43 -0700 (PDT)
Date: Sat, 23 Mar 2024 06:33:33 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240323063334.735219-1-ovt@google.com>
Subject: [PATCH v2] efi: fix panic in kdump kernel
From: Oleksandr Tymoshenko <ovt@google.com>
To: Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: ovt@google.com, stable@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check if get_next_variable() is actually valid pointer before
calling it. In kdump kernel this method is set to NULL that causes
panic during the kexec-ed kernel boot.

Tested with QEMU and OVMF firmware.

Fixes: bad267f9e18f ("efi: verify that variable services are supported")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
Changes in v2:
  - Style fix
  - Added Cc: stable
  - Added Fixes: trailer
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8859fb0b006d..fdf07dd6f459 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -203,6 +203,8 @@ static bool generic_ops_supported(void)
 
 	name_size = sizeof(name);
 
+	if (!efi.get_next_variable)
+		return false;
 	status = efi.get_next_variable(&name_size, &name, &guid);
 	if (status == EFI_UNSUPPORTED)
 		return false;
-- 
2.44.0.396.g6e790dbe36-goog


