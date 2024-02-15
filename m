Return-Path: <linux-efi+bounces-572-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6C8570B7
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 23:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4DF1F222C7
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577F13DBA4;
	Thu, 15 Feb 2024 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq5fy2yO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154913A86F;
	Thu, 15 Feb 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037494; cv=none; b=u028JKfnU2t4xTR8rA10ryIOGBb4pwnUnKL+RV919B+qhR88CD1CxxxbrqZ5zk13IDjpPloSAHXStpOgrEvYiEMMeIq0PHcGuGJ8QVhSHWH/EaRAxUfD2HnEu4Er8mu69tI551F5M9sDX0+u91xC6JXzl1g8eTpnzfOf33XIFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037494; c=relaxed/simple;
	bh=6XhwMTtsLs0JIWiOr9upPSdCY8YQXot2QALVLFFVtTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh5mNOi42vKMfsR1dQRxsPwE8JLlvJsEPVs1cUuZWnI/1/LjloxGYLVFiqN10YP70i2fEPoBi7vuAFntM/btYSa85XcqUx8ufhCeXKBRCGO4vQ1DgJguVoqdcw5wKI7uliEmeEJo1ux2ak0V4Az0thp03P3KOvTh1CwfTt1rj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq5fy2yO; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e42845298eso786875a34.2;
        Thu, 15 Feb 2024 14:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708037492; x=1708642292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MnyzlgyQvhJraZkrPcyEIJ8UMchFvRt/RNLWEzws5Fw=;
        b=kq5fy2yOa3ia9NZAOnabiWem340bFMUD9byZyRscSJq1edzIxOelnGLD44EUYnDZTS
         znrGgvGYL0DUBcWCeSbZmTzuRw//NpjM74xqAFTEJZTJktkiM5fPN0hTK3RvVQsYJc5+
         jfLiHwhzVDd+XIl3wNp1C82hJbYd3DlCZE77ngqyEhjwnd3GI8SmMD7O9QMMakqA7xh6
         WgFmaghh50pZU1s1mTbl9LFLmUntLlEePWFQnbzokfLwnvq9JZmPtdMtjUtku1FQ7qCJ
         g22VsLt/KA75ccZD6khQMeafWQ9i07+eOBYO83ODnEstAIQQVvhk45DKU1ewdXk6I/+h
         +XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037492; x=1708642292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnyzlgyQvhJraZkrPcyEIJ8UMchFvRt/RNLWEzws5Fw=;
        b=xLAViVhoEYCZz6weBCmSdh50T8dR1V7OOSCPhw9RH1DpV19kai/NWmI7aG4AzKGEsX
         nYbzfKbIq+RF4WOteGePn75XEiYKn2YW6nNsQB20yz8VEdkXM77BwE/0cdN+lG48zpwY
         V2+iGAA1YXkFs9t5a2StgukmJLWSEKk6wht2yHTabDDaCwMIdLlm13uqCpSmMqVLFykc
         LlF86VEeZahbqG2pKHR690y8VQWpHWt4MGCKmKj9JO/t1cOrWLbCZC7CcOCm1Jwi7bJO
         lO4V+CXYv3Lo2H7PkNiwhEDNdi55herSFNrT1suWHozfxEx8JSUsoTxsaNBqnWSuQ7M8
         V1ig==
X-Forwarded-Encrypted: i=1; AJvYcCUn4AyIh0ZOopMS3i1MVp20OqfRdd2Z3RR4wcQFNI1cdar5Vx+H1wEK5IkxGYrpLcAebbRki/zDQ+km5mp7HTvBV9vzoruSNeWR39KOMe0vjFyJxdseHs4Y11k+/3WxpoekaB5i5jqNjVYio80vh+4ylaYq8fRwy++KSfEw2yvt
X-Gm-Message-State: AOJu0Yxuaar00NG0bzvQXMtDsX2roolz7b6PImZvJmHIehfKDYyVPWmq
	4caeBNUjVsNWQrav7b9zpWzZTTsECSIst958z4jAQf6hmddKiDyT
