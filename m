Return-Path: <linux-efi+bounces-2150-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB099CDB8A
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80322835E5
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CB18C322;
	Fri, 15 Nov 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwJtOI5F"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2D18D621
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662930; cv=none; b=KMLjda+4/1WfA5uU+KzJyxfBWpGpMmVv2/VPXVceRLlUJQC8LJkeE1FRjvKIOXOBcK1vtW1z1LvwFy3P46gJWEN3lQIg2Her69IH7RskBlgmDKIfTM6BSQwYLEV+t+3lauC/GnEpPhyBLxVLKbG8YERkP6Pa9fWUfOQNoa/nHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662930; c=relaxed/simple;
	bh=kc535yvtQ8g1YGBB755uXai2x9MS7VjnGufa4hgeq+A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pnsAVXkXBv8HrsZknNbTn0nXRECyajygnvLUYzjZCGDcAwlgLk9wSGnkYDpx2FABsP7U/zebHRJ574qpyy7c0kjwAHwiYGvQHZrRgzkyF4dB7XOZIWm8fBiL4E0wmVRFvueFUlMYvNTBXRxl7jVT6557UOrBwazpZsjPcsxXyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwJtOI5F; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso9416785e9.0
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 01:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731662927; x=1732267727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zz9UmlLzjNzpLfdxnis/31bCV6XLCMazL0Yp99pwAUo=;
        b=JwJtOI5Fi/1ElDFeSPywQXEnqmkUtgMkyO+wBixVic6kiy8Zj9tyJUdcOKGOpvagwh
         Mx8UXqZa8yeMVmbpaHolck9H/ilZ1naU5l8I4jE+Rx6o+Zyev5UYZGVCyiVlXxRBT7ia
         389vzFXEW+qwV6onx5Y72uNXC/FMQ4eOUrF5h8ZXt78qYKIVNGqqHdqmon9zUaYwnl3f
         EJVCRzLeSy2j+LPfPilXIeds6CptyQi05OpZZQ40tobj4/SgrKdyY4S9IMD5b4hNiqMS
         kkQxFlBIkYSwop1UiD0lcoEDD9NFJmdeyCvpLVmwa8SMoGd4bZvw5JukG3VfNvBXOUbn
         ir7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662927; x=1732267727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zz9UmlLzjNzpLfdxnis/31bCV6XLCMazL0Yp99pwAUo=;
        b=JU+lfe9tM/h10kiR+6hZgIO5NKxwEA1Sh4VEYYf4p5jpMSTrTMx4R3mOOF0BcGk83D
         z6j5CTYGIqGOgyakK/Bblki8a2eRwE+fvTu96hSfGx8kaUym20K55pZpaezUwIHbitgP
         uXS6BOtuAUm898LEdVfoqtaQ56WVSQU6qxfT13tBAiJ5So4dietKHZVlcViFRvoUxQ4/
         KWU5XHUAkI8ajzfg4Ud/wig1Yro+cgUseDr7Ra6Uan1yAeB+QjGfXv56btHg6IHK+353
         xQBaWG/pnOBhWrzV0EgMvGIeAoaADzkeBk9FfNqtKNettCmCnNNUdyxYLUWXiCFHpXoM
         ce9w==
X-Gm-Message-State: AOJu0Yz8/gpgltQLmd2kbOs/aO25Imuwmuo40e+NpkxqgCNxodSkUNCO
	FlXUJHd0J4CwRObE0Yq+JfU+QfF/BpUByACtgiAHPvjdQSexiOWIgIYQ82ekO4nhH4/npF1ZGjS
	fswoYoSx4Df1QzkjcshmzM8nRqY8Xvtm2FsSpl1gPRaaDaU1HEIPIIxsJln4RjdyZRnPUuM8AuF
	IX+0SXYwgHbA9vRH78oJCrqu+3cA==
X-Google-Smtp-Source: AGHT+IFkqsRj1WhtZlgLtSK70EvwfJDpM706KIIaZu1twLJoTT7LSZ87HeighjrEDzrVhHsmiYFtp4hA
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a7b:c00c:0:b0:431:49b2:777d with SMTP id
 5b1f17b1804b1-432df0305dfmr450095e9.3.1731662927059; Fri, 15 Nov 2024
 01:28:47 -0800 (PST)
Date: Fri, 15 Nov 2024 10:28:39 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=ardb@kernel.org;
 h=from:subject; bh=xICokFLOYPGeGiDHADAdShtwtVonvWxpwP0PLJz03nY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1cxD09SFT7z+xtO5+IO/dLOh49Fe0wP890n+HuPafr/
 vrwuxztKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZq8rI8KOyoPzfMU+vOYvk
 N66foMNv+URS9v3UrV2/Ur78LtscpsTIMHnlrt36e4XNQwvXf1gUYRs0ZyHPRjnrKc+3LN61L+k /Bz8A
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115092838.3080857-5-ardb+git@google.com>
Subject: [PATCH 1/4] efi/libstub: Free correct pointer on failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Jonathan Marek <jonathan@marek.ca>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

cmdline_ptr is an out parameter, which is not allocated by the function
itself, and likely points into the caller's stack.

cmdline refers to the pool allocation that should be freed when cleaning
up after a failure, so pass this instead to free_pool().

Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint ...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f09e277ba210..fc71dcab43e0 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -148,7 +148,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	return EFI_SUCCESS;
 
 fail_free_cmdline:
-	efi_bs_call(free_pool, cmdline_ptr);
+	efi_bs_call(free_pool, cmdline);
 	return status;
 }
 
-- 
2.47.0.338.g60cca15819-goog


