Return-Path: <linux-efi+bounces-4307-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B7B03697
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 08:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC383B981D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5394218596;
	Mon, 14 Jul 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSp9aPs3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F82222AB
	for <linux-efi@vger.kernel.org>; Mon, 14 Jul 2025 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473464; cv=none; b=LcxNwFj1ID01idA2BnmNrLdNKgPK7ulYF/vfEfJIzxQ60uPhZrVmKlVred9gS9tssXq3/9GmodAMRs6X3rfoyf+dLgY1fTC/7u6P9rp+ZtBm4oo4NI29XD9m9Iik/LGGgaCNedhFD8d4jSna5qfJwuMS0+OIJlcqPeiL2x881oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473464; c=relaxed/simple;
	bh=XDk/UZY05XJ4EiH/B3HsLcLcKWy6I2jZ9/dIhAfsBko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P98g5QN7OvMSFRL0ittOU/Gez42EI9fcHVwCQbnISd3HeXyX6y3w1CFl7OHEx+FeNfIjkng+FW6bs3BR5JLRuZ0N/iFoq46bhpqbqTHZrGShyXEJVIEa6GXf8GvhloLqZjtwsPNKYv/9sjTmZHdFk1TsWMDqco+TzpqAHXSAHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSp9aPs3; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so1721220f8f.2
        for <linux-efi@vger.kernel.org>; Sun, 13 Jul 2025 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752473460; x=1753078260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAtRoMW47q6eWngfmkGzhbl2Om3dflePIieHts+FOBI=;
        b=bSp9aPs3KRtkvhLEe2L93iLZxWia/AnejfcfvLbVVauDo4EljAzb3XvQnXIyU6iEuj
         8mwsnJfQxL8KLpdIzSrHRMUkIJ9VtXC4LSI7qbFnBd/q2S8mOdGmN9iiJsE9pxiMbnSo
         0TX+sraR9cYPpBuQXsYrQFoF5M7vgWSVKHTX7WuCbzgNw7lhlZCJqAl9CBGRapN1Ba3D
         UjcaFkZ3uvk5fc7aYZBW6Fs2pPpufC7ZlnrIWC0BPVZLH9IwuhxBHabvi0FQUGFop9T7
         S3lbwGGAbc51hia50dS5VEj619aJGTHsFep2DTlQJZZC9KNExMmZvdyzIcLplMbgDhfT
         AYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473460; x=1753078260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAtRoMW47q6eWngfmkGzhbl2Om3dflePIieHts+FOBI=;
        b=IYVKirbt8Zjt/pza2xCR0ociZoyxCVIkFBNZ/Fk9WVnFtJO4n+8O3XOtrqLUav8og+
         CjSoWQIUf6c86jIGUR0v4LlBcx37DpLxsS825zB3PGGusg2cun3noJdaU4mx2TKIVX2f
         aZODC7Np2pY7NNOAB8GD8tJMGZUA1N4EbZCw1NrlHAjBOYz9fWOBj0cpaHfW5cUWc9Vz
         dhuM1zkaibVjJvVVetNyPxzXkW7TFdVpriXR7JTubtGmI+rjb0TR5CtNO5elTBDrtU6W
         KwSrtmTHluTpCnS8MK7Oqpf3B71+lroeXfKvMHjcrYJiaWYR892YZCt35Reyp9xuhQP5
         Q3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6SFFANtwLeEyfYM0ruXUoXVtgxayd+riNZbfvRL93eGif8RMP3vCvCB/kFP5wfqijYacmTdt9UZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxq6j6k21mp29Jt3klMyYCvHzIN7rZ6BN8qUK5UaWNGGKTYxZ
	ab4nO/qwDs0zmUpGEM8cEIwDs7zYE6JQDZYr/41ci2QOaY98dbrBde8A01MVdWgLR4pfi164Fg=
	=
X-Google-Smtp-Source: AGHT+IFsCLtHJL4bZduQByJdBWFSePt0ZVoqPC5acNqYECl/7QLB3y/VpTPIitmJ3C2pFikEet6/1z+u
X-Received: from wmbay17.prod.google.com ([2002:a05:600c:1e11:b0:450:cd94:c302])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:240a:b0:3a5:8a68:b839
 with SMTP id ffacd0b85a97d-3b5f2e26c14mr9849725f8f.45.1752473460616; Sun, 13
 Jul 2025 23:11:00 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:08:46 +0200
In-Reply-To: <20250714060843.4029171-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5138; i=ardb@kernel.org;
 h=from:subject; bh=ntdr4EjVjZJfnyc3XZ20vyNdLzsBSSjtiozuNHpTjes=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNk3s+Lmbqczj0rvAVfRxbEdM6a85TrRHj8D0lpvTzZ/
 Fdaq652lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk4VjL8T33FvUb59jozdqnm
 q/uqv/H1Tplbn7TcdSZ/lf6yLc3mAgz/jPUOZcXfVexgUWyuFC302nb67J1Gr/K2qWeKJ0eZ/2j hBwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714060843.4029171-7-ardb+git@google.com>
Subject: [RFC PATCH 2/3] efi/test: Don't bother pseudo-testing unused EFI services
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI test module covers the get/set wakeup time EFI runtime
services, as well as GetNextHighMonoCount(). In both cases, though, it
just mindlessly exercises the API, without any functional testing.

In case of the get/set wakeup time services, this would involve setting
the wakeup time, and subsequently checking whether the system actually
wakes up at the configured time, which is difficult for obvious reasons.

