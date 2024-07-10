Return-Path: <linux-efi+bounces-1409-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED37492DC22
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 00:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655DAB260BF
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 22:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E314AD22;
	Wed, 10 Jul 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYSflvzz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3661411ED;
	Wed, 10 Jul 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652150; cv=none; b=Mtu6W/osD8OLRS7koGxyCl0n3jLFmDqItHpcC9Rc2UQTGAwgF++K1TyXP/6HvCr513mnvw9n2AiBtFOfdw5u4T8JLUAFc9AU36lft2ynFf9aDomzSr0Y/bNjEneG6xnvHpbdzXEHEocrpCXNUQmDR69Q/DK3DHEhsJZu4RszD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652150; c=relaxed/simple;
	bh=tA8EowCt7yQ9n01EIXy3jVpx5cDt0751LfgzlrzR254=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFDM/Rh1puXUwq5Ymc4P9HG1n/+QM+gZWCixCqiSpRCQANxqlk/QWqSB0HlnhtWK4w+mzHNQTEAxObhoe06rQ79j4hHz2Ocak7DUV/8cZaDqUO2rxLuDhr/l72p2wqdmVnxG/wkTOt1I2UmEA4RyvU0b9VQFXpnQ8/sY/6qfHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYSflvzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A4CC32781;
	Wed, 10 Jul 2024 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720652149;
	bh=tA8EowCt7yQ9n01EIXy3jVpx5cDt0751LfgzlrzR254=;
	h=From:To:Cc:Subject:Date:From;
	b=OYSflvzz713DV5FtaX1W+/rzgu/i07POf1KUYF9g4lFh0iFxt7UgyEWB0Er/7f7QE
	 ++22z1KJ5wP2uak3Vql+q+MQ7tBs6Ruiy/Uqby8zzLYhfsFC/rFmCgY7PsAMmbMjy7
	 H0ugMo/LT1SRbqJwPkxRevzm949zB/LdM6gRjqz7Nv4mnOe9o/fnY5DIuNVVXzLk/J
	 xSNN8OZRJV1mJr37vOhfu7A1paYVZfpuGaQzpwCfM0FeHjiQfsgl54LN12aaNYf/hR
	 EI7D5sNC7PKhqFP+mF6Rz71GUoeDPWWctvgb8ZmtQVTnpyzEP3M8nUqhaVxXo1NozN
	 ituqATFMA1eZw==
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] efi: Replace efi_memory_attributes_table_t 0-sized array with flexible array
Date: Wed, 10 Jul 2024 15:55:42 -0700
Message-Id: <20240710225538.work.224-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=kees@kernel.org; h=from:subject:message-id; bh=tA8EowCt7yQ9n01EIXy3jVpx5cDt0751LfgzlrzR254=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjxFulF/PptAM1kRj0lGUj5tBfy6AWGSucrEp5 T1+9BpDv/eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo8RbgAKCRCJcvTf3G3A JsvREACIDISo4ZwAKyrGmkTwn3Wkbi11X8HG7AGopGidk/5ook+I+J3HrJAhrY0ba7YXZX/iiKf PsSZ2RGXE57dZ5FY/YRZQ3VAOqIuJEB3yKyneQnFslR5/qgQ1zZXRWrtn5EGZwnfJOK44EsNh/O 4HLUxj8ibBlO8QEl3Yybz5jQ5B1QfMI3U2gnzW3gKY+j989luPVFp6oqHE4kvgxvMTv8W3Bj+BO wp71KOIGNET/BsNo5o1NUNeaLHr62AGbJmTwcW7S1sIPEbNjLRre8YDOGh/xHkYbUsfbWVr3tjO DCDffiunjfGc3CR8oeumaFxExhXBi6FKbqkzwx/wLmIjjigrcf1rNy8Ebdpvqe2yysWjxgCZxOm vJiZZD0gJUps6kxf/QTjaX5EtokcttB8VTLmBoqGhJ0FTO656P2+nFBNEu7fg6YRuLGR92usCgE dIgXy4e9SfV4ytG6UDGst26E/up8CPjaUpQqK1/EVAkfHh11wf694cvSfvofRtDgG8a/Etr6u6e +4mgIReW+SK2xH5whLbmeSLdQHJ1KIT9soh88CKldnlmJNrUk6rJBmOEiKTuMY/4MAnuCSQ8RTs SJZsxSux0qHXVJuJh4MvdmI6a6G20ATSp8OdCMk+CbE+nYi1L3S11cgbSVvQKwMHOjaPLcMZt1+ Z9E1VQT+6iStL
 PA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While efi_memory_attributes_table_t::entry isn't used directly as an
array, it is used as a base for pointer arithmetic. The type is wrong
as it's not technically an array of efi_memory_desc_t's; they could be
larger. Regardless, leave the type unchanged and remove the old style
"0" array size. Additionally replace the open-coded entry offset code
with the existing efi_early_memdesc_ptr() helper.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/memattr.c | 2 +-
 include/linux/efi.h            | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index ab85bf8e165a..01142604e8df 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -164,7 +164,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
 		bool valid;
 		char buf[64];
 
-		valid = entry_is_valid((void *)tbl->entry + i * tbl->desc_size,
+		valid = entry_is_valid(efi_early_memdesc_ptr(tbl->entry, tbl->desc_size, i),
 				       &md);
 		size = md.num_pages << EFI_PAGE_SHIFT;
 		if (efi_enabled(EFI_DBG) || !valid)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 418e555459da..b06639c4f6a5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -607,7 +607,11 @@ typedef struct {
 	u32 num_entries;
 	u32 desc_size;
 	u32 flags;
-	efi_memory_desc_t entry[0];
+	/*
+	 * There are @num_entries following, each of size @desc_size bytes,
+	 * including an efi_memory_desc_t header.
+	 */
+	efi_memory_desc_t entry[];
 } efi_memory_attributes_table_t;
 
 typedef struct {
-- 
2.34.1