X-Google-Smtp-Source: AGHT+IG8iQn+l7rjVK6rQt/T/nVBqPf9ZO5YH6YMTo01yyXvveR1XnpgoqHUqqvoAWvhWXJHUcFfhw==
X-Received: by 2002:a05:6830:12cf:b0:6e4:2202:ff9f with SMTP id a15-20020a05683012cf00b006e42202ff9fmr3142170otq.17.1708037491957;
        Thu, 15 Feb 2024 14:51:31 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 11-20020ac8590b000000b0042c80eb0d79sm992012qty.52.2024.02.15.14.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:51:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E339B1200043;
	Thu, 15 Feb 2024 17:51:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 17:51:30 -0500
X-ME-Sender: <xms:cpXOZb1aE9duRy89ifK7dQhnCHAOL_538imeKi_uUIkub1Mt0oOo-Q>
    <xme:cpXOZaGM9crAP1vvGjcVhBB69HQM1yb7iC34IKif0QQHmSnAcUnqbPSd9QupWXwYH
    RmwyCRIiZ2x_UHZIw>
X-ME-Received: <xmr:cpXOZb7esUBBD1pK1mso6yXvxRQbUPoEt_i_P9eBp0JsNsRtxgt1fjL44pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgfetfffhheejgedtudeiffduteefhefggedujeduhfeifefgiefgveeuudeludff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgv
X-ME-Proxy: <xmx:cpXOZQ335bmTmgtqdxktyV4BJoOk3hPxiUqUGvJqVVQ0fvuIEaxJQw>
    <xmx:cpXOZeGiHwUhalTilpoToW9rhLUWgSqxJ2w0Qlcuq78tJwlOIRPODA>
    <xmx:cpXOZR8cIWEpJx8arOoJDCnivts6T5ALKn_tDY3CfehR74QHgPBMWA>
    <xmx:cpXOZbNKLkrIlURDOWlkFcOEC2xvOMr9Ro6IZuiZPKV_nb9NdoOhi2XoLVQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 17:51:30 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-arm-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
Date: Thu, 15 Feb 2024 14:51:06 -0800
Message-ID: <20240215225116.3435953-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
a trouble with the following firmware memory region setup:

	[..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
	[..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]

, on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
range will be omitted from the the linear map due to 64k round-up. And
a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:

	[...] Unable to handle kernel paging request at virtual address ffff0000dfd80000

To fix this, add ACPI_MEMORY_NVS into the linear map.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: stable@vger.kernel.org # 5.15+
---
We hit this in an ARM64 Hyper-V VM when using 64k page size, although
this issue may also be fixed if the efi memory regions are all 64k
aligned, but I don't find this memory region setup is invalid per UEFI
spec, also I don't find that spec disallows ACPI_MEMORY_NVS to be mapped
in the OS linear map, but if there is any better way or I'm reading the
spec incorrectly, please let me know.

It's Cced stable since 5.15 because that's when Hyper-V ARM64 support is
added, and Hyper-V is the only one that hits the problem so far.

 drivers/firmware/efi/efi-init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f2..9a1b9bc66d50 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -139,6 +139,7 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_LOADER_CODE:
 	case EFI_LOADER_DATA:
 	case EFI_ACPI_RECLAIM_MEMORY:
+	case EFI_ACPI_MEMORY_NVS:
 	case EFI_BOOT_SERVICES_CODE:
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
@@ -202,8 +203,12 @@ static __init void reserve_regions(void)
 			if (!is_usable_memory(md))
 				memblock_mark_nomap(paddr, size);
 
-			/* keep ACPI reclaim memory intact for kexec etc. */
-			if (md->type == EFI_ACPI_RECLAIM_MEMORY)
+			/*
+			 * keep ACPI reclaim and NVS memory and intact for kexec
+			 * etc.
+			 */
+			if (md->type == EFI_ACPI_RECLAIM_MEMORY ||
+			    md->type == EFI_ACPI_MEMORY_NVS)
 				memblock_reserve(paddr, size);
 		}
 	}
-- 
2.43.0


