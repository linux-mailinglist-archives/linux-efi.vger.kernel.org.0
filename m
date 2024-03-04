Return-Path: <linux-efi+bounces-694-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1B87002F
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA831F24244
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5B38DE6;
	Mon,  4 Mar 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8Sxo9qN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050039FCC
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551226; cv=none; b=bXtl2fA0QxvC+fMwYDfSUcYEJ5Z+cTNgVO34YkKTgDN07sDoJKQ9VdMX8YKhael4z5Om1UOH1cByoePQoFULUPiqLE0JLBQ75+GRdQ3Fj+njMYQ2mCLdWu2z1sNyoaq19/AIuNhqb7ndzHf/RfGjj9mE6k7pw2koPhTYdDjqaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551226; c=relaxed/simple;
	bh=MZ5ZOrjFKPpiskhJjxCszA5CWhieK/cxWIrb/EKcx5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m9BpRFjW72KvAAStKWI9aknyOgLT2R9+xUZnQvtat/H+AGhOxhZdiy0WrOrYOTCYJiVgtSEcZ9HtC48PlBLjulcWOgnvu+k1EcceUjcM+CmzUP+fxwhU3RkhzdhM6/WILm9xwy68D4VKAzr6ggR6kojTse23EjfeTqIDQ1tx66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8Sxo9qN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso7733342276.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551223; x=1710156023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSsHpSt5ct1OFILUVAmXpAo7GQUCPIXFS0WoT8nXgWU=;
        b=d8Sxo9qNaxNMrm02clmRCuuYS5D2Hc4mLwc/iZPz/U8zn8K9o/5avA7vy2KnD4Y5vR
         zBmIe6gAZNQvRBW6oq7UrmZKLOcH9pWK7iLyDB4+HTN6TGUrBb+ViLbXy9RCxmRb841R
         g0Iyvy+Q2hq1Ati0FKYLjtIQjihi0kARPF52xDheFFUOwVRHMZu+JX0FTE7GOyNeYi4W
         MULGHBK/D2Qms/nF0cULIAiD7URyZVWEMWbTd4T4apn0gV8Ms26phDcCvo4RkBAZG4Jz
         dPY6zUCLWdGQL4RfOTEybrRHupcgFyc0eYDTZ29pPi+bd+3WPGb4AP7nnDprpiCWtXfJ
         vTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551223; x=1710156023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSsHpSt5ct1OFILUVAmXpAo7GQUCPIXFS0WoT8nXgWU=;
        b=qBcQ4beFAcW4zcuxVcgAi8Fzp7jGE0zTzUNHiVtB69zwoJZGAXfB4bDlc1x7y3QZzk
         jIvtthtz2O5uO8Ra3HUJKQ8OxkOwgxfiM4leBL8YhNBdkBboGYac9d8kpKAmlpwyo/32
         wnNjfPdIeMWdv1aYl1orKNnXyhg5XG1opxEj9DoNXxfaxbx/bMCmM9xop5v50erzVm2h
         NbVJehBmHotOfko91eyNV8o6mT25jz+EPIEZY9fiKJQU8Yka+NbC3n2go8Kii/i2TEba
         H8GW+CrtKyuLl62Oz8B4CSI2gZFLIPLNSTEyR8ENEBfcTa7q5ZRb6ZDeXHuyb50GwaHb
         KNZQ==
X-Gm-Message-State: AOJu0YzSWLdi2jBQN1MDLeFpbvU3VSpxwMzqZFnFMg2tCnVyjfU3jRc9
	LdtrOlGgnSrtJ3oz6sAoCjiPuZ32W2r/TAjDk8mOa4xXzEAEHmly+6WgLE82KFOddfTbmw==
X-Google-Smtp-Source: AGHT+IGfBSAd5voqXMAdKqy++G5u1p/YqXvV76rQrlY+Sfm4uyhqSdaxdbs96XZyuwEwE15bvldKvI9V
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:ef0c:0:b0:dc6:cafd:dce5 with SMTP id
 g12-20020a25ef0c000000b00dc6cafddce5mr2247355ybd.12.1709551223553; Mon, 04
 Mar 2024 03:20:23 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:40 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=ardb@kernel.org;
 h=from:subject; bh=AqJOAwI4fG7tKpMkIMw1VDde8EUwBC2EWoPZrfUZpHA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOu+k6l2WVcb2GktOtXhf+a+adObw7i833ZKev/bPn
 v7A9lpVRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIxd2MDBOTfR1eKkj/VfqU
 FtU0679TJLd5fbuIbO/ZTo/N9ywvazEyPJghGrmE6/Wxk7//WVkG/w7/w8y3jivzmPvZ1emHBMK DuQA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-22-ardb+git@google.com>
Subject: [PATCH stable-v6.1 02/18] efi: efivars: prevent double registration
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Johan Hovold <johan+linaro@kernel.org>

[ Commit 0217a40d7ba6e71d7f3422fbe89b436e8ee7ece7 upstream ]

Add the missing sanity check to efivars_register() so that it is no
longer possible to override an already registered set of efivar ops
(without first deregistering them).

This can help debug initialisation ordering issues where drivers have so
far unknowingly been relying on overriding the generic ops.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 0ba9f18312f5..4ca256bcd697 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -66,19 +66,28 @@ int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject)
 {
+	int rv;
+
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
+	if (__efivars) {
+		pr_warn("efivars already registered\n");
+		rv = -EBUSY;
+		goto out;
+	}
+
 	efivars->ops = ops;
 	efivars->kobject = kobject;
 
 	__efivars = efivars;
 
 	pr_info("Registered efivars operations\n");
-
+	rv = 0;
+out:
 	up(&efivars_lock);
 
-	return 0;
+	return rv;
 }
 EXPORT_SYMBOL_GPL(efivars_register);
 
-- 
2.44.0.278.ge034bb2e1d-goog


