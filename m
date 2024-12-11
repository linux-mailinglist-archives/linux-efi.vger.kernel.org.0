Return-Path: <linux-efi+bounces-2363-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C619EC54F
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 08:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C724E284A3F
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9A1BEF8C;
	Wed, 11 Dec 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+hG83Z3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F01C683;
	Wed, 11 Dec 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900707; cv=none; b=u85iGG+ZgK+8R+XRCjMeFkMMug/IQDsoPN1cQSS5RDEUq3i90itM+lX1D48k8jT/ZpxpzotY+B2v3NILGH3u7oGRmmIJinkXBOASRDwA1skH1UcrfccozEFVS/bE281kEhOOYpqbrgmdglsA57eAIvjHuHmU2l254hiKdb4mq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900707; c=relaxed/simple;
	bh=v/EsnuxQHEXkYShXZUNLcRpHaWK9XeacMD7tK4LZlLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7V04agifSKkMuDMCLnwpELgLPYqYPLsuoffr+Zxwqg8iXhm5z0sCasyHsjlQtAvZ1Spx+dYCn1YfCsf0RXH0hW7u1ArdXjEoqGDpjNBuOyZsYDF0Xp0Pk7gnVqVdnSaKs8jblpc2UwrxBlquuP00cwkYkx/A0B+wOqyhnxAjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+hG83Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE90C4CED2;
	Wed, 11 Dec 2024 07:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733900706;
	bh=v/EsnuxQHEXkYShXZUNLcRpHaWK9XeacMD7tK4LZlLI=;
	h=From:To:Cc:Subject:Date:From;
	b=H+hG83Z3FlgRicGpip0ZUlxS/bdrxtnyLr4Wf541Q0OSSkWmdZ7Prva5nP9ilZB2V
	 kXbcNWGT4SasD+U5SEIT2sMO0LsfC6/tcFveVrC2KZjxCeS9RTocr9dM8FGtCIi11D
	 gAYVzpNDw3q1sE/A1egUiYq8i12OjbeUEI+tE5D0vx5NOJtYR61+O0cjCoId5yiKWW
	 hUq6QSd0BWrOC1Jc2tyHnDea3Fg64td3aIlZ+VhxyWjenqDLJX5PhXDyAk+4ptD7X0
	 sUnF4+K4JQiTpTWs4ZWeM4AFiDy3PfX6DpDytdudoNdPrIgegrEL0/gL3uoOWOx6ub
	 O9ZrRjYxm8AUw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH] efi/esrt: remove esre_attribute::store()
Date: Wed, 11 Dec 2024 08:05:03 +0100
Message-ID: <20241211070503.87386-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

esre_attribute::store() is not needed since commit af97a77bc01c (efi:
Move some sysfs files to be read-only by root). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/esrt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 7a81c0ce4780..4bb7b0584bc9 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -75,8 +75,6 @@ static LIST_HEAD(entry_list);
 struct esre_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct esre_entry *entry, char *buf);
-	ssize_t (*store)(struct esre_entry *entry,
-			 const char *buf, size_t count);
 };
 
 static struct esre_entry *to_entry(struct kobject *kobj)
-- 
2.47.1


