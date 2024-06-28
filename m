Return-Path: <linux-efi+bounces-1306-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DDF91B364
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 02:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A11F23018
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9682139AC;
	Fri, 28 Jun 2024 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzpnJNF6"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CF29B0
	for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534662; cv=none; b=l/G6OigvQqe+A32vEC9FRFlOiuA2rqGC+7Wp9ImwCCS0i8jB5eajw190rwH8pMvgkAnFVJZ7rtzsK2S9TfYwrULDDjvp/eGahrSn+RThaw81ZGu7XJHc4LsSN1+edJ+Y4MmzXsbPjS7lSEDOcDa72Px1NKjYGJRscrBqwkR6++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534662; c=relaxed/simple;
	bh=mGi3br9UC13i+sut16sB/CwEKVX820m4gMw5RVfumsA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f8KwXKbTGrnCU/fBZykRRSUXZNFYU14UWrko9n6C79vfadkselfc18QbtvFr6pOD9A5AHMrHj/r8ntqr6WRgxobSjrbvoRJltA71Id+09/NhXZkiSSYoyuNZ1J1Ba1RWPVhbZlWtmLmHcl3hA0I/JVvWaj9EK1QejsFzNQCivKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzpnJNF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UD0TZhFgnFh0fbg8+VW4LR/vmzomGaI+4ExHpGhlqJs=;
	b=MzpnJNF6LBSsyjnN9/kFhh7EnIb3ScdZhxRe+gMbYFZnHxtw9u6oNCLDCj1WRxU7xXnGN7
	vG2GtdXTZRv0Px8oj1n/IlpenatL8PVJ3t3/mLDFKOnNrO2hsf/Cvxl+HEmTAT6RB6ma52
	IxufPsjQN2G1Z8v5TrH+OwYeE+/SSEM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-TiSbFz0pPpelusFPvWewdQ-1; Thu, 27 Jun 2024 20:30:58 -0400
X-MC-Unique: TiSbFz0pPpelusFPvWewdQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f439f51960so3889139f.1
        for <linux-efi@vger.kernel.org>; Thu, 27 Jun 2024 17:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534658; x=1720139458;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD0TZhFgnFh0fbg8+VW4LR/vmzomGaI+4ExHpGhlqJs=;
        b=lHu7jPKNV2ElD4mIasOF2DLh6ZUVlWbS4FeYPINTKTcqB3lV2yY7iLr+vK7atox24R
         oTkmX7gUFr9sGdRZtVykfcQSdIUMETDv6b3SxE8HGHOCBvdinJOo06cEOv8azfLreiQU
         bcQ+wbU6yIqowELMSBBwX36vDLjvaMAZeIW+Jdm6fUZLau1No+i4JzLH+jkoOQnS232Z
         rPGIm+X23F4C7jps9YVimqmXiUeUezrTXLw8nCeczWbJ/F4zekqcFMH8QpNGSQZk35+D
         rqiUZJwUA5Hm4JclXg74RojnvKGewPKBpNfmC9sXr8Qp7CDdv8LXxHFhJLzaz3c5MyvR
         uNzA==
X-Gm-Message-State: AOJu0YwHMPS220jGkb0lxJX3cUspn3bWoY1HMAM0XLZo5zbpw2nHx6nG
	eBgaepTeQTjTPtAzTJp3fcZZ5vyZ5xr3SAuoZaQiXaBMK8Bw/phnVV9CdO9UoAZ1Lg9i1+yHyPe
	Pe4C5lGf1L3WBS1RD/gBxopYKVni/qp1YVz0fcmMbmWcuDi2zTVcG0zE12A==
X-Received: by 2002:a05:6602:8d:b0:7f6:1b3a:437b with SMTP id ca18e2360f4ac-7f61b3a44c2mr187734739f.17.1719534657860;
        Thu, 27 Jun 2024 17:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOsACJkE3UNbEuQpyjaC1nCYuaIr4BQ65r5H24LLaLew3xs2nJd5TV2I9cKqMq7cM4hfew/A==
X-Received: by 2002:a05:6602:8d:b0:7f6:1b3a:437b with SMTP id ca18e2360f4ac-7f61b3a44c2mr187733639f.17.1719534657514;
        Thu, 27 Jun 2024 17:30:57 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b8c81sm221640173.134.2024.06.27.17.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:30:57 -0700 (PDT)
Message-ID: <ff7c415c-43d4-4a1e-a987-246c781f8850@redhat.com>
Date: Thu, 27 Jun 2024 19:30:56 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 04/14] efivarfs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-efi@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/efivarfs/super.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index bb14462f6d99..a929f1b613be 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -275,8 +275,8 @@ enum {
 };
 
 static const struct fs_parameter_spec efivarfs_parameters[] = {
-	fsparam_u32("uid", Opt_uid),
-	fsparam_u32("gid", Opt_gid),
+	fsparam_uid("uid", Opt_uid),
+	fsparam_gid("gid", Opt_gid),
 	{},
 };
 
@@ -293,14 +293,10 @@ static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *para
 
 	switch (opt) {
 	case Opt_uid:
-		opts->uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(opts->uid))
-			return -EINVAL;
+		opts->uid = result.uid;
 		break;
 	case Opt_gid:
-		opts->gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(opts->gid))
-			return -EINVAL;
+		opts->gid = result.gid;
 		break;
 	default:
 		return -EINVAL;
-- 
2.45.2



