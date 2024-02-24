Return-Path: <linux-efi+bounces-663-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8FA86268E
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 19:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53C2282CA4
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD77481BD;
	Sat, 24 Feb 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oErxsUSS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE538481AA
	for <linux-efi@vger.kernel.org>; Sat, 24 Feb 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797822; cv=none; b=s0czvjuK6FYBk845dUrJhq+/DGrdQDDmCg3jLM5O9tRRqoT0HvLvaEFYzWt3r4002Wk8rV1ThHEBP18ejOAwreK1MM2Vd4gKu1iUdkw3zHXWspVOcAaiGCCmyV17tQsvRMWfi6vUFkSkfLpe9HiYAcF0/yHenUHDCq8poFObfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797822; c=relaxed/simple;
	bh=kxs26b8GUoBlIyCI9eLI5q7CD84AMnG2Vsm9Mhiba6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DKRMMOpHRKhjTSPIDgAHcv74cPIXygRA638aLihafXWkz2KRTndWKc54RME7t7q1QJRJi7fvYkOG8YgEQHce7k4ulOKCVSKo8mvFPc6SPCAOkv9JxsLsh31JJFmyWzdd/DMdxsJ3iKlQapsQ9W9656v4YfnNIfWev8PskThQGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oErxsUSS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e40126031so9958585e9.0
        for <linux-efi@vger.kernel.org>; Sat, 24 Feb 2024 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708797819; x=1709402619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ds706J+QMrSrQnnNIIA/F9Fv75pH0gjOXcdejSWETMc=;
        b=oErxsUSSDO77vBjLdCow4zQAA77kowsIwFusSRoO8BexH71r5eqDXg97pejHwcOuAg
         VjeRCGt8sfFXaIyjw2k16xrr3yRRnTFrES58ArvD0sb1D6k2d6iDve6ieF5r7xWLw5T0
         27qhC9pAjwe4BykunHnBLg0nQbvNl49MVo+Sn1BiAAV92m04Xw/pnNHkRtpldUjPi9j1
         K87inUH4Vgj1IjQc2G8YSw9ufWnZwSn/tTW2AkJr1FwvwG9q4EHn87enlUD2PR95kLh2
         oPezeI70h75YeelFHPttqSkei8SYcfsoswud9PicrLhtAsSczAchemJedMYTrIt1bWzt
         3KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708797819; x=1709402619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds706J+QMrSrQnnNIIA/F9Fv75pH0gjOXcdejSWETMc=;
        b=hooryWVRDvZTRd1KX1ZurAr0VjdpMJU/qPB1qxRYp4opuox85cQR6F25HyOyrSiHqK
         g7h1uq+WKgoCKTvzgGWT76AQHZFSDjE2Ut4fx9+2C4SdccuLI7UTo1Q+8IHzBV/ARliu
         l3Gua1BCmStAD5Z8rjdTI2y7qiWZpdW9SUqVnMRYtlqtam4jdHZXwseyehL+ugRFCpVd
         fanzU6jIG4ktzBYGe929YR41g2rwVSqevhQoEUpYTZmKKx/iAPreVQ3MbaiWfOx8fSw2
         nmnbkQ97aaqBOZsv+2XPNgaEEJVtDrWRRg1C4GMsG++Q5gJv0ckfnHvghzvVCSZwQHM5
         HK1A==
X-Gm-Message-State: AOJu0YypDua2epzylrP3/bhJc7nWZZ8BaxuYAVy5xbiZCMVn8teVu6rE
	Wi17sT2EPwHaRbdRZsfFo3F8Tpr0q9W8O3GN4i0BhnmVsoe5wnPPvVlI/f4jzEFKNHRMygRxb5g
	7sP/drGwWeK9Np6bo+TwDLcufV5a60/AR9+71nbFIjvG36GReSXTvIiiGBAmhzY0RJaEmBaU3k2
	HwhZ7RjVPynmFoVYp6RwmTZxZV6g==
X-Google-Smtp-Source: AGHT+IH7Uf369/+ZgEnYidTajF9oA7yciLQDuFnohb7iqRL95DspDKSfBQ+ILERTd3WI8lsQubb6Oc7/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5185:b0:412:9a83:60e6 with SMTP id
 fa5-20020a05600c518500b004129a8360e6mr9831wmb.2.1708797819121; Sat, 24 Feb
 2024 10:03:39 -0800 (PST)
Date: Sat, 24 Feb 2024 19:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=ardb@kernel.org;
 h=from:subject; bh=bCSFBERUMUzyEABykVHI5Zo9ULmzeWURD0GH1TFeopI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfWWfuFrnfz+8OaSxw/+6s+MOHh6XdOjUx2zuN9/SWbtj
 1mZ93t1RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIWinD//Kvv9+tLLOpvPtx
 nl+KVNeWEIsCD2G3yOrGILf71688/cnIsKWzcwrTU4t/X1++q7nZm3/bd3VKP7NCzLyulkSX03O zeQA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224180329.3564813-3-ardb+git@google.com>
Subject: [PATCH 1/2] efivarfs: Drop redundant cleanup on fill_super() failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Al points out that kill_sb() will be called if efivarfs_fill_super()
fails and so there is no point in cleaning up the efivar entry list.

Reported-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 6038dd39367a..210daac79748 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -343,12 +343,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	err = efivar_init(efivarfs_callback, (void *)sb, true,
-			  &sfi->efivarfs_list);
-	if (err)
-		efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
-
-	return err;
+	return efivar_init(efivarfs_callback, sb, true, &sfi->efivarfs_list);
 }
 
 static int efivarfs_get_tree(struct fs_context *fc)
-- 
2.44.0.rc0.258.g7320e95886-goog


