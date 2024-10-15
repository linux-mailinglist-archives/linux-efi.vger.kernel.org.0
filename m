Return-Path: <linux-efi+bounces-1973-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F999F503
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98227280A97
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34221F9EA8;
	Tue, 15 Oct 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQQvVp9k"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D571C4A2C
	for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016169; cv=none; b=PGEZuSPK8xSC10aGzghypjWwsGvhQ6kfj+9f+9pzG+6rS94vorVSjGk/CDbioHK0TP5GHS3GiS/JaGyFM5Fi1bIkpKUQo+CK7Q7X2LcDCrX7VnDdDkvbY5RhNLh3knQouRp8eEoeDY2yfssyeXiopSU9JmnSXyWZR7/kW4iTXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016169; c=relaxed/simple;
	bh=BJZj/dEBYUvetfEZcPn6U2INkGIIWdrX/wfmsQx2rxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LFE8Pl4+DTrv8uc9dte9Mt0El6JsvXaKfcK4rDqtdi6aMleoTovZ+KjfNSSFMdjG5yKnPpj63HYW8weaNU0sCM5PvOVONnNR26oYikt+zdIt1A2cLwNiN2iAcA1atADEcUwyFOuzqdcNrRJh1PKqkKmM1DnGu3rBbJ0woE74Bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQQvVp9k; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e000d68bb1so1417717b3.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016167; x=1729620967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLB4hXLLxRt5W1gNs5r4BTRK4JBX5nV19kECJ9LPoq8=;
        b=BQQvVp9kH7y0tvjfxk3ezh63eP5PdUTTrkA9YyP7goiVidA6GSOgFFBQTQPghvHmeT
         xWzNqa+P0pTNgbv4IOrWVwwszXrcKcVuVME38HCg7XDZ/KbdyhgUlejdtd/LJHi0z+S6
         0DjeNuuUXGLrN4tQvtuoX0aFN/4ZPJqVxL3lFLBU703Cr3f+ZEIQLeIFefffTD+jRwuk
         l0eQmtEx46yTpt1kO0AAR2eAZJwjbd3+7HZWvWE3ByRKRnhKDE10CHPXw33s5DAJS+5R
         1VpzPxJtcjvOrEXfHB26uCR8BpzWlseK5lgkqYKGeXmlbq+Hb6JUQWiUThRz+R+jdfrK
         vi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016167; x=1729620967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLB4hXLLxRt5W1gNs5r4BTRK4JBX5nV19kECJ9LPoq8=;
        b=ZlVc6hLjOVKxcKG8IlLKY5Y67EHXjapNM6D+Plc2ANHNcW0wbj++HnbOk4ABHlQJqI
         VyRxiaaCWsxZ17zKp6aeW9yfmJ0AmaaJSX490f92XIh8o5BK4sWFFwJOTWRuTuk7fiqp
         w6QPpee5I5i3WxScIS9MtsHOOYhqfvyl7G4mP5WdfP0KsxP55iotMqflChB7zUiLAfYl
         bldvKo4m0JtKjBJnnSj6F9EF/X1rMCgoiauc418slbvEXNGsK+XxbkxyUAl6h7b7WyMr
         Iz3SVjgt/km+HXsvSjemS3i1+aWgpOtfnUxovcxFhNpSBbAN5P2u9rQqp9XYdTCf2IrF
         JlRw==
X-Gm-Message-State: AOJu0YzyTzHhfSq5nobPBipEcsTiQGwdRpazjqFYhYEFxbXxizRvrbEV
	dCRBFrdqe1AzRokSiKmX4/usR4RSuW7COzigvC0x9RBtNI57KkvPu3k2za5ar0lv37EGhjaW78G
	ki+/F3K3UNTySkXCL9qRGBpHKa/+uFFFg6I0XsOewNAxztfEtmJ3R1Hufd5+ilbn4ntZnPxCuk8
	r3hCfUS12RBcp+eSHqrkCV6AJL5A==
X-Google-Smtp-Source: AGHT+IGKAM7sU9sXkondbx1hiQgcs9CSlRrfIWUr3OyF6Of+7LZoTMoTYcZyQ6Rw1HfX60fHOnFDi0sq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:1ca:b0:e28:e97f:5397 with SMTP id
 3f1490d57ef6-e2977518269mr3960276.3.1729016167269; Tue, 15 Oct 2024 11:16:07
 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:15:54 +0200
In-Reply-To: <20241015181549.3121999-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015181549.3121999-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=ardb@kernel.org;
 h=from:subject; bh=6m7aUuA46M4Ug0AbSzb6lLfveQg53ri9buly5/TPwIc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1vY6R5g152/SnOR5NXlHs3xVk1fQzsXzl/cQTfL5sdD
 08Hm+3pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPhSGFkWHmoctPMZ7UPOebP
 +7L/X3HAL1Gdfk32BecjBd7nc01fasrwP0LbUmK1yOOc3qz8Ip+/kVOrGsLf1xRsbzoQ0SU/YdY 3LgA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015181549.3121999-10-ardb+git@google.com>
Subject: [PATCH 4/4] efi/libstub: Take command line overrides into account for
 loaded files
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When CONFIG_CMDLINE_OVERRIDE or CONFIG_CMDLINE_FORCE are configured, the
command line provided by the boot stack should be ignored, and only the
built-in command line should be taken into account.

Add the required handling of this when dealing with initrd= or dtb=
command line options in the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 17bf25dccc07..0e41b88238b1 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -189,7 +189,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  unsigned long *load_addr,
 				  unsigned long *load_size)
 {
-	const bool ignore_load_options = false;
+	const bool ignore_load_options = IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ||
+					 IS_ENABLED(CONFIG_CMDLINE_FORCE);
 	const efi_char16_t *cmdline = efi_table_attr(image, load_options);
 	u32 cmdline_len = efi_table_attr(image, load_options_size);
 	unsigned long efi_chunk_size = ULONG_MAX;
-- 
2.47.0.rc1.288.g06298d1525-goog


