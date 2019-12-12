Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF67C11CAF4
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 11:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfLLKeO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 05:34:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728695AbfLLKcJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 05:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xhb4ZJoupfFMXp/pCal+74SHCUI6sDdlcj1jTQYldEk=;
        b=Z5CLFHnyyiohcmatFFTANBfKg1SPx/mtQCOYp+0R0IfWaCLze8sVWEtvTeVa29aWCix38g
        dUF8HqdKTLjC0ae3cIgIlqJ3rgG+Tkb0aepNhs78MGZuQ7RqII9aOeMEbSQ8RZgFG8fTAi
        nhXROhJNvHn9Kc3VdKJLI6IDFhOVFRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-DFewpmFsP2aPnGtP2VJ2eQ-1; Thu, 12 Dec 2019 05:32:05 -0500
X-MC-Unique: DFewpmFsP2aPnGtP2VJ2eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E98D8017DF;
        Thu, 12 Dec 2019 10:32:04 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 995D663BCD;
        Thu, 12 Dec 2019 10:32:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.5 regression fix 1/2] efi/libstub/random: Initialize pointer variables to zero for mixed mode
Date:   Thu, 12 Dec 2019 11:31:57 +0100
Message-Id: <20191212103158.4958-2-hdegoede@redhat.com>
In-Reply-To: <20191212103158.4958-1-hdegoede@redhat.com>
References: <20191212103158.4958-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed th=
e
UEFI RNG table"), causes the drivers/efi/libstub/random.c code to get use=
d
on x86 for the first time.

But this code was not written with EFI mixed mode in mind (running a 64
bit kernel on 32 bit EFI firmware), this causes the kernel to crash durin=
g
early boot when running in mixed mode.

The problem is that in mixed mode pointers are 64 bit, but when running o=
n
a 32 bit firmware, EFI calls which return a pointer value by reference on=
ly
fill the lower 32 bits of the passed pointer, leaving the upper 32 bits
uninitialized which leads to crashes.

This commit fixes this by initializing pointers which are passed by
reference to EFI calls to NULL before passing them, so that the upper 32
bits are initialized to 0.

Fixes: 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed th=
e UEFI RNG table")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/firmware/efi/libstub/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi=
/libstub/random.c
index 35edd7cfb6a1..97378cf96a2e 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -33,7 +33,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *s=
ys_table_arg,
 {
 	efi_guid_t rng_proto =3D EFI_RNG_PROTOCOL_GUID;
 	efi_status_t status;
-	struct efi_rng_protocol *rng;
+	struct efi_rng_protocol *rng =3D NULL;
=20
 	status =3D efi_call_early(locate_protocol, &rng_proto, NULL,
 				(void **)&rng);
@@ -162,8 +162,8 @@ efi_status_t efi_random_get_seed(efi_system_table_t *=
sys_table_arg)
 	efi_guid_t rng_proto =3D EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw =3D EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid =3D LINUX_EFI_RANDOM_SEED_TABLE_GUID;
-	struct efi_rng_protocol *rng;
-	struct linux_efi_random_seed *seed;
+	struct efi_rng_protocol *rng =3D NULL;
+	struct linux_efi_random_seed *seed =3D NULL;
 	efi_status_t status;
=20
 	status =3D efi_call_early(locate_protocol, &rng_proto, NULL,
--=20
2.23.0

