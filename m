Return-Path: <linux-efi+bounces-2734-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E41A24B00
	for <lists+linux-efi@lfdr.de>; Sat,  1 Feb 2025 18:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287A2165529
	for <lists+linux-efi@lfdr.de>; Sat,  1 Feb 2025 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BC1C6F70;
	Sat,  1 Feb 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2BgXYy3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C31C6889
	for <linux-efi@vger.kernel.org>; Sat,  1 Feb 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430504; cv=none; b=Bjlk1jLRYOcXGIH9F/VPCtYQRkmo67lBS+z0jORyjIGA5nFV9PJVJoIJMZDPQ6nJ6i2q4opyjsYnsA+yqFat8oNWLehjzyRUUhtRr/xs1wDHB++aCUQyn/b1X3W7vlsYnx0wXR0jRneVpaCqNpRmAqeclyY4UNPPMemUXMQqfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430504; c=relaxed/simple;
	bh=Wje9jXh/Lzg7dNVojpTxoJYmqBjn6FxH5ERgj9QJZNM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rwV533n0GsaaoZ7P7plsxIwpkp3LUPGDfFsVGz8N8fIUIkdoKrhlQaFYGasenTp4uUK/0W334Z5rbG41pRYrNh+j/v2gDZh+VkOpKX6/ROPdUHbhTepDBYJBD81zcWUQSudleLPMOGR89z9PdU4PAbyynCkFrIVpEs929uqHVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2BgXYy3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso3297001a12.0
        for <linux-efi@vger.kernel.org>; Sat, 01 Feb 2025 09:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738430501; x=1739035301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LKRxqv3rpHMXNzli1kxx7NaVjQ2CKQKlOaLUroi86/c=;
        b=S2BgXYy39/aFDj8K1qnQHszr6tlpO3jqEjgtAeElTDlpwmVhaZBp2n2V/DLC9+NSbY
         2nQYtQnV3Kaqmn4MwEcA51gUDLCW7pyBc+o1Cs2BK5KJlaTeDebccEQCxIuAR4lyXO4i
         EgaQUHcsa33128R5JbmSUUwV7rx/rjx9gzxGG6II0pV6DScPl+KLgsZwm/jkVqZy+BDS
         OCnb5UYVQ+3ZGYkhVguIlsx7d2+DIEF7L66iVExLZQlEiYgAUVQfCG0u5qDVmmm0um/1
         aS+ppWSfRJci5sGMqZI7xe95xUEl97BymnvD/Y0689gIgZ8zj+B42fqajVIxNbBTbJ2j
         1mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430501; x=1739035301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKRxqv3rpHMXNzli1kxx7NaVjQ2CKQKlOaLUroi86/c=;
        b=neGnrj+xLfex/bWDx7dJCijmkj6+Sq/0GRZxru5CHFuzWYhMEr+87viszvXDS1P3pn
         ffuT3LttOC5kEOG8OFr7g8ANicoJyygy6KByyw75WwpH3Oqoow+QPdQhuRR1bmkZ6L//
         K+7Er9Cfu62rpy4ALp+WA/yef9gOaFtsTaIdaxYZZbgmSe0CCrN8IFblKA9FY05idiSM
         jvQYpX6O92Rrs/GoE4iFdgIlER8gDlEaoBF/4eHMoGacd3RylFSkkIYpPIRvz73aSsIm
         AJFGbQ0iGoK612037v+r9agra6y/A/I210bd0Mf7Z5BdSs/e8HC1SFNDV0Jp3Qg0r836
         JytQ==
X-Gm-Message-State: AOJu0Ywq2vxGJfe5XufT/EKfT+HRamIqaf2RrsyXInp5MIDmLWdQadRZ
	b+JDlAIFLG/pn7zJe7qptLnkYwnRGbUyyTEbHTOb6htuIjVdDW/9nAish8rmV3f8TMdposj0m9w
	qXtXVnRr+kHbzbqEal3CGmlrLinbz9OW2iUEMc+huN5dexZ2XsUK0yCTI/1vHHi8OlL9DqbukOF
	2mZ/3UZkRhBvNYvuTW7cg81CxGIw==
X-Google-Smtp-Source: AGHT+IG+iioIcLE1n2x2b5wS9rFGgmHjtDC2eNRzzZJ7bBkw6Q7fp+IlwZekIdNJiM3C+zWK1UVZnF/4
X-Received: from edbij11.prod.google.com ([2002:a05:6402:158b:b0:5cf:ca78:ecdf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51d4:b0:5dc:100c:157f
 with SMTP id 4fb4d7f45d1cf-5dc5efbf5afmr19486211a12.11.1738430501387; Sat, 01
 Feb 2025 09:21:41 -0800 (PST)
Date: Sat,  1 Feb 2025 18:21:34 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=572; i=ardb@kernel.org;
 h=from:subject; bh=nigpWL6qVv3nStiJxVFaJcS25/39Tm1V0wccEmiRXMI=;
 b=kA0DAAgWMG4JVi59LVwByyZiAGeeWB2gRIbc0Rrc54+L/uCiwNdGFr6PxVYQL6sRJ5wf1yaIn
 oh1BAAWCAAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmeeWB0ACgkQMG4JVi59LVwaVQEApSmH
 8+Jyl75SnzF+L2n77H5dpRk0rHoER1Baq9UW6XgBAPntTLwPZiiOh0cRqVTzefa/KJbd1dRYmzr nKcf9dYcB
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201172133.3592112-4-ardb+git@google.com>
Subject: [PATCH 0/2] efi: Add support for EFI_MEMORY_HOT_PLUGGABLE
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Adopt the EFI_MEMORY_HOT_PLUGGABLE memory attribute definition from UEFI
2.11 and test for it where appropriate.

Ard Biesheuvel (2):
  efi: Avoid cold plugged memory for placing the kernel
  efi: Use BIT_ULL() constants for memory attributes

 drivers/firmware/efi/efi.c                 |  6 ++--
 drivers/firmware/efi/libstub/randomalloc.c |  3 ++
 drivers/firmware/efi/libstub/relocate.c    |  3 ++
 include/linux/efi.h                        | 31 ++++++++++----------
 4 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.48.1.362.g079036d154-goog


