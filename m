Return-Path: <linux-efi+bounces-664-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC4886268F
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671C51C2100A
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D5481D7;
	Sat, 24 Feb 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6v9+UOh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2655481AA
	for <linux-efi@vger.kernel.org>; Sat, 24 Feb 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797826; cv=none; b=fo1IboqyeTHMxC7Uuh1TVtl21A+ucrCDHrMpM6Y8dmOmGbdCVOl8qZiYa2iMsFc0MXsZpm1vmwILPzwGtseXsjALfz0P3PsAyyulhbBj7FrNurFm8TuNsvg38hDTgL15UGrKokoMVtot3uRzUlIwLsKxL9kO26CzXMtVu4gc87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797826; c=relaxed/simple;
	bh=eBDLM//Vvi48D/4Kp0nBWwLpPDYIWO6b/tdiMm4x4/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSlgiVKpK+7+VhTOEKi1LK/tw4tTxNTKe2IAk7Ef0mET4F47UJrn+IdG3G7GJFQETe/Ogk+CpePq8tOiLrOUh8KeR59L5rChRytuxOP60sdLab8WBjOsVP8RPv0c9Rw3feR4e/oB3ai5GtDJp/Fay24irpSPiZcGDY5wkpgLs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6v9+UOh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6083fbe9923so34370897b3.1
        for <linux-efi@vger.kernel.org>; Sat, 24 Feb 2024 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708797823; x=1709402623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWLwHGYB/96cFhayRopTTaFBn2ISYovDX2sYrw6SDqw=;
        b=c6v9+UOh9vZ/r0adfLLFYGg5DcHi29+QZGpaEvZvq0/27j4LYBg+tck4Hf3K/LbJbt
         aNMIIrfn699F2X3VA06Ec/3nFi/mXPHeneO0Ts8mueOG4HsyTNIlRwnexZ9Ph4PLMiQI
         4MB89J0CNeF/n7gcCdYThj4N/pwZLyBjLNSkK5kC1ErJ/65tvOczjsT6d1Sdn5W5g0sQ
         j0PesUwncF2Ejyd8ZOw2eCNlTAR6uU1N3zcLrlSNKeWPFfO/HOzcwkD/jkLcIG+xiUEV
         L6NDQYUKMHmgn0ejlhIXIszDJjrkz+nJMAtcMX8isWnUB2LGrfooeNy8Jh9VtBIEHpsX
         7dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708797823; x=1709402623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWLwHGYB/96cFhayRopTTaFBn2ISYovDX2sYrw6SDqw=;
        b=pbWorHkJOrOagiSxWTdVBDHZZAhWIDuf2R1/PET5xueg4xE5lw1EQYmcZ9RcoZxKbR
         2Ib00j3DWHv9mGW1g4QNYXfuvEEgsUiQvhzxDAK2Xu3HNyqRwfC547hFOwDzi6Mz8/Zr
         qPPw48cHgFKLb4Q0Drj6d2foPhRV3nm5FFpGkDpNnl0Dd3F56lIw5ogdtkfq0VjvjFEJ
         Q7XWJL8rcpuAuHFGVVPLRsEo0n9CB6RSqRUTn/OEWBxm7YdGHvzamcfdQH8U5F+soCnP
         q5LMQsEWONQCQrM83SM/Vxa5IjsBqnDUnheWJtuWXD1FcOr/GJTchlsL4XlpOxVBFpk8
         +NLA==
X-Gm-Message-State: AOJu0Yy40PkMo5HRdlT+ZzFAG+3JCNuY7DBW7rUrgkQlwUWrlDwiisks
	o1wwUtGXSjezzZbGLFpnineW8SRk/qtZEizd/7ttJUJcyXez+coZtKKRuMHty7MCbfXpYyv6+MP
	o6+VVyaEf5D1LuHUdgawQnkSYz9BorKaZBXoUai2A02unxvTLNQl5oi3XHo1GGZx3u38e6ZQexZ
	7ggYR14EIFUEdf2X84HLmJ5JBPVg==
X-Google-Smtp-Source: AGHT+IFd/h9h/T9P0NN/9TnS1p9P8bFC6508LDZOcxNH1L5RI+dlKAtoxrhjHGcNLr+oFmXUkbyp+6vW
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:ea4c:0:b0:608:2c2b:a3de with SMTP id
 t73-20020a0dea4c000000b006082c2ba3demr820991ywe.7.1708797823548; Sat, 24 Feb
 2024 10:03:43 -0800 (PST)
Date: Sat, 24 Feb 2024 19:03:31 +0100
In-Reply-To: <20240224180329.3564813-3-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240224180329.3564813-3-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860; i=ardb@kernel.org;
 h=from:subject; bh=B2vlTDSPtrVHVkHjTHhhwtuWFrU9P7Q9QRzL+EDp6Dk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfWWftEe/n0fKxoV4zsKoveZXPt5vuCU3KqF+TeO7bwZp
 uKfc7C0o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk2TeG/5m/hac/myww+c5j
 8xdtAjdq7t5IMrpgl2wZtoPbw0VUs5rhf3HOm5XteduCH0ttS9bMWLOdf4by+gbW9NIHomYldXm pTAA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224180329.3564813-4-ardb+git@google.com>
Subject: [PATCH 2/2] efivarfs: Drop 'duplicates' bool parameter on efivar_init()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The 'duplicates' bool argument is always true when efivar_init() is
called from its only caller so let's just drop it instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/internal.h | 2 +-
 fs/efivarfs/super.c    | 2 +-
 fs/efivarfs/vars.c     | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 169252e6dc46..f7206158ee81 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -38,7 +38,7 @@ struct efivar_entry {
 
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 			    struct list_head *),
-		void *data, bool duplicates, struct list_head *head);
+		void *data, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 210daac79748..bb14462f6d99 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -343,7 +343,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	return efivar_init(efivarfs_callback, sb, true, &sfi->efivarfs_list);
+	return efivar_init(efivarfs_callback, sb, &sfi->efivarfs_list);
 }
 
 static int efivarfs_get_tree(struct fs_context *fc)
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 114ff0fd4e55..69008517d699 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -361,7 +361,6 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  * efivar_init - build the initial list of EFI variables
  * @func: callback function to invoke for every variable
  * @data: function-specific data to pass to @func
- * @duplicates: error if we encounter duplicates on @head?
  * @head: initialised head of variable list
  *
  * Get every EFI variable from the firmware and invoke @func. @func
@@ -371,7 +370,7 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  */
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 			    struct list_head *),
-		void *data, bool duplicates, struct list_head *head)
+		void *data, struct list_head *head)
 {
 	unsigned long variable_name_size = 1024;
 	efi_char16_t *variable_name;
@@ -413,8 +412,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 			 * we'll ever see a different variable name,
 			 * and may end up looping here forever.
 			 */
-			if (duplicates &&
-			    variable_is_present(variable_name, &vendor_guid,
+			if (variable_is_present(variable_name, &vendor_guid,
 						head)) {
 				dup_variable_bug(variable_name, &vendor_guid,
 						 variable_name_size);
-- 
2.44.0.rc0.258.g7320e95886-goog


