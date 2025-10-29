Return-Path: <linux-efi+bounces-5216-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A52C1A05C
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AD90503691
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD93346B6;
	Wed, 29 Oct 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bIj6YdJy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94461334C02
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737241; cv=none; b=IW+BXRKH7FBrZp+DXcwMLdG79YzqvYQz9PITEcu8s4zPwKj6vQw3e1Bfa7yAbrm5J6eTFe3+Iepwlzq/AI+zbeJVsSa2gKrDkU/eiCFdyOnYeiRq/AkvBLIFjkrEVVxcrMcA2ZC/9RmVl89cZqO3EfwxAtYu4r0xQ0iOvPK+keA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737241; c=relaxed/simple;
	bh=3k4eu6bu2FqRegq68CTBi09f2mevDFi0nw5dHF0KKDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtlXTpTo8gqtkZN3/cufsYnfYUkOcm1d2dD84OBbGSixz7OBQMPGZ8ySjLexo7VAFYgxPpXV+aOuvN7ns1MIFMflirId+PSnpyyVBiiz+8crt+vqHK172h7ED+FjXG6kZ2pF6VPkb/7U1cjsO08H+yGPnDEw3wA8Qke/xk2iXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bIj6YdJy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so9042629a91.2
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737239; x=1762342039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjTmNoD235Z0Q+UTnvL+T6Jk9tiw9Xtbmp+pbEirE4Q=;
        b=bIj6YdJyEvkwKDBetosLgBeCt45p3L0tgSGwDD+ZQi68I92SvNAaB0ufF2WJnsNoA7
         MRPCIfmWhm4DpZMUp6H+HrwA20J3HILEMjSkvem5aZZVkqIGyD7PTouaGUDqqFRKwNCj
         XTpv7R02xxQf7aoIgHvuOYyga1LiO79ki/MAQ9MnXCknBaMeaVWtlR6wP37ESCxbjugm
         Pa8AQsCGS4i+praZfZgXP6Tgv55xznDbjgO4uQ0jXVmLTqYUdhp0QE3Xcx65YASwHhK/
         ICdXQvz/z/iZ93hDbzkbUN3mnBIILO8STRGfpjiPjCjHyDXl6qybhIBuJB54zE7iPR4r
         eAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737239; x=1762342039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjTmNoD235Z0Q+UTnvL+T6Jk9tiw9Xtbmp+pbEirE4Q=;
        b=TbIMgEgxk5nWlghf78pzzkowmsCAzYYqd5/ZLS6liiDiocBzei7uNnN0UcTr1NkNsf
         jPJ9JS+fmm61L3xEPcjs5xp8k2fk8NMJ/W9QFVG86f8SxyJoR8tbxmGwR/PhGi+9VvV3
         VrlnDYY7H473rDO2QEyKVwMOmkRhFH7rWLaf/Gg3l1Vc64/zWzNkkBIQJfhPDEEl9zSF
         jeFNublJvLVQAgx6WsGGoNl6vpE2WPw+qOgsKhlVAq8IJo6+Lsyg1MXvovGlcLlHigaI
         pRgFk8jqRba5XSYwdz5pXxiav9O7KY+LfB2RHyYVuFqC43sX2k4Ol+32GqPNBGCj9I1s
         BBuw==
X-Forwarded-Encrypted: i=1; AJvYcCVx1QgLMICEJoKX5HMqlDUVdkoG56PV3Jxy3toziBqBdexEMrM6OEyw7cRrn1ufRMEwSvbX9VF/AtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwveGtqMWiM7dupZIAW0Kc9/I5PdqVZyV2hJimHPYgJIM59CRSe
	JFyf9OQu5wSrFPfi8v/4OiWurgQachUpIsFCI5JP5bLWoGyyjPE22ZD1GJDYIeq5N4k=
X-Gm-Gg: ASbGnctwsH1Rft9a1/Qx4lC/eplTf4T9PNdnGdvKBbDpUetBHPY8jAfN6uqJjhjCxZP
	6cdqH8J0sth8FWNy/31BwJ1Z0SXEw/Ia9/6PIbM8ntfXmPGdZ3zLRMHHOEM+Myo1IaQ4zW21iVt
	QTFfrZX5RtFUlUW1nWGhh/VPMq2YSIbqsKmgysoXpwfY82A4bjfr6ol8iC0EQr4FpAHBbZ+UlMU
	Ce5RvsfqesMLGOP+OT+KeUd0LpQ2Hw9CBjIQ/T52uZ/SKqmsfL9qhlc1QJY6IM6q7meWt5/ZAYJ
	Ck70LlkBAu7mUNGQQyWO3tb3e2OsJrdwDaC/9eRSNUVb1jlEZ6Ma/OCX59tyXre/N+F3JHCc/TO
	gYrAxh5kf1MhUV+v8E51RpIHV4yVQjpaKP1C3Lb1AT15aNzTXV+N/9YAjYWmnBKZiiw4AgHSZHz
	lcK2sjaLBGHIRtXom6joR1WvOB6vhD
X-Google-Smtp-Source: AGHT+IGV9vVH8+hlZLrwbCF6EeuF04kV3fpI5UDP/oNNvPeA5hF+38GHsytRURBATavrU36r7KMQfg==
X-Received: by 2002:a17:90b:384d:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-3403a15844cmr2891587a91.14.1761737238675;
        Wed, 29 Oct 2025 04:27:18 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:18 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification types
Date: Wed, 29 Oct 2025 16:56:41 +0530
Message-ID: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e8458..20b490227398 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0


