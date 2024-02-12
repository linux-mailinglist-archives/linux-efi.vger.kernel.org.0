Return-Path: <linux-efi+bounces-506-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F5851224
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 12:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10A11F229C6
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EE38DE1;
	Mon, 12 Feb 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+8jQASs"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E32BAE7;
	Mon, 12 Feb 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737099; cv=none; b=nH95QBeIRFivMuI8ug1GJkl4Le5NokCRmkiMzjnhJ+p2GWzfsfwz5+VuYPRv3vb4hHENGw76lT7yRmXKaFukkprPgWfqg/OrjisK1nUTf6UPX5V6XHcPG97KE1L3tKF/b9Y+JmI1Misy52AmVVmhjCXhRdB3rXM2E4tSGZwkvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737099; c=relaxed/simple;
	bh=ATEIqE2FYDHx4amPoL6rW+Wx6eEq3KOSbQzs0WhLrGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gzaF6tvxFFmWURRr0Dzz+1fH0sFgKu7H5Ca4DsoEo1VkOjmBZoysl4W+n3uBxKBClVVUL3QnJoKtcgC8IYLcsFqcsDkvjKjSarokpi5RrvHFv04Gs9dmUoz1crS4Qwq8QqNdul1Yd30Hvm2WGXHLOWLTWT8pHIJ0hPxvGdxoVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+8jQASs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9C1C433F1;
	Mon, 12 Feb 2024 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707737099;
	bh=ATEIqE2FYDHx4amPoL6rW+Wx6eEq3KOSbQzs0WhLrGI=;
	h=From:To:Cc:Subject:Date:From;
	b=b+8jQASs+XYTJoe4+xr9ps5KrmUppJwkCnsn6wlXL9dO6QVpkYGfTy4FUWd/YP7yd
	 71GrPNwFyPFLNcOi+YROhjDmLEDDVqVlExpcKHvrVh4hr3K0KFE/YXKI9279Fx8m5T
	 6sCC+J4CkXU4mjQsHu8Pd7SieDj0ZIhzvEMQqb+81KbDpZiHKCkOO5rsxCgqeCfh8d
	 SHCoudX46no3TtnbSGegMkUUeie7jyL+P+uY6JblDEVagI20foItOySJ4ZuG7+0U2i
	 LdCYNruvQkQ6MuWBJisg+i+sEXkkJemP338eAQFxNrCaLgwu8dylayqqqpO3Rdc5ck
	 0+56xcKH8VVmA==
From: Arnd Bergmann <arnd@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/capsule-loader: fix incorrect allocation size
Date: Mon, 12 Feb 2024 12:24:40 +0100
Message-Id: <20240212112454.1213449-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-14 notices that the allocation with sizeof(void) on 32-bit architectures
is not enough for a 64-bit phys_addr_t:

drivers/firmware/efi/capsule-loader.c: In function 'efi_capsule_open':
drivers/firmware/efi/capsule-loader.c:295:24: error: allocation of insufficient size '4' for type 'phys_addr_t' {aka 'long long unsigned int'} with size '8' [-Werror=alloc-size]
  295 |         cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
      |                        ^

Use the correct type instead here.

Fixes: f24c4d478013 ("efi/capsule-loader: Reinstate virtual capsule mapping")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/efi/capsule-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 3e8d4b51a814..97bafb5f7038 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -292,7 +292,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
+	cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
 	if (!cap_info->phys) {
 		kfree(cap_info->pages);
 		kfree(cap_info);
-- 
2.39.2


