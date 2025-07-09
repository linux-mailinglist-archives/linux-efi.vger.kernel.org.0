Return-Path: <linux-efi+bounces-4229-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1AAFE22E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410F956470C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF126B76B;
	Wed,  9 Jul 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4P40U50b"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B8283FE8
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048715; cv=none; b=IGLGlQWQlUz3Vjb6kMS12lh35P0X0ixIIFu858sttIQ4j1waUBkbJxVZtGhbJSmvsKEGiO4NFSJjW0NJtNuiWQEDthu6kH5pTZHe9p7x3KUfTjZRatFZQBDaytfuyAKiHrUXQ1iiD3k+44F7+etc1fT8qV0/JWHZE3EOpochv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048715; c=relaxed/simple;
	bh=MlIRBxRaja7ZlU2OXFrbRrUPNNl74/HsMd4o37sL9hE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gjxd841Md3L2n58n3LwUFHtH3zQcQ+8cfKQndOgsrkOOjyaSX+uu5mX5HVP6tQdUpx2NX9tzzwlz/70uvHvHAF9oIIjdYdPi0qXe/eHr2S/YgfjuyOvRR8nXhbo8YdDvAL85+r3nrwVzOr7EqJQnLKVpVp8L0YgDh6bL9T8DNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4P40U50b; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4532514dee8so36380855e9.0
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048712; x=1752653512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQugI64DfH4l5motO7Op00/v3FgIyII8TOhMD/41k4=;
        b=4P40U50bRnG4ZrUEJERMgmwO4STUGsDxTltcezUNosQQpaXyro0mT4rDHtVaLj0Gfj
         DivkdZFzXvkVkbJRPphkFBials+IH26Mu2+9ZpsLh4WaQcEB7AwB29+xfD2dMOWD4KBo
         ETYLD8bKdyp9g0FeuAQDwuX+av2qHIO8uDERzYwAa36HwamiJjUNOmBKRzuIVK4dlGIG
         MBD0w+BkueG7cxg4+XVPZK5rSXt9eujtMo2ZDSkZNA8B9BkcP9Znv93mj4Z5T0caBnZH
         H0oBi4V67+bteOcje6Gh73LoN58YXstB1lCAeDXOQnHVwFI6NEiL26M139LNDmmaZa06
         KEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048712; x=1752653512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQugI64DfH4l5motO7Op00/v3FgIyII8TOhMD/41k4=;
        b=PdFHkGaucIQXUBYLF/QszW7cpOsctbNCHSbAPnx6lr/ts5xy++tsm/s7/URpDK4I0G
         LFICphuXyhLgnqvfrtuxGB8OU8Sb1IFBBb0lW1Hu1J8DgeVsB1LSdY/fx0wNEnRXa+HA
         xukTfz8KELzaLuWyU8o1KdEs6nRupJ1LDZgBaixir0XbKT+QJj4G2Vy1COfcubBS6AOu
         UyfbM+tPTWhCph2IYNDhITIk3ryUKWeKObVcBdERTOYHGxROZknbS7Oqcf4IBa32YS7w
         yNcYi7cKv1eXm9/sTkQT7+mlv+iLeQRW3sVMNMCrQVhDAav8f57IRn0FVQuMjkT45zr5
         Bvvw==
X-Gm-Message-State: AOJu0YydX1TY/FKagA72LZPp4vHAXlaSO2Tpuw+ehm4nZbSEuGbRZfZ8
	uo6MgKEOvH6UT0bvZrNeI7ORvxiyFvjbsrBSPhgCxqMwjiyjXkzKn9PwhkU/OxgOylWHaDx4tA=
	=
X-Google-Smtp-Source: AGHT+IGSJGX/pEHs6QWpVjrof537fmpAF9vkUHI44VaBcW8UIx6L7uDKveEm9eWEJjArZ+KCIFi3vL06
X-Received: from wmbea14.prod.google.com ([2002:a05:600c:674e:b0:43e:9aac:5a49])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5309:b0:43c:efed:733e
 with SMTP id 5b1f17b1804b1-454d5327ef4mr13878735e9.14.1752048712259; Wed, 09
 Jul 2025 01:11:52 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:09:05 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org;
 h=from:subject; bh=2wDANTljMa+3l9R4Cw8PAic5NzJMQu4mfQTgCSM10MY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPheUX9+Kv8/UmBnls2hwsZnLF65Plcca6y0LPlX8/q
 zgfkTOjo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkN5SRYUPj3MiwRQ//pe6+
 f3ff28PP/KIMOK6u32gX8iJ019HvehGMDAtWynwt99Jrzsjzj78V1Lt+4vrPdw3KnyYGRT1pXV9 wmgEA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-50-ardb+git@google.com>
Subject: [PATCH v4 24/24] x86/boot: Get rid of the .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4277efb26358..d7af4a64c211 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -160,11 +160,6 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
-	/* bootstrapping code */
-	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
-		HEAD_TEXT
-	} :text = 0xcccccccc
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.50.0.727.gbf7dc18ff4-goog