In case of GetNextHighMonoCount(), this would involve performing some
kind of verification that the returned number increases monotonically
across reboots.

Given that these APIs are not used in Linux to begin with, let's not
pretend that testing them in this manner has any value, and just drop
these tests entirely, so that we can drop the APIs themselves from the
Linux EFI runtime layer.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/test/efi_test.c | 108 +-------------------
 1 file changed, 2 insertions(+), 106 deletions(-)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 77b5f7ac3e20..bb2ace902346 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -333,77 +333,6 @@ static long efi_runtime_set_time(unsigned long arg)
 	return status == EFI_SUCCESS ? 0 : -EINVAL;
 }
 
-static long efi_runtime_get_waketime(unsigned long arg)
-{
-	struct efi_getwakeuptime __user *getwakeuptime_user;
-	struct efi_getwakeuptime getwakeuptime;
-	efi_bool_t enabled, pending;
-	efi_status_t status;
-	efi_time_t efi_time;
-
-	getwakeuptime_user = (struct efi_getwakeuptime __user *)arg;
-	if (copy_from_user(&getwakeuptime, getwakeuptime_user,
-				sizeof(getwakeuptime)))
-		return -EFAULT;
-
-	status = efi.get_wakeup_time(
-		getwakeuptime.enabled ? (efi_bool_t *)&enabled : NULL,
-		getwakeuptime.pending ? (efi_bool_t *)&pending : NULL,
-		getwakeuptime.time ? &efi_time : NULL);
-
-	if (put_user(status, getwakeuptime.status))
-		return -EFAULT;
-
-	if (status != EFI_SUCCESS)
-		return -EINVAL;
-
-	if (getwakeuptime.enabled && put_user(enabled,
-						getwakeuptime.enabled))
-		return -EFAULT;
-
-	if (getwakeuptime.pending && put_user(pending,
-						getwakeuptime.pending))
-		return -EFAULT;
-
-	if (getwakeuptime.time) {
-		if (copy_to_user(getwakeuptime.time, &efi_time,
-				sizeof(efi_time_t)))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static long efi_runtime_set_waketime(unsigned long arg)
-{
-	struct efi_setwakeuptime __user *setwakeuptime_user;
-	struct efi_setwakeuptime setwakeuptime;
-	efi_bool_t enabled;
-	efi_status_t status;
-	efi_time_t efi_time;
-
-	setwakeuptime_user = (struct efi_setwakeuptime __user *)arg;
-
-	if (copy_from_user(&setwakeuptime, setwakeuptime_user,
-				sizeof(setwakeuptime)))
-		return -EFAULT;
-
-	enabled = setwakeuptime.enabled;
-	if (setwakeuptime.time) {
-		if (copy_from_user(&efi_time, setwakeuptime.time,
-					sizeof(efi_time_t)))
-			return -EFAULT;
-
-		status = efi.set_wakeup_time(enabled, &efi_time);
-	} else
-		status = efi.set_wakeup_time(enabled, NULL);
-
-	if (put_user(status, setwakeuptime.status))
-		return -EFAULT;
-
-	return status == EFI_SUCCESS ? 0 : -EINVAL;
-}
-
 static long efi_runtime_get_nextvariablename(unsigned long arg)
 {
 	struct efi_getnextvariablename __user *getnextvariablename_user;
@@ -505,37 +434,6 @@ static long efi_runtime_get_nextvariablename(unsigned long arg)
 	return rv;
 }
 
-static long efi_runtime_get_nexthighmonocount(unsigned long arg)
-{
-	struct efi_getnexthighmonotoniccount __user *getnexthighmonocount_user;
-	struct efi_getnexthighmonotoniccount getnexthighmonocount;
-	efi_status_t status;
-	u32 count;
-
-	getnexthighmonocount_user = (struct
-			efi_getnexthighmonotoniccount __user *)arg;
-
-	if (copy_from_user(&getnexthighmonocount,
-			   getnexthighmonocount_user,
-			   sizeof(getnexthighmonocount)))
-		return -EFAULT;
-
-	status = efi.get_next_high_mono_count(
-		getnexthighmonocount.high_count ? &count : NULL);
-
-	if (put_user(status, getnexthighmonocount.status))
-		return -EFAULT;
-
-	if (status != EFI_SUCCESS)
-		return -EINVAL;
-
-	if (getnexthighmonocount.high_count &&
-	    put_user(count, getnexthighmonocount.high_count))
-		return -EFAULT;
-
-	return 0;
-}
-
 static long efi_runtime_reset_system(unsigned long arg)
 {
 	struct efi_resetsystem __user *resetsystem_user;
@@ -697,16 +595,14 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 		return efi_runtime_set_time(arg);
 
 	case EFI_RUNTIME_GET_WAKETIME:
-		return efi_runtime_get_waketime(arg);
-
 	case EFI_RUNTIME_SET_WAKETIME:
-		return efi_runtime_set_waketime(arg);
+		return -EINVAL;
 
 	case EFI_RUNTIME_GET_NEXTVARIABLENAME:
 		return efi_runtime_get_nextvariablename(arg);
 
 	case EFI_RUNTIME_GET_NEXTHIGHMONOTONICCOUNT:
-		return efi_runtime_get_nexthighmonocount(arg);
+		return -EINVAL;
 
 	case EFI_RUNTIME_QUERY_VARIABLEINFO:
 		return efi_runtime_query_variableinfo(arg);
-- 
2.50.0.727.gbf7dc18ff4-goog


